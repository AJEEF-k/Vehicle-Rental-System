package com.vrs.controller.auth;

import java.io.IOException;

import com.vrs.dao.implementation.VendorDAOImpl;
import com.vrs.dao.interfaces.VendorDAO;
import com.vrs.model.Vendor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.vrs.dao.implementation.UserDAOImpl;
import com.vrs.dao.interfaces.UserDAO;
import com.vrs.model.User;
import com.vrs.utility.PasswordUtil;
import com.vrs.utility.ValidationUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

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

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isBlank()
                || password == null || password.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=required");

            return;
        }

        email = email.trim();

        if (!ValidationUtil.isValidEmail(email)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=email");

            return;
        }

        User user = userDAO.getUserByEmail(email);

        if (user == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=invalid");

            return;
        }

        boolean passwordMatches =
                PasswordUtil.verifyPassword(
                        password,
                        user.getPassword());

        if (!passwordMatches) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=invalid");

            return;
        }

        if (!"active".equalsIgnoreCase(user.getAccountStatus())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=inactive");

            return;
        }
            
        if ("vendor".equalsIgnoreCase(user.getRole())) {

            VendorDAO vendorDAO = new VendorDAOImpl();

            Vendor vendor =
                    vendorDAO.getVendorByUserId(user.getUserId());

            if (vendor == null
                    || !"APPROVED".equalsIgnoreCase(
                            vendor.getApprovalStatus())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login.jsp?error=vendorNotApproved");

                return;
            }
        }

        /*
         * Prevent session fixation.
         * Create a fresh session after successful authentication.
         */
        HttpSession oldSession = request.getSession(false);

        if (oldSession != null) {
            oldSession.invalidate();
        }

        HttpSession session = request.getSession(true);

        session.setAttribute("user", user);

        /*
         * Role-based redirection.
         */
        String role = user.getRole();

        if ("customer".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/home");

        } else if ("vendor".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/dashboard");

        } else if ("admin".equalsIgnoreCase(role)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/dashboard");

        } else {

            session.invalidate();

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=invalidRole");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        response.sendRedirect(
                request.getContextPath() + "/login.jsp");
    }
}