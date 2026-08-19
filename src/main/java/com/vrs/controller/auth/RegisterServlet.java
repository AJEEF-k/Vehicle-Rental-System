package com.vrs.controller.auth;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.vrs.dao.implementation.UserDAOImpl;
import com.vrs.dao.interfaces.UserDAO;
import com.vrs.model.User;
import com.vrs.utility.PasswordUtil;
import com.vrs.utility.ValidationUtil;

@WebServlet("/register")          
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {  

        String fullName = request.getParameter("fullName");   
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");

        if (fullName == null || fullName.isBlank()
                || email == null || email.isBlank()
                || password == null || password.isBlank()
                || phoneNumber == null || phoneNumber.isBlank()) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=required");

            return;
        }

        fullName = fullName.trim();
        email = email.trim();
        phoneNumber = phoneNumber.trim();

        if (!ValidationUtil.isValidEmail(email)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=email");

            return;
        }

        if (!ValidationUtil.isValidPhone(phoneNumber)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=phone");

            return;
        }

        if (!ValidationUtil.isValidPassword(password)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=password");

            return;
        }

        if (userDAO.emailExists(email)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=emailExists");

            return;
        }

        String hashedPassword =
                PasswordUtil.hashPassword(password);

        User user = new User();

        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setPhoneNumber(phoneNumber);

        /*
         * Public registration creates customers only.
         */
        user.setRole("customer");
        user.setAccountStatus("active");

        boolean registered = userDAO.registerUser(user);    

        if (registered) {

            /*
             * PRG:
             * POST → Redirect → GET
             */
            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?success=registered");

        } else {

            response.sendRedirect(
                    request.getContextPath()
                    + "/register.jsp?error=failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws IOException {

        response.sendRedirect(
                request.getContextPath() + "/register.jsp");
    }
}