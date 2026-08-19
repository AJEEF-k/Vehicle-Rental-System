package com.vrs.controller.vendor;

import java.io.IOException;

import com.vrs.dao.implementation.UserDAOImpl;
import com.vrs.dao.implementation.VendorDAOImpl;
import com.vrs.dao.interfaces.UserDAO;
import com.vrs.dao.interfaces.VendorDAO;
import com.vrs.model.User;
import com.vrs.model.Vendor;
import com.vrs.utility.AuthUtil;
import com.vrs.utility.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/vendor/profile")
public class VendorProfileServlet extends HttpServlet {

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
            throws ServletException, IOException {

    	if (!AuthUtil.requireApprovedVendor(request, response)) {
    	    return;
    	}

        User user = AuthUtil.getLoggedInUser(request);

        Vendor vendor =
                vendorDAO.getVendorByUserId(user.getUserId());

        if (vendor == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/dashboard?error=vendorProfile");

            return;
        }

        request.setAttribute("user", user);
        request.setAttribute("vendor", vendor);

        request.getRequestDispatcher("/vendor/profile.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

    	if (!AuthUtil.requireApprovedVendor(request, response)) {
    	    return;
    	}
    	
        User loggedInUser =
                AuthUtil.getLoggedInUser(request);

        Vendor existingVendor =
                vendorDAO.getVendorByUserId(
                        loggedInUser.getUserId());

        if (existingVendor == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/dashboard?error=vendorProfile");

            return;
        }

        String fullName =
                request.getParameter("fullName");

        String email =
                request.getParameter("email");

        String phoneNumber =
                request.getParameter("phoneNumber");

        String agencyName =
                request.getParameter("agencyName");

        String shopAddress =
                request.getParameter("shopAddress");

        String description =
                request.getParameter("description");

        if (fullName == null || fullName.isBlank()
                || email == null || email.isBlank()
                || phoneNumber == null || phoneNumber.isBlank()
                || agencyName == null || agencyName.isBlank()
                || shopAddress == null || shopAddress.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/profile?error=required");

            return;
        }

        fullName = fullName.trim();
        email = email.trim();
        phoneNumber = phoneNumber.trim();
        agencyName = agencyName.trim();
        shopAddress = shopAddress.trim();

        if (!ValidationUtil.isValidEmail(email)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/profile?error=email");

            return;
        }

        if (!ValidationUtil.isValidPhone(phoneNumber)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/profile?error=phone");

            return;
        }

        /*
         * Email is editable but must remain unique.
         *
         * If the email is unchanged, this is fine.
         * If it belongs to another user, reject the update.
         */
        User existingUser =
                userDAO.getUserByEmail(email);

        if (existingUser != null
                && existingUser.getUserId()
                != loggedInUser.getUserId()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/profile?error=emailExists");

            return;
        }

        User user = new User();

        user.setUserId(loggedInUser.getUserId());
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumber);

        boolean userUpdated =
                userDAO.updateProfile(user);

        if (!userUpdated) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/profile?error=updateFailed");

            return;
        }

        Vendor vendor = new Vendor();

        vendor.setVendorId(existingVendor.getVendorId());
        vendor.setUserId(loggedInUser.getUserId());
        vendor.setAgencyName(agencyName);
        vendor.setShopAddress(shopAddress);
        vendor.setDescription(
                description == null
                        ? null
                        : description.trim());

        boolean vendorUpdated =
                vendorDAO.updateVendor(vendor);

        if (!vendorUpdated) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/profile?error=updateFailed");

            return;
        }

        /*
         * Update the User object stored in the session
         * so the new profile information is immediately
         * available without requiring another login.
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
                + "/vendor/profile?success=updated");
    }
}