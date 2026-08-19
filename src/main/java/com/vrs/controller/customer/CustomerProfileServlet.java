package com.vrs.controller.customer;

import java.io.IOException;

import com.vrs.dao.implementation.UserDAOImpl;
import com.vrs.dao.interfaces.UserDAO;
import com.vrs.model.User;
import com.vrs.utility.AuthUtil;
import com.vrs.utility.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/customer/profile")
public class CustomerProfileServlet extends HttpServlet {

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

        User user = AuthUtil.getLoggedInUser(request);

        request.setAttribute("user", user);

        request.getRequestDispatcher(
                "/customer/profile.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

        if (!AuthUtil.requireRole(request, response, "CUSTOMER")) {
            return;
        }

        User loggedInUser =
                AuthUtil.getLoggedInUser(request);

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String phoneNumber =
                request.getParameter("phoneNumber");

        if (fullName == null || fullName.isBlank()
                || email == null || email.isBlank()
                || phoneNumber == null || phoneNumber.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/profile?error=required");

            return;
        }

        fullName = fullName.trim();
        email = email.trim();
        phoneNumber = phoneNumber.trim();

        if (!ValidationUtil.isValidEmail(email)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/profile?error=email");

            return;
        }

        if (!ValidationUtil.isValidPhone(phoneNumber)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/profile?error=phone");

            return;
        }

        /*
         * Email is editable but must remain unique.
         */
        User existingUser =
                userDAO.getUserByEmail(email);

        if (existingUser != null
                && existingUser.getUserId()
                != loggedInUser.getUserId()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/profile?error=emailExists");

            return;
        }

        User updatedUser = new User();

        updatedUser.setUserId(
                loggedInUser.getUserId());

        updatedUser.setFullName(fullName);
        updatedUser.setEmail(email);
        updatedUser.setPhoneNumber(phoneNumber);

        boolean updated =
                userDAO.updateProfile(updatedUser);

        if (!updated) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/profile?error=updateFailed");

            return;
        }

        /*
         * Update the session object so the new values
         * are immediately available.
         */
        loggedInUser.setFullName(fullName);
        loggedInUser.setEmail(email);
        loggedInUser.setPhoneNumber(phoneNumber);

        request.getSession(false)
               .setAttribute("user", loggedInUser);

        /*
         * PRG
         */
        response.sendRedirect(
                request.getContextPath()
                + "/customer/profile?success=updated");
    }
}