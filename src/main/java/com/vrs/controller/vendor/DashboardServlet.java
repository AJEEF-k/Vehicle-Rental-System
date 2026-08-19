package com.vrs.controller.vendor;

import java.io.IOException;

import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/vendor/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

    	if (!AuthUtil.requireApprovedVendor(request, response)) {
    	    return;
    	}  

        request.getRequestDispatcher("/vendor/dashboard.jsp")
               .forward(request, response);
    }
}