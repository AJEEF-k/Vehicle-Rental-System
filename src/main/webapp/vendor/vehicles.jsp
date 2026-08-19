<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Vehicles - DriveWay Vendor</title>
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
                <div class="page-title"><span class="custom-icon car-icon"></span> My Vehicles</div>
                <div class="page-subtitle">Manage your fleet — edit details and update availability</div>
            </div>
            <div class="page-actions">
                <a href="${pageContext.request.contextPath}/vendor/add-vehicle"
                   style="display:inline-flex;align-items:center;gap:7px;padding:10px 20px;background:var(--accent);color:white;border-radius:var(--radius-sm);font-size:0.875rem;font-weight:600;text-decoration:none;">
                    <span class="custom-icon plus-icon"></span> Add Vehicle
                </a>
            </div>
        </div>

        <c:if test="${param.success == 'added'}"><div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Vehicle added successfully.</div></c:if>
        <c:if test="${param.success == 'updated'}"><div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Vehicle updated successfully.</div></c:if>
        <c:if test="${param.success == 'statusUpdated'}"><div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Vehicle status updated.</div></c:if>
        <c:if test="${param.error == 'invalidVehicle'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid vehicle.</div></c:if>
        <c:if test="${param.error == 'invalidValues'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please enter valid vehicle values.</div></c:if>
        <c:if test="${param.error == 'failed'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Vehicle operation failed.</div></c:if>

        <c:choose>
            <c:when test="${empty vehicles}">
                <div class="empty-state">
                    <div class="empty-state-icon"><span class="custom-icon car-icon"></span></div>
                    <div class="empty-state-title">No vehicles yet</div>
                    <div class="empty-state-desc">Add your first vehicle to start accepting bookings.</div>
                    <a href="${pageContext.request.contextPath}/vendor/add-vehicle"
                       style="display:inline-flex;align-items:center;gap:7px;padding:11px 24px;background:var(--accent);color:white;border-radius:var(--radius-sm);font-weight:600;font-size:0.875rem;text-decoration:none;">
                        <span class="custom-icon plus-icon"></span> Add First Vehicle
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="vendor-vehicle-list">
                    <c:forEach var="vehicle" items="${vehicles}">
                        <div class="vendor-vehicle-card">

                            <!-- Image -->
                            <c:choose>
                                <c:when test="${not empty vehicle.imagePath}">
                                    <img src="${pageContext.request.contextPath}/${vehicle.imagePath}"
                                         alt="${vehicle.vehicleName}" class="vendor-vehicle-image">
                                </c:when>
                                <c:otherwise>
                                    <div class="vendor-vehicle-image-placeholder">🚗</div>
                                </c:otherwise>
                            </c:choose>

                            <div class="vendor-vehicle-body">
                                <div class="vendor-vehicle-name">${vehicle.vehicleName}</div>
                                <div class="vendor-vehicle-meta">${vehicle.brand} &middot; ${vehicle.category}</div>

                                <div class="vendor-vehicle-stats">
                                    <div class="vendor-vehicle-stat">
                                        <div class="vendor-vehicle-stat-label">Hourly</div>
                                        <div class="vendor-vehicle-stat-value">₹${vehicle.hourlyRate}/hr</div>
                                    </div>
                                    <div class="vendor-vehicle-stat">
                                        <div class="vendor-vehicle-stat-label">Daily</div>
                                        <div class="vendor-vehicle-stat-value">₹${vehicle.dailyRate}/day</div>
                                    </div>
                                    <c:if test="${not empty vehicle.batteryRange}">
                                        <div class="vendor-vehicle-stat">
                                            <div class="vendor-vehicle-stat-label">Range</div>
                                            <div class="vendor-vehicle-stat-value">${vehicle.batteryRange} km</div>
                                        </div>
                                    </c:if>
                                    <div class="vendor-vehicle-stat">
                                        <div class="vendor-vehicle-stat-label">Status</div>
                                        <div>
                                            <c:choose>
                                                <c:when test="${vehicle.operationalStatus == 'Available'}"><span class="badge badge-success" style="font-size:0.72rem;">${vehicle.operationalStatus}</span></c:when>
                                                <c:when test="${vehicle.operationalStatus == 'Booked'}"><span class="badge badge-warning" style="font-size:0.72rem;">${vehicle.operationalStatus}</span></c:when>
                                                <c:otherwise><span class="badge badge-secondary" style="font-size:0.72rem;">${vehicle.operationalStatus}</span></c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>

                                <div class="vehicle-actions">
                                    <a href="${pageContext.request.contextPath}/vendor/update-vehicle?vehicleId=${vehicle.vehicleId}"
                                       style="display:inline-flex;align-items:center;gap:6px;padding:7px 14px;background:var(--primary-light);color:var(--primary);border-radius:var(--radius-sm);font-size:0.82rem;font-weight:600;text-decoration:none;">
                                        <span class="custom-icon edit-icon"></span> Edit
                                    </a>
                                    <form action="${pageContext.request.contextPath}/vendor/change-vehicle-status" method="post"
                                          style="display:flex;gap:6px;align-items:center;flex:1;">
                                        <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
                                        <select name="status" style="flex:1;padding:7px 10px;font-size:0.82rem;" required>
                                            <option value="Available" <c:if test="${vehicle.operationalStatus == 'Available'}">selected</c:if>>Available</option>
                                            <option value="Maintenance" <c:if test="${vehicle.operationalStatus == 'Maintenance'}">selected</c:if>>Maintenance</option>
                                            <option value="Inactive" <c:if test="${vehicle.operationalStatus == 'Inactive'}">selected</c:if>>Inactive</option>
                                        </select>
                                        <button type="submit" style="padding:7px 12px;font-size:0.8rem;background:var(--success);">
                                            <span class="custom-icon check-icon"></span>
                                        </button>
                                    </form>
                                </div>
                            </div>

                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </main>
</div>
<jsp:include page="/common/footer.jsp" />
</body>
</html>
