<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String activeMenu = (String) request.getAttribute("activeMenu");
    if (activeMenu == null) {
        activeMenu = "";
    }

    Integer unreadCount = (Integer) request.getAttribute("unreadCount");
%>

<style>

    /* =========================
       Sidebar
    ========================= */

    .main-sidebar{
        background: linear-gradient(180deg,#1e3c72,#2a5298,#0f2027) !important;
        min-height:100vh;
        box-shadow:4px 0 15px rgba(0,0,0,.20);
    }

    /* =========================
       Brand
    ========================= */

    .brand-link{
        background:rgba(255,255,255,.08);
        border-bottom:1px solid rgba(255,255,255,.15);
        text-align:center;
        padding:16px;
    }

    .brand-link:hover{
        text-decoration:none;
    }

    .brand-text{
        color:#fff !important;
        font-size:20px;
        font-weight:700;
        letter-spacing:.5px;
    }

    /* =========================
       User
    ========================= */

    .user-panel{
        border-bottom:1px solid rgba(255,255,255,.12);
        padding:15px 10px;
    }

    .user-panel .info{
        width:100%;
    }

    .user-panel .info a{
        display:block;
        text-align:center;
        color:#fff !important;
        font-size:15px;
        font-weight:600;
    }

    /* =========================
       Navigation
    ========================= */

    .nav-sidebar{
        margin-top:12px;
    }

    .nav-sidebar .nav-item{
        margin:5px 10px;
    }

    .nav-sidebar .nav-link{

        display:flex;
        align-items:center;

        color:#eef6ff !important;

        border-radius:10px;

        padding:12px 15px;

        transition:.3s;

    }

    .nav-sidebar .nav-icon{

        width:24px;

        text-align:center;

        margin-right:12px;

        font-size:16px;

    }

    .nav-sidebar .nav-link p{

        margin:0;

        font-size:15px;

        font-weight:500;

    }

    .nav-sidebar .nav-link:hover{

        background:rgba(255,255,255,.18);

        color:#fff !important;

        transform:translateX(4px);

    }

    .nav-sidebar .nav-link.active{

        background:linear-gradient(90deg,#2196F3,#42A5F5);

        color:#fff !important;

        box-shadow:0 4px 10px rgba(0,0,0,.20);

    }

    .nav-sidebar .nav-link.active .nav-icon{

        color:#fff;

    }

    /* =========================
       Notification Badge
    ========================= */

    .badge-danger{

        background:#ff3b30 !important;

        border-radius:50px;

        padding:4px 8px;

        font-size:11px;

    }

    /* =========================
       Logout
    ========================= */

    .logout-link{

        margin-top:18px;

    }

    .logout-link .nav-link{

        color:#ffd54f !important;

    }

    .logout-link .nav-link:hover{

        background:#ffc107;

        color:#1e3c72 !important;

    }

</style>

<aside class="main-sidebar sidebar-dark-primary elevation-4">

    <!-- Logo -->

    <a href="#" class="brand-link">

        <span class="brand-text">

            Trainee Management

        </span>

    </a>

    <div class="sidebar">

        <!-- User -->

        <div class="user-panel d-flex">

            <div class="info">

                <a href="#">

                    ${sessionScope.userName}

                </a>

            </div>

        </div>

        <!-- Menu -->

        <nav class="mt-2">

            <ul class="nav nav-pills nav-sidebar flex-column"
                data-widget="treeview"
                role="menu"
                data-accordion="false">

                <!-- Dashboard -->

                <li class="nav-item">

                    <a href="staffController?actionType=dashboard"
                       class="nav-link <%= "dashboard".equals(activeMenu) ? "active" : ""%>">

                        <i class="nav-icon fas fa-home"></i>

                        <p>Dashboard</p>

                    </a>

                </li>

                <!-- Assigned Trainees -->

                <li class="nav-item">

                    <a href="staffController?actionType=viewTrainees"
                       class="nav-link <%= "viewTrainees".equals(activeMenu) ? "active" : ""%>">

                        <i class="nav-icon fas fa-users"></i>

                        <p>Assigned Trainees</p>

                    </a>

                </li>

                <!-- Assign Tasks -->

                <li class="nav-item">

                    <a href="staffController?actionType=viewAssignTasks"
                       class="nav-link <%= "viewAssignTasks".equals(activeMenu) ? "active" : ""%>">

                        <i class="nav-icon fas fa-tasks"></i>

                        <p>Assign Tasks</p>

                    </a>

                </li>

                <!-- Task List -->

                <li class="nav-item">

                    <a href="staffController?actionType=viewTaskList"
                       class="nav-link <%= "viewTaskList".equals(activeMenu) ? "active" : ""%>">

                        <i class="nav-icon fas fa-list"></i>

                        <p>Task List</p>

                    </a>

                </li>

                <!-- Daily Work Logs -->

                <li class="nav-item">

                    <a href="staffController?actionType=viewWorkLogs"
                       class="nav-link <%= "viewWorkLogs".equals(activeMenu) ? "active" : ""%>">

                        <i class="nav-icon fas fa-clipboard-list"></i>

                        <p>Daily Work Logs</p>

                    </a>

                </li>

                <!-- Leave Approval -->

                <li class="nav-item">

                    <a href="staffController?actionType=viewLeaveApproval"
                       class="nav-link <%= "viewLeaveApproval".equals(activeMenu) ? "active" : ""%>">

                        <i class="nav-icon fas fa-calendar-check"></i>

                        <p>Leave Approval</p>

                    </a>

                </li>

                <!-- Monthly Report -->

                <li class="nav-item">

                    <a href="staffController?actionType=viewPendingMonthlyReports"
                       class="nav-link <%= "viewPendingMonthlyReports".equals(activeMenu) ? "active" : ""%>">

                        <i class="nav-icon fas fa-file-alt"></i>

                        <p>Monthly Report Approval</p>

                    </a>

                </li>

                <!-- Notifications -->

            

                <!-- Change Password -->

                <li class="nav-item">

                    <a href="staffController?actionType=changePasswordPage"
                       class="nav-link <%= "changePassword".equals(activeMenu) ? "active" : ""%>">

                        <i class="nav-icon fas fa-key"></i>

                        <p>Change Password</p>

                    </a>

                </li>

                <!-- Logout -->

                <li class="nav-item logout-link">

                    <a href="loginController?actionType=logout"
                       class="nav-link">

                        <i class="nav-icon fas fa-sign-out-alt"></i>

                        <p>Logout</p>

                    </a>

                </li>

            </ul>

        </nav>

    </div>

</aside>