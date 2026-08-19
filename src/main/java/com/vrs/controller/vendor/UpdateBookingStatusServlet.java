package com.vrs.controller.vendor;

import java.io.IOException;

import com.vrs.dao.implementation.BookingDAOImpl;
import com.vrs.dao.implementation.VehicleDAOImpl;
import com.vrs.dao.implementation.VendorDAOImpl;
import com.vrs.dao.interfaces.BookingDAO;
import com.vrs.dao.interfaces.VehicleDAO;
import com.vrs.dao.interfaces.VendorDAO;
import com.vrs.model.Booking;
import com.vrs.model.User;
import com.vrs.model.Vehicle;
import com.vrs.model.Vendor;
import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/vendor/update-booking-status")
public class UpdateBookingStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BookingDAO bookingDAO;
    private VehicleDAO vehicleDAO;
    private VendorDAO vendorDAO;

    @Override
    public void init() throws ServletException {

        bookingDAO = new BookingDAOImpl();
        vehicleDAO = new VehicleDAOImpl();
        vendorDAO = new VendorDAOImpl();
    }

    @Override   
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

    	if (!AuthUtil.requireApprovedVendor(request, response)) {
    	    return;
    	}
    	
        String bookingIdParameter =
                request.getParameter("bookingId");
   
        String newStatus =
                request.getParameter("bookingStatus");

        if (bookingIdParameter == null
                || bookingIdParameter.isBlank()
                || newStatus == null
                || newStatus.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/bookings?error=invalidRequest");

            return;
        }

        try {

            int bookingId =
                    Integer.parseInt(bookingIdParameter);

            newStatus = newStatus.trim();

            if (!isValidStatus(newStatus)) {  

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/bookings?error=invalidStatus");

                return;
            }

            User user = AuthUtil.getLoggedInUser(request);

            Vendor vendor =
                    vendorDAO.getVendorByUserId(
                            user.getUserId());

            if (vendor == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/dashboard?error=vendorProfile");

                return;
            }

            Booking booking =
                    bookingDAO.getBookingById(bookingId);

            if (booking == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/bookings?error=bookingNotFound");

                return;
            }

            /*
             * Find the vehicle associated with the booking.
             */
            Vehicle vehicle =
                    vehicleDAO.getVehicleById(
                            booking.getVehicleId());

            if (vehicle == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/bookings?error=vehicleNotFound");

                return;
            }

            /*
             * Make sure this booking belongs to the
             * currently logged-in vendor.
             */
            if (vehicle.getVendorId() != vendor.getVendorId()) {

                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN);

                return;
            }

            /*
             * Validate the booking status transition.
             */
            if (!isValidTransition(
                    booking.getBookingStatus(),
                    newStatus)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/bookings?error=invalidTransition");

                return;
            }

            boolean updated =
                    bookingDAO.updateBookingStatus(
                            bookingId,
                            newStatus);   

            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/bookings?success=statusUpdated");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/bookings?error=updateFailed");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/bookings?error=invalidBooking");
        }
    }

    private boolean isValidStatus(String status) {

        return "Active".equals(status)
                || "Completed".equals(status)
                || "Cancelled".equals(status);
    }  

    private boolean isValidTransition(String currentStatus,String newStatus) {

             if (currentStatus == null) { 
                  return false;
              }

             if ("Confirmed".equals(currentStatus)) {

                 return "Active".equals(newStatus) || "Cancelled".equals(newStatus);
              }

             if ("Active".equals(currentStatus)) {  

                return "Completed".equals(newStatus);
             }

            return false;
      }
}