package com.vrs.controller.admin;

import java.io.IOException;
import java.util.List;

import com.vrs.dao.implementation.VendorDAOImpl;
import com.vrs.dao.interfaces.VendorDAO;
import com.vrs.model.Vendor;
import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/vendors")
public class ViewVendorsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private VendorDAO vendorDAO;

    @Override
    public void init() throws ServletException {
        vendorDAO = new VendorDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!AuthUtil.requireRole(request, response, "ADMIN")) {
            return;
        }
   
        List<Vendor> vendors = vendorDAO.getAllVendors();

        request.setAttribute("vendors", vendors);

        request.getRequestDispatcher("/admin/vendors.jsp")
               .forward(request, response);
    }
}