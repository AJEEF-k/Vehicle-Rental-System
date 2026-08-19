<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DriveWay - Vehicle Rental System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icons.css">
    <style>
      /* Landing-specific styles */
      body { background: var(--dark); }

      .landing-header {
        background: transparent;
        box-shadow: none;
        border-bottom: 1px solid rgba(255,255,255,0.07);
      }

      .hero {
        min-height: calc(100vh - 64px);
        background: linear-gradient(160deg, #0D1B2A 0%, #0F2540 40%, #162D50 100%);
        display: flex;
        align-items: center;
        padding: 60px 24px;
        position: relative;
        overflow: hidden;
      }

      .hero::before {
        content: '';
        position: absolute;
        width: 600px; height: 600px;
        background: radial-gradient(circle, rgba(26,86,219,0.15) 0%, transparent 70%);
        top: -100px; right: -100px;
        border-radius: 50%;
      }

      .hero::after {
        content: '';
        position: absolute;
        width: 400px; height: 400px;
        background: radial-gradient(circle, rgba(255,107,43,0.08) 0%, transparent 70%);
        bottom: -80px; left: 10%;
        border-radius: 50%;
      }

      .hero-content {
        max-width: 1100px;
        margin: 0 auto;
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 64px;
        align-items: center;
        position: relative;
        z-index: 1;
        width: 100%;
      }

      .hero-eyebrow {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: rgba(255,107,43,0.15);
        border: 1px solid rgba(255,107,43,0.3);
        color: var(--accent);
        padding: 6px 14px;
        border-radius: 99px;
        font-size: 0.8rem;
        font-weight: 600;
        letter-spacing: 0.04em;
        text-transform: uppercase;
        margin-bottom: 20px;
      }

      .hero-title {
        font-size: 3.2rem;
        font-weight: 800;
        color: #fff;
        line-height: 1.1;
        letter-spacing: -0.03em;
        margin-bottom: 20px;
      }

      .hero-title .highlight {
        background: linear-gradient(135deg, var(--accent), #FFB347);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
      }

      .hero-subtitle {
        color: rgba(255,255,255,0.55);
        font-size: 1.05rem;
        line-height: 1.7;
        margin-bottom: 36px;
        max-width: 480px;
        font-weight: 400;
      }

      .hero-cta {
        display: flex;
        gap: 14px;
        flex-wrap: wrap;
        align-items: center;
      }

      .btn-hero-primary {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 14px 30px;
        background: var(--accent);
        color: white;
        border-radius: var(--radius-sm);
        font-weight: 700;
        font-size: 0.975rem;
        text-decoration: none;
        transition: var(--transition);
        box-shadow: 0 8px 24px rgba(255,107,43,0.35);
      }
      .btn-hero-primary:hover {
        background: var(--accent-dark);
        transform: translateY(-2px);
        box-shadow: 0 12px 32px rgba(255,107,43,0.45);
        color: white;
      }

      .btn-hero-secondary {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 14px 28px;
        background: rgba(255,255,255,0.08);
        color: rgba(255,255,255,0.85);
        border: 1px solid rgba(255,255,255,0.15);
        border-radius: var(--radius-sm);
        font-weight: 600;
        font-size: 0.975rem;
        text-decoration: none;
        transition: var(--transition);
        backdrop-filter: blur(4px);
      }
      .btn-hero-secondary:hover {
        background: rgba(255,255,255,0.14);
        color: white;
        border-color: rgba(255,255,255,0.25);
      }

      .hero-stats {
        display: flex;
        gap: 32px;
        margin-top: 40px;
        padding-top: 32px;
        border-top: 1px solid rgba(255,255,255,0.08);
      }

      .hero-stat-value {
        font-size: 1.6rem;
        font-weight: 800;
        color: white;
        letter-spacing: -0.02em;
        line-height: 1;
      }

      .hero-stat-label {
        font-size: 0.8rem;
        color: rgba(255,255,255,0.4);
        margin-top: 4px;
        font-weight: 400;
      }

      /* Right panel - vehicle showcase card */
      .hero-visual {
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .hero-card {
        background: rgba(255,255,255,0.05);
        border: 1px solid rgba(255,255,255,0.1);
        border-radius: var(--radius-lg);
        padding: 28px;
        backdrop-filter: blur(12px);
        width: 100%;
        max-width: 380px;
      }

      .hero-card-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 20px;
      }

      .hero-card-badge {
        background: rgba(16,185,129,0.15);
        border: 1px solid rgba(16,185,129,0.3);
        color: #34D399;
        padding: 4px 12px;
        border-radius: 99px;
        font-size: 0.75rem;
        font-weight: 600;
      }

      .hero-car-visual {
        width: 100%;
        height: 130px;
        background: linear-gradient(135deg, rgba(26,86,219,0.15), rgba(255,107,43,0.1));
        border-radius: var(--radius-md);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 5rem;
        margin-bottom: 20px;
      }

      .hero-vehicle-name {
        color: white;
        font-size: 1.1rem;
        font-weight: 700;
        margin-bottom: 4px;
      }

      .hero-vehicle-brand {
        color: rgba(255,255,255,0.45);
        font-size: 0.82rem;
        margin-bottom: 16px;
      }

      .hero-vehicle-specs {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 12px;
        margin-bottom: 18px;
      }

      .hero-spec {
        background: rgba(255,255,255,0.06);
        border-radius: var(--radius-xs);
        padding: 10px 12px;
      }

      .hero-spec-label {
        font-size: 0.7rem;
        color: rgba(255,255,255,0.4);
        text-transform: uppercase;
        letter-spacing: 0.06em;
        font-weight: 600;
        margin-bottom: 2px;
      }

      .hero-spec-value {
        font-size: 0.92rem;
        font-weight: 700;
        color: white;
      }

      .hero-book-btn {
        width: 100%;
        padding: 12px;
        background: var(--accent);
        color: white;
        border: none;
        border-radius: var(--radius-sm);
        font-weight: 700;
        font-size: 0.9rem;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        text-decoration: none;
        transition: var(--transition);
      }
      .hero-book-btn:hover { background: var(--accent-dark); color: white; }

      /* Features section */
      .features-section {
        background: #F8FAFC;
        padding: 72px 24px;
      }

      .features-inner {
        max-width: 1100px;
        margin: 0 auto;
      }

      .section-label {
        text-align: center;
        font-size: 0.75rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.12em;
        color: var(--accent);
        margin-bottom: 10px;
      }

      .section-title {
        text-align: center;
        font-size: 2rem;
        font-weight: 800;
        color: var(--dark);
        margin-bottom: 12px;
        letter-spacing: -0.02em;
      }

      .section-subtitle {
        text-align: center;
        color: var(--text-muted);
        font-size: 1rem;
        max-width: 520px;
        margin: 0 auto 48px;
        line-height: 1.7;
      }

      .features-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 24px;
      }

      .feature-card {
        background: white;
        border: 1px solid var(--border);
        border-radius: var(--radius-md);
        padding: 28px 24px;
        transition: var(--transition);
        box-shadow: var(--shadow-xs);
      }

      .feature-card:hover {
        box-shadow: var(--shadow-md);
        transform: translateY(-4px);
        border-color: rgba(26,86,219,0.2);
      }

      .feature-icon {
        width: 52px; height: 52px;
        border-radius: var(--radius-sm);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.4rem;
        margin-bottom: 18px;
      }

      .feature-card h3 {
        font-size: 1rem;
        font-weight: 700;
        color: var(--dark);
        margin-bottom: 8px;
      }

      .feature-card p {
        font-size: 0.875rem;
        color: var(--text-muted);
        line-height: 1.6;
      }

      /* Role cards section */
      .roles-section {
        background: white;
        padding: 72px 24px;
        border-top: 1px solid var(--border);
      }

      .roles-inner {
        max-width: 1100px;
        margin: 0 auto;
      }

      .roles-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 24px;
        margin-top: 48px;
      }

      .role-card {
        border-radius: var(--radius-lg);
        padding: 36px 28px;
        text-align: center;
        position: relative;
        overflow: hidden;
        transition: var(--transition);
      }

      .role-card:hover { transform: translateY(-4px); box-shadow: var(--shadow-lg); }

      .role-card.customer { background: linear-gradient(135deg, #EFF6FF, #DBEAFE); border: 1px solid #BFDBFE; }
      .role-card.vendor   { background: linear-gradient(135deg, #FFF7ED, #FFEDD5); border: 1px solid #FED7AA; }
      .role-card.admin    { background: linear-gradient(135deg, #F0FDF4, #DCFCE7); border: 1px solid #BBF7D0; }

      .role-icon {
        width: 64px; height: 64px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
        margin: 0 auto 18px;
      }

      .role-card.customer .role-icon { background: rgba(26,86,219,0.12); color: var(--primary); }
      .role-card.vendor   .role-icon { background: rgba(255,107,43,0.12); color: var(--accent);  }
      .role-card.admin    .role-icon { background: rgba(16,185,129,0.12); color: var(--success); }

      .role-card h3 {
        font-size: 1.1rem;
        font-weight: 700;
        margin-bottom: 10px;
      }

      .role-card.customer h3 { color: #1E40AF; }
      .role-card.vendor   h3 { color: #9A3412; }
      .role-card.admin    h3 { color: #065F46; }

      .role-card p {
        font-size: 0.875rem;
        line-height: 1.6;
        margin-bottom: 22px;
      }

      .role-card.customer p { color: #1E40AF; opacity: 0.7; }
      .role-card.vendor   p { color: #9A3412; opacity: 0.7; }
      .role-card.admin    p { color: #065F46; opacity: 0.7; }

      .role-btn {
        display: inline-flex;
        align-items: center;
        gap: 7px;
        padding: 10px 22px;
        border-radius: var(--radius-sm);
        font-weight: 600;
        font-size: 0.875rem;
        text-decoration: none;
        transition: var(--transition);
      }

      .role-card.customer .role-btn { background: var(--primary); color: white; }
      .role-card.vendor   .role-btn { background: var(--accent);  color: white; }
      .role-card.admin    .role-btn { background: var(--success); color: white; }

      .role-btn:hover { opacity: 0.9; transform: translateY(-1px); color: white; }

      /* Landing footer */
      .landing-footer {
        background: var(--dark);
        color: rgba(255,255,255,0.35);
        text-align: center;
        padding: 24px;
        font-size: 0.85rem;
      }
      .landing-footer span { color: var(--accent); }

      @media (max-width: 900px) {
        .hero-content { grid-template-columns: 1fr; gap: 40px; }
        .hero-title { font-size: 2.4rem; }
        .hero-visual { justify-content: flex-start; }
        .hero-card { max-width: 100%; }
        .features-grid { grid-template-columns: 1fr 1fr; }
        .roles-grid { grid-template-columns: 1fr; max-width: 420px; margin-left: auto; margin-right: auto; }
      }

      @media (max-width: 600px) {
        .hero { padding: 40px 16px; }
        .hero-title { font-size: 1.9rem; }
        .features-grid { grid-template-columns: 1fr; }
        .hero-stats { gap: 20px; }
      }
    </style>
</head>
<body>

<!-- Header -->
<header class="site-header landing-header">
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/index.jsp" class="header-brand">
            <div class="brand-icon"><span class="custom-icon bike-icon"></span></div>
            <div>
                <div>Drive<span class="brand-highlight">Way</span></div>
                <div class="header-tagline">Vehicle Rental System</div>
            </div>
        </a>
    </div>
    <div style="display:flex;gap:12px;align-items:center;">
        <a href="${pageContext.request.contextPath}/login.jsp" style="color:rgba(255,255,255,0.7);font-size:0.9rem;font-weight:500;text-decoration:none;">Log In</a>
        <a href="${pageContext.request.contextPath}/register.jsp" style="background:var(--accent);color:white;padding:9px 20px;border-radius:var(--radius-sm);font-size:0.875rem;font-weight:600;text-decoration:none;">Get Started</a>
    </div>
</header>

<!-- HERO SECTION -->
<section class="hero">
    <div class="hero-content">
        <!-- Left column -->
        <div class="hero-left">
            <div class="hero-eyebrow">
                <span class="custom-icon bolt-icon"></span> Fast, Simple & Affordable
            </div>
            <h1 class="hero-title">
                Rent Any Vehicle,<br>
                <span class="highlight">Anywhere.</span>
            </h1>
            <p class="hero-subtitle">
                Connect with verified vendors across the city. Browse vehicles, book in minutes, and hit the road — completely hassle-free.
            </p>
            <div class="hero-cta">
            
                <a href="${pageContext.request.contextPath}/register.jsp" class="btn-hero-primary">
                    <span class="custom-icon user-icon"></span>
                    Create Free Account
                </a>
                
                <a href="${pageContext.request.contextPath}/vendor-register.jsp" class="btn-hero-secondary">
				
				        <span class="custom-icon store-icon"></span>
				        Vendor Registration
				
				    </a>
                
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn-hero-secondary">
                    <span class="custom-icon login-icon"></span>
                    Sign In
                </a>
            </div>
            <div class="hero-stats">
                <div>
                    <div class="hero-stat-value">100+</div>
                    <div class="hero-stat-label">Vehicles Listed</div>
                </div>
                <div>
                    <div class="hero-stat-value">₹99</div>
                    <div class="hero-stat-label">Starting Per Hour</div>
                </div>
                <div>
                    <div class="hero-stat-value">24/7</div>
                    <div class="hero-stat-label">Available Anytime</div>
                </div>
            </div>
        </div>

        <!-- Right column - showcase card -->
        <div class="hero-visual">
            <div class="hero-card">
                <div class="hero-card-header">
                    <span style="color:rgba(255,255,255,0.7);font-size:0.82rem;font-weight:600;"><span class="custom-icon star-icon" style="background-color:#FBBF24;margin-right:4px;"></span> Featured Listing</span>
                    <span class="hero-card-badge"><span class="custom-icon dot-icon" style="font-size:0.5rem;margin-right:4px;"></span> Available</span>
                </div>
                <div class="hero-car-visual">🏍️</div>
                <div class="hero-vehicle-name">Ultraviolette F77</div>
                <div class="hero-vehicle-brand">Ultraviolette &nbsp;·&nbsp; Electric BIKE</div>
                <div class="hero-vehicle-specs">
                    <div class="hero-spec">
                        <div class="hero-spec-label">Hourly Rate</div>
                        <div class="hero-spec-value">₹150/hr</div>
                    </div>
                    <div class="hero-spec">
                        <div class="hero-spec-label">Daily Rate</div>
                        <div class="hero-spec-value">₹1,200/day</div>
                    </div>
                    <div class="hero-spec">
                        <div class="hero-spec-label">Range</div>
                        <div class="hero-spec-value">211 km</div>
                    </div>
                    <div class="hero-spec">
                        <div class="hero-spec-label">Category</div>
                        <div class="hero-spec-value">Electric BIKE</div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/login.jsp" class="hero-book-btn">
                    <span class="custom-icon calendar-check-icon"></span> Book This Vehicle
                </a>
            </div>
        </div>
    </div>
</section>

<!-- FEATURES SECTION -->
<section class="features-section">
    <div class="features-inner">
        <div class="section-label">Why DriveWay?</div>
        <h2 class="section-title">Everything you need to rent with confidence</h2>
        <p class="section-subtitle">A platform built for modern India — connecting customers with trusted vehicle vendors.</p>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon" style="background:#EFF6FF;color:#1A56DB;">
                    <span class="custom-icon shield-icon"></span>
                </div>
                <h3>Verified Vendors</h3>
                <p>All vendors go through an admin approval process before listing vehicles, ensuring quality and trust.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon" style="background:#FFF7ED;color:#FF6B2B;">
                    <span class="custom-icon bolt-icon"></span>
                </div>
                <h3>Instant Booking</h3>
                <p>Pick your dates, choose hourly or daily rates, and confirm your booking in under two minutes.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon" style="background:#F0FDF4;color:#10B981;">
                    <span class="custom-icon leaf-icon"></span>
                </div>
                <h3>Electric Fleet</h3>
                <p>Browse a growing selection of electric vehicles with battery range information front and center.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon" style="background:#F5F3FF;color:#7C3AED;">
                    <span class="custom-icon rupee-icon"></span>
                </div>
                <h3>Flexible Pricing</h3>
                <p>Choose between hourly and daily rates. Pay via UPI or Cash — whatever suits your plan.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon" style="background:#FEF2F2;color:#EF4444;">
                    <span class="custom-icon star-icon"></span>
                </div>
                <h3>Honest Reviews</h3>
                <p>After completing a booking, customers can leave reviews to help the community make better choices.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon" style="background:#ECFDF5;color:#059669;">
                    <span class="custom-icon headset-icon"></span>
                </div>
                <h3>Real-time Status</h3>
                <p>Track your booking status from Confirmed → Active → Completed, with vendor updates in real time.</p>
            </div>
        </div>
    </div>
</section>

<!-- ROLES SECTION -->
<section class="roles-section">
    <div class="roles-inner">
        <div class="section-label">Who Is It For?</div>
        <h2 class="section-title">Three roles. One platform.</h2>
        <p class="section-subtitle">Whether you want to rent a vehicle, list your fleet, or manage the system — DriveWay has you covered.</p>
        <div class="roles-grid">
            <div class="role-card customer">
                <div class="role-icon"><span class="custom-icon user-icon"></span></div>
                <h3>Customer</h3>
                <p>Browse available vehicles, book by the hour or day, manage your bookings, and leave reviews.</p>
                <a href="${pageContext.request.contextPath}/register.jsp" class="role-btn">
                    <span class="custom-icon arrow-right-icon"></span> Start Renting
                </a>
            </div>
            <div class="role-card vendor">
                <div class="role-icon"><span class="custom-icon store-icon"></span></div>
                <h3>Vendor</h3>
                <p>List your vehicles, set your own rates, and manage bookings from a dedicated vendor dashboard.</p>
                <a href="${pageContext.request.contextPath}/vendor-register.jsp" class="role-btn">
                    <span class="custom-icon arrow-right-icon"></span> List Your Fleet
                </a>
            </div>
            <div class="role-card admin">
                <div class="role-icon"><span class="custom-icon shield-icon"></span></div>
                <h3>Admin</h3>
                <p>Approve vendors, oversee all bookings, users, and vehicles, and keep the platform running smoothly.</p>
                <a href="${pageContext.request.contextPath}/login.jsp" class="role-btn">
                    <span class="custom-icon arrow-right-icon"></span> Admin Login
                </a>
            </div>
        </div>
    </div>
</section>

<footer class="landing-footer">
    <p>&copy; 2026 <span>DriveWay</span> Vehicle Rental System &mdash; All rights reserved.</p>
</footer>

</body>
</html>
