<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Bookings - DriveWay Admin</title>
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
            <div class="page-title"><span class="custom-icon calendar-icon"></span> All Bookings</div>
            <div class="page-subtitle">Complete booking history across all vehicles</div>
        </div>

        <c:choose>
            <c:when test="${empty bookings}">
                <div class="empty-state">
                    <div class="empty-state-icon"><span class="custom-icon calendar-x-icon"></span></div>
                    <div class="empty-state-title">No bookings found</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>User</th>
                                <th>Vehicle</th>
                                <th>Dates</th>
                                <th>Rate</th>
                                <th>Amount</th>
                                <th>Payment</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${bookings}">
                                <tr>
                                    <td><span style="font-weight:600;">#${booking.bookingId}</span></td>
                                    <td><span class="text-sm">User #${booking.userId}</span></td>
                                    <td><span class="text-sm">Vehicle #${booking.vehicleId}</span></td>
                                    <td>
                                        <div class="text-sm">${booking.startDateTime}</div>
                                        <div class="text-sm text-muted">→ ${booking.endDateTime}</div>
                                    </td>
                                    <td>
                                        <div class="text-sm">${booking.rateType}</div>
                                        <div class="text-sm text-muted">₹${booking.appliedRate}</div>
                                    </td>
                                    <td>
                                        <div style="font-weight:700;color:var(--primary);">₹${booking.totalAmount}</div>
                                        <div class="text-xs text-muted">+₹${booking.securityDeposit} dep.</div>
                                    </td>
                                    <td>
                                        <div class="text-sm">${booking.paymentMethod}</div>
                                        <c:choose>
                                            <c:when test="${booking.paymentStatus == 'Paid'}"><span class="badge badge-success" style="font-size:0.7rem;">${booking.paymentStatus}</span></c:when>
                                            <c:otherwise><span class="badge badge-warning" style="font-size:0.7rem;">${booking.paymentStatus}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${booking.bookingStatus == 'Confirmed'}"><span class="badge badge-info">${booking.bookingStatus}</span></c:when>
                                            <c:when test="${booking.bookingStatus == 'Active'}"><span class="badge badge-success">${booking.bookingStatus}</span></c:when>
                                            <c:when test="${booking.bookingStatus == 'Completed'}"><span class="badge badge-secondary">${booking.bookingStatus}</span></c:when>
                                            <c:when test="${booking.bookingStatus == 'Cancelled'}"><span class="badge badge-danger">${booking.bookingStatus}</span></c:when>
                                            <c:otherwise><span class="badge badge-secondary">${booking.bookingStatus}</span></c:otherwise>
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
