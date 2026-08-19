<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - DriveWay</title>
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
            <div class="auth-panel-subtitle">Your journey starts here. Rent electric &amp; conventional vehicles from trusted vendors across the city.</div>
        </div>
        <div class="auth-panel-features">
            <div class="auth-feature">
                <div class="auth-feature-icon"><span class="custom-icon shield-icon"></span></div>
                <div class="auth-feature-text">Verified vendors &amp; secure bookings</div>
            </div>
            <div class="auth-feature">
                <div class="auth-feature-icon"><span class="custom-icon bolt-icon"></span></div>
                <div class="auth-feature-text">Instant booking confirmation</div>
            </div>
            <div class="auth-feature">
                <div class="auth-feature-icon"><span class="custom-icon rupee-icon"></span></div>
                <div class="auth-feature-text">Flexible hourly &amp; daily rates</div>
            </div>
        </div>
    </div>

    <!-- Right form panel -->
    <div class="auth-form-panel">
        <div class="auth-container">
            <h2>Welcome back</h2>
            <p class="auth-heading-sub">Sign in to your DriveWay account</p>

            <div class="auth-card">
            
            
			  <% String success = request.getParameter("success"); %>
				
				<% if ("registered".equals(success)) { %>
				
				    <div class="auth-message success">
				        <span class="custom-icon check-circle-icon"></span>
				        Customer account created successfully. Please sign in.
				    </div>
				
				<% } else if ("vendorRegistered".equals(success)) { %>
				
				    <div class="auth-message success">
				        <span class="custom-icon check-circle-icon"></span>
				        Vendor registration submitted successfully.
				        Please wait for admin approval before signing in.
				    </div>

                  <% } %>
                  

                <% String error = request.getParameter("error"); %>
                
                <% if (error != null) { %>
                    <div class="auth-message">
                        <span class="custom-icon warning-icon"></span>
                        <% if ("invalid".equals(error)) { %>
                            Invalid email or password. Please try again.
                        <% } else if ("inactive".equals(error)) { %>
                            Your account is currently inactive.
                        <% } else if ("vendorNotApproved".equals(error)) { %>
                            Your vendor account is pending admin approval.
                        <% } else if ("session".equals(error)) { %>
                            Please sign in to continue.
                        <% } else { %>
                            An error occurred. Please try again.
                        <% } %>
                    </div>
                <% } %>

                <form class="auth-form" action="${pageContext.request.contextPath}/login" method="post">

                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <div class="auth-input-wrap">
                            <span class="custom-icon email-icon"></span>
                            <input type="email" id="email" name="email" placeholder="you@example.com" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="auth-input-wrap">
                            <span class="custom-icon lock-icon"></span>
                            <input type="password" id="password" name="password" placeholder="Enter your password" required>
                        </div>
                    </div>

                    <button type="submit" class="auth-btn">
                        <span class="custom-icon login-icon"></span>
                        Sign In
                    </button>

                </form>
            </div>

			 <div class="auth-links">
			
			    Don't have an account?
			
			    <a href="${pageContext.request.contextPath}/register.jsp">
			        Customer Registration
			    </a>
			
			    &nbsp;&middot;&nbsp;
			
			    <a href="${pageContext.request.contextPath}/vendor-register.jsp">
			        Vendor Registration
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
