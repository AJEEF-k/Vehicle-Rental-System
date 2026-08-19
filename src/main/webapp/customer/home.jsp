<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - DriveWay</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icons.css">
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="page-layout">

    <jsp:include page="/common/sidebar.jsp" />

    <main class="content">

        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <div class="welcome-text">
                <h2><span class="custom-icon wave-icon" style="color:rgba(255,255,255,0.6);font-size:1.2rem;margin-right:8px;"></span>Welcome to DriveWay!</h2>
                <p>Browse our fleet of vehicles and book your next ride in minutes.</p>
            </div>
            <div class="welcome-actions">
                <a href="${pageContext.request.contextPath}/customer/vehicles"
                   style="display:inline-flex;align-items:center;gap:8px;padding:11px 22px;background:var(--accent);color:white;border-radius:var(--radius-sm);font-weight:600;font-size:0.9rem;text-decoration:none;transition:var(--transition);">
                    <span class="custom-icon car-icon"></span> Browse Vehicles
                </a>
            </div>
        </div>

        <!-- Quick Links -->
        <div class="quick-links">
            <a href="${pageContext.request.contextPath}/customer/vehicles" class="quick-link-card">
                <div class="quick-link-icon blue"><span class="custom-icon car-icon"></span></div>
                <div class="quick-link-text">
                    <div class="quick-link-title">Browse Vehicles</div>
                    <div class="quick-link-desc">Find your next rental</div>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/customer/bookings" class="quick-link-card">
                <div class="quick-link-icon orange"><span class="custom-icon calendar-check-icon"></span></div>
                <div class="quick-link-text">
                    <div class="quick-link-title">My Bookings</div>
                    <div class="quick-link-desc">Track your rides</div>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/customer/profile" class="quick-link-card">
                <div class="quick-link-icon green"><span class="custom-icon user-icon"></span></div>
                <div class="quick-link-text">
                    <div class="quick-link-title">My Profile</div>
                    <div class="quick-link-desc">Update your details</div>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/customer/change-password" class="quick-link-card">
                <div class="quick-link-icon purple"><span class="custom-icon lock-icon"></span></div>
                <div class="quick-link-text">
                    <div class="quick-link-title">Change Password</div>
                    <div class="quick-link-desc">Secure your account</div>
                </div>
            </a>
        </div>

        <!-- Info section -->
        <div class="card">
            <div class="card-header">
                <div class="card-title"><span class="custom-icon info-icon"></span> How It Works</div>
            </div>
            <div class="card-body">
                <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:24px;">
                    <div style="text-align:center;padding:16px 8px;">
                        <div style="width:48px;height:48px;background:var(--primary-light);color:var(--primary);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.3rem;margin:0 auto 12px;">
                            <span class="custom-icon search-icon"></span>
                        </div>
                        <div style="font-weight:700;color:var(--dark);margin-bottom:5px;font-size:0.9rem;">1. Browse</div>
                        <div style="font-size:0.82rem;color:var(--text-muted);">Search vehicles by name, brand, or category</div>
                    </div>
                    <div style="text-align:center;padding:16px 8px;">
                        <div style="width:48px;height:48px;background:#FFF3ED;color:var(--accent);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.3rem;margin:0 auto 12px;">
                            <span class="custom-icon calendar-check-icon"></span>
                        </div>
                        <div style="font-weight:700;color:var(--dark);margin-bottom:5px;font-size:0.9rem;">2. Book</div>
                        <div style="font-size:0.82rem;color:var(--text-muted);">Pick your dates and payment method</div>
                    </div>
                    <div style="text-align:center;padding:16px 8px;">
                        <div style="width:48px;height:48px;background:var(--success-bg);color:var(--success);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.3rem;margin:0 auto 12px;">
                            <span class="custom-icon arrow-right-icon"></span>
                        </div>
                        <div style="font-weight:700;color:var(--dark);margin-bottom:5px;font-size:0.9rem;">3. Ride</div>
                        <div style="font-size:0.82rem;color:var(--text-muted);">Vendor confirms & you hit the road</div>
                    </div>
                    <div style="text-align:center;padding:16px 8px;">
                        <div style="width:48px;height:48px;background:var(--warning-bg);color:var(--warning);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.3rem;margin:0 auto 12px;">
                            <span class="custom-icon star-icon"></span>
                        </div>
                        <div style="font-weight:700;color:var(--dark);margin-bottom:5px;font-size:0.9rem;">4. Review</div>
                        <div style="font-size:0.82rem;color:var(--text-muted);">Leave a review to help others</div>
                    </div>
                </div>
            </div>
        </div>

    </main>

</div>

<jsp:include page="/common/footer.jsp" />

</body>
</html>
