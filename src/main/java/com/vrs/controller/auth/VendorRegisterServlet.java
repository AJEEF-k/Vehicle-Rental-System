package com.vrs.controller.auth;

import java.io.IOException;

import com.vrs.dao.implementation.UserDAOImpl;
import com.vrs.dao.implementation.VendorDAOImpl;
import com.vrs.dao.interfaces.UserDAO;
import com.vrs.dao.interfaces.VendorDAO;
import com.vrs.model.User;
import com.vrs.model.Vendor;
import com.vrs.utility.PasswordUtil;
import com.vrs.utility.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/vendor-register")
public class VendorRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;
    private VendorDAO vendorDAO;

    @Override
    public void init() throws ServletException {

        userDAO = new UserDAOImpl();
        vendorDAO = new VendorDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        response.sendRedirect(
                request.getContextPath()
                + "/vendor-register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");

        String agencyName = request.getParameter("agencyName");
        String shopAddress = request.getParameter("shopAddress");
        String description = request.getParameter("description");

        /*
         * Required fields
         */
        if (fullName == null || fullName.isBlank()
                || email == null || email.isBlank()
                || phoneNumber == null || phoneNumber.isBlank()
                || password == null || password.isBlank()
                || agencyName == null || agencyName.isBlank()
                || shopAddress == null || shopAddress.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor-register.jsp?error=required");

            return;
        }

        fullName = fullName.trim();
        email = email.trim();
        phoneNumber = phoneNumber.trim();
        agencyName = agencyName.trim();
        shopAddress = shopAddress.trim();

        if (description != null) {
            description = description.trim();
        }

        /*
         * Validate common user fields
         */
        if (!ValidationUtil.isValidEmail(email)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor-register.jsp?error=email");

            return;
        }

        if (!ValidationUtil.isValidPhone(phoneNumber)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor-register.jsp?error=phone");

            return;
        }

        if (!ValidationUtil.isValidPassword(password)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor-register.jsp?error=password");

            return;
        }

        /*
         * Email must be unique across all users.
         */
        if (userDAO.emailExists(email)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor-register.jsp?error=emailExists");

            return;
        }

        /*
         * Create user first.
         */
        String hashedPassword =
                PasswordUtil.hashPassword(password);

        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);
        user.setPassword(hashedPassword);

        /*
         * Vendor registration is different from
         * public customer registration.
         */
        user.setRole("vendor");
        user.setAccountStatus("active");

        boolean userCreated =
                userDAO.registerUser(user);

        if (!userCreated) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor-register.jsp?error=failed");

            return;
        }

        /*
         * registerUser() returns only boolean.
         * Fetch the newly created user to obtain userId.
         */
        User createdUser =
                userDAO.getUserByEmail(email);

        if (createdUser == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor-register.jsp?error=failed");

            return;
        }

        /*
         * Create vendor profile.
         *
         * IMPORTANT:
         * New vendors must start as PENDING.
         * They cannot access vendor features until
         * an admin approves them.
         */
        Vendor vendor = new Vendor();

        vendor.setUserId(createdUser.getUserId());
        vendor.setAgencyName(agencyName);
        vendor.setShopAddress(shopAddress);
        vendor.setDescription(description);
        vendor.setApprovalStatus("PENDING");

        boolean vendorCreated =
                vendorDAO.addVendor(vendor);

        if (!vendorCreated) {

            /*
             * Cleanup the newly created user if
             * vendor creation fails.
             */
            if (createdUser.getUserId() > 0) {
                ((UserDAOImpl) userDAO)
                        .deleteUserById(
                                createdUser.getUserId());
            }

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor-register.jsp?error=failed");

            return;
        }

        /*
         * PRG:
         * POST → Redirect → GET
         */
        response.sendRedirect(
                request.getContextPath()
                + "/login.jsp?success=vendorRegistered");
    }
}