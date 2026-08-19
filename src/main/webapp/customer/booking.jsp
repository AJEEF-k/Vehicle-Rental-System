<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Vehicle - DriveWay</title>
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
                <div class="page-title"><span class="custom-icon calendar-check-icon"></span> Book Vehicle</div>
                <div class="page-subtitle">Fill in the booking details below</div>
            </div>
            <div class="page-actions">
                <a href="${pageContext.request.contextPath}/customer/vehicles"
                   style="display:inline-flex;align-items:center;gap:7px;padding:9px 18px;background:var(--card);color:var(--text-muted);border:1.5px solid var(--border);border-radius:var(--radius-sm);font-size:0.875rem;font-weight:500;text-decoration:none;">
                    <span class="custom-icon arrow-left-icon"></span> Back to Vehicles
                </a>
            </div>
        </div>

        <!-- Error Alerts -->
        <c:if test="${param.error == 'required'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please fill in all required fields.</div></c:if>
        <c:if test="${param.error == 'invalidPeriod'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid rental period selected.</div></c:if>
        <c:if test="${param.error == 'pastDate'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Start date and time cannot be in the past.</div></c:if>
        <c:if test="${param.error == 'invalidRateType'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid rate type.</div></c:if>
        <c:if test="${param.error == 'invalidPaymentMethod'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid payment method.</div></c:if>
        <c:if test="${param.error == 'alreadyBooked'}"><div class="alert alert-warning"><span class="custom-icon clock-icon"></span> Vehicle is already booked for the selected period.</div></c:if>
        <c:if test="${param.error == 'bookingFailed'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Booking could not be created. Please try again.</div></c:if>
        <c:if test="${param.error == 'invalidInput'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid booking input.</div></c:if>
        <c:if test="${param.error == 'invalidDate'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid date or time provided.</div></c:if>
        <c:if test="${param.error == 'invalidVehicle'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid vehicle.</div></c:if>
        <c:if test="${param.error == 'vehicleUnavailable'}"><div class="alert alert-warning"><span class="custom-icon clock-icon"></span> Vehicle is currently unavailable.</div></c:if>

        <c:if test="${not empty vehicle}">

            <div class="booking-layout">

                <!-- Left: Booking Form -->
                <div class="booking-form-card">
                    <div style="padding:22px 28px;border-bottom:1px solid var(--border);background:#FAFBFC;">
                        <div style="font-weight:700;font-size:1rem;color:var(--dark);display:flex;align-items:center;gap:8px;">
                            <span class="custom-icon calendar-check-icon" style="background-color:var(--primary);"></span>
                            Booking Details
                        </div>
                    </div>
                    <div style="padding:28px;">
                        <form id="bookingForm"
                              action="${pageContext.request.contextPath}/customer/book-vehicle"
                              method="post"
                              onsubmit="return validateBookingForm();">

                            <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}">

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="startDateTime"><span class="custom-icon calendar-icon" style="margin-right:5px;background-color:var(--text-muted);"></span>Start Date &amp; Time</label>
                                    <input type="datetime-local" id="startDateTime" name="startDateTime" required>
                                </div>
                                <div class="form-group">
                                    <label for="endDateTime"><span class="custom-icon calendar-check-icon" style="margin-right:5px;background-color:var(--text-muted);"></span>End Date &amp; Time</label>
                                    <input type="datetime-local" id="endDateTime" name="endDateTime" required>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="rateType"><span class="custom-icon tag-icon" style="margin-right:5px;background-color:var(--text-muted);"></span>Rate Type</label>
                                    <select id="rateType" name="rateType" required>
                                        <option value="">Select rate type</option>
                                        <option value="Hourly">Hourly — ₹${vehicle.hourlyRate}/hr</option>
                                        <option value="Daily">Daily — ₹${vehicle.dailyRate}/day</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="paymentMethod"><span class="custom-icon card-icon" style="margin-right:5px;background-color:var(--text-muted);"></span>Payment Method</label>
                                    <select id="paymentMethod" name="paymentMethod" required>
                                        <option value="">Select payment method</option>
                                        <option value="UPI">UPI</option>
                                        <option value="Cash">Cash</option>
                                    </select>
                                </div>
                            </div>

                            <div style="padding:14px;background:var(--info-bg);border-radius:var(--radius-sm);border:1px solid #BFDBFE;margin-bottom:24px;font-size:0.85rem;color:var(--info-text);display:flex;gap:10px;">
                                <span class="custom-icon info-icon" style="flex-shrink:0;margin-top:1px;"></span>
                                <span>A refundable security deposit of <strong>₹1,000</strong> will be collected at the time of pickup. Total amount will be calculated based on duration.</span>
                            </div>

                            <button type="submit" style="width:100%;padding:13px;font-size:0.975rem;justify-content:center;background:var(--accent);">
                                <span class="custom-icon calendar-check-icon"></span> Confirm Booking
                            </button>

                        </form>
                    </div>
                </div>

                <!-- Right: Vehicle Summary -->
                <div class="booking-summary-card">
                    <div class="booking-summary-header">
                        <h3><span class="custom-icon car-icon" style="margin-right:6px;"></span>${vehicle.vehicleName}</h3>
                        <p>${vehicle.brand} &middot; ${vehicle.category}</p>
                    </div>

                    <c:if test="${not empty vehicle.imagePath}">
                        <img src="${pageContext.request.contextPath}/${vehicle.imagePath}"
                             alt="${vehicle.vehicleName}"
                             style="width:100%;height:180px;object-fit:cover;">
                    </c:if>

                    <div class="booking-summary-body">
                        <div class="booking-summary-item">
                            <span><span class="custom-icon clock-icon" style="width:14px;margin-right:4px;background-color:var(--text-light);"></span>Hourly Rate</span>
                            <span>₹${vehicle.hourlyRate}/hr</span>
                        </div>
                        <div class="booking-summary-item">
                            <span><span class="custom-icon calendar-icon" style="width:14px;margin-right:4px;background-color:var(--text-light);"></span>Daily Rate</span>
                            <span>₹${vehicle.dailyRate}/day</span>
                        </div>
                        <div class="booking-summary-item">
                            <span><span class="custom-icon shield-icon" style="width:14px;margin-right:4px;background-color:var(--text-light);"></span>Security Deposit</span>
                            <span>₹1,000</span>
                        </div>
                        <div class="booking-summary-item" style="border-bottom:none;">
                            <span><span class="custom-icon dot-icon" style="width:14px;margin-right:4px;color:var(--text-light);"></span>Availability</span>
                            <span class="badge badge-success" style="font-size:0.75rem;">${vehicle.operationalStatus}</span>
                        </div>
                    </div>

                    <div style="padding:14px 22px;background:var(--warning-bg);border-top:1px solid #FCD34D;font-size:0.8rem;color:var(--warning-text);display:flex;gap:8px;">
                        <span class="custom-icon info-icon" style="flex-shrink:0;margin-top:1px;"></span>
                        <span>Final amount depends on duration and rate type selected.</span>
                    </div>
                </div>

            </div>

        </c:if>

        <c:if test="${empty vehicle}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Vehicle information is unavailable.</div>
        </c:if>

    </main>

</div>

<jsp:include page="/common/footer.jsp" />

<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script src="${pageContext.request.contextPath}/js/validation.js"></script>
<script src="${pageContext.request.contextPath}/js/booking.js"></script>

</body>
</html>
