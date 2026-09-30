<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Logic to handle active menu highlighting
    String activeMenu = (String) request.getAttribute("activeMenu");
    if (activeMenu == null) {
        activeMenu = "";
    }
%>
<style>
    /* =========================
       Sidebar Styling
    ========================= */
    .main-sidebar {
        background: linear-gradient(180deg,#1e3c72,#2a5298,#0f2027) !important;
        min-height: 100vh;
        box-shadow: 4px 0 15px rgba(0,0,0,.20);
    }
    /* =========================
       Brand Logo Area
    ========================= */
    .brand-link {
        background: rgba(255,255,255,.08);
        border-bottom: 1px solid rgba(255,255,255,.15);
        text-align: center;
        padding: 16px;
    }
    .brand-link:hover {
        text-decoration: none;
    }
    .brand-text {
        color: #fff !important;
        font-size: 20px;
        font-weight: 700;
        letter-spacing: .5px;
    }
    /* =========================
       User Panel
    ========================= */
    .user-panel {
        border-bottom: 1px solid rgba(255,255,255,.12);
        padding: 15px 10px;
    }
    .user-panel .info {
        width: 100%;
    }
    .user-panel .info a {
        display: block;
        text-align: center;
        color: #fff !important;
        font-size: 15px;
        font-weight: 600;
    }
    /* =========================
       Navigation Menu
    ========================= */
    .nav-sidebar {
        margin-top: 12px;
    }
    .nav-sidebar .nav-item {
        margin: 5px 10px;
    }
    .nav-sidebar .nav-link {
        display: flex;
        align-items: center;
        color: #eef6ff !important;
        border-radius: 10px;
        padding: 12px 15px;
        transition: .3s;
    }
    .nav-sidebar .nav-icon {
        width: 24px;
        text-align: center;
        margin-right: 12px;
        font-size: 16px;
    }
    .nav-sidebar .nav-link p {
        margin: 0;
        font-size: 15px;
        font-weight: 500;
    }
    .nav-sidebar .nav-link:hover {
        background: rgba(255,255,255,.18);
        color: #fff !important;
        transform: translateX(4px);
    }
    /* Active State Styling */
    .nav-sidebar .nav-link.active {
        background: linear-gradient(90deg,#2196F3,#42A5F5);
        color: #fff !important;
        box-shadow: 0 4px 10px rgba(0,0,0,.20);
    }
    .nav-sidebar .nav-link.active .nav-icon {
        color: #fff;
    }
    /* =========================
       Logout Link Styling
    ========================= */
    .logout-link {
        margin-top: 18px;
    }
    .logout-link .nav-link {
        color: #ffd54f !important;
    }
    .logout-link .nav-link:hover {
        background: #ffc107;
        color: #1e3c72 !important;
    }
</style>

<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo - Changed to point to Controller -->
    <a href="officerController?actionType=dashboard" class="brand-link">
        <span class="brand-text">
            TRAINEE MANAGEMENT
        </span>
    </a>

    <div class="sidebar">
        <!-- Officer Name -->
        <div class="user-panel d-flex">
            <div class="info">
                <a href="#">
                    ${sessionScope.userName != null ? sessionScope.userName : 'CITG Officer'}
                </a>
            </div>
        </div>

        <!-- Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column"
                data-widget="treeview"
                role="menu">
                
                <!-- Dashboard - CORRECTED: Now points to Controller -->
                <li class="nav-item">
                    <a href="officerController?actionType=dashboard"
                       class="nav-link <%= "dashboard".equals(activeMenu) ? "active" : ""%>">
                        <i class="nav-icon fas fa-home"></i>
                        <p>Dashboard</p>
                    </a>
                </li>

                <!-- Add Trainee -->
                <li class="nav-item">
                    <a href="officerController?actionType=addTrainee"
                       class="nav-link <%= "addTrainee".equals(activeMenu) ? "active" : ""%>">
                        <i class="nav-icon fas fa-user-plus"></i>
                        <p>Add Trainee</p>
                    </a>
                </li>

                <!-- View Trainees -->
                <li class="nav-item">
                    <a href="officerController?actionType=viewTrainee"
                       class="nav-link <%= "viewTrainee".equals(activeMenu) ? "active" : ""%>">
                        <i class="nav-icon fas fa-users"></i>
                        <p>View Trainees</p>
                    </a>
                </li>

                <!-- Logout - Changed to point to a controller for session invalidation -->
                <li class="nav-item logout-link">
                    <a href="loginController?actionType=logout" class="nav-link">
                        <i class="nav-icon fas fa-sign-out-alt"></i>
                        <p>Logout</p>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</aside>