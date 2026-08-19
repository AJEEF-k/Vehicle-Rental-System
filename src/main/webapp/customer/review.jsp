<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Review - DriveWay</title>
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
                <div class="page-title"><span class="custom-icon star-icon"></span> Submit Review</div>
                <div class="page-subtitle">Share your experience to help other renters</div>
            </div>
            <div class="page-actions">
                <a href="${pageContext.request.contextPath}/customer/bookings"
                   style="display:inline-flex;align-items:center;gap:7px;padding:9px 18px;background:var(--card);color:var(--text-muted);border:1.5px solid var(--border);border-radius:var(--radius-sm);font-size:0.875rem;font-weight:500;text-decoration:none;">
                    <span class="custom-icon arrow-left-icon"></span> My Bookings
                </a>
            </div>
        </div>

        <c:if test="${param.error == 'required'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please provide all required values.</div></c:if>
        <c:if test="${param.error == 'invalidBooking'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid booking.</div></c:if>
        <c:if test="${param.error == 'bookingNotFound'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Booking not found.</div></c:if>
        <c:if test="${param.error == 'notReviewable'}"><div class="alert alert-warning"><span class="custom-icon clock-icon"></span> This booking is not eligible for a review.</div></c:if>
        <c:if test="${param.error == 'alreadyReviewed'}"><div class="alert alert-warning"><span class="custom-icon star-icon"></span> This booking has already been reviewed.</div></c:if>
        <c:if test="${param.error == 'invalidRating'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Rating must be between 1 and 5.</div></c:if>
        <c:if test="${param.error == 'reviewFailed'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Unable to submit the review. Please try again.</div></c:if>

        <c:choose>
            <c:when test="${not empty booking}">
                <div class="review-card">

                    <!-- Booking summary -->
                    <div style="background:var(--primary-light);border-radius:var(--radius-sm);padding:16px 20px;margin-bottom:24px;display:flex;gap:16px;align-items:center;">
                        <div style="width:44px;height:44px;background:var(--primary);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.1rem;color:white;flex-shrink:0;">
                            <span class="custom-icon receipt-icon"></span>
                        </div>
                        <div>
                            <div style="font-weight:700;color:var(--dark);font-size:0.9rem;">Booking #${booking.bookingId}</div>
                            <div style="font-size:0.8rem;color:var(--text-muted);">Vehicle #${booking.vehicleId}</div>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/customer/submit-review" method="post">
                        <input type="hidden" name="bookingId" value="${booking.bookingId}">

                        <div class="form-group">
                            <label for="vehicleRating">
                                <span class="custom-icon car-icon" style="margin-right:5px;background-color:var(--text-muted);"></span>
                                Vehicle Rating
                            </label>
                            <div class="star-rating" style="margin-bottom:8px;">
                                <span class="custom-icon star-icon"></span>
                                <span class="custom-icon star-icon"></span>
                                <span class="custom-icon star-icon"></span>
                                <span class="custom-icon star-icon"></span>
                                <span class="custom-icon star-icon" style="background-color:var(--border);"></span>
                            </div>
                            <select id="vehicleRating" name="vehicleRating" required>
                                <option value="">Select vehicle rating (1–5)</option>
                                <option value="5">⭐⭐⭐⭐⭐ — Excellent</option>
                                <option value="4">⭐⭐⭐⭐ — Good</option>
                                <option value="3">⭐⭐⭐ — Average</option>
                                <option value="2">⭐⭐ — Below Average</option>
                                <option value="1">⭐ — Poor</option>
                            </select>
                            <div class="form-hint">How would you rate the vehicle condition and performance?</div>
                        </div>

                        <div class="form-group">
                            <label for="vendorRating">
                                <span class="custom-icon store-icon" style="margin-right:5px;background-color:var(--text-muted);"></span>
                                Vendor Rating
                            </label>
                            <select id="vendorRating" name="vendorRating" required>
                                <option value="">Select vendor rating (1–5)</option>
                                <option value="5">⭐⭐⭐⭐⭐ — Excellent</option>
                                <option value="4">⭐⭐⭐⭐ — Good</option>
                                <option value="3">⭐⭐⭐ — Average</option>
                                <option value="2">⭐⭐ — Below Average</option>
                                <option value="1">⭐ — Poor</option>
                            </select>
                            <div class="form-hint">How was your overall experience with the vendor?</div>
                        </div>

                        <button type="submit" style="background:var(--warning);color:var(--dark);">
                            <span class="custom-icon send-icon"></span> Submit Review
                        </button>
                    </form>

                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Booking information is unavailable.</div>
            </c:otherwise>
        </c:choose>

    </main>
</div>
<jsp:include page="/common/footer.jsp" />
</body>
</html>
