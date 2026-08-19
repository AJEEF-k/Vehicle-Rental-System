<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Vehicles - DriveWay Admin</title>
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
            <div class="page-title"><span class="custom-icon car-icon"></span> All Vehicles</div>
            <div class="page-subtitle">Complete fleet listed by all approved vendors</div>
        </div>

        <c:choose>
            <c:when test="${empty vehicles}">
                <div class="empty-state">
                    <div class="empty-state-icon"><span class="custom-icon car-icon"></span></div>
                    <div class="empty-state-title">No vehicles found</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Registration</th>
                                <th>Name</th>
                                <th>Brand</th>
                                <th>Category</th>
                                <th>Hourly Rate</th>
                                <th>Daily Rate</th>
                                <th>Battery Range</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="vehicle" items="${vehicles}">
                                <tr>
                                    <td><span class="text-muted text-sm">#${vehicle.vehicleId}</span></td>
                                    <td><code style="font-size:0.82rem;background:var(--bg);padding:2px 6px;border-radius:4px;">${vehicle.registrationNumber}</code></td>
                                    <td><span style="font-weight:600;color:var(--dark);">${vehicle.vehicleName}</span></td>
                                    <td>${vehicle.brand}</td>
                                    <td><span class="badge badge-info">${vehicle.category}</span></td>
                                    <td>₹${vehicle.hourlyRate}/hr</td>
                                    <td>₹${vehicle.dailyRate}/day</td>
                                    <td><c:if test="${not empty vehicle.batteryRange}">${vehicle.batteryRange} km</c:if><c:if test="${empty vehicle.batteryRange}"><span class="text-muted">—</span></c:if></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${vehicle.operationalStatus == 'Available'}"><span class="badge badge-success">${vehicle.operationalStatus}</span></c:when>
                                            <c:when test="${vehicle.operationalStatus == 'Booked'}"><span class="badge badge-warning">${vehicle.operationalStatus}</span></c:when>
                                            <c:otherwise><span class="badge badge-secondary">${vehicle.operationalStatus}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>

    </main>
</div>
<jsp:include page="/common/footer.jsp" />
</body>
</html>
