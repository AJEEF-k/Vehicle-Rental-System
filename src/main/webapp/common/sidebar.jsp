<aside class="sidebar">

    <div class="sidebar-label">Customer</div>

    <nav>
        <a href="${pageContext.request.contextPath}/customer/home">
            <span class="custom-icon home-icon"></span>
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/customer/vehicles">
            <span class="custom-icon car-icon"></span>
            Browse Vehicles
        </a>
        <a href="${pageContext.request.contextPath}/customer/bookings">
            <span class="custom-icon calendar-check-icon"></span>
            My Bookings
        </a>
        <a href="${pageContext.request.contextPath}/customer/profile">
            <span class="custom-icon user-icon"></span>
            My Profile
        </a>
        <a href="${pageContext.request.contextPath}/customer/change-password">
            <span class="custom-icon lock-icon"></span>
            Change Password
        </a>
    </nav>

    <div class="sidebar-divider"></div>

    <div class="sidebar-logout">
        <a href="${pageContext.request.contextPath}/logout">
            <span class="custom-icon logout-icon"></span>
            Sign Out
        </a>
    </div>

</aside>
