package com.vrs.controller.admin;

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

@WebServlet("/admin/vehicles")
public class ViewVehiclesServlet extends HttpServlet {

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

        if (!AuthUtil.requireRole(request, response, "ADMIN")) {
            return;
        }

        List<Vehicle> vehicles = vehicleDAO.getAllVehiclesForAdmin();

        request.setAttribute("vehicles", vehicles);

        request.getRequestDispatcher("/admin/vehicles.jsp")
               .forward(request, response);
    }
}