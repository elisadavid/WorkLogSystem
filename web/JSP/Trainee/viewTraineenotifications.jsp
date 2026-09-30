<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Notification"%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="traineeSideMenu.jsp"/>

<style>

    .content-wrapper{
        background:#f4f6f9;
    }

    .notification-card{
        border-radius:12px;
        border:0;
        margin-bottom:15px;
        box-shadow:0 2px 8px rgba(0,0,0,.08);
        transition:.3s;
    }

    .notification-card:hover{
        transform:translateY(-2px);
        box-shadow:0 4px 15px rgba(0,0,0,.15);
    }

    .notification-title{
        font-size:22px;
        font-weight:600;
        color:#1f2937;
    }

    .notification-message{
        font-size:15px;
        color:#555;
        margin-top:6px;
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
        font-size:12px;
        padding:6px 10px;
    }

    .empty-box{
        padding:70px;
        text-align:center;
    }

    .empty-box i{
        font-size:70px;
        color:#b5b5b5;
    }

    .empty-box h4{
        margin-top:20px;
    }

</style>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">

            <div class="row mb-3">

                <div class="col-sm-6">

                    <h2>

                        <i class="fas fa-bell text-warning"></i>

                        Notifications

                    </h2>

                </div>

            </div>

        </div>
    </section>

    <section class="content">

        <div class="container-fluid">

            <%
                ArrayList<Notification> notificationList
                        = (ArrayList<Notification>) request.getAttribute("notificationList");
            %>

            <% if (notificationList != null && notificationList.size() > 0) { %>

            <% for (Notification obj : notificationList) { %>

            <div class="card notification-card">

                <div class="card-body">

                    <div class="row">

                        <div class="col-md-9">

                            <div class="notification-title">

                                <% String title = obj.getTitle();

                                        if (title.toUpperCase().contains("APPROVED")) { %>

                                <i class="fas fa-check-circle text-success notification-icon"></i>

                                <% } else if (title.toUpperCase().contains("REJECT")) { %>

                                <i class="fas fa-times-circle text-danger notification-icon"></i>

                                <% } else if (title.toUpperCase().contains("TASK")) { %>

                                <i class="fas fa-tasks text-primary notification-icon"></i>

                                <% } else { %>

                                <i class="fas fa-bell text-warning notification-icon"></i>

                                <% }%>

                                <%=obj.getTitle()%>

                            </div>

                            <div class="notification-message">

                                <%=obj.getMessage()%>

                            </div>

                        </div>

                        <div class="col-md-3 text-right">

                            <div class="notification-time">

                                <i class="far fa-clock"></i>

                                <%=obj.getCreatedAt()%>

                            </div>

                            <br>

                            <% if ("UNREAD".equalsIgnoreCase(obj.getStatus())) { %>

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

            <% } %>

            <% } else { %>

            <div class="card">

                <div class="card-body empty-box">

                    <i class="far fa-bell-slash"></i>

                    <h4>No Notifications</h4>

                    <p class="text-muted">
                        You don't have any notifications.
                    </p>

                </div>

            </div>

            <% }%>

        </div>

    </section>

</div>

<jsp:include page="../../footer.jsp"/>