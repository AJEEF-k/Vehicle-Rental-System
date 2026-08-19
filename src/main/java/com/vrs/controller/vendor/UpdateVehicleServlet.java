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

@WebServlet("/vendor/update-vehicle")
public class UpdateVehicleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private VehicleDAO vehicleDAO;
    private VendorDAO vendorDAO;

    @Override
    public void init() throws ServletException {
        vehicleDAO = new VehicleDAOImpl();
        vendorDAO = new VendorDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

    	if (!AuthUtil.requireApprovedVendor(request, response)) {
    	    return;
    	}

        String vehicleIdParameter =
                request.getParameter("vehicleId");

        if (vehicleIdParameter == null
                || vehicleIdParameter.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/vehicles?error=invalidVehicle");

            return;
        }

        try {

            int vehicleId =
                    Integer.parseInt(vehicleIdParameter);

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
                    || vehicle.getVendorId() != vendor.getVendorId()) {

                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN);

                return;
            }

            request.setAttribute("vehicle", vehicle);

            request.getRequestDispatcher(
                    "/vendor/edit-vehicle.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/vehicles?error=invalidVehicle");
        }
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

            User user = AuthUtil.getLoggedInUser(request);

            Vendor vendor =
                    vendorDAO.getVendorByUserId(user.getUserId());

            if (vendor == null) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/dashboard?error=vendorProfile");

                return;
            }

            Vehicle existingVehicle =
                    vehicleDAO.getVehicleById(vehicleId);

            if (existingVehicle == null
                    || existingVehicle.getVendorId()
                    != vendor.getVendorId()) {

                response.sendError(
                        HttpServletResponse.SC_FORBIDDEN);

                return;
            }

            String vehicleName =
                    request.getParameter("vehicleName");

            String brand =
                    request.getParameter("brand");

            String category =
                    request.getParameter("category");

            String hourlyRateParameter =
                    request.getParameter("hourlyRate");

            String dailyRateParameter =
                    request.getParameter("dailyRate");

            String batteryRangeParameter =
                    request.getParameter("batteryRange");

            String imagePath =
                    request.getParameter("imagePath");

            if (vehicleName == null
                    || vehicleName.isBlank()
                    || brand == null
                    || brand.isBlank()
                    || category == null
                    || category.isBlank()
                    || hourlyRateParameter == null
                    || dailyRateParameter == null
                    || batteryRangeParameter == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/update-vehicle?vehicleId="
                        + vehicleId
                        + "&error=required");

                return;
            }

            int hourlyRate =
                    Integer.parseInt(hourlyRateParameter);

            int dailyRate =
                    Integer.parseInt(dailyRateParameter);

            int batteryRange =
                    Integer.parseInt(batteryRangeParameter);

            if (hourlyRate <= 0
                    || dailyRate <= 0
                    || batteryRange <= 0) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/update-vehicle?vehicleId="
                        + vehicleId
                        + "&error=invalidValues");

                return;
            }

            Vehicle vehicle = new Vehicle();

            vehicle.setVehicleId(vehicleId);
            vehicle.setVendorId(vendor.getVendorId());

            /*
             * Registration number is intentionally not changed.
             * It identifies the vehicle.
             */
            vehicle.setRegistrationNumber(
                    existingVehicle.getRegistrationNumber());

            vehicle.setVehicleName(vehicleName.trim());
            vehicle.setBrand(brand.trim());
            vehicle.setCategory(category.trim());
            vehicle.setHourlyRate(hourlyRate);
            vehicle.setDailyRate(dailyRate);
            vehicle.setBatteryRange(batteryRange);

            vehicle.setImagePath(
                    imagePath == null || imagePath.isBlank()
                            ? existingVehicle.getImagePath()
                            : imagePath.trim());

            boolean updated =
                    vehicleDAO.updateVehicle(vehicle);

            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/vehicles?success=updated");

            } else {

                response.sendRedirect(   
                        request.getContextPath()
                        + "/vendor/update-vehicle?vehicleId="
                        + vehicleId
                        + "&error=failed");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/vehicles?error=invalidValues");
        }
    }
}