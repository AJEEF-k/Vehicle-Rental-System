<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reviews - DriveWay Admin</title>
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
            <div class="page-title"><span class="custom-icon star-icon"></span> Customer Reviews</div>
            <div class="page-subtitle">Ratings submitted by customers after completed bookings</div>
        </div>

        <c:choose>
            <c:when test="${empty reviews}">
                <div class="empty-state">
                    <div class="empty-state-icon"><span class="custom-icon star-icon"></span></div>
                    <div class="empty-state-title">No reviews yet</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Review ID</th>
                                <th>Booking</th>
                                <th>Vehicle Rating</th>
                                <th>Vendor Rating</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="review" items="${reviews}">
                                <tr>
                                    <td><span class="text-muted text-sm">#${review.reviewId}</span></td>
                                    <td><span style="font-weight:600;">Booking #${review.bookingId}</span></td>
                                    <td>
                                        <div style="display:flex;align-items:center;gap:6px;">
                                            <span style="font-weight:700;font-size:1rem;color:var(--warning);">${review.vehicleRating}</span>
                                            <span style="color:var(--warning);">
                                                <c:forEach begin="1" end="${review.vehicleRating}"><span class="custom-icon star-icon" style="font-size:0.75rem;"></span></c:forEach>
                                            </span>
                                            <span class="text-xs text-muted">/ 5</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div style="display:flex;align-items:center;gap:6px;">
                                            <span style="font-weight:700;font-size:1rem;color:var(--warning);">${review.vendorRating}</span>
                                            <span style="color:var(--warning);">
                                                <c:forEach begin="1" end="${review.vendorRating}"><span class="custom-icon star-icon" style="font-size:0.75rem;"></span></c:forEach>
                                            </span>
                                            <span class="text-xs text-muted">/ 5</span>
                                        </div>
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
