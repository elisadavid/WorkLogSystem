<%@page import="model.staffDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.traineeDetails"%>

<%
    ArrayList<traineeDetails> arrtraineelist
            = (ArrayList<traineeDetails>) request.getAttribute("arrtraineelist");

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="headSidemenu.jsp"/>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">
            <h1>View Trainees</h1>
        </div>
    </section>

    <section class="content">

        <div class="container-fluid">

            <div class="card card-primary card-outline">

                <div class="card-header">
                    <h3 class="card-title">Division Trainees</h3>
                </div>

                <div class="card-body">

                    <table id="dataTable" class="table table-bordered table-striped">

                        <thead>

                            <tr>
                                <th>Sl No</th>
                                <th>Trainee ID</th>
                                <th>Name</th>
                                <th>Gender</th>
                                <th>Designation</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Joining Date</th>
                                <th>Completion Date</th>
                                <th>Active</th>
                                <th>Training Status</th>
                                <th>Reason</th>
                                <th>Assigned Mentor</th>
                                <th>Mentor Status</th>
                                <th>Reject Reason</th>
                                <th>Action</th>
                            </tr>

                        </thead>

                        <tbody>

                            <%
                                int count = 0;

                                if (arrtraineelist != null) {

                                    for (traineeDetails obj : arrtraineelist) {

                                        count++;
                            %>

                            <tr>

                                <td><%=count%></td>

                                <td><%=obj.getTraineeId()%></td>

                                <td><%=obj.getTraineeName()%></td>

                                <td><%=obj.getGender()%></td>

                                <td>
                                    <%=obj.getObjDesignationitems().getDesignation()%>
                                </td>

                                <td><%=obj.getPhonenumber()%></td>

                                <td><%=obj.getEmailId()%></td>

                                <td><%=sdf.format(obj.getJoiningDate())%></td>

                                <td><%=sdf.format(obj.getCompletionDate())%></td>

                                <td class="text-center">

                                    <% if ("YES".equalsIgnoreCase(obj.getActive())) { %>

                                    <span class="badge badge-success">
                                        <i class="fas fa-check-circle"></i> YES
                                    </span>

                                    <% } else { %>

                                    <span class="badge badge-danger">
                                        <i class="fas fa-user-slash"></i> NO
                                    </span>

                                    <% } %>

                                </td>

                                <td class="text-center">

                                    <%
                                        String trainingStatus = obj.getCompletionStatus();

                                        if (trainingStatus == null || trainingStatus.trim().isEmpty()) {
                                    %>

                                    <span class="badge badge-primary">
                                        <i class="fas fa-user-clock"></i> Ongoing
                                    </span>

                                    <%
                                    } else if ("COMPLETED".equalsIgnoreCase(trainingStatus)) {
                                    %>

                                    <span class="badge badge-success">
                                        <i class="fas fa-graduation-cap"></i> Completed
                                    </span>

                                    <%
                                    } else if ("INCOMPLETE".equalsIgnoreCase(trainingStatus)) {
                                    %>

                                    <span class="badge badge-warning">
                                        <i class="fas fa-exclamation-circle"></i> Incomplete
                                    </span>

                                    <%
                                        }
                                    %>

                                </td>


                                <td>

                                    <%
                                        if ("INCOMPLETE".equalsIgnoreCase(obj.getCompletionStatus())) {

                                            if (obj.getCompletionReason() != null
                                                    && !obj.getCompletionReason().trim().isEmpty()) {
                                    %>

                                    <%=obj.getCompletionReason()%>

                                    <%
                                    } else {
                                    %>

                                    -

                                    <%
                                        }

                                    } else {
                                    %>

                                    -

                                    <%
                                        }
                                    %>

                                </td
                                <!-- Assigned Mentor -->
                                <td>

                                    <%
                                        if (obj.getObjStaff() != null) {
                                    %>

                                    <b><%=obj.getObjStaff().getStaffId()%></b><br>
                                    <%=obj.getObjStaff().getStaffName()%>

                                    <%
                                    } else {
                                    %>

                                    <span class="badge badge-warning">
                                        Not Assigned
                                    </span>

                                    <%
                                        }
                                    %>

                                </td>

                                <!-- Mentor Status -->
                                <td class="text-center">

                                    <%
                                        String status = null;

                                        if (obj.getObjAssignment() != null) {
                                            status = obj.getObjAssignment().getStatus();
                                        }

                                        if (status == null) {
                                    %>

                                    <span class="badge badge-secondary">Not Assigned</span>

                                    <%
                                    } else if ("PENDING".equalsIgnoreCase(status)) {
                                    %>

                                    <span class="badge badge-warning">Pending</span>

                                    <%
                                    } else if ("ACCEPTED".equalsIgnoreCase(status)) {
                                    %>

                                    <span class="badge badge-success">Accepted</span>

                                    <%
                                    } else if ("REJECTED".equalsIgnoreCase(status)) {
                                    %>

                                    <span class="badge badge-danger">Rejected</span>

                                    <%
                                        }
                                    %>

                                </td>

                                <td>

                                    <%
                                        if (obj.getObjAssignment() != null
                                                && "REJECTED".equalsIgnoreCase(obj.getObjAssignment().getStatus())) {

                                            if (obj.getObjAssignment().getRemarks() != null
                                                    && !obj.getObjAssignment().getRemarks().trim().isEmpty()) {
                                    %>

                                    <%=obj.getObjAssignment().getRemarks()%>

                                    <%
                                    } else {
                                    %>

                                    -

                                    <%
                                        }

                                    } else {
                                    %>

                                    -

                                    <%
                                        }
                                    %>

                                </td>
                                <!-- Action -->
                                <td>

                                    <%
                                        if (status == null || "REJECTED".equalsIgnoreCase(status)) {
                                    %>

                                    <button class="btn btn-primary btn-sm"
                                            data-toggle="modal"
                                            data-target="#assignMentorModal"
                                            data-id="<%=obj.getTraineeId()%>"
                                            data-name="<%=obj.getTraineeName()%>">

                                        <i class="fas fa-user-plus"></i>

                                        <%=status == null ? "Assign Mentor" : "Reassign Mentor"%>

                                    </button>

                                    <%
                                    } else {
                                    %>

                                    <button class="btn btn-secondary btn-sm" disabled>
                                        <i class="fas fa-check"></i>
                                        Assigned
                                    </button>

                                    <%
                                        }
                                    %>

                                </td>





                            </tr>

                            <%
                                    }

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

<div class="modal fade" id="assignMentorModal">

    <div class="modal-dialog">

        <div class="modal-content">

            <form action="HeadController" method="post">

                <input type="hidden" name="actionType" value="saveMentor">

                <div class="modal-header bg-primary">

                    <h4 class="modal-title">
                        Assign Mentor
                    </h4>

                    <button type="button"
                            class="close"
                            data-dismiss="modal">

                        &times;

                    </button>

                </div>

                <div class="modal-body">

                    <input type="hidden"
                           name="traineeId"
                           id="traineeId">

                    <div class="form-group">

                        <label>Trainee</label>

                        <input type="text"
                               id="traineeName"
                               class="form-control"
                               readonly>

                    </div>

                    <div class="form-group">

                        <label>Select Mentor</label>

                        <select name="staffId"
                                class="form-control"
                                required>

                            <%
                                ArrayList<staffDetails> arrStaff
                                        = (ArrayList<staffDetails>) request.getAttribute("arrStaff");

                                if (arrStaff != null) {

                                    for (staffDetails s : arrStaff) {
                            %>

                            <option value="<%=s.getStaffId()%>">

                                <%=s.getStaffName()%>

                            </option>

                            <%
                                    }
                                }
                            %>

                        </select>

                    </div>

                </div>

                <div class="modal-footer">

                    <button class="btn btn-success">

                        Save

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>

<script>

    $(function () {

        $("#dataTable").DataTable({

            responsive: true,
            autoWidth: false

        });

    });

    $('#loginModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        var traineeId = button.data('id');
        var traineeName = button.data('name');

        var modal = $(this);

        modal.find('#traineeId').val(traineeId);
        modal.find('#traineeName').val(traineeName);

        // Optional: Default username = Trainee ID
        modal.find('#username').val(traineeId);

        // Clear password
        modal.find('#password').val('');

    });

    $('#resetPasswordModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        $('#resetTraineeId').val(button.data('id'));
        $('#resetTraineeName').val(button.data('name'));

    });

    $('#assignMentorModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        $('#traineeId').val(button.data('id'));

        $('#traineeName').val(button.data('name'));

    });

</script>

