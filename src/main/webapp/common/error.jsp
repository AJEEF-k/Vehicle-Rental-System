<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - DriveWay</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icons.css">
    <style>
      .error-page { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 24px; }
      .error-card { background: white; border-radius: var(--radius-lg); padding: 48px; text-align: center; max-width: 480px; box-shadow: var(--shadow-lg); border: 1px solid var(--border); }
      .error-code { font-size: 5rem; font-weight: 800; color: var(--danger); line-height: 1; margin-bottom: 12px; letter-spacing: -0.04em; }
      .error-title { font-size: 1.4rem; font-weight: 700; color: var(--dark); margin-bottom: 10px; }
      .error-msg { color: var(--text-muted); margin-bottom: 28px; }
    </style>
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="error-page">
    <div class="error-card">
        <div class="error-code"><span class="custom-icon warning-icon"></span></div>
        <div class="error-title">Something went wrong</div>
        <p class="error-msg">
            <%= request.getAttribute("errorMessage") != null
                ? request.getAttribute("errorMessage")
                : "An unexpected error occurred. Please try again." %>
        </p>
        <a href="${pageContext.request.contextPath}/index.jsp" style="display:inline-flex;align-items:center;gap:8px;padding:11px 24px;background:var(--primary);color:white;border-radius:var(--radius-sm);font-weight:600;font-size:0.9rem;">
            <span class="custom-icon home-icon"></span> Go Home
        </a>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
</body>
</html>
