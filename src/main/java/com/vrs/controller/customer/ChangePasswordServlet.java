package com.vrs.controller.customer;

import java.io.IOException;

import com.vrs.dao.implementation.UserDAOImpl;
import com.vrs.dao.interfaces.UserDAO;
import com.vrs.model.User;
import com.vrs.utility.AuthUtil;
import com.vrs.utility.PasswordUtil;
import com.vrs.utility.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/customer/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!AuthUtil.requireRole(request, response, "CUSTOMER")) {
            return;
        }

        request.getRequestDispatcher(
                "/customer/change-password.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

        if (!AuthUtil.requireRole(request, response, "CUSTOMER")) {
            return;
        }

        User user =
                AuthUtil.getLoggedInUser(request);

        String currentPassword =
                request.getParameter("currentPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");

        if (currentPassword == null
                || currentPassword.isBlank()
                || newPassword == null
                || newPassword.isBlank()
                || confirmPassword == null
                || confirmPassword.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/change-password?error=required");

            return;
        }

        /*
         * Verify current password.
         */
        if (!PasswordUtil.verifyPassword(
                currentPassword,
                user.getPassword())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/change-password?error=currentPassword");

            return;
        }

        if (!ValidationUtil.isValidPassword(newPassword)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/change-password?error=password");

            return;
        }

        if (!newPassword.equals(confirmPassword)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/change-password?error=mismatch");

            return;
        }

        /*
         * Prevent using the current password again.
         */
        if (PasswordUtil.verifyPassword(
                newPassword,
                user.getPassword())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/change-password?error=samePassword");

            return;
        }

        String hashedPassword =
                PasswordUtil.hashPassword(newPassword);

        boolean updated =
                userDAO.updatePassword(
                        user.getUserId(),
                        hashedPassword);

        if (!updated) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/change-password?error=failed");

            return;
        }

        /*
         * Keep the session User object synchronized.
         */
        user.setPassword(hashedPassword);

        request.getSession(false)
               .setAttribute("user", user);

        /*
         * PRG
         */
        response.sendRedirect(
                request.getContextPath()
                + "/customer/change-password?success=updated");
    }
}