<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bookings - DriveWay Vendor</title>
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
                <div class="page-title"><span class="custom-icon calendar-icon"></span> Vehicle Bookings</div>
                <div class="page-subtitle">Manage all bookings for your listed vehicles</div>
            </div>
        </div>

        <!-- Alerts -->
        <c:if test="${param.success == 'updated'}">
            <div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Booking status updated successfully.</div>
        </c:if>
        <c:if test="${param.error == 'invalidBooking'}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid booking.</div>
        </c:if>
        <c:if test="${param.error == 'invalidStatus'}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid booking status.</div>
        </c:if>
        <c:if test="${param.error == 'notAllowed'}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> You are not allowed to update this booking.</div>
        </c:if>
        <c:if test="${param.error == 'updateFailed'}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Unable to update booking status.</div>
        </c:if>

        <c:choose>
            <c:when test="${empty bookings}">
                <div class="empty-state">
                    <div class="empty-state-icon"><span class="custom-icon calendar-x-icon"></span></div>
                    <div class="empty-state-title">No bookings yet</div>
                    <div class="empty-state-desc">Bookings from customers will appear here once your vehicles are rented.</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="vendor-booking-list">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="vendor-booking-card">

                            <!-- Header -->
                            <div class="vendor-booking-header">
                                <span class="vendor-booking-id">
                                    <span class="custom-icon receipt-icon" style="background-color:var(--primary);margin-right:6px;"></span>
                                    Booking #${booking.bookingId}
                                </span>
                                <div style="display:flex;align-items:center;gap:10px;">
                                    <c:choose>
                                        <c:when test="${booking.bookingStatus == 'Confirmed'}">
                                            <span class="badge badge-info">
                                                <span class="custom-icon dot-icon" style="font-size:0.5rem;"></span> Confirmed
                                            </span>
                                        </c:when>
                                        <c:when test="${booking.bookingStatus == 'Active'}">
                                            <span class="badge badge-success">
                                                <span class="custom-icon dot-icon" style="font-size:0.5rem;"></span> Active
                                            </span>
                                        </c:when>
                                        <c:when test="${booking.bookingStatus == 'Completed'}">
                                            <span class="badge badge-secondary">
                                                <span class="custom-icon check-circle-icon" style="font-size:0.7rem;"></span> Completed
                                            </span>
                                        </c:when>
                                        <c:when test="${booking.bookingStatus == 'Cancelled'}">
                                            <span class="badge badge-danger">
                                                <span class="custom-icon times-circle-icon" style="font-size:0.7rem;"></span> Cancelled
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-secondary">${booking.bookingStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                    <span style="font-size:0.78rem;color:var(--text-muted);">
                                        Booked on ${booking.bookingDate}
                                    </span>
                                </div>
                            </div>

                            <!-- Body: booking info grid -->
                            <div class="vendor-booking-body">
                                <div class="vendor-info-item">
                                    <div class="vendor-info-label">Customer</div>
                                    <div class="vendor-info-value">User #${booking.userId}</div>
                                </div>
                                <div class="vendor-info-item">
                                    <div class="vendor-info-label">Vehicle</div>
                                    <div class="vendor-info-value">Vehicle #${booking.vehicleId}</div>
                                </div>
                                <div class="vendor-info-item">
                                    <div class="vendor-info-label">Start</div>
                                    <div class="vendor-info-value">${booking.startDateTime}</div>
                                </div>
                                <div class="vendor-info-item">
                                    <div class="vendor-info-label">End</div>
                                    <div class="vendor-info-value">${booking.endDateTime}</div>
                                </div>
                                <div class="vendor-info-item">
                                    <div class="vendor-info-label">Rate Type</div>
                                    <div class="vendor-info-value">${booking.rateType}</div>
                                </div>
                                <div class="vendor-info-item">
                                    <div class="vendor-info-label">Applied Rate</div>
                                    <div class="vendor-info-value">₹${booking.appliedRate}</div>
                                </div>
                                <div class="vendor-info-item">
                                    <div class="vendor-info-label">Total Amount</div>
                                    <div class="vendor-info-value" style="color:var(--primary);font-size:1rem;font-weight:700;">
                                        ₹${booking.totalAmount}
                                    </div>
                                </div>
                                <div class="vendor-info-item">
                                    <div class="vendor-info-label">Security Deposit</div>
                                    <div class="vendor-info-value">₹${booking.securityDeposit}</div>
                                </div>
                                <div class="vendor-info-item">
                                    <div class="vendor-info-label">Payment</div>
                                    <div class="vendor-info-value">${booking.paymentMethod}</div>
                                </div>
                                <div class="vendor-info-item">
                                    <div class="vendor-info-label">Payment Status</div>
                                    <div class="vendor-info-value">
                                        <c:choose>
                                            <c:when test="${booking.paymentStatus == 'Completed'}">
                                                <span class="badge badge-success" style="font-size:0.72rem;">${booking.paymentStatus}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-warning" style="font-size:0.72rem;">${booking.paymentStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                            <!-- Footer: action buttons -->
                            <div class="booking-actions">

                                <!-- Confirmed → Active (Start) or Cancelled -->
                                <c:if test="${booking.bookingStatus == 'Confirmed'}">
                                    <form action="${pageContext.request.contextPath}/vendor/update-booking-status" method="post">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <input type="hidden" name="bookingStatus" value="Active">
                                        <button type="submit" class="btn-success btn-sm">
                                            <span class="custom-icon play-icon"></span> Start Booking
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/vendor/update-booking-status" method="post">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <input type="hidden" name="bookingStatus" value="Cancelled">
                                        <button type="submit" class="btn-danger btn-sm">
                                            <span class="custom-icon times-icon"></span> Cancel Booking
                                        </button>
                                    </form>
                                </c:if>

                                <!-- Active → Completed -->
                                <c:if test="${booking.bookingStatus == 'Active'}">
                                    <form action="${pageContext.request.contextPath}/vendor/update-booking-status" method="post">
                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                        <input type="hidden" name="bookingStatus" value="Completed">
                                        <button type="submit" class="btn-accent btn-sm">
                                            <span class="custom-icon flag-icon"></span> Complete Booking
                                        </button>
                                    </form>
                                </c:if>

                                <c:if test="${booking.bookingStatus != 'Confirmed' && booking.bookingStatus != 'Active'}">
                                    <span class="text-sm text-muted" style="padding:6px 0;">
                                        <span class="custom-icon lock-icon" style="margin-right:4px;"></span>
                                        No further actions available
                                    </span>
                                </c:if>

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
