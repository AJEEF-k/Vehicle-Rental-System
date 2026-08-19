package com.vrs.controller.customer;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;

import com.vrs.dao.implementation.BookingDAOImpl;
import com.vrs.dao.implementation.VehicleDAOImpl;
import com.vrs.dao.interfaces.BookingDAO;
import com.vrs.dao.interfaces.VehicleDAO;
import com.vrs.model.Booking;
import com.vrs.model.User;
import com.vrs.model.Vehicle;
import com.vrs.utility.AuthUtil;
import com.vrs.utility.DateTimeUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/customer/book-vehicle")
public class BookVehicleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /*
     * Your current booking data shows a security deposit
     * of 1000.
     */
    private static final int SECURITY_DEPOSIT = 1000;

    private BookingDAO bookingDAO;
    private VehicleDAO vehicleDAO;

    @Override
    public void init() throws ServletException {

        bookingDAO = new BookingDAOImpl();
        vehicleDAO = new VehicleDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!AuthUtil.requireRole(request, response, "CUSTOMER")) {
            return;
        }

        String vehicleIdParameter =
                request.getParameter("vehicleId");

        if (vehicleIdParameter == null
                || vehicleIdParameter.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/vehicles?error=invalidVehicle");

            return;
        }

        try {

            int vehicleId =
                    Integer.parseInt(vehicleIdParameter);

            Vehicle vehicle =
                    vehicleDAO.getVehicleById(vehicleId);

            if (vehicle == null
                    || !"Available".equals(
                            vehicle.getOperationalStatus())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/vehicles?error=vehicleUnavailable");

                return;
            }

            request.setAttribute("vehicle", vehicle);

            request.getRequestDispatcher(
                    "/customer/booking.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/vehicles?error=invalidVehicle");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

        if (!AuthUtil.requireRole(request, response, "CUSTOMER")) {
            return;
        }

        try {
   
            User user =
                    AuthUtil.getLoggedInUser(request);

            int vehicleId =
                    Integer.parseInt(
                            request.getParameter("vehicleId"));

            String startParameter =
                    request.getParameter("startDateTime");

            String endParameter =
                    request.getParameter("endDateTime");

            String rateType =
                    request.getParameter("rateType");

            String paymentMethod =
                    request.getParameter("paymentMethod");

            if (startParameter == null
                    || endParameter == null
                    || rateType == null
                    || paymentMethod == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/book-vehicle?vehicleId="
                        + vehicleId
                        + "&error=required");

                return;
            }

            LocalDateTime startDateTime =
                    LocalDateTime.parse(startParameter);

            LocalDateTime endDateTime =
                    LocalDateTime.parse(endParameter);

            rateType = rateType.trim();
            paymentMethod = paymentMethod.trim();

            /*
             * Validate rental period.
             */
            if (!DateTimeUtil.isValidRentalPeriod(
                    startDateTime,
                    endDateTime)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/book-vehicle?vehicleId="
                        + vehicleId
                        + "&error=invalidPeriod");

                return;
            }

            /*
             * Rental cannot start in the past.
             */
            if (startDateTime.isBefore(LocalDateTime.now())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/book-vehicle?vehicleId="
                        + vehicleId
                        + "&error=pastDate");

                return;
            }

            /*
             * Validate rate type.
             */
            if (!"Hourly".equals(rateType)
                    && !"Daily".equals(rateType)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/book-vehicle?vehicleId="
                        + vehicleId
                        + "&error=invalidRateType");

                return;
            }

            /*
             * Validate payment method.
             */
            if (!"UPI".equals(paymentMethod)
                    && !"Cash".equals(paymentMethod)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/book-vehicle?vehicleId="
                        + vehicleId
                        + "&error=invalidPaymentMethod");

                return;
            }

            Vehicle vehicle =
                    vehicleDAO.getVehicleById(vehicleId);

            if (vehicle == null
                    || !"Available".equals(
                            vehicle.getOperationalStatus())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/vehicles?error=vehicleUnavailable");

                return;
            }

            /*
             * Check booking-period availability.
             */
            boolean available =
                    vehicleDAO.isVehicleAvailable(
                            vehicleId,
                            startDateTime,
                            endDateTime);

            if (!available) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/book-vehicle?vehicleId="
                        + vehicleId
                        + "&error=alreadyBooked");

                return;
            }

            /*
             * Pricing snapshot.
             */
            int appliedRate;

            if ("Hourly".equals(rateType)) {
                appliedRate = vehicle.getHourlyRate();
            } else {
                appliedRate = vehicle.getDailyRate();
            }

            int totalAmount =
                    calculateTotal(
                            startDateTime,
                            endDateTime,
                            rateType,
                            appliedRate);

            /*
             * Payment status is independent from
             * booking status.
             */
            String paymentStatus;

            if ("UPI".equals(paymentMethod )|| "Cash".equals(paymentMethod) ) {
                paymentStatus = "Completed";  
            } else {
                paymentStatus = "Pending";
            }

            Booking booking = new Booking();

            booking.setUserId(user.getUserId());
            booking.setVehicleId(vehicleId);

            booking.setBookingDate(LocalDateTime.now());
            
            booking.setStartDateTime(startDateTime);
            booking.setEndDateTime(endDateTime);

            booking.setBookingStatus("Confirmed");

            booking.setPaymentMethod(paymentMethod);
            booking.setPaymentStatus(paymentStatus);

            /*
             * Pricing snapshot.
             */
            booking.setRateType(rateType);
            booking.setAppliedRate(appliedRate);
            booking.setTotalAmount(totalAmount);

            booking.setSecurityDeposit(
                    SECURITY_DEPOSIT);

            boolean created =
                    bookingDAO.createBooking(booking);

            if (created) {

                /*
                 * PRG
                 */
                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/bookings?success=booked");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/book-vehicle?vehicleId="
                        + vehicleId
                        + "&error=bookingFailed");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/vehicles?error=invalidInput");

        } catch (DateTimeParseException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/vehicles?error=invalidDate");
        }
    }

    private int calculateTotal(
            LocalDateTime startDateTime,
            LocalDateTime endDateTime,
            String rateType,   
            int appliedRate) {

        Duration duration =
                Duration.between(
                        startDateTime,
                        endDateTime);

        long minutes = duration.toMinutes();

        if ("Hourly".equals(rateType)) {

            /*
             * Any partial hour is charged as one full hour.
             */
            long hours =
                    (minutes + 59) / 60;

            return (int) (hours * appliedRate);
        }

        /*
         * Any partial day is charged as one full day.
         */
        long days =
                (minutes + (24 * 60) - 1)
                / (24 * 60);

        return (int) (days * appliedRate);
    }
}