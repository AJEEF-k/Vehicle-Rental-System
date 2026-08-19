package com.vrs.controller.customer;

import java.io.IOException;

import com.vrs.dao.implementation.BookingDAOImpl;
import com.vrs.dao.interfaces.BookingDAO;
import com.vrs.model.Booking;
import com.vrs.model.User;
import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/customer/cancel-booking")
public class CancelBookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

        if (!AuthUtil.requireRole(request, response, "CUSTOMER")) {
            return;
        }

        String bookingIdParameter =
                request.getParameter("bookingId");

        if (bookingIdParameter == null
                || bookingIdParameter.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/bookings?error=invalidBooking");

            return;
        }

        try {

            int bookingId =
                    Integer.parseInt(bookingIdParameter);

            User user =
                    AuthUtil.getLoggedInUser(request);

            Booking booking =
                    bookingDAO.getBookingById(bookingId);

            if (booking == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/bookings?error=bookingNotFound");

                return;
            }

            /*
             * Make sure the booking belongs to the
             * currently logged-in customer.
             */
            if (booking.getUserId() != user.getUserId()) {

                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN);

                return;
            }

            /*
             * Customer can cancel only Confirmed bookings.
             */
            if (!"Confirmed".equals(
                    booking.getBookingStatus())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/bookings?error=notCancellable");

                return;
            }

            boolean cancelled =
                    bookingDAO.updateBookingStatus(
                            bookingId,
                            "Cancelled");

            if (cancelled) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/bookings?success=cancelled");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/bookings?error=cancelFailed");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/bookings?error=invalidBooking");
        }
    }
}