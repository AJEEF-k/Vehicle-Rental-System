<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Vehicles - DriveWay</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/customer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icons.css">
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="page-layout">

    <jsp:include page="/common/sidebar.jsp" />

    <main class="content">

        <div class="page-header">
            <div class="page-header-left">
                <div class="page-title"><span class="custom-icon car-icon"></span> Browse Vehicles</div>
                <div class="page-subtitle">Choose from our verified fleet of available vehicles</div>
            </div>
        </div>

        <!-- Search Bar -->
        <form class="search-bar" action="${pageContext.request.contextPath}/customer/vehicles" method="get">
            <div class="search-bar-input-wrap">
                <span class="custom-icon search-icon"></span>
                <input type="text" id="keyword" name="keyword" value="${keyword}"
                       placeholder="Search by name, brand or category...">
            </div>
            <button type="submit" style="flex-shrink:0;">
                <span class="custom-icon search-icon"></span> Search
            </button>
            <c:if test="${not empty keyword}">
                <a href="${pageContext.request.contextPath}/customer/vehicles"
                   style="display:inline-flex;align-items:center;gap:6px;padding:10px 16px;border-radius:var(--radius-sm);background:var(--bg);color:var(--text-muted);border:1.5px solid var(--border);font-size:0.875rem;font-weight:500;flex-shrink:0;text-decoration:none;">
                    <span class="custom-icon times-icon"></span> Clear
                </a>
            </c:if>
        </form>

        <!-- Error Alerts -->
        <c:if test="${param.error == 'invalidVehicle'}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid vehicle selected.</div>
        </c:if>
        <c:if test="${param.error == 'vehicleNotFound'}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Vehicle not found.</div>
        </c:if>
        <c:if test="${param.error == 'vehicleUnavailable'}">
            <div class="alert alert-warning"><span class="custom-icon clock-icon"></span> This vehicle is currently unavailable.</div>
        </c:if>

        <!-- Vehicles Grid -->
        <c:choose>
            <c:when test="${empty vehicles}">
                <div class="empty-state">
                    <div class="empty-state-icon"><span class="custom-icon car-icon"></span></div>
                    <div class="empty-state-title">No vehicles found</div>
                    <div class="empty-state-desc">
                        <c:choose>
                            <c:when test="${not empty keyword}">No results for "<strong>${keyword}</strong>". Try a different search.</c:when>
                            <c:otherwise>No vehicles are currently available. Check back soon.</c:otherwise>
                        </c:choose>
                    </div>
                    <c:if test="${not empty keyword}">
                        <a href="${pageContext.request.contextPath}/customer/vehicles"
                           style="display:inline-flex;align-items:center;gap:7px;padding:10px 22px;background:var(--primary);color:white;border-radius:var(--radius-sm);font-weight:600;font-size:0.875rem;">
                            <span class="custom-icon undo-icon"></span> Clear Search
                        </a>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="vehicle-list">
                    <c:forEach var="vehicle" items="${vehicles}">
                        <div class="vehicle-card">

                            <!-- Signature price badge -->
                            <div class="vehicle-card-price-badge">
                                <span class="price-from">From</span>
                                ₹${vehicle.hourlyRate}/hr
                            </div>

                            <!-- Vehicle image -->
                            <div class="vehicle-image-wrap">
                                <c:choose>
                                    <c:when test="${not empty vehicle.imagePath}">
                                        <img src="${pageContext.request.contextPath}/${vehicle.imagePath}"
                                             alt="${vehicle.vehicleName}" class="vehicle-image">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="vehicle-image-placeholder">
                                            <c:choose>
                                                <c:when test="${vehicle.category == 'Bike' || vehicle.category == 'Motorcycle'}">🏍️</c:when>
                                                <c:when test="${vehicle.category == 'SUV'}">🚙</c:when>
                                                <c:when test="${vehicle.category == 'Truck'}">🚚</c:when>
                                                <c:otherwise>🚗</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Card body -->
                            <div class="vehicle-card-body">
                                <div class="vehicle-card-category">${vehicle.category}</div>
                                <h3>${vehicle.vehicleName}</h3>
                                <div class="vehicle-card-brand">${vehicle.brand}</div>

                                <div class="vehicle-meta">
                                    <div class="vehicle-meta-item">
                                        <span class="custom-icon clock-icon"></span>
                                        <span>₹<strong>${vehicle.hourlyRate}</strong>/hr</span>
                                    </div>
                                    <div class="vehicle-meta-item">
                                        <span class="custom-icon calendar-icon"></span>
                                        <span>₹<strong>${vehicle.dailyRate}</strong>/day</span>
                                    </div>
                                    <c:if test="${not empty vehicle.batteryRange}">
                                        <div class="vehicle-meta-item">
                                            <span class="custom-icon bolt-icon"></span>
                                            <span><strong>${vehicle.batteryRange}</strong> km</span>
                                        </div>
                                    </c:if>
                                    <div class="vehicle-meta-item">
                                        <span class="custom-icon shield-icon"></span>
                                        <span>₹1,000 deposit</span>
                                    </div>
                                </div>

                                <div class="vehicle-card-footer">
                                    <c:choose>
                                        <c:when test="${vehicle.operationalStatus == 'Available'}">
                                            <span class="badge badge-success">
                                                <span class="custom-icon dot-icon" style="font-size:0.5rem;"></span> Available
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-warning">
                                                <span class="custom-icon dot-icon" style="font-size:0.5rem;"></span> ${vehicle.operationalStatus}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                    <a href="${pageContext.request.contextPath}/customer/vehicle-details?vehicleId=${vehicle.vehicleId}"
                                       style="display:inline-flex;align-items:center;gap:6px;padding:8px 16px;background:var(--primary);color:white;border-radius:var(--radius-sm);font-size:0.82rem;font-weight:600;text-decoration:none;">
                                        View Details <span class="custom-icon arrow-right-icon"></span>
                                    </a>
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
