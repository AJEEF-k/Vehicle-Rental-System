<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Vehicle - DriveWay Vendor</title>
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
                <div class="page-title"><span class="custom-icon plus-circle-icon"></span> Add Vehicle</div>
                <div class="page-subtitle">List a new vehicle for customers to rent</div>
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
        <c:if test="${param.error == 'failed'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Vehicle could not be added. Please try again.</div></c:if>

        <div class="vendor-form-card">
            <div class="card-header">
                <div class="card-title"><span class="custom-icon car-icon"></span> Vehicle Information</div>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/vendor/add-vehicle" method="post">

                    <div class="form-row">
                        <div class="form-group">
                            <label for="registrationNumber">Registration Number <span style="color:var(--danger);">*</span></label>
                            <input type="text" id="registrationNumber" name="registrationNumber" placeholder="e.g. KA01AB1234" required>
                        </div>
                        <div class="form-group">
                            <label for="vehicleName">Vehicle Name <span style="color:var(--danger);">*</span></label>
                            <input type="text" id="vehicleName" name="vehicleName" placeholder="e.g. Tata Nexon" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="brand">Brand <span style="color:var(--danger);">*</span></label>
                            <input type="text" id="brand" name="brand" placeholder="e.g. Tata Motors" required>
                        </div>
                        <div class="form-group">
                            <label for="category">Category <span style="color:var(--danger);">*</span></label>
                            <input type="text" id="category" name="category" placeholder="e.g. SUV, Sedan, Bike" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="hourlyRate">Hourly Rate (₹) <span style="color:var(--danger);">*</span></label>
                            <input type="number" id="hourlyRate" name="hourlyRate" min="1" step="1" placeholder="e.g. 150" required>
                        </div>
                        <div class="form-group">
                            <label for="dailyRate">Daily Rate (₹) <span style="color:var(--danger);">*</span></label>
                            <input type="number" id="dailyRate" name="dailyRate" min="1" step="1" placeholder="e.g. 1200" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="batteryRange">Battery Range (km) <span style="color:var(--danger);">*</span></label>
                            <input type="number" id="batteryRange" name="batteryRange" min="1" step="1" placeholder="e.g. 312">
                            <div class="form-hint">Enter 0 or leave blank for non-electric vehicles.</div>
                        </div>
                        <div class="form-group">
                            <label for="imagePath">Image Path</label>
                            <input type="text" id="imagePath" name="imagePath" placeholder="e.g. images/nexon.jpg">
                            <div class="form-hint">Relative path to the vehicle image (optional).</div>
                        </div>
                    </div>

                    <div style="padding-top:8px;">
                        <button type="submit" style="background:var(--accent);">
                            <span class="custom-icon plus-circle-icon"></span> Add Vehicle
                        </button>
                    </div>

                </form>
            </div>
        </div>

    </main>
</div>
<jsp:include page="/common/footer.jsp" />
</body>
</html>
