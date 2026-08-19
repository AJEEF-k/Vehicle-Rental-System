<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - DriveWay Admin</title>
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
                <div class="page-title"><span class="custom-icon users-icon"></span> Manage Users</div>
                <div class="page-subtitle">All registered customers and vendor accounts</div>
            </div>
        </div>
        
        
		   <c:if test="${param.success == 'statusUpdated'}">
			    <p class="success">
			        Customer account status updated successfully.
			    </p>
			</c:if>
			
			<c:if test="${param.error == 'invalidRequest'}">
			    <p class="error">
			        Invalid account status request.
			    </p>
			</c:if>
			
			<c:if test="${param.error == 'invalidStatus'}">
			    <p class="error">
			        Invalid account status.
			    </p>
			</c:if>
			
			<c:if test="${param.error == 'userNotFound'}">
			    <p class="error">
			        User not found.
			    </p>
			</c:if>
			
			<c:if test="${param.error == 'customerOnly'}">
			    <p class="error">
			        Account status changes are available only for customers.
			    </p>
			</c:if>
			
			<c:if test="${param.error == 'updateFailed'}">
			    <p class="error">
			        Unable to update the customer account status.
			    </p>
			</c:if>
			        

        <c:choose>
            <c:when test="${empty users}">
                <div class="empty-state">
                    <div class="empty-state-icon"><span class="custom-icon users-icon"></span></div>
                    <div class="empty-state-title">No users found</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td><span class="text-muted text-sm">#${user.userId}</span></td>
                                    <td><span style="font-weight:600;color:var(--dark);">${user.fullName}</span></td>
                                    <td>${user.email}</td>
                                    <td>${user.phoneNumber}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.role == 'ADMIN'}"><span class="badge badge-danger">${user.role}</span></c:when>
                                            <c:when test="${user.role == 'VENDOR'}"><span class="badge badge-warning">${user.role}</span></c:when>
                                            <c:otherwise><span class="badge badge-info">${user.role}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                        
                                            <c:when test="${user.accountStatus == 'ACTIVE'}"><span class="badge badge-success">${user.accountStatus}</span></c:when>
                                            <c:otherwise><span class="badge badge-secondary">${user.accountStatus}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    
                                    
                                    <td>

									    <c:if test="${user.role == 'CUSTOMER'}">
									
									        <div class="user-actions">
									
									            <c:choose>
									
									                <c:when test="${user.accountStatus == 'ACTIVE'}">
									
									                    <form action="${pageContext.request.contextPath}/admin/customer/status"
									                          method="post"
									                          onsubmit="return confirmAction('Are you sure you want to deactivate this customer account?');">
									
									                        <input type="hidden"
									                               name="userId"
									                               value="${user.userId}">
									
									                        <input type="hidden"
									                               name="accountStatus"
									                               value="INACTIVE">
									
									                        <button type="submit"
									                                class="btn-status-danger">
									
									                            Deactivate
									
									                        </button>
									
									                    </form>
									
									                </c:when>
									
									                <c:otherwise>
									
									                    <form action="${pageContext.request.contextPath}/admin/customer/status"
									                          method="post"
									                          onsubmit="return confirmAction('Activate this customer account?');">
									
									                        <input type="hidden"
									                               name="userId"
									                               value="${user.userId}">
									
									                        <input type="hidden"
									                               name="accountStatus"
									                               value="ACTIVE">
									
									                        <button type="submit"
									                                class="btn-status-success">
									
									                            Activate
									
									                        </button>
									
									                    </form>
									
									                </c:otherwise>
									
									            </c:choose>
									
									        </div>
									
									    </c:if>
									    
									   <c:if test="${user.role != 'CUSTOMER'}">

									        <span class="no-action">
									            No Action
									        </span>
									
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
<script src="${pageContext.request.contextPath}/js/common.js"></script>

</body>
</html>
