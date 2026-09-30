<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false"%>
<%
    request.setAttribute("activeMenu", "dashboard");
%>
<jsp:include page="../../header.jsp"/>
<jsp:include page="staffSideMenu.jsp"/>
<style>
    .content-wrapper{
        background:linear-gradient(135deg,#eef4ff,#f8fbff);
        min-height:100vh;
    }
    .content-header{
        padding:25px 25px 15px;
    }
    .content-header p{
        color:#6c757d;
        font-size:15px;
    }
    .dashboard-card{
        background:#fff;
        border-radius:18px;
        padding:22px;
        min-height:185px;
        position:relative;
        overflow:hidden;
        transition:.35s;
        box-shadow:0 10px 25px rgba(0,0,0,.08);
        border:none;
    }
    .dashboard-card::before{
        content:"";
        position:absolute;
        left:0;
        top:0;
        width:100%;
        height:6px;
        background:linear-gradient(90deg,#1e3c72,#2a5298,#42A5F5);
    }
    .dashboard-card:hover{
        transform:translateY(-8px);
        box-shadow:0 18px 35px rgba(30,60,114,.18);
    }
    .card-top{
        display:flex;
        justify-content:space-between;
        align-items:flex-start;
    }
    .card-title{
        font-size:13px;
        font-weight:700;
        text-transform:uppercase;
        color:#6b7280;
        letter-spacing:.8px;
    }
    .card-value{
        margin-top:10px;
        font-size:42px;
        font-weight:700;
        color:#1e3c72;
        line-height:1;
    }
    .icon-box{
        width:62px;
        height:62px;
        border-radius:16px;
        display:flex;
        justify-content:center;
        align-items:center;
        color:#fff;
        font-size:24px;
        box-shadow:0 8px 18px rgba(0,0,0,.18);
    }
    .blue{
        background:linear-gradient(135deg,#1565C0,#42A5F5);
    }
    .green{
        background:linear-gradient(135deg,#00b894,#00cec9);
    }
    .orange{
        background:linear-gradient(135deg,#ff9800,#ffc107);
    }
    .red{
        background:linear-gradient(135deg,#e53935,#ff6b6b);
    }
    .card-footer-link{
        display:inline-flex;
        align-items:center;
        margin-top:25px;
        color:#1e3c72;
        font-weight:600;
        text-decoration:none;
        transition:.3s;
    }
    .card-footer-link i{
        margin-left:8px;
        transition:.3s;
    }
    .card-footer-link:hover{
        color:#42A5F5;
        text-decoration:none;
    }
    .card-footer-link:hover i{
        transform:translateX(6px);
    }
    .mb-4{
        margin-bottom:25px !important;
    }
</style>

<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <p>Welcome back, <strong style="font-size: 1.2rem; color: #1e3c72;">${sessionScope.userName}</strong></p>
                </div>
            </div>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
           <div class="row">
    <!-- Total Trainees -->
    <div class="col-lg-3 col-md-6 mb-4">
        <div class="dashboard-card">
            <div class="card-top">
                <div class="card-title">Total Trainees</div>
                <div class="card-value">${totalTrainees}</div>
                <div class="icon-box blue"><i class="fas fa-users"></i></div>
            </div>
            <a href="staffController?actionType=viewTrainees" class="card-footer-link">View Trainees <i class="fas fa-arrow-right ml-2"></i></a>
        </div>
    </div>

    <!-- Pending Work Logs -->
    <div class="col-lg-3 col-md-6 mb-4">
        <div class="dashboard-card">
            <div class="card-top">
                <div class="card-title">Pending Work Logs</div>
                <div class="card-value">${pendingWorkLogs}</div>
                <div class="icon-box orange"><i class="fas fa-clipboard-check"></i></div>
            </div>
            <a href="staffController?actionType=viewWorkLogs" class="card-footer-link">Review Logs <i class="fas fa-arrow-right ml-2"></i></a>
        </div>
    </div>

    <!-- Pending Leaves -->
    <div class="col-lg-3 col-md-6 mb-4">
        <div class="dashboard-card">
            <div class="card-top">
                <div class="card-title">Pending Leaves</div>
                <div class="card-value">${pendingLeaves}</div>
                <div class="icon-box red"><i class="fas fa-calendar-check"></i></div>
            </div>
            <a href="staffController?actionType=viewLeaveApproval" class="card-footer-link">Approve Leaves <i class="fas fa-arrow-right ml-2"></i></a>
        </div>
    </div>

    <!-- NEW: Rejected Leaves -->
    <div class="col-lg-3 col-md-6 mb-4">
        <div class="dashboard-card">
            <div class="card-top">
                <div class="card-title">Rejected Leaves</div>
                <div class="card-value">${rejectedLeaves}</div>
                <!-- Using a different color for rejected (e.g., a darker red or grey) -->
                <div class="icon-box" style="background: linear-gradient(135deg, #636e72, #2d3436);"><i class="fas fa-calendar-times"></i></div>
            </div>
            <a href="staffController?actionType=viewLeaveApproval" class="card-footer-link">View History <i class="fas fa-arrow-right ml-2"></i></a>
        </div>
    </div>
</div>

<div class="row">
    <!-- Notifications -->
    <div class="col-lg-3 col-md-6 mb-4">
        <div class="dashboard-card">
            <div class="card-top">
                <div class="card-title">Notifications</div>
                <div class="card-value">${unreadCount}</div>
                <div class="icon-box green"><i class="fas fa-bell"></i></div>
            </div>
            <a href="notificationController?actionType=viewNotifications" class="card-footer-link">Open Notifications <i class="fas fa-arrow-right ml-2"></i></a>
        </div>
    </div>

    <!-- Monthly Reports -->
    <div class="col-lg-3 col-md-6 mb-4">
        <div class="dashboard-card">
            <div class="card-top">
                <div class="card-title">Monthly Reports</div>
                <div class="card-value">${pendingReports}</div>
                <div class="icon-box blue"><i class="fas fa-file-alt"></i></div>
            </div>
            <a href="staffController?actionType=viewPendingMonthlyReports" class="card-footer-link">View Reports <i class="fas fa-arrow-right ml-2"></i></a>
        </div>
    </div>
</div>
</div>
</section>
</div>
<jsp:include page="../../footer.jsp"/>