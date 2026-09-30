                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     <%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String actionType = request.getParameter("actionType");
    if (actionType == null) {
        actionType = "dashboard";
    }
%>
<%
    String activeMenu = (String) request.getAttribute("activeMenu");
    if (activeMenu == null) {
        activeMenu = "";
    }
%>

<style>

    .main-sidebar{
        background:linear-gradient(to bottom,#1e293b 0%,#5758a8 100%) !important;
        box-shadow:4px 0 12px rgba(0,0,0,.15);
    }

    .brand-link{
        background:rgba(0,0,0,.12);
        border-bottom:1px solid rgba(255,255,255,.12)!important;
        text-align:center;
        padding:18px 10px;
    }

    .brand-text{
        color:#fff!important;
        font-size:18px;
        font-weight:700;
        letter-spacing:.5px;
        text-transform:uppercase;
    }

    .user-panel{
        padding:10px 8px;
    }

    .user-panel .info{
        width:100%;
    }

    .user-panel .info a{
        color:#ffffff!important;
        font-weight:600;
        font-size:15px;
        display:block;
    }

    .nav-sidebar{
        margin-top:10px;
    }

    .nav-sidebar .nav-item{
        margin-bottom:5px;
    }

    .nav-sidebar .nav-link{
        color:rgba(255,255,255,.85)!important;
        margin:0 10px;
        border-radius:10px;
        padding:11px 15px;
        display:flex;
        align-items:center;
        transition:.3s;
    }

    .nav-sidebar .nav-link i{
        width:22px;
        text-align:center;
        color:rgba(255,255,255,.85)!important;
        font-size:16px;
    }

    .nav-sidebar .nav-link p{
        margin:0;
        margin-left:12px;
        flex:1;
        display:flex;
        justify-content:space-between;
        align-items:center;
    }

    .nav-sidebar .nav-link:hover{
        background:rgba(255,255,255,.12)!important;
        color:#fff!important;
        transform:translateX(4px);
    }

    .nav-sidebar .nav-link.active{
        background:#2563eb!important;
        color:#fff!important;
        font-weight:bold;
        box-shadow:0 4px 10px rgba(0,0,0,.20);
    }

    .nav-sidebar .nav-link.active i{
        color:#fff!important;
    }

    .badge-danger{
        border-radius:20px;
        padding:4px 8px;
    }

    .logout-link{
        color:#ffd166!important;
    }

    .logout-link:hover{
        background:rgba(255,255,255,.10)!important;
    }

    .main-header{
        background:#1e3a8a!important;
        border-bottom:none!important;
    }

</style>

<aside class="main-sidebar sidebar-dark-primary elevation-4">

    <a href="#" class="brand-link">
        <span class="brand-text">
            Trainee Management
        </span>
    </a>

    <div class="sidebar">

        <div class="user-panel mt-3 pb-3 mb-3 d-flex">

            <div class="info">
                <a href="#">
                    <i class="fas fa-user-circle mr-2"></i>
                    ${sessionScope.userName}
                </a>
            </div>

        </div>

        <nav>

            <ul class="nav nav-pills nav-sidebar flex-column">

                <li class="nav-item">
                    <a href="HeadController?actionType=dashboard"
                       class="nav-link <%=actionType.equals("dashboard") ? "active" : ""%>">

                        <i class="nav-icon fas fa-home"></i>
                        <p>Dashboard</p>

                    </a>
                </li>

                <li class="nav-item">
                    <a href="HeadController?actionType=viewTrainee"
                       class="nav-link <%=actionType.equals("viewTrainee") ? "active" : ""%>">

                        <i class="nav-icon fas fa-users"></i>
                        <p>View Trainees</p>

                    </a>
                </li>

                <li class="nav-item">
                    <a href="HeadController?actionType=AddStaff"
                       class="nav-link <%=actionType.equals("AddStaff") ? "active" : ""%>">

                        <i class="nav-icon fas fa-user-plus"></i>
                        <p>Add Mentor</p>

                    </a>
                </li>

                <li class="nav-item">
                    <a href="HeadController?actionType=viewStaff"
                       class="nav-link <%=actionType.equals("viewStaff") ? "active" : ""%>">

                        <i class="nav-icon fas fa-user-tie"></i>
                        <p>View Mentors</p>

                    </a>
                </li>

                <%
                    Integer unreadCount = (Integer) request.getAttribute("unreadCount");
                %>

                <li class="nav-item">
                    <a href="notificationController?actionType=viewNotifications" class="nav-link">
                        <i class="nav-icon fas fa-bell"></i>
                        <p>
                            Notifications

                            <% if (unreadCount != null && unreadCount > 0) {%>

                            <span class="right badge badge-danger">
                                <%= unreadCount%>
                            </span>

                            <% }%>

                        </p>
                    </a>
                </li>



                <li class="nav-item">
                    <a href="HeadController?actionType=changePasswordPage"
                       class="nav-link <%= "changePassword".equals(actionType) ? "active" : ""%>">
                        <i class="nav-icon fas fa-key"></i>
                        <p>Change Password</p>
                    </a>
                </li>

                <li class="nav-item mt-3">

                    <a href="loginController?actionType=logout"
                       class="nav-link logout-link">

                        <i class="nav-icon fas fa-sign-out-alt"></i>

                        <p>Logout</p>

                    </a>

                </li>

            </ul>

        </nav>

    </div>

</aside>