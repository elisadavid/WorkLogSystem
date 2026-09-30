<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Notification"%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="staffSideMenu.jsp"/>

<style>

    .content-wrapper{
        background:#f4f6f9;
    }

    .notification-card{
        border:0;
        border-radius:10px;
        margin-bottom:15px;
        box-shadow:0 2px 8px rgba(0,0,0,.08);
        transition:.3s;
    }

    .notification-card:hover{
        transform:translateY(-2px);
        box-shadow:0 6px 18px rgba(0,0,0,.15);
    }

    .notification-card.unread{
        border-left:5px solid #dc3545;
    }

    .notification-card.read{
        border-left:5px solid #28a745;
    }

    .notification-title{
        font-size:22px;
        font-weight:600;
        color:#343a40;
    }

    .notification-message{
        color:#555;
        margin-top:8px;
        margin-bottom:0;
        font-size:15px;
    }

    .notification-time{
        font-size:13px;
        color:#6c757d;
    }

    .notification-icon{
        font-size:22px;
        margin-right:8px;
    }

    .badge{
        padding:6px 12px;
        font-size:12px;
    }

    .empty-box{
        text-align:center;
        padding:80px;
    }

    .empty-box i{
        font-size:70px;
        color:#bcbcbc;
    }

</style>

<div class="content-wrapper">

    <section class="content-header">

        <div class="container-fluid">

            <div class="row mb-2">

                <div class="col-sm-6">

                    <h2>
                        <i class="fas fa-bell text-warning"></i>
                        Notifications
                    </h2>

                </div>

                <div class="col-sm-6">

                    <ol class="breadcrumb float-sm-right">

                        <li class="breadcrumb-item">
                            <a href="staffDashboard.jsp">Home</a>
                        </li>

                        <li class="breadcrumb-item active">
                            Notifications
                        </li>

                    </ol>

                </div>

            </div>

        </div>

    </section>

    <section class="content">

        <div class="container-fluid">

            <%

                ArrayList<Notification> notificationList
                        = (ArrayList<Notification>) request.getAttribute("notificationList");

                if (notificationList != null && !notificationList.isEmpty()) {

                    for (Notification obj : notificationList) {

                        boolean unread
                                = "UNREAD".equalsIgnoreCase(obj.getStatus());

                        String title
                                = obj.getTitle() == null ? "" : obj.getTitle().toUpperCase();

            %>

            <div class="card notification-card <%= unread ? "unread" : "read"%>">

                <div class="card-body">

                    <div class="row">

                        <div class="col-md-9">

                            <h5 class="notification-title">

                                <% if (title.contains("APPROVED")) { %>

                                <i class="fas fa-check-circle text-success notification-icon"></i>

                                <% } else if (title.contains("REJECT")) { %>

                                <i class="fas fa-times-circle text-danger notification-icon"></i>

                                <% } else if (title.contains("TASK")) { %>

                                <i class="fas fa-tasks text-primary notification-icon"></i>

                                <% } else if (title.contains("LEAVE")) { %>

                                <i class="fas fa-calendar-check text-info notification-icon"></i>

                                <% } else if (title.contains("WORK")) { %>

                                <i class="fas fa-clipboard-list text-warning notification-icon"></i>

                                <% } else { %>

                                <i class="fas fa-bell text-warning notification-icon"></i>

                                <% }%>

                                <%=obj.getTitle()%>

                            </h5>

                            <p class="notification-message">

                                <%=obj.getMessage()%>

                            </p>

                        </div>

                        <div class="col-md-3 text-right">

                            <small class="notification-time">

                                <i class="far fa-clock"></i>

                                <%=obj.getCreatedAt()%>

                            </small>

                            <br><br>

                            <% if (unread) { %>

                            <span class="badge badge-danger">
                                Unread
                            </span>

                            <% } else { %>

                            <span class="badge badge-success">
                                Read
                            </span>

                            <% } %>

                        </div>

                    </div>

                </div>

            </div>

            <%

                }

            } else {

            %>

            <div class="card">

                <div class="card-body empty-box">

                    <i class="far fa-bell-slash"></i>

                    <h4 class="mt-3">
                        No Notifications
                    </h4>

                    <p class="text-muted">
                        No notifications available.
                    </p>

                </div>

            </div>

            <% }%>

        </div>

    </section>

</div>

<jsp:include page="../../footer.jsp"/>