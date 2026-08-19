package com.vrs.controller.vendor;

import java.io.IOException;

import com.vrs.dao.implementation.VehicleDAOImpl;
import com.vrs.dao.implementation.VendorDAOImpl;
import com.vrs.dao.interfaces.VehicleDAO;
import com.vrs.dao.interfaces.VendorDAO;
import com.vrs.model.User;
import com.vrs.model.Vehicle;
import com.vrs.model.Vendor;
import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/vendor/change-vehicle-status")
public class ChangeVehicleStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private VehicleDAO vehicleDAO;
    private VendorDAO vendorDAO;

    @Override
    public void init() throws ServletException {
        vehicleDAO = new VehicleDAOImpl();
        vendorDAO = new VendorDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

    	if (!AuthUtil.requireApprovedVendor(request, response)) {
    	    return;
    	}
        try {

            int vehicleId =
                    Integer.parseInt(
                            request.getParameter("vehicleId"));

            String status =
                    request.getParameter("status");

            if (!isValidStatus(status)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/vehicles?error=invalidStatus");

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

            Vehicle vehicle =
                    vehicleDAO.getVehicleById(vehicleId);

            if (vehicle == null
                    || vehicle.getVendorId()
                    != vendor.getVendorId()) {

                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN);

                return;
            }

            boolean updated =
                    vehicleDAO.updateOperationalStatus(
                            vehicleId,
                            status);

            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/vehicles?success=statusUpdated");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/vehicles?error=statusFailed");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/vehicles?error=invalidVehicle");
        }
    }

    private boolean isValidStatus(String status) {

        return "Available".equalsIgnoreCase(status)
                || "Maintenance".equalsIgnoreCase(status)
                || "Inactive".equalsIgnoreCase(status);
    }
}