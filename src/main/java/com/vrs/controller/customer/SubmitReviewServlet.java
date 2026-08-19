package com.vrs.controller.customer;

import java.io.IOException;

import com.vrs.dao.implementation.BookingDAOImpl;
import com.vrs.dao.implementation.ReviewDAOImpl;
import com.vrs.dao.interfaces.BookingDAO;
import com.vrs.dao.interfaces.ReviewDAO;
import com.vrs.model.Booking;
import com.vrs.model.Review;
import com.vrs.model.User;
import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/customer/submit-review")
public class SubmitReviewServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BookingDAO bookingDAO;
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {

        bookingDAO = new BookingDAOImpl();
        reviewDAO = new ReviewDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

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
             * Verify that this booking belongs to
             * the logged-in customer.
             */
            if (booking.getUserId() != user.getUserId()) {

                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN);

                return;
            }

            /*
             * Only Completed bookings can be reviewed.
             */
            if (!"Completed".equals(
                    booking.getBookingStatus())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/bookings?error=notReviewable");

                return;
            }

            /*
             * One review per booking.
             */
            if (reviewDAO.hasReview(bookingId)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/bookings?error=alreadyReviewed");

                return;
            }

            request.setAttribute("booking", booking);

            request.getRequestDispatcher(
                    "/customer/review.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/bookings?error=invalidBooking");
        }
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

        String vehicleRatingParameter =
                request.getParameter("vehicleRating");

        String vendorRatingParameter =
                request.getParameter("vendorRating");

        if (bookingIdParameter == null
                || vehicleRatingParameter == null
                || vendorRatingParameter == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/bookings?error=required");

            return;
        }

        try {

            int bookingId =
                    Integer.parseInt(bookingIdParameter);

            int vehicleRating =
                    Integer.parseInt(vehicleRatingParameter);

            int vendorRating =
                    Integer.parseInt(vendorRatingParameter);

            if (vehicleRating < 1
                    || vehicleRating > 5
                    || vendorRating < 1
                    || vendorRating > 5) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/submit-review?bookingId="
                        + bookingId
                        + "&error=invalidRating");

                return;
            }

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
             * Verify booking ownership.
             */
            if (booking.getUserId() != user.getUserId()) {

                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN);

                return;
            }

            /*
             * Only Completed bookings can be reviewed.
             */
            if (!"Completed".equals(
                    booking.getBookingStatus())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/bookings?error=notReviewable");

                return;
            }

            /*
             * Prevent duplicate review.
             */
            if (reviewDAO.hasReview(bookingId)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/bookings?error=alreadyReviewed");

                return;
            }

            Review review = new Review();

            review.setBookingId(bookingId);
            review.setVehicleRating(vehicleRating);
            review.setVendorRating(vendorRating);

            boolean created =
                    reviewDAO.addReview(review);

            if (created) {

                /*
                 * PRG
                 */
                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/bookings?success=reviewSubmitted");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/submit-review?bookingId="
                        + bookingId
                        + "&error=reviewFailed");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/bookings?error=invalidRating");
        }
    }
}