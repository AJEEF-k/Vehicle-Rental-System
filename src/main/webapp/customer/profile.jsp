<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - DriveWay</title>
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
            <div class="page-title"><span class="custom-icon user-icon"></span> My Profile</div>
            <div class="page-subtitle">Update your personal information</div>
        </div>

        <c:if test="${param.success == 'updated'}"><div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Profile updated successfully.</div></c:if>
        <c:if test="${param.error == 'required'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please fill in all required fields.</div></c:if>
        <c:if test="${param.error == 'email'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please enter a valid email address.</div></c:if>
        <c:if test="${param.error == 'phone'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please enter a valid phone number.</div></c:if>
        <c:if test="${param.error == 'emailExists'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> This email is already registered.</div></c:if>
        <c:if test="${param.error == 'updateFailed'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Profile update failed. Please try again.</div></c:if>

        <c:choose>
            <c:when test="${not empty user}">
                <div class="profile-layout">

                    <!-- Avatar card -->
                    <div class="profile-avatar-card">
                        <div class="profile-avatar"><span class="custom-icon user-icon"></span></div>
                        <div class="profile-name">${user.fullName}</div>
                        <div class="profile-role"><span class="badge badge-info" style="margin-top:6px;"><span class="custom-icon user-icon"></span> Customer</span></div>
                        <div style="margin-top:20px;padding-top:20px;border-top:1px solid var(--border);">
                            <a href="${pageContext.request.contextPath}/customer/change-password"
                               style="display:inline-flex;align-items:center;gap:7px;padding:9px 20px;background:var(--bg);color:var(--text-muted);border:1.5px solid var(--border);border-radius:var(--radius-sm);font-size:0.85rem;font-weight:500;width:100%;justify-content:center;text-decoration:none;">
                                <span class="custom-icon lock-icon"></span> Change Password
                            </a>
                        </div>
                    </div>

                    <!-- Form card -->
                    <div class="profile-form-card">
                        <div class="card-header"><div class="card-title"><span class="custom-icon edit-icon"></span> Edit Profile</div></div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/customer/profile" method="post">
                                <div class="form-group">
                                    <label for="fullName">Full Name</label>
                                    <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
                                </div>
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input type="email" id="email" name="email" value="${user.email}" required>
                                </div>
                                <div class="form-group">
                                    <label for="phoneNumber">Phone Number</label>
                                    <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" required>
                                </div>
                                <button type="submit"><span class="custom-icon save-icon"></span> Save Changes</button>
                            </form>
                        </div>
                    </div>

                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> User information is unavailable.</div>
            </c:otherwise>
        </c:choose>

    </main>
</div>
<jsp:include page="/common/footer.jsp" />
</body>
</html>
