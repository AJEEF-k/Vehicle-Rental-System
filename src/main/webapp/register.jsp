<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - DriveWay</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icons.css">
</head>
<body>

<div class="auth-page">

    <!-- Left brand panel -->
    <div class="auth-panel">
        <div class="auth-panel-brand">
            <div class="auth-panel-icon">
                <span class="custom-icon car-icon"></span>
            </div>
            <div class="auth-panel-title">Drive<span>Way</span></div>
            <div class="auth-panel-subtitle">Create your free customer account and start renting vehicles from verified vendors today.</div>
        </div>
        <div class="auth-panel-features">
            <div class="auth-feature">
                <div class="auth-feature-icon"><span class="custom-icon car-icon"></span></div>
                <div class="auth-feature-text">Access hundreds of vehicles instantly</div>
            </div>
            <div class="auth-feature">
                <div class="auth-feature-icon"><span class="custom-icon calendar-check-icon"></span></div>
                <div class="auth-feature-text">Book hourly or daily — your choice</div>
            </div>
            <div class="auth-feature">
                <div class="auth-feature-icon"><span class="custom-icon star-icon"></span></div>
                <div class="auth-feature-text">Rate &amp; review after every booking</div>
            </div>
        </div>
    </div>

    <!-- Right form panel -->
    <div class="auth-form-panel">
        <div class="auth-container">
            <h2>Create your account</h2>
            <p class="auth-heading-sub">Join DriveWay as a customer — it's free</p>

            <div class="auth-card">

                <% String error = request.getParameter("error"); %>
                <% if (error != null) { %>
                    <div class="auth-message">
                        <span class="custom-icon warning-icon"></span>
                        <% if ("required".equals(error)) { %>
                            Please fill in all required fields.
                        <% } else if ("email".equals(error)) { %>
                            Please enter a valid email address.
                        <% } else if ("phone".equals(error)) { %>
                            Please enter a valid 10-digit phone number.
                        <% } else if ("password".equals(error)) { %>
                            Password must be at least 8 characters long.
                        <% } else if ("emailExists".equals(error)) { %>
                            An account with this email already exists.
                        <% } else if ("failed".equals(error)) { %>
                            Registration failed. Please try again.
                        <% } else { %>
                            An unexpected error occurred.
                        <% } %>
                    </div>
                <% } %>

                <form class="auth-form" action="${pageContext.request.contextPath}/register" method="post">

                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <div class="auth-input-wrap">
                            <span class="custom-icon user-icon"></span>
                            <input type="text" id="fullName" name="fullName" placeholder="Your full name" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <div class="auth-input-wrap">
                            <span class="custom-icon email-icon"></span>
                            <input type="email" id="email" name="email" placeholder="you@example.com" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="phoneNumber">Phone Number</label>
                        <div class="auth-input-wrap">
                            <span class="custom-icon phone-icon"></span>
                            <input type="text" id="phoneNumber" name="phoneNumber" placeholder="10-digit mobile number" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="auth-input-wrap">
                            <span class="custom-icon lock-icon"></span>
                            <input type="password" id="password" name="password" placeholder="At least 8 characters" required>
                        </div>
                        <div class="form-hint">Minimum 8 characters required</div>
                    </div>

                    <button type="submit" class="auth-btn" style="background:var(--accent);">
                        <span class="custom-icon user-plus-icon"></span>
                        Create Account
                    </button>

                </form>
            </div>

            <div class="auth-links">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login.jsp">Sign in</a>
                &nbsp;&middot;&nbsp;
                <a href="${pageContext.request.contextPath}/index.jsp">Back to Home</a>
            </div>
        </div>
    </div>

</div>

</body>
</html>
