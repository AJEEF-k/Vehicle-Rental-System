package com.vrs.controller.customer;

import java.io.IOException;

import com.vrs.dao.implementation.VehicleDAOImpl;
import com.vrs.dao.interfaces.VehicleDAO;
import com.vrs.model.Vehicle;
import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/customer/vehicle-details")
public class VehicleDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private VehicleDAO vehicleDAO;

    @Override
    public void init() throws ServletException {
        vehicleDAO = new VehicleDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!AuthUtil.requireRole(request, response, "CUSTOMER")) {
            return;
        }

        String vehicleIdParameter =
                request.getParameter("vehicleId");

        if (vehicleIdParameter == null
                || vehicleIdParameter.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/vehicles?error=invalidVehicle");

            return;
        }

        try {

            int vehicleId =
                    Integer.parseInt(vehicleIdParameter);

            Vehicle vehicle =
                    vehicleDAO.getVehicleById(vehicleId);

            if (vehicle == null) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/vehicles?error=vehicleNotFound");

                return;
            }

            /*
             * Customer should not book a vehicle that is
             * currently under maintenance or inactive.
             */
            if (!"Available".equals(vehicle.getOperationalStatus())) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/customer/vehicles?error=vehicleUnavailable");

                return;
            }

            request.setAttribute("vehicle", vehicle);

            request.getRequestDispatcher(
                    "/customer/vehicle-details.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/customer/vehicles?error=invalidVehicle");
        }
    }
}