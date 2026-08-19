<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - DriveWay</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icons.css">
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="page-layout">

    <jsp:include page="/common/admin-sidebar.jsp" />

    <main class="content">

        <div class="page-header">
            <div class="page-header-left">
                <div class="page-title"><span class="custom-icon chart-icon"></span> Admin Dashboard</div>
                <div class="page-subtitle">System overview and quick management access</div>
            </div>
        </div>

        <!-- Stat Cards -->
        <div class="stat-cards">
            <a href="${pageContext.request.contextPath}/admin/users" class="stat-card">
                <div class="stat-icon stat-icon-blue"><span class="custom-icon users-icon"></span></div>
                <div class="stat-content">
                    <div class="stat-value">—</div>
                    <div class="stat-label">Total Users</div>
                    <div class="stat-link">View all <span class="custom-icon arrow-right-icon" style="font-size:0.65rem;"></span></div>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/vendors" class="stat-card">
                <div class="stat-icon stat-icon-orange"><span class="custom-icon store-icon"></span></div>
                <div class="stat-content">
                    <div class="stat-value">—</div>
                    <div class="stat-label">Vendors</div>
                    <div class="stat-link">View all <span class="custom-icon arrow-right-icon" style="font-size:0.65rem;"></span></div>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/vehicles" class="stat-card">
                <div class="stat-icon stat-icon-green"><span class="custom-icon car-icon"></span></div>
                <div class="stat-content">
                    <div class="stat-value">—</div>
                    <div class="stat-label">Vehicles Listed</div>
                    <div class="stat-link">View all <span class="custom-icon arrow-right-icon" style="font-size:0.65rem;"></span></div>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/bookings" class="stat-card">
                <div class="stat-icon stat-icon-purple"><span class="custom-icon calendar-icon"></span></div>
                <div class="stat-content">
                    <div class="stat-value">—</div>
                    <div class="stat-label">Total Bookings</div>
                    <div class="stat-link">View all <span class="custom-icon arrow-right-icon" style="font-size:0.65rem;"></span></div>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/reviews" class="stat-card">
                <div class="stat-icon stat-icon-yellow"><span class="custom-icon star-icon"></span></div>
                <div class="stat-content">
                    <div class="stat-value">—</div>
                    <div class="stat-label">Reviews</div>
                    <div class="stat-link">View all <span class="custom-icon arrow-right-icon" style="font-size:0.65rem;"></span></div>
                </div>
            </a>
        </div>

        <!-- Management Cards -->
        <div style="margin-bottom:16px;">
            <div style="font-size:0.78rem;font-weight:600;text-transform:uppercase;letter-spacing:0.08em;color:var(--text-muted);margin-bottom:14px;">Management Sections</div>
            <div class="admin-card-list">

                <div class="admin-card">
                    <div class="admin-card-icon" style="background:#EFF6FF;color:#1A56DB;"><span class="custom-icon users-icon"></span></div>
                    <h3>Manage Users</h3>
                    <p>View all registered customers and vendor accounts on the platform.</p>
                    <a href="${pageContext.request.contextPath}/admin/users">View Users <span class="custom-icon arrow-right-icon" style="font-size:0.75rem;"></span></a>
                </div>

                <div class="admin-card">
                    <div class="admin-card-icon" style="background:#FFF7ED;color:#FF6B2B;"><span class="custom-icon store-icon"></span></div>
                    <h3>Manage Vendors</h3>
                    <p>Approve or reject vendor registration requests. Monitor vendor activity.</p>
                    <a href="${pageContext.request.contextPath}/admin/vendors">View Vendors <span class="custom-icon arrow-right-icon" style="font-size:0.75rem;"></span></a>
                </div>

                <div class="admin-card">
                    <div class="admin-card-icon" style="background:#F0FDF4;color:#10B981;"><span class="custom-icon car-icon"></span></div>
                    <h3>All Vehicles</h3>
                    <p>Browse the complete fleet of vehicles listed by all approved vendors.</p>
                    <a href="${pageContext.request.contextPath}/admin/vehicles">View Vehicles <span class="custom-icon arrow-right-icon" style="font-size:0.75rem;"></span></a>
                </div>

                <div class="admin-card">
                    <div class="admin-card-icon" style="background:#F5F3FF;color:#7C3AED;"><span class="custom-icon calendar-icon"></span></div>
                    <h3>All Bookings</h3>
                    <p>View the complete booking history across all vehicles and customers.</p>
                    <a href="${pageContext.request.contextPath}/admin/bookings">View Bookings <span class="custom-icon arrow-right-icon" style="font-size:0.75rem;"></span></a>
                </div>

                <div class="admin-card">
                    <div class="admin-card-icon" style="background:#FFFBEB;color:#F59E0B;"><span class="custom-icon star-icon"></span></div>
                    <h3>Reviews</h3>
                    <p>Read all customer reviews for vehicles and vendors across the platform.</p>
                    <a href="${pageContext.request.contextPath}/admin/reviews">View Reviews <span class="custom-icon arrow-right-icon" style="font-size:0.75rem;"></span></a>
                </div>

            </div>
        </div>

    </main>

</div>

<jsp:include page="/common/footer.jsp" />

</body>
</html>
