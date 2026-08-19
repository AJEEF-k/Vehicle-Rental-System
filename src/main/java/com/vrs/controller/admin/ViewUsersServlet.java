package com.vrs.controller.admin;

import java.io.IOException;
import java.util.List;

import com.vrs.dao.implementation.UserDAOImpl;
import com.vrs.dao.interfaces.UserDAO;
import com.vrs.model.User;
import com.vrs.utility.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/users")
public class ViewUsersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();   
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!AuthUtil.requireRole(request, response, "ADMIN")) {
            return;
        }

        List<User> users = userDAO.getAllUsers();

        request.setAttribute("users", users);

        request.getRequestDispatcher("/admin/users.jsp")
               .forward(request, response);
    }
}