<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - DriveWay</title>
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
                <div class="page-title"><span class="custom-icon calendar-check-icon"></span> My Bookings</div>
                <div class="page-subtitle">Track and manage all your vehicle bookings</div>
            </div>
            <div class="page-actions">
                <a href="${pageContext.request.contextPath}/customer/vehicles"
                   style="display:inline-flex;align-items:center;gap:7px;padding:10px 20px;background:var(--accent);color:white;border-radius:var(--radius-sm);font-size:0.875rem;font-weight:600;text-decoration:none;">
                    <span class="custom-icon plus-icon"></span> New Booking
                </a>
            </div>
        </div>

        <!-- Status Messages -->
        <c:if test="${param.success == 'booked'}">
            <div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Booking created successfully. Enjoy your ride!</div>
        </c:if>
        <c:if test="${param.success == 'cancelled'}">
            <div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Booking cancelled successfully.</div>
        </c:if>
        <c:if test="${param.success == 'reviewSubmitted'}">
            <div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Review submitted. Thank you!</div>
        </c:if>
        <c:if test="${param.error == 'invalidBooking'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid booking.</div></c:if>
        <c:if test="${param.error == 'bookingNotFound'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Booking not found.</div></c:if>
        <c:if test="${param.error == 'notCancellable'}"><div class="alert alert-warning"><span class="custom-icon clock-icon"></span> This booking cannot be cancelled.</div></c:if>
        <c:if test="${param.error == 'cancelFailed'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Booking cancellation failed.</div></c:if>
        <c:if test="${param.error == 'notReviewable'}"><div class="alert alert-warning"><span class="custom-icon clock-icon"></span> This booking is not eligible for a review.</div></c:if>
        <c:if test="${param.error == 'alreadyReviewed'}"><div class="alert alert-warning"><span class="custom-icon star-icon"></span> This booking has already been reviewed.</div></c:if>

        <c:choose>
            <c:when test="${empty bookings}">
                <div class="empty-state">
                    <div class="empty-state-icon"><span class="custom-icon calendar-x-icon"></span></div>
                    <div class="empty-state-title">No bookings yet</div>
                    <div class="empty-state-desc">Your bookings will appear here once you rent a vehicle.</div>
                    <a href="${pageContext.request.contextPath}/customer/vehicles"
                       style="display:inline-flex;align-items:center;gap:7px;padding:11px 24px;background:var(--primary);color:white;border-radius:var(--radius-sm);font-weight:600;font-size:0.875rem;text-decoration:none;">
                        <span class="custom-icon car-icon"></span> Browse Vehicles
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bookings-list">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="booking-card">

                            <div class="booking-card-header">
                                <span class="booking-card-id">
                                    <span class="custom-icon receipt-icon" style="background-color:var(--primary);margin-right:6px;"></span>
                                    Booking #${booking.bookingId}
                                </span>
                                <div style="display:flex;align-items:center;gap:10px;">
                                    <c:choose>
                                        <c:when test="${booking.bookingStatus == 'Confirmed'}">
                                            <span class="badge badge-info"><span class="custom-icon dot-icon" style="font-size:0.5rem;"></span> Confirmed</span>
                                        </c:when>
                                        <c:when test="${booking.bookingStatus == 'Active'}">
                                            <span class="badge badge-success"><span class="custom-icon dot-icon" style="font-size:0.5rem;"></span> Active</span>
                                        </c:when>
                                        <c:when test="${booking.bookingStatus == 'Completed'}">
                                            <span class="badge badge-secondary"><span class="custom-icon check-circle-icon" style="font-size:0.7rem;"></span> Completed</span>
                                        </c:when>
                                        <c:when test="${booking.bookingStatus == 'Cancelled'}">
                                            <span class="badge badge-danger"><span class="custom-icon times-circle-icon" style="font-size:0.7rem;"></span> Cancelled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-secondary">${booking.bookingStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <span class="text-sm text-muted">Booked on ${booking.bookingDate}</span>
                                </div>
                            </div>

                            <div class="booking-card-body">
                                <div class="booking-info-item">
                                    <div class="booking-info-label">Start</div>
                                    <div class="booking-info-value">${booking.startDateTime}</div>
                                </div>
                                <div class="booking-info-item">
                                    <div class="booking-info-label">End</div>
                                    <div class="booking-info-value">${booking.endDateTime}</div>
                                </div>
                                <div class="booking-info-item">
                                    <div class="booking-info-label">Rate Type</div>
                                    <div class="booking-info-value">${booking.rateType}</div>
                                </div>
                                <div class="booking-info-item">
                                    <div class="booking-info-label">Applied Rate</div>
                                    <div class="booking-info-value">₹${booking.appliedRate}</div>
                                </div>
                                <div class="booking-info-item">
                                    <div class="booking-info-label">Total Amount</div>
                                    <div class="booking-info-value" style="color:var(--primary);font-size:1rem;">₹${booking.totalAmount}</div>
                                </div>
                                <div class="booking-info-item">
                                    <div class="booking-info-label">Security Deposit</div>
                                    <div class="booking-info-value">₹${booking.securityDeposit}</div>
                                </div>
                                <div class="booking-info-item">
                                    <div class="booking-info-label">Payment</div>
                                    <div class="booking-info-value">${booking.paymentMethod}</div>
                                </div>
                                <div class="booking-info-item">
                                    <div class="booking-info-label">Payment Status</div>
                                    <c:choose>
                                        <c:when test="${booking.paymentStatus == 'Paid'}">
                                            <div class="booking-info-value"><span class="badge badge-success" style="font-size:0.72rem;">${booking.paymentStatus}</span></div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="booking-info-value"><span class="badge badge-warning" style="font-size:0.72rem;">${booking.paymentStatus}</span></div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="booking-card-footer">
                                <div style="font-size:0.8rem;color:var(--text-muted);">
                                    <span class="custom-icon car-icon" style="margin-right:4px;"></span> Vehicle #${booking.vehicleId}
                                </div>
                                <div style="display:flex;gap:10px;">
                                    <c:if test="${booking.bookingStatus == 'Confirmed'}">
                                        <form action="${pageContext.request.contextPath}/customer/cancel-booking"
                                              method="post"
                                              onsubmit="return confirmAction('Are you sure you want to cancel this booking?');">
                                            <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                            <button type="submit" class="btn-danger btn-sm">
                                                <span class="custom-icon times-icon"></span> Cancel Booking
                                            </button>
                                        </form>
                                    </c:if>
                                    <c:if test="${booking.bookingStatus == 'Completed'}">
                                        <a href="${pageContext.request.contextPath}/customer/submit-review?bookingId=${booking.bookingId}"
                                           style="display:inline-flex;align-items:center;gap:6px;padding:7px 16px;background:var(--warning-bg);color:var(--warning-text);border:1px solid #FCD34D;border-radius:var(--radius-sm);font-size:0.82rem;font-weight:600;text-decoration:none;">
                                            <span class="custom-icon star-icon"></span> Leave Review
                                        </a>
                                    </c:if>
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
<script src="${pageContext.request.contextPath}/js/common.js"></script>

</body>
</html>
