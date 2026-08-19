<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - DriveWay</title>
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
            <div class="page-title"><span class="custom-icon lock-icon"></span> Change Password</div>
            <div class="page-subtitle">Keep your account secure with a strong password</div>
        </div>

        <c:if test="${param.success == 'updated'}"><div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Password changed successfully.</div></c:if>
        <c:if test="${param.error == 'required'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please fill in all fields.</div></c:if>
        <c:if test="${param.error == 'currentPassword'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Current password is incorrect.</div></c:if>
        <c:if test="${param.error == 'password'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> New password does not meet required format (min 8 characters).</div></c:if>
        <c:if test="${param.error == 'mismatch'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> New passwords do not match.</div></c:if>
        <c:if test="${param.error == 'samePassword'}"><div class="alert alert-warning"><span class="custom-icon warning-icon"></span> New password must be different from the current password.</div></c:if>
        <c:if test="${param.error == 'failed'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Password change failed. Please try again.</div></c:if>

        <div class="card" style="max-width:520px;">
            <div class="card-header"><div class="card-title"><span class="custom-icon key-icon"></span> Update Password</div></div>
            <div class="card-body">
                <form id="changePasswordForm"
                      action="${pageContext.request.contextPath}/customer/change-password"
                      method="post"
                      onsubmit="return validatePasswordForm('changePasswordForm');">
                    <div class="form-group">
                        <label for="currentPassword">Current Password</label>
                        <input type="password" id="currentPassword" name="currentPassword" placeholder="Enter current password" required>
                    </div>
                    <div class="form-group">
                        <label for="newPassword">New Password</label>
                        <input type="password" id="newPassword" name="newPassword" placeholder="At least 8 characters" required>
                        <div class="form-hint">Must be at least 8 characters long</div>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirm New Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter new password" required>
                    </div>
                    <button type="submit"><span class="custom-icon shield-icon"></span> Update Password</button>
                </form>
            </div>
        </div>

    </main>
</div>
<jsp:include page="/common/footer.jsp" />
<script src="${pageContext.request.contextPath}/js/common.js"></script>
<script src="${pageContext.request.contextPath}/js/validation.js"></script>
</body>
</html>
