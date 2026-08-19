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

@WebServlet("/vendor/add-vehicle")
public class AddVehicleServlet extends HttpServlet {

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

        request.getRequestDispatcher("/vendor/add-vehicle.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

    	if (!AuthUtil.requireApprovedVendor(request, response)) {
    	    return;
    	}  

        User user = AuthUtil.getLoggedInUser(request);

        Vendor vendor =
                vendorDAO.getVendorByUserId(user.getUserId());

        if (vendor == null
                || !"APPROVED".equalsIgnoreCase(
                        vendor.getApprovalStatus())) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/dashboard?error=vendorNotApproved");

            return;
        }

        String registrationNumber =
                request.getParameter("registrationNumber");

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

        if (registrationNumber == null
                || registrationNumber.isBlank()
                || vehicleName == null
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
                    + "/vendor/add-vehicle?error=required");

            return;
        }

        try {

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
                        + "/vendor/add-vehicle?error=invalidValues");

                return;
            }

            Vehicle vehicle = new Vehicle();

            vehicle.setVendorId(vendor.getVendorId());
            vehicle.setRegistrationNumber(
                    registrationNumber.trim());
            vehicle.setVehicleName(vehicleName.trim());
            vehicle.setBrand(brand.trim());
            vehicle.setCategory(category.trim());
            vehicle.setHourlyRate(hourlyRate);
            vehicle.setDailyRate(dailyRate);
            vehicle.setBatteryRange(batteryRange);

            vehicle.setImagePath(
                    imagePath == null || imagePath.isBlank()
                            ? null
                            : imagePath.trim());

            vehicle.setOperationalStatus("Available");

            boolean added =
                    vehicleDAO.addVehicle(vehicle);

            if (added) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/vehicles?success=added");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/vendor/add-vehicle?error=failed");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/add-vehicle?error=invalidValues");
        }
    }
}