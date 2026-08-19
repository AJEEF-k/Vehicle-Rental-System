package com.vrs.controller.admin;

import java.io.IOException;
import java.util.List;

import com.vrs.dao.implementation.ReviewDAOImpl;
import com.vrs.dao.interfaces.ReviewDAO;
import com.vrs.model.Review;
import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/reviews")
public class ViewReviewsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!AuthUtil.requireRole(request, response, "ADMIN")) {
            return;
        }

        List<Review> reviews =
                reviewDAO.getAllReviews();

        request.setAttribute("reviews", reviews);

        request.getRequestDispatcher("/admin/reviews.jsp")
               .forward(request, response);
    }
}