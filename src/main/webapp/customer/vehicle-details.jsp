<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${vehicle.vehicleName} - DriveWay</title>
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
                <div class="page-title"><span class="custom-icon car-icon"></span> Vehicle Details</div>
            </div>
            <div class="page-actions">
                <a href="${pageContext.request.contextPath}/customer/vehicles"
                   style="display:inline-flex;align-items:center;gap:7px;padding:9px 18px;background:var(--card);color:var(--text-muted);border:1.5px solid var(--border);border-radius:var(--radius-sm);font-size:0.875rem;font-weight:500;text-decoration:none;">
                    <span class="custom-icon arrow-left-icon"></span> Back to Vehicles
                </a>
            </div>
        </div>

        <c:if test="${empty vehicle}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Vehicle not found.</div>
        </c:if>

        <c:if test="${not empty vehicle}">

            <div class="vehicle-detail-layout">

                <!-- Left: Image + Specs -->
                <div>

                    <!-- Image -->
                    <div class="vehicle-detail-image-wrap" style="margin-bottom:20px;">
                        <c:choose>
                            <c:when test="${not empty vehicle.imagePath}">
                                <img src="${pageContext.request.contextPath}/${vehicle.imagePath}"
                                     alt="${vehicle.vehicleName}" class="vehicle-detail-image">
                            </c:when>
                            <c:otherwise>
                                <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;font-size:5rem;background:linear-gradient(135deg,#F1F5F9,#E2E8F0);">🚗</div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Vehicle Description Card -->
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title"><span class="custom-icon info-icon"></span> Vehicle Specifications</div>
                        </div>
                        <div class="card-body" style="padding:0;">
                            <div class="vehicle-spec-row" style="padding:14px 24px;">
                                <span class="vehicle-spec-label"><span class="custom-icon hash-icon"></span> Registration</span>
                                <span class="vehicle-spec-value" style="font-family:monospace;">${vehicle.registrationNumber}</span>
                            </div>
                            <div class="vehicle-spec-row" style="padding:14px 24px;">
                                <span class="vehicle-spec-label"><span class="custom-icon tag-icon"></span> Brand</span>
                                <span class="vehicle-spec-value">${vehicle.brand}</span>
                            </div>
                            <div class="vehicle-spec-row" style="padding:14px 24px;">
                                <span class="vehicle-spec-label"><span class="custom-icon layers-icon"></span> Category</span>
                                <span class="vehicle-spec-value">${vehicle.category}</span>
                            </div>
                            <c:if test="${not empty vehicle.batteryRange}">
                                <div class="vehicle-spec-row" style="padding:14px 24px;">
                                    <span class="vehicle-spec-label"><span class="custom-icon bolt-icon"></span> Battery Range</span>
                                    <span class="vehicle-spec-value">${vehicle.batteryRange} km</span>
                                </div>
                            </c:if>
                            <div class="vehicle-spec-row" style="padding:14px 24px;border-bottom:none;">
                                <span class="vehicle-spec-label"><span class="custom-icon dot-icon"></span> Status</span>
                                <c:choose>
                                    <c:when test="${vehicle.operationalStatus == 'Available'}">
                                        <span class="badge badge-success"><span class="custom-icon dot-icon" style="font-size:0.5rem;"></span> Available</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-warning">${vehicle.operationalStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Right: Booking Panel -->
                <div class="vehicle-detail-info">

                    <div style="margin-bottom:6px;">
                        <span style="font-size:0.75rem;font-weight:600;text-transform:uppercase;letter-spacing:0.08em;color:var(--primary);">${vehicle.category}</span>
                    </div>
                    <h2 style="font-size:1.7rem;font-weight:800;color:var(--dark);letter-spacing:-0.02em;margin-bottom:4px;">${vehicle.vehicleName}</h2>
                    <p style="color:var(--text-muted);font-size:0.9rem;margin-bottom:20px;">${vehicle.brand}</p>

                    <!-- Pricing block -->
                    <div class="vehicle-pricing-block">
                        <div class="price-item">
                            <div class="price-label">Hourly Rate</div>
                            <div class="price-value">₹${vehicle.hourlyRate}</div>
                        </div>
                        <div class="price-item">
                            <div class="price-label">Daily Rate</div>
                            <div class="price-value">₹${vehicle.dailyRate}</div>
                        </div>
                    </div>

                    <!-- Security deposit note -->
                    <div style="display:flex;align-items:center;gap:8px;padding:11px 14px;background:#FFF7ED;border-radius:var(--radius-sm);border:1px solid #FED7AA;margin-bottom:20px;">
                        <span class="custom-icon shield-icon" style="background-color:var(--accent);"></span>
                        <span style="font-size:0.85rem;color:#9A3412;font-weight:500;">₹1,000 refundable security deposit required</span>
                    </div>

                    <!-- Book button -->
                    <c:if test="${vehicle.operationalStatus == 'Available'}">
                        <form action="${pageContext.request.contextPath}/customer/book-vehicle" method="get">
                            <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">
                            <button type="submit" class="btn-accent" style="width:100%;justify-content:center;padding:13px;font-size:0.975rem;">
                                <span class="custom-icon calendar-check-icon"></span> Book This Vehicle
                            </button>
                        </form>
                    </c:if>

                    <c:if test="${vehicle.operationalStatus != 'Available'}">
                        <div style="text-align:center;padding:16px;background:var(--bg);border-radius:var(--radius-sm);border:1px solid var(--border);">
                            <span class="custom-icon clock-icon" style="background-color:var(--warning);font-size:1.5rem;margin-bottom:8px;display:block;"></span>
                            <span style="font-size:0.875rem;color:var(--text-muted);">This vehicle is currently <strong>${vehicle.operationalStatus}</strong></span>
                        </div>
                    </c:if>

                    <div style="margin-top:14px;padding-top:14px;border-top:1px solid var(--border-light);">
                        <a href="${pageContext.request.contextPath}/customer/vehicles"
                           style="display:flex;align-items:center;justify-content:center;gap:7px;color:var(--text-muted);font-size:0.875rem;">
                            <span class="custom-icon arrow-left-icon"></span> Back to all vehicles
                        </a>
                    </div>
                </div>

            </div>

        </c:if>

    </main>

</div>

<jsp:include page="/common/footer.jsp" />

</body>
</html>
