package com.vrs.controller.customer;

import java.io.IOException;
import java.util.List;

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

@WebServlet("/customer/bookings")
public class MyBookingsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!AuthUtil.requireRole(request, response, "CUSTOMER")) {
            return;
        }

        User user = AuthUtil.getLoggedInUser(request);

        List<Booking> bookings =
                bookingDAO.getBookingsByUserId(
                        user.getUserId());

        request.setAttribute("bookings", bookings);

        request.getRequestDispatcher(
                "/customer/my-bookings.jsp")
               .forward(request, response);
    }
}