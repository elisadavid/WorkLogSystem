<%@page import="java.util.ArrayList"%>
<%@page import="model.Notification"%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="headSidemenu.jsp"/>

<%
    ArrayList<Notification> notificationList
            = (ArrayList<Notification>) request.getAttribute("notificationList");
%>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">
            <h3><i class="fas fa-bell"></i> Notifications</h3>
        </div>
    </section>

    <section class="content">

        <div class="container-fluid">

            <% if (notificationList != null && !notificationList.isEmpty()) { %>

            <% for (Notification obj : notificationList) { %>

            <div class="card mb-3 shadow-sm">

                <div class="card-body">

                    <div class="d-flex justify-content-between">

                        <div>

                            <h5>

                                <% if (obj.getStatus().equals("UNREAD")) { %>

                                <i class="fas fa-circle text-danger"></i>

                                <% } else { %>

                                <i class="fas fa-check-circle text-success"></i>

                                <% }%>

                                <%= obj.getTitle()%>

                            </h5>

                            <p class="text-muted mb-2">
                                <%= obj.getMessage()%>
                            </p>

                            <small class="text-secondary">
                                <i class="far fa-clock"></i>
                                <%= obj.getCreatedAt()%>
                            </small>

                        </div>

                        <div class="text-right">

                            <% if (obj.getStatus().equals("UNREAD")) { %>

                            <span class="badge badge-danger">
                                UNREAD
                            </span>

                            <% } else { %>

                            <span class="badge badge-success">
                                READ
                            </span>

                            <% }%>

                            <br><br>

                            <a href="notificationController?actionType=openNotification&notifId=<%=obj.getNotifId()%>"
                               class="btn btn-primary btn-sm">

                                <i class="fas fa-eye"></i>
                                View

                            </a>

                        </div>

                    </div>

                </div>

            </div>

            <% } %>

            <% } else { %>

            <div class="card">

                <div class="card-body text-center">

                    <i class="fas fa-bell-slash fa-4x text-secondary"></i>

                    <h4 class="mt-3">
                        No Notifications
                    </h4>

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