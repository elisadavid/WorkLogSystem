<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Load required plugins for functionality -->
<!--<link rel="stylesheet" href="plugins/jquery-ui/jquery-ui.css">
<script src="plugins/jquery/jquery.min.js"></script>
<script src="plugins/jquery-ui/jquery-ui.min.js"></script>-->

<%
    String activeMenu = (String) request.getAttribute("activeMenu");
    if (activeMenu == null) {
        activeMenu = "";
    }

    Integer unreadCount = (Integer) request.getAttribute("unreadCount");
%>

<style>
    /* 1. SIDEBAR MAIN BACKGROUND - Professional Dark Gradient */
    .main-sidebar {
        background: linear-gradient(180deg, #1e3c72 0%, #2a5298 50%, #0f2027 100%) !important;
        box-shadow: 4px 0 10px rgba(0, 0, 0, 0.2) !important;
        border-right: none !important;
        overflow-x: hidden;
    }

    /* 2. BRAND LINK (Top Logo Area) */
    .brand-link {
        border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
        background: rgba(0, 0, 0, 0.2) !important;
        color: #ffffff !important;
        padding: 15px 15px !important;
    }
    .brand-text {
        color: #ffffff !important;
        font-weight: 700 !important;
        letter-spacing: 1px;
        text-transform: uppercase;
    }

    /* 3. USER PANEL */
    .user-panel {
        border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
        margin-bottom: 1rem !important;
        padding: 15px !important;
    }
    .user-panel .info {
        color: #e0e7ff !important;
        font-size: 0.85rem;
        line-height: 1.2;
    }
    .user-panel strong {
        color: #ffffff !important;
        display: block;
        font-size: 1rem;
        font-weight: 600;
        margin-top: 2px;
    }

    /* 4. NAV LINKS */
    .nav-sidebar .nav-item .nav-link {
        color: rgba(255, 255, 255, 0.8) !important;
        border-radius: 8px !important;
        margin: 4px 12px !important;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
        padding: 10px 15px !important;
    }
    .nav-sidebar .nav-link i {
        color: rgba(255, 255, 255, 0.7) !important;
        margin-right: 10px;
    }

    /* Nav Headers */
    .nav-header {
        color: rgba(255, 255, 255, 0.4) !important;
        font-size: 0.7rem !important;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        margin-left: 24px !important;
        margin-top: 15px !important;
    }

    /* 5. ACTIVE STATE - Glassmorphism Effect */
    .nav-sidebar .nav-item .nav-link.active {
        background: rgba(255, 255, 255, 0.15) !important;
        backdrop-filter: blur(10px);
        -webkit-backdrop-filter: blur(10px);
        color: #ffffff !important;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        font-weight: 600;
    }
    .nav-sidebar .nav-item .nav-link.active i {
        color: #ffffff !important;
    }

    /* 6. HOVER STATE */
    .nav-sidebar .nav-item .nav-link:hover {
        background: rgba(255, 255, 255, 0.1) !important;
        color: #ffffff !important;
        transform: translateX(5px);
    }

    /* Treeview Sub-menus */
    .nav-treeview {
        background: rgba(0, 0, 0, 0.2) !important;
    }
    .nav-treeview .nav-link {
        font-size: 0.85rem !important;
        padding-left: 30px !important;
    }

    /* 7. TOP NAVBAR Match */
    .main-header {
        background: #1e3a8a !important;
        border-bottom: none !important;
    }

    /* Notification Badge */
    .notification-count {
        background: #ff4d4d;
        color: #fff;
        border-radius: 50%;
        padding: 2px 6px;
        font-size: 10px;
        font-weight: bold;
        margin-left: 8px;
        display: inline-block;
        min-width: 18px;
        text-align: center;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
</style>

<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index.jsp" class="brand-link">
        <img src="dist/img/AdminLTELogo.png" alt="Logo" class="brand-image img-circle elevation-3" style="opacity: 1">
        <span class="brand-text font-weight-light">WORKLOG</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- User Profile Section -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex align-items-center">
            <div class="image">
                <img src="dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image" style="width: 40px; height: 40px; border: 2px solid rgba(255,255,255,0.5);">
            </div>
            <div class="info ml-3">
                <span class="d-block">Welcome back,</span>
                <strong><%= session.getAttribute("userName")%></strong>
            </div>
        </div>

        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                <li class="nav-header">My Workspace</li>

                
                <li class="nav-item">

                    <a href="traineesController?actionType=dashboard"
                       class="nav-link <%= "dashboard".equals(activeMenu) ? "active" : ""%>">

                        <i class="nav-icon fas fa-home"></i>

                        <p>Dashboard</p>

                    </a>

                </li> 
                
                <!-- Work Log Section -->
                <li class="nav-item">
                    <a href="traineesController?actionType=viewTasks" class="nav-link">
                        <i class="nav-icon fas fa-tasks"></i>
                        <p>My Tasks</p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="traineesController?actionType=viewWorkLogs" class="nav-link">
                        <i class="nav-icon fas fa-clipboard-list"></i>
                        <p>Daily Work Log</p>
                    </a>
                </li>

                <!-- Leave Section -->
                <li class="nav-item">
                    <a href="traineesController?actionType=viewLeave" class="nav-link">
                        <i class="nav-icon fas fa-calendar-check"></i>
                        <p>Request Leave</p>
                    </a>
                </li>

                <!-- Reports Section -->
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-file-alt"></i>
                        <p>
                            Monthly Report
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>

                    <ul class="nav nav-treeview">

                        <li class="nav-item">
                            <a href="traineesController?actionType=generateMonthlyReport"
                               class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>Generate Report</p>
                            </a>
                        </li>

                        <li class="nav-item">
                            <a href="traineesController?actionType=viewMonthlyReport"
                               class="nav-link">
                                <i class="far fa-circle nav-icon"></i>
                                <p>My Reports</p>
                            </a>
                        </li>

                    </ul>
                </li>


               
                <li class="nav-item">
                    <a href="notificationController?actionType=viewNotifications" class="nav-link">
                        <i class="nav-icon fas fa-bell"></i>
                        <p>
                            Notifications
                            <% if (unreadCount != null && unreadCount > 0) {%>
                            <span class="notification-count"><%= unreadCount%></span>
                            <% }%>
                        </p>
                    </a>
                </li>

                <!-- Logout -->
                <li class="nav-item mt-4">
                    <a href="logoutController?actionType=logout" class="nav-link text-warning">
                        <i class="nav-icon fas fa-sign-out-alt"></i>
                        <p>Logout</p>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</aside>