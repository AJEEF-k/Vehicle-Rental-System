package com.vrs.controller.admin;

import java.io.IOException;

import com.vrs.dao.implementation.VendorDAOImpl;
import com.vrs.dao.interfaces.VendorDAO;
import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/vendor/reject")
public class VendorRejectionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private VendorDAO vendorDAO;

    @Override
    public void init() throws ServletException {
        vendorDAO = new VendorDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {

        if (!AuthUtil.requireRole(request, response, "ADMIN")) {
            return;
        }

        String vendorIdParameter =
                request.getParameter("vendorId");

        if (vendorIdParameter == null
                || vendorIdParameter.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/vendors?error=invalidVendor");

            return;
        }

        try {

            int vendorId = Integer.parseInt(vendorIdParameter);

            boolean updated =
                    vendorDAO.updateApprovalStatus(
                            vendorId,
                            "REJECTED");

            if (updated) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/vendors?success=rejected");

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/vendors?error=rejectionFailed");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/vendors?error=invalidVendor");
        }
    }
}