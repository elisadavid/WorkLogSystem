<%@page import="java.util.ArrayList"%>
<%@page import="model.Notification"%>
<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false"%>
<jsp:include page="../../header.jsp"/>
<jsp:include page="headSidemenu.jsp"/>


<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <!-- Notification Bell -->
            <div class="notification-bell-container">
                <div class="dropdown">
                    <a class="nav-link text-dark" data-toggle="dropdown" href="#" style="position: relative;">
                        <i class="far fa-bell fa-lg"></i>
                        <span class="badge badge-danger" style="position: absolute; top: -5px; right: -5px; border-radius: 50%;">
                           <%= request.getAttribute("unreadNotifCount") %>
                        </span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right" style="width: 300px;">
                        <span class="dropdown-item dropdown-header">Notifications</span>
                        <div class="dropdown-divider"></div>
                        <%
                            ArrayList<Notification> notifList = (ArrayList<Notification>) request.getAttribute("notifList");
                            if (notifList != null && !notifList.isEmpty()) {
                                for (Notification n : notifList) {
                        %>
                        <a href="#" class="dropdown-item">
                            <i class="fas fa-envelope mr-2 text-primary"></i> <%= n.getMessage()%>
                        </a>
                        <%
                            }
                        } else {
                        %>
                        <a href="#" class="dropdown-item text-center text-muted">No new notifications</a>
                        <% }%>
                        <div class="dropdown-divider"></div>
                        <a href="notifications.jsp" class="dropdown-item text-center text-primary">See All Notifications</a>
                    </div>
                </div>
            </div>
            <h1>Head Dashboard</h1>
            <p>Welcome back, <span class="text-primary" style="font-weight: 600;">${sessionScope.userName}</span></p>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <!-- Total Trainees Card -->
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="modern-stat-card card-blue">
                        <div class="card-top-row">
                            <span class="card-label">Trainees</span>
                            <div class="stat-icon"><i class="fas fa-users"></i></div>
                        </div>
                       <h3 class="card-value"><%= request.getAttribute("totalTrainees") %></h3>
                        <a href="HeadController?actionType=viewTrainee" class="card-action">
                            View All <i class="fas fa-chevron-right"></i>
                        </a>
                    </div>
                </div>
                <!-- Total Mentors Card -->
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="modern-stat-card card-green">
                        <div class="card-top-row">
                            <span class="card-label">Mentors</span>
                            <div class="stat-icon"><i class="fas fa-user-tie"></i></div>
                        </div>
                       <h3 class="card-value"><%= request.getAttribute("totalMentors") == null ? "0" : request.getAttribute("totalMentors") %></h3>
                        <a href="HeadController?actionType=viewStaff" class="card-action">
                            View All <i class="fas fa-chevron-right"></i>
                        </a>
                    </div>
                </div>
                <!-- Add Mentor Card -->
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="modern-stat-card card-amber">
                        <div class="card-top-row">
                            <span class="card-label">Add Mentor</span>
                            <div class="stat-icon"><i class="fas fa-user-plus"></i></div>
                        </div>
                        <h3 class="card-value">+</h3>
                        <a href="HeadController?actionType=AddStaff" class="card-action">
                            Add New <i class="fas fa-chevron-right"></i>
                        </a>
                    </div>
                </div>
<!--                 Assign Mentor Card 
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="modern-stat-card card-red">
                        <div class="card-top-row">
                            <span class="card-label">Assignment</span>
                            <div class="stat-icon"><i class="fas fa-user-check"></i></div>
                        </div>
                        <h3 class="card-value">Assign</h3>
                        <a href="HeadController?actionType=saveMentor" class="card-action">
                            Open Tool <i class="fas fa-chevron-right"></i>
                        </a>
                    </div>
                </div>-->
            </div>
        </div>
    </section>
</div>
<jsp:include page="../../footer.jsp"/>

<style>
    /* General Dashboard Background */
    .content-wrapper {
        background-color: #f4f6f9 !important;
    }
    .content-header h1 {
        font-weight: 700;
        color: #1e3a8a;
        font-size: 24px;
    }
    /* MODERN CARD SYSTEM */
    .modern-stat-card {
        background: #ffffff !important;
        border-radius: 12px !important;
        border: none !important;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06) !important;
        transition: all 0.3s ease !important;
        position: relative;
        overflow: hidden;
        padding: 20px !important;
        display: flex;
        flex-direction: column;
        height: 100%;
        border-left: 6px solid #ccc;
    }
    .modern-stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1) !important;
    }
    .card-top-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }
    .card-value {
        font-size: 28px !important;
        font-weight: 800 !important;
        color: #1e293b;
        margin: 0;
    }
      {
        font-size: 14px !important;
        font-weight: 600 !important;
        color: #64748b !important;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    .stat-icon {
        width: 48px;
        height: 48px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px !important;
    }
    .card-blue {
        border-left-color: #3b82f6 !important;
    }
    .card-blue .stat-icon {
        background: #eff6ff;
        color: #3b82f6;
    }
    .card-green {
        border-left-color: #10b981 !important;
    }
    .card-green .stat-icon {
        background: #ecfdf5;
        color: #10b981;
    }
    .card-amber {
        border-left-color: #f59e0b !important;
    }
    .card-amber .stat-icon {
        background: #fffbeb;
        color: #f59e0b;
    }
    .card-red {
        border-left-color: #ef4444 !important;
    }
    .card-red .stat-icon {
        background: #fef2f2;
        color: #ef4444;
    }
    .card-action {
        margin-top: auto;
        padding-top: 15px;
        font-size: 13px !important;
        font-weight: 700 !important;
        text-decoration: none !important;
        color: #64748b !important;
        transition: color 0.2s;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .card-action:hover {
        color: #1e3a8a !important;
    }
    /* Notification Bell Position */
    .notification-bell-container {
        position: absolute;
        top: 15px;
        right: 20px;
        z-index: 1000;
    }
</style>