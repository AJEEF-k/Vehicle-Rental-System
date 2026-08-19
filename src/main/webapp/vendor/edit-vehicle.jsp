<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Vehicle - DriveWay Vendor</title>
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
                <div class="page-title"><span class="custom-icon edit-icon"></span> Edit Vehicle</div>
                <div class="page-subtitle">Update vehicle details and pricing</div>
            </div>
            <div class="page-actions">
                <a href="${pageContext.request.contextPath}/vendor/vehicles"
                   style="display:inline-flex;align-items:center;gap:7px;padding:9px 18px;background:var(--card);color:var(--text-muted);border:1.5px solid var(--border);border-radius:var(--radius-sm);font-size:0.875rem;font-weight:500;text-decoration:none;">
                    <span class="custom-icon arrow-left-icon"></span> My Vehicles
                </a>
            </div>
        </div>

        <c:if test="${param.error == 'required'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please fill in all required fields.</div></c:if>
        <c:if test="${param.error == 'invalidValues'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please enter valid vehicle values.</div></c:if>
        <c:if test="${param.error == 'failed'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Vehicle update failed. Please try again.</div></c:if>

        <c:choose>
            <c:when test="${not empty vehicle}">

                <!-- Image preview if exists -->
                <c:if test="${not empty vehicle.imagePath}">
                    <div class="card" style="margin-bottom:20px;max-width:700px;">
                        <div class="card-header"><div class="card-title"><span class="custom-icon image-icon"></span> Current Image</div></div>
                        <div style="height:200px;overflow:hidden;background:var(--bg);">
                            <img src="${pageContext.request.contextPath}/${vehicle.imagePath}"
                                 alt="${vehicle.vehicleName}"
                                 style="width:100%;height:100%;object-fit:cover;">
                        </div>
                    </div>
                </c:if>

                <div class="vendor-form-card">
                    <div class="card-header">
                        <div class="card-title"><span class="custom-icon car-icon"></span> ${vehicle.vehicleName}</div>
                        <span class="text-muted text-sm">ID #${vehicle.vehicleId}</span>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/vendor/update-vehicle" method="post">
                            <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="vehicleName">Vehicle Name <span style="color:var(--danger);">*</span></label>
                                    <input type="text" id="vehicleName" name="vehicleName" value="${vehicle.vehicleName}" required>
                                </div>
                                <div class="form-group">
                                    <label for="brand">Brand <span style="color:var(--danger);">*</span></label>
                                    <input type="text" id="brand" name="brand" value="${vehicle.brand}" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="category">Category <span style="color:var(--danger);">*</span></label>
                                    <input type="text" id="category" name="category" value="${vehicle.category}" required>
                                </div>
                                <div class="form-group">
                                    <label for="batteryRange">Battery Range (km)</label>
                                    <input type="number" id="batteryRange" name="batteryRange" value="${vehicle.batteryRange}" min="1" step="1">
                                    <div class="form-hint">Leave blank for non-electric vehicles.</div>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="hourlyRate">Hourly Rate (₹) <span style="color:var(--danger);">*</span></label>
                                    <input type="number" id="hourlyRate" name="hourlyRate" value="${vehicle.hourlyRate}" min="1" step="1" required>
                                </div>
                                <div class="form-group">
                                    <label for="dailyRate">Daily Rate (₹) <span style="color:var(--danger);">*</span></label>
                                    <input type="number" id="dailyRate" name="dailyRate" value="${vehicle.dailyRate}" min="1" step="1" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="imagePath">Image Path</label>
                                <input type="text" id="imagePath" name="imagePath" value="${vehicle.imagePath}" placeholder="e.g. images/vehicle.jpg">
                                <div class="form-hint">Relative path to the vehicle image file.</div>
                            </div>

                            <div style="padding-top:8px;">
                                <button type="submit">
                                    <span class="custom-icon save-icon"></span> Update Vehicle
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

            </c:when>
            <c:otherwise>
                <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Vehicle information is unavailable.</div>
            </c:otherwise>
        </c:choose>

    </main>
</div>
<jsp:include page="/common/footer.jsp" />
</body>
</html>
