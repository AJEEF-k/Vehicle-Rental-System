package com.vrs.controller.customer;

import java.io.IOException;
import java.util.List;

import com.vrs.dao.implementation.VehicleDAOImpl;
import com.vrs.dao.interfaces.VehicleDAO;
import com.vrs.model.Vehicle;
import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/customer/vehicles")
public class BrowseVehiclesServlet extends HttpServlet {

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

        String keyword = request.getParameter("keyword");

        List<Vehicle> vehicles;

        if (keyword == null || keyword.isBlank()) {

            vehicles = vehicleDAO.getAllVehicles();

        } else {

            keyword = keyword.trim();

            vehicles = vehicleDAO.searchVehicles(keyword);

            request.setAttribute("keyword", keyword);
        }

        request.setAttribute("vehicles", vehicles);

        request.getRequestDispatcher(
                "/customer/vehicles.jsp")
               .forward(request, response);
    }
}