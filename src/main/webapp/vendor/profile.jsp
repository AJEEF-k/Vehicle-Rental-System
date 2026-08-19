<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Profile - DriveWay</title>
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
                <div class="page-title"><span class="custom-icon building-icon"></span> My Profile</div>
                <div class="page-subtitle">Update your agency and personal information</div>
            </div>
        </div>

        <!-- Alerts -->
        <c:if test="${param.success == 'updated'}">
            <div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Profile updated successfully.</div>
        </c:if>
        <c:if test="${param.error == 'required'}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please fill in all required fields.</div>
        </c:if>
        <c:if test="${param.error == 'email'}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please enter a valid email address.</div>
        </c:if>
        <c:if test="${param.error == 'phone'}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Please enter a valid phone number.</div>
        </c:if>
        <c:if test="${param.error == 'emailExists'}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> This email is already in use.</div>
        </c:if>
        <c:if test="${param.error == 'updateFailed'}">
            <div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Profile update failed. Please try again.</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty user && not empty vendor}">

                <div style="display:grid;grid-template-columns:260px 1fr;gap:24px;align-items:start;">

                    <!-- Avatar / Agency card -->
                    <div class="card">
                        <div class="card-body" style="text-align:center;padding:28px 20px;">
                            <div style="width:72px;height:72px;background:linear-gradient(135deg,#FFF7ED,#FFEDD5);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:1.8rem;color:var(--accent);margin:0 auto 14px;border:2px solid #FED7AA;">
                                <span class="custom-icon store-icon"></span>
                            </div>
                            <div style="font-size:1rem;font-weight:700;color:var(--dark);margin-bottom:4px;">${vendor.agencyName}</div>
                            <div style="font-size:0.82rem;color:var(--text-muted);margin-bottom:2px;">${user.fullName}</div>
                            <div style="margin-top:10px;">
                                <c:choose>
                                    <c:when test="${vendor.approvalStatus == 'APPROVED'}">
                                        <span class="badge badge-success"><span class="custom-icon check-circle-icon" style="font-size:0.65rem;"></span> Approved Vendor</span>
                                    </c:when>
                                    <c:when test="${vendor.approvalStatus == 'PENDING'}">
                                        <span class="badge badge-warning"><span class="custom-icon clock-icon" style="font-size:0.65rem;"></span> Pending Approval</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-danger">${vendor.approvalStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div style="margin-top:20px;padding-top:18px;border-top:1px solid var(--border);">
                                <a href="${pageContext.request.contextPath}/vendor/change-password"
                                   style="display:inline-flex;align-items:center;gap:7px;padding:9px 16px;background:var(--bg);color:var(--text-muted);border:1.5px solid var(--border);border-radius:var(--radius-sm);font-size:0.82rem;font-weight:500;width:100%;justify-content:center;text-decoration:none;">
                                    <span class="custom-icon lock-icon"></span> Change Password
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Profile form -->
                    <div class="vendor-profile">
                        <div class="card-header">
                            <div class="card-title"><span class="custom-icon edit-icon"></span> Edit Profile</div>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/vendor/profile" method="post">

                                <div style="margin-bottom:22px;">
                                    <div style="font-size:0.75rem;font-weight:600;text-transform:uppercase;letter-spacing:0.08em;color:var(--text-muted);margin-bottom:14px;padding-bottom:8px;border-bottom:1px solid var(--border);">
                                        Personal Information
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="fullName">Full Name <span style="color:var(--danger);">*</span></label>
                                            <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="email">Email Address <span style="color:var(--danger);">*</span></label>
                                            <input type="email" id="email" name="email" value="${user.email}" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="phoneNumber">Phone Number <span style="color:var(--danger);">*</span></label>
                                        <input type="text" id="phoneNumber" name="phoneNumber" value="${user.phoneNumber}" required>
                                    </div>
                                </div>

                                <div>
                                    <div style="font-size:0.75rem;font-weight:600;text-transform:uppercase;letter-spacing:0.08em;color:var(--text-muted);margin-bottom:14px;padding-bottom:8px;border-bottom:1px solid var(--border);">
                                        Agency Information
                                    </div>
                                    <div class="form-group">
                                        <label for="agencyName">Agency Name <span style="color:var(--danger);">*</span></label>
                                        <input type="text" id="agencyName" name="agencyName" value="${vendor.agencyName}" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="shopAddress">Shop Address <span style="color:var(--danger);">*</span></label>
                                        <textarea id="shopAddress" name="shopAddress" rows="3" required>${vendor.shopAddress}</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <textarea id="description" name="description" rows="3">${vendor.description}</textarea>
                                        <div class="form-hint">Tell customers about your agency (optional).</div>
                                    </div>
                                </div>

                                <button type="submit">
                                    <span class="custom-icon save-icon"></span> Save Changes
                                </button>

                            </form>
                        </div>
                    </div>

                </div>

            </c:when>
            <c:otherwise>
                <div class="alert alert-danger">
                    <span class="custom-icon warning-icon"></span> Vendor information is unavailable.
                </div>
            </c:otherwise>
        </c:choose>

    </main>
</div>
<jsp:include page="/common/footer.jsp" />
</body>
</html>
