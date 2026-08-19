package com.vrs.controller.vendor;

import java.io.IOException;
import java.util.List;

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

@WebServlet("/vendor/vehicles")
public class VendorVehiclesServlet extends HttpServlet {

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

        User user = AuthUtil.getLoggedInUser(request);

        Vendor vendor =
                vendorDAO.getVendorByUserId(user.getUserId());

        if (vendor == null) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/vendor/dashboard?error=vendorProfile");
            return;
        }

        List<Vehicle> vehicles =
                vehicleDAO.getVehiclesByVendorId(
                        vendor.getVendorId());

        request.setAttribute("vehicles", vehicles);
  
        request.getRequestDispatcher("/vendor/vehicles.jsp")
               .forward(request, response);
    }
}