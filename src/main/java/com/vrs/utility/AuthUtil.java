package com.vrs.utility;

import com.vrs.model.User;

import com.vrs.dao.implementation.VendorDAOImpl;
import com.vrs.dao.interfaces.VendorDAO;
import com.vrs.model.Vendor;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AuthUtil {

    private AuthUtil() {
    }

    public static User getLoggedInUser(HttpServletRequest request) {

        HttpSession session = request.getSession(false);

        if (session == null) {
            return null;
        }     
   
        return (User) session.getAttribute("user");
    }

    public static boolean isLoggedIn(HttpServletRequest request) {

        return getLoggedInUser(request) != null;
    }

    public static boolean hasRole(HttpServletRequest request,
                                  String requiredRole) {

        User user = getLoggedInUser(request);

        if (user == null || requiredRole == null) {
            return false;
        }

        return requiredRole.equalsIgnoreCase(user.getRole());
    }

    public static boolean requireLogin(HttpServletRequest request,
                                       HttpServletResponse response)
            throws IOException {

        if (!isLoggedIn(request)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=session");

            return false;
        }

        return true;
    }

    public static boolean requireRole(HttpServletRequest request,
                                      HttpServletResponse response,
                                      String requiredRole)
            throws IOException {
  
        User user = getLoggedInUser(request);

        if (user == null) {

            response.sendRedirect(   
                    request.getContextPath()  
                    + "/login.jsp?error=session");

            return false;
        }

        if (!requiredRole.equalsIgnoreCase(user.getRole())) {

            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN);

            return false;   
        }

        return true;
    }
    
    
    public static boolean requireApprovedVendor(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        User user = getLoggedInUser(request);

        if (user == null) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=session");

            return false;
        }

        if (!"vendor".equalsIgnoreCase(user.getRole())) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN);

            return false;
        }

        VendorDAO vendorDAO = new VendorDAOImpl();

        Vendor vendor = vendorDAO.getVendorByUserId(user.getUserId());

        if (vendor == null) {
            response.sendError(
                    HttpServletResponse.SC_FORBIDDEN);

            return false;
        }

        if (!"APPROVED".equalsIgnoreCase(
                vendor.getApprovalStatus())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=vendorNotApproved");

            return false;
        }

        return true;
    }
}