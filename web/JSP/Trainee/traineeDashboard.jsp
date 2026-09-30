<%@page contentType="text/html" pageEncoding="UTF-8" isELIgnored="false"%>
<jsp:include page="../../header.jsp"></jsp:include>
<jsp:include page="traineeSideMenu.jsp"></jsp:include>

<style>
    /* ============================================================
       MODERN DASHBOARD STYLING
    ============================================================ */
    .content-wrapper {
        background: linear-gradient(135deg, #eef4ff, #f8fbff);
        min-height: 100vh;
        padding-top: 20px;
    }
    
    .welcome-section {
        margin-bottom: 30px;
    }
    
    .welcome-text {
        font-size: 24px;
        font-weight: 700;
        color: #1e3c72;
    }

    /* Dashboard Card System */
    .dashboard-card {
        background: #fff;
        border-radius: 18px;
        padding: 22px;
        min-height: 185px;
        position: relative;
        overflow: hidden;
        transition: all 0.3s ease;
        box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
        border: none;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }
    
    .dashboard-card::before {
        content: "";
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 6px;
        background: linear-gradient(90deg, #1e3c72, #2a5298, #42A5F5);
    }
    
    .dashboard-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 18px 35px rgba(30, 60, 114, .18);
    }
    
    .card-top {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
    }
    
    .card-title {
        font-size: 13px;
        font-weight: 700;
        text-transform: uppercase;
        color: #6b7280;
        letter-spacing: 0.5px;
    }
    
    .card-value {
        font-size: 42px;
        font-weight: 800;
        color: #1e3c72;
        margin-top: 10px;
        line-height: 1;
    }
    
    .icon-box {
        width: 62px;
        height: 62px;
        border-radius: 16px;
        display: flex;
        justify-content: center;
        align-items: center;
        color: #fff;
        font-size: 24px;
        box-shadow: 0 8px 18px rgba(0, 0, 0, .18);
    }
    
    /* Color Variants */
    .blue { background: linear-gradient(135deg, #1565C0, #42A5F5); }
    .green { background: linear-gradient(135deg, #00b894, #00cec9); }
    .orange { background: linear-gradient(135deg, #ff9800, #ffc107); }
    .red { background: linear-gradient(135deg, #e53935, #ff6b6b); }
    
    .card-footer-link {
        display: inline-flex;
        align-items: center;
        margin-top: 20px;
        color: #1e3c72;
        font-weight: 600;
        text-decoration: none;
        transition: 0.3s;
        font-size: 14px;
    }
    
    .card-footer-link:hover {
        color: #42A5F5;
        text-decoration: none;
    }
    
    .card-footer-link i {
        margin-left: 8px;
        transition: 0.3s;
    }
    
    .card-footer-link:hover i {
        transform: translateX(5px);
    }
</style>

<div class="content-wrapper">
    <!-- Header Section -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="welcome-section">
                <h2 class="welcome-text">Welcome back, ${sessionScope.userName}!</h2>
                <p class="text-muted">Here is an overview of your current progress and requests.</p>
            </div>
        </div>
    </div>

    <!-- Main Content Section -->
    <section class="content">
        <div class="container-fluid">
            
            <!-- First Row: Core Activities -->
            <div class="row">
                <!-- My Tasks -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="dashboard-card">
                        <div class="card-top">
                            <div>
                                <div class="card-title">My Tasks</div>
                                <div class="card-value">${taskCount}</div>
                            </div>
                            <div class="icon-box blue"><i class="fas fa-tasks"></i></div>
                        </div>
                        <a href="traineesController?actionType=viewTasks" class="card-footer-link">
                            View Tasks <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <!-- Work Logs -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="dashboard-card">
                        <div class="card-top">
                            <div>
                                <div class="card-title">Work Logs</div>
                                <div class="card-value">${logCount}</div>
                            </div>
                            <div class="icon-box green"><i class="fas fa-clipboard-list"></i></div>
                        </div>
                        <a href="traineesController?actionType=viewWorkLogs" class="card-footer-link">
                            View Logs <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <!-- Pending Leaves -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="dashboard-card">
                        <div class="card-top">
                            <div>
                                <div class="card-title">Pending Leaves</div>
                                <div class="card-value">${pendingLeaves}</div>
                            </div>
                            <div class="icon-box orange"><i class="fas fa-clock"></i></div>
                        </div>
                        <a href="traineesController?actionType=viewLeave" class="card-footer-link">
                            Check Status <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <!-- Approved Leaves -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="dashboard-card">
                        <div class="card-top">
                            <div>
                                <div class="card-title">Approved Leaves</div>
                                <div class="card-value">${approvedLeaves}</div>
                            </div>
                            <div class="icon-box green"><i class="fas fa-check-circle"></i></div>
                        </div>
                        <a href="traineesController?actionType=viewLeave" class="card-footer-link">
                            View History <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Second Row: Reports & Rejections -->
            <div class="row">
                <!-- Rejected Leaves -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="dashboard-card">
                        <div class="card-top">
                            <div>
                                <div class="card-title">Rejected Leaves</div>
                                <div class="card-value">${rejectedLeaves}</div>
                            </div>
                            <div class="icon-box red"><i class="fas fa-times-circle"></i></div>
                        </div>
                        <a href="traineesController?actionType=viewLeave" class="card-footer-link">
                            View Reason <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <!-- Approved Reports -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="dashboard-card">
                        <div class="card-top">
                            <div>
                                <div class="card-title">Approved Reports</div>
                                <div class="card-value">${approvedReports}</div>
                            </div>
                            <div class="icon-box blue"><i class="fas fa-file-signature"></i></div>
                        </div>
                        <a href="traineesController?actionType=viewMonthlyReport" class="card-footer-link">
                            View Reports <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <!-- Rejected Reports -->
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="dashboard-card">
                        <div class="card-top">
                            <div>
                                <div class="card-title">Rejected Reports</div>
                                <div class="card-value">${rejectedReports}</div>
                            </div>
                            <div class="icon-box red"><i class="fas fa-file-excel"></i></div>
                        </div>
                        <a href="traineesController?actionType=viewMonthlyReport" class="card-footer-link">
                            Fix Reports <i class="fas fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<jsp:include page="../../footer.jsp"/>