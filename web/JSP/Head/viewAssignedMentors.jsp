
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Assignment"%>

<%
    ArrayList<Assignment> arrAssignmentList
            = (ArrayList<Assignment>) request.getAttribute("arrAssignmentList");

    int count = 0;
%>
<jsp:include page="../../header.jsp"/>
<jsp:include page="headSidemenu.jsp"/>

<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <h1>View Assigned Mentors</h1>
        </div> <!-- Fixed: closed div tag -->
    </section>

    <section class="content">
        <div class="container-fluid">
            <!-- Assignment Form -->


            <!-- Data Table Card -->
            <div class="card card-primary card-outline">
                <div class="card-header">
                    <h3 class="card-title">Assigned Mentor Details</h3>
                </div> <!-- Fixed: closed div tag -->
                <div class="card-body">
                    <table id="dataTable" class="table table-bordered table-striped">
                        <thead>

                            <tr>

                                <th>Sl No</th>

                                <th>Trainee ID</th>

                                <th>Trainee Name</th>

                                <th>Mentor ID</th>

                                <th>Mentor Name</th>

                                <th>Status</th>

                                <th>Assigned Date</th>

                                <th>Remarks</th>

                                <th>Action</th>

                            </tr>

                        </thead>

                        <tbody>

                            <%
                                if (arrAssignmentList != null) {

                                    for (Assignment obj : arrAssignmentList) {

                                        count++;

                            %>

                            <tr>

                                <td><%=count%></td>

                                <td><%=obj.getTraineeId()%></td>

                                <td><%=obj.getObjTrainee().getTraineeName()%></td>

                                <td><%=obj.getStaffId()%></td>

                                <td><%=obj.getObjStaff().getStaffName()%></td>

                                <td>

                                    <%

                                        if ("PENDING".equals(obj.getStatus())) {

                                    %>

                                    <span class="badge badge-warning">

                                        Pending

                                    </span>

                                    <%} else if ("ACCEPTED".equals(obj.getStatus())) {

                                    %>

                                    <span class="badge badge-success">

                                        Accepted

                                    </span>

                                    <%} else {

                                    %>

                                    <span class="badge badge-danger">

                                        Rejected

                                    </span>

                                    <%    }

                                    %>

                                </td>

                                <td>

                                    <%=obj.getAssignedDate()%>

                                </td>

                                <td>

                                    <%=obj.getRemarks() == null ? "-" : obj.getRemarks()%>

                                </td>

                                <td>

                                    <%

                                        if ("PENDING".equals(obj.getStatus())) {

                                    %>

                                    <span class="badge badge-info">

                                        Waiting for Mentor

                                    </span>

                                    <%} else {

                                    %>

                                    -

                                    <%    }

                                    %>

                                </td>

                            </tr>

                            <%        }

                                }

                            %>

                        </tbody>

                    </table>
                </div>
            </div>
        </div>
    </section>
</div>

<jsp:include page="../../footer.jsp"/>

<script>
    $(function () {
        $("#dataTable").DataTable({
            responsive: true,
            autoWidth: false
        });
    });
</script>