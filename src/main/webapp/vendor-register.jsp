<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Vendor Registration - DriveWay</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/common.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icons.css">


</head>

<body>

<div class="auth-page">

    <!-- Left panel -->
    <div class="auth-panel">

        <div class="auth-panel-brand">

            <div class="auth-panel-icon">
                <span class="custom-icon store-icon"></span>
            </div>

            <div class="auth-panel-title">
                Drive<span>Way</span>
            </div>

            <div class="auth-panel-subtitle">
                Register as a vendor and start offering your vehicles
                to customers through DriveWay.
            </div>

        </div>

        <div class="auth-panel-features">

            <div class="auth-feature">

                <div class="auth-feature-icon">
                    <span class="custom-icon car-icon"></span>
                </div>

                <div class="auth-feature-text">
                    List and manage your vehicles
                </div>

            </div>

            <div class="auth-feature">

                <div class="auth-feature-icon">
                    <span class="custom-icon calendar-check-icon"></span>
                </div>

                <div class="auth-feature-text">
                    Manage customer bookings
                </div>

            </div>

            <div class="auth-feature">

                <div class="auth-feature-icon">
                    <span class="custom-icon shield-icon"></span>
                </div>

                <div class="auth-feature-text">
                    Verified vendor accounts
                </div>

            </div>

        </div>

    </div>


    <!-- Right form panel -->
    <div class="auth-form-panel">

        <div class="auth-container">

            <h2>Become a Vendor</h2>

            <p class="auth-heading-sub">
                Register your rental business with DriveWay
            </p>

            <div class="auth-card">

                <%
                    String error =
                            request.getParameter("error");
                %>

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

                            Vendor registration failed. Please try again.

                        <% } else { %>

                            An unexpected error occurred.

                        <% } %>

                    </div>

                <% } %>


                <form class="auth-form"
                      action="${pageContext.request.contextPath}/vendor-register"
                      method="post">

                    <!-- Personal Information -->

                    <div class="form-group">

                        <label for="fullName">
                            Full Name
                        </label>

                        <div class="auth-input-wrap">

                            <span class="custom-icon user-icon"></span>

                            <input type="text"
                                   id="fullName"
                                   name="fullName"
                                   placeholder="Your full name"
                                   required>

                        </div>

                    </div>


                    <div class="form-group">

                        <label for="email">
                            Email Address
                        </label>

                        <div class="auth-input-wrap">

                            <span class="custom-icon email-icon"></span>

                            <input type="email"
                                   id="email"
                                   name="email"
                                   placeholder="you@example.com"
                                   required>

                        </div>

                    </div>


                    <div class="form-group">

                        <label for="phoneNumber">
                            Phone Number
                        </label>

                        <div class="auth-input-wrap">

                            <span class="custom-icon phone-icon"></span>

                            <input type="text"
                                   id="phoneNumber"
                                   name="phoneNumber"
                                   placeholder="10-digit mobile number"
                                   required>

                        </div>

                    </div>


                    <div class="form-group">

                        <label for="password">
                            Password
                        </label>

                        <div class="auth-input-wrap">

                            <span class="custom-icon lock-icon"></span>

                            <input type="password"
                                   id="password"
                                   name="password"
                                   placeholder="At least 8 characters"
                                   required>

                        </div>

                        <div class="form-hint">
                            Minimum 8 characters required
                        </div>

                    </div>


                    <div class="auth-divider">
                        <span>Business Information</span>
                    </div>


                    <div class="form-group">

                        <label for="agencyName">
                            Agency Name
                        </label>

                        <div class="auth-input-wrap">

                            <span class="custom-icon building-icon"></span>

                            <input type="text"
                                   id="agencyName"
                                   name="agencyName"
                                   placeholder="Your rental agency name"
                                   required>

                        </div>

                    </div>


                    <div class="form-group">

                        <label for="shopAddress">
                            Shop Address
                        </label>

                        <div class="auth-input-wrap">

                            <span class="custom-icon location-icon"></span>

                            <input type="text"
                                   id="shopAddress"
                                   name="shopAddress"
                                   placeholder="Business address"
                                   required>

                        </div>

                    </div>


                    <div class="form-group">

                        <label for="description">
                            Business Description
                        </label>

                        <textarea id="description"
                                  name="description"
                                  rows="4"
                                  placeholder="Tell customers about your rental business"></textarea>

                    </div>


                    <button type="submit"
                            class="auth-btn">

                        <span class="custom-icon store-icon"></span>

                        Register as Vendor

                    </button>

                </form>

            </div>


            <div class="auth-links">

                Already have an account?

                <a href="${pageContext.request.contextPath}/login.jsp">
                    Sign in
                </a>

                &nbsp;&middot;&nbsp;

                <a href="${pageContext.request.contextPath}/register.jsp">
                    Customer Registration
                </a>

                &nbsp;&middot;&nbsp;

                <a href="${pageContext.request.contextPath}/index.jsp">
                    Back to Home
                </a>

            </div>

        </div>

    </div>

</div>

</body>
</html>