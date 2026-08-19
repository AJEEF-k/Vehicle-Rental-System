<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Vendors - DriveWay Admin</title>
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
            <div class="page-header-left">
                <div class="page-title"><span class="custom-icon store-icon"></span> Manage Vendors</div>
                <div class="page-subtitle">Approve or reject vendor registration requests</div>
            </div>
        </div>

        <c:if test="${param.success == 'approved'}"><div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Vendor approved successfully.</div></c:if>
        <c:if test="${param.success == 'rejected'}"><div class="alert alert-success"><span class="custom-icon check-circle-icon"></span> Vendor rejected successfully.</div></c:if>
        <c:if test="${param.error == 'invalidVendor'}"><div class="alert alert-danger"><span class="custom-icon warning-icon"></span> Invalid vendor.</div></c:if>

        <c:choose>
            <c:when test="${empty vendors}">
                <div class="empty-state">
                    <div class="empty-state-icon"><span class="custom-icon store-icon"></span></div>
                    <div class="empty-state-title">No vendors found</div>
                    <div class="empty-state-desc">No vendor registrations yet.</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Agency Name</th>
                                <th>Shop Address</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="vendor" items="${vendors}">
                                <tr>
                                    <td><span class="text-muted text-sm">#${vendor.vendorId}</span></td>
                                    <td>
                                        <div style="font-weight:600;color:var(--dark);">${vendor.agencyName}</div>
                                        <div style="font-size:0.78rem;color:var(--text-muted);">User #${vendor.userId}</div>
                                    </td>
                                    <td style="max-width:180px;white-space:normal;font-size:0.85rem;">${vendor.shopAddress}</td>
                                    <td style="max-width:200px;white-space:normal;font-size:0.85rem;color:var(--text-muted);">${vendor.description}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${vendor.approvalStatus == 'APPROVED'}"><span class="badge badge-success"><span class="custom-icon check-circle-icon" style="font-size:0.65rem;"></span> Approved</span></c:when>
                                            <c:when test="${vendor.approvalStatus == 'PENDING'}"><span class="badge badge-warning"><span class="custom-icon clock-icon" style="font-size:0.65rem;"></span> Pending</span></c:when>
                                            <c:when test="${vendor.approvalStatus == 'REJECTED'}"><span class="badge badge-danger"><span class="custom-icon times-circle-icon" style="font-size:0.65rem;"></span> Rejected</span></c:when>
                                            <c:otherwise><span class="badge badge-secondary">${vendor.approvalStatus}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${vendor.approvalStatus == 'PENDING'}">
                                            <div class="vendor-actions">
                                                <form action="${pageContext.request.contextPath}/admin/vendor/approve" method="post">
                                                    <input type="hidden" name="vendorId" value="${vendor.vendorId}">
                                                    <button type="submit" class="btn-success btn-sm">
                                                        <span class="custom-icon check-icon"></span> Approve
                                                    </button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/admin/vendor/reject" method="post">
                                                    <input type="hidden" name="vendorId" value="${vendor.vendorId}">
                                                    <button type="submit" class="btn-danger btn-sm">
                                                        <span class="custom-icon times-icon"></span> Reject
                                                    </button>
                                                </form>
                                            </div>
                                        </c:if>
                                        
                                        <c:if test="${vendor.approvalStatus == 'REJECTED'}">
                                            <div class="vendor-actions">
                                                <form action="${pageContext.request.contextPath}/admin/vendor/approve" method="post">
                                                    <input type="hidden" name="vendorId" value="${vendor.vendorId}">
                                                    <button type="submit" class="btn-success btn-sm">
                                                        <span class="custom-icon check-icon"></span> Approve
                                                    </button>
                                                </form>
                                  
                                            </div>
                                        </c:if>
                                        
                                         <c:if test="${vendor.approvalStatus == 'APPROVED'}">
                                            <div class="vendor-actions">
                                                <form action="${pageContext.request.contextPath}/admin/vendor/reject" method="post">
                                                    <input type="hidden" name="vendorId" value="${vendor.vendorId}">
                                                    <button type="submit" class="btn-danger btn-sm">
                                                        <span class="custom-icon check-icon"></span> Reject
                                                    </button>
                                                </form>
                                  
                                            </div>
                                        </c:if>
                                        
                                       
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
