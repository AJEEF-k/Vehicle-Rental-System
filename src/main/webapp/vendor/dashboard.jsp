<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Dashboard - DriveWay</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vendor.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icons.css">
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="page-layout">

    <jsp:include page="/common/vendor-sidebar.jsp" />

    <main class="content">

        <div class="page-header">
            <div class="page-header-left">
                <div class="page-title"><span class="custom-icon gauge-icon"></span> Vendor Dashboard</div>
                <div class="page-subtitle">Manage your fleet and bookings from one place</div>
            </div>
        </div>

        <!-- Welcome Banner -->
        <div style="background:linear-gradient(135deg,#0D1B2A 0%,#1A3D6E 100%);border-radius:var(--radius-lg);padding:28px 32px;margin-bottom:24px;position:relative;overflow:hidden;">
            <div style="position:absolute;right:-30px;top:-30px;width:180px;height:180px;background:rgba(255,107,43,0.1);border-radius:50%;"></div>
            <div style="position:relative;z-index:1;">
                <h2 style="color:white;font-size:1.35rem;margin-bottom:6px;"><span class="custom-icon store-icon" style="background-color:var(--accent);margin-right:8px;"></span>Welcome to your Vendor Portal</h2>
                <p style="color:rgba(255,255,255,0.55);font-size:0.875rem;">Add vehicles, manage your fleet, and track bookings from customers.</p>
            </div>
        </div>

        <!-- Quick Stat Cards -->
        <div class="vendor-stat-cards">
            <div class="vendor-stat-card">
                <div class="vendor-stat-icon stat-icon-blue"><span class="custom-icon car-icon"></span></div>
                <div>
                    <div class="vendor-stat-value">—</div>
                    <div class="vendor-stat-label">My Vehicles</div>
                </div>
            </div>
            <div class="vendor-stat-card">
                <div class="vendor-stat-icon stat-icon-orange"><span class="custom-icon calendar-check-icon"></span></div>
                <div>
                    <div class="vendor-stat-value">—</div>
                    <div class="vendor-stat-label">Active Bookings</div>
                </div>
            </div>
            <div class="vendor-stat-card">
                <div class="vendor-stat-icon stat-icon-green"><span class="custom-icon check-circle-icon"></span></div>
                <div>
                    <div class="vendor-stat-value">—</div>
                    <div class="vendor-stat-label">Completed</div>
                </div>
            </div>
        </div>

        <!-- Action Cards -->
        <div style="font-size:0.78rem;font-weight:600;text-transform:uppercase;letter-spacing:0.08em;color:var(--text-muted);margin-bottom:14px;">Quick Actions</div>
        <div class="vendor-card-grid">

            <div class="vendor-card">
                <div class="vendor-card-icon" style="background:#EFF6FF;color:#1A56DB;">
                    <span class="custom-icon car-icon"></span>
                </div>
                <h3>My Vehicles</h3>
                <p>View, edit, and manage all vehicles listed under your account.</p>
                <div class="vendor-card-actions">
                    <a href="${pageContext.request.contextPath}/vendor/vehicles">
                        <span class="custom-icon arrow-right-icon"></span> View My Vehicles
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/add-vehicle" style="color:var(--accent);">
                        <span class="custom-icon plus-icon"></span> Add New Vehicle
                    </a>
                </div>
            </div>

            <div class="vendor-card">
                <div class="vendor-card-icon" style="background:#FFF7ED;color:#FF6B2B;">
                    <span class="custom-icon calendar-icon"></span>
                </div>
                <h3>Bookings</h3>
                <p>Manage incoming bookings — confirm, start, or complete customer rentals.</p>
                <div class="vendor-card-actions">
                    <a href="${pageContext.request.contextPath}/vendor/bookings">
                        <span class="custom-icon arrow-right-icon"></span> View All Bookings
                    </a>
                </div>
            </div>

            <div class="vendor-card">
                <div class="vendor-card-icon" style="background:#F0FDF4;color:#10B981;">
                    <span class="custom-icon building-icon"></span>
                </div>
                <h3>Account</h3>
                <p>Update your agency profile information and change your password.</p>
                <div class="vendor-card-actions">
                    <a href="${pageContext.request.contextPath}/vendor/profile">
                        <span class="custom-icon edit-icon"></span> Edit Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/change-password" style="color:var(--text-muted);">
                        <span class="custom-icon lock-icon"></span> Change Password
                    </a>
                </div>
            </div>

        </div>

    </main>

</div>

<jsp:include page="/common/footer.jsp" />

</body>
</html>
