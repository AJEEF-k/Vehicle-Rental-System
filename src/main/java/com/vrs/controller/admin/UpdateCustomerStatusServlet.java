package com.vrs.controller.admin;

import java.io.IOException;

import com.vrs.dao.implementation.UserDAOImpl;
import com.vrs.dao.interfaces.UserDAO;
import com.vrs.model.User;
import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/customer/status")
public class UpdateCustomerStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        /*
         * Only ADMIN can access this operation.
         */
        if (!AuthUtil.requireRole(
                request,
                response,
                "ADMIN")) {

            return;
        }

        String userIdParameter =
                request.getParameter("userId");

        String accountStatus =
                request.getParameter("accountStatus");

        /*
         * Validate request parameters.
         */
        if (userIdParameter == null
                || userIdParameter.isBlank()
                || accountStatus == null
                || accountStatus.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/users?error=invalidRequest");

            return;
        }

        int userId;

        try {

            userId =
                    Integer.parseInt(
                            userIdParameter);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/users?error=invalidRequest");

            return;
        }

        /*
         * Only Active and Inactive are allowed.
         */
        if (!"Active".equalsIgnoreCase(accountStatus)
                && !"Inactive".equalsIgnoreCase(
                        accountStatus)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/users?error=invalidStatus");

            return;
        }

        /*
         * Find the target user.
         */
        User user =
                userDAO.getUserById(userId);

        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/users?error=userNotFound");

            return;
        }

        /*
         * IMPORTANT:
         * This feature is only for customers.
         * Vendor approval/rejection remains in Manage Vendors.
         */
        if (!"customer".equalsIgnoreCase(
                user.getRole())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/users?error=customerOnly");

            return;
        }

        /*
         * Avoid unnecessary database updates.
         */
        if (accountStatus.equalsIgnoreCase(
                user.getAccountStatus())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/users");

            return;
        }

        /*
         * Update account status.
         */
        boolean updated =
                userDAO.updateAccountStatus(
                        userId,
                        accountStatus);

        if (!updated) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/users?error=updateFailed");

            return;
        }

        response.sendRedirect(
                request.getContextPath()
                + "/admin/users?success=statusUpdated");
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        response.sendRedirect(
                request.getContextPath()
                + "/admin/users");
    }
}