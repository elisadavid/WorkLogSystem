<%-- 
    Document   : viewTraineeStaff
    Created on : 08-Jul-2026, 2:35:27 pm
    Author     : Trainee2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.traineeDetails"%>

<%
    ArrayList<traineeDetails> arrtraineelist
            = (ArrayList<traineeDetails>) request.getAttribute("arrtraineelist");

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
    request.setAttribute("activeMenu", "viewTrainees");
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="staffSideMenu.jsp"/>

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
                                <th>Assignment Status</th>
                                <th>Training Status</th>
                                <th>Active</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>

                            <%
                                int count = 0;

                                if (arrtraineelist != null) {

                                    for (traineeDetails obj : arrtraineelist) {

                                        count++;

                                        String status = "";

                                        if (obj.getObjAssign() != null
                                                && obj.getObjAssign().getStatus() != null) {

                                            status = obj.getObjAssign().getStatus();
                                        }
                            %>

                            <tr>

                                <td><%=count%></td>

                                <td><%=obj.getTraineeId()%></td>

                                <td><%=obj.getTraineeName()%></td>

                                <td><%=obj.getGender()%></td>

                                <td><%=obj.getObjDesignationitems().getDesignation()%></td>

                                <td><%=obj.getPhonenumber()%></td>

                                <td><%=obj.getEmailId()%></td>

                                <td><%=sdf.format(obj.getJoiningDate())%></td>

                                <td><%=sdf.format(obj.getCompletionDate())%></td>

                                <!-- Assignment Status -->
                                <td class="text-center">

                                    <% if ("PENDING".equalsIgnoreCase(status)) { %>

                                    <span class="badge badge-warning">
                                        <i class="fas fa-clock"></i> Pending
                                    </span>

                                    <% } else if ("ACCEPTED".equalsIgnoreCase(status)) { %>

                                    <span class="badge badge-success">
                                        <i class="fas fa-check-circle"></i> Accepted
                                    </span>

                                    <% } else if ("REJECTED".equalsIgnoreCase(status)) { %>

                                    <span class="badge badge-danger">
                                        <i class="fas fa-times-circle"></i> Rejected
                                    </span>

                                    <% } else { %>

                                    <span class="badge badge-secondary">
                                        Not Assigned
                                    </span>

                                    <% } %>

                                </td>

                                <!-- Training Status -->
                                <td class="text-center">

                                    <%
                                        String trainingStatus = obj.getCompletionStatus();

                                        if (trainingStatus == null || trainingStatus.trim().isEmpty()) {
                                    %>

                                    <span class="badge badge-primary">
                                        <i class="fas fa-user-clock"></i> Ongoing
                                    </span>

                                    <% } else if ("COMPLETED".equalsIgnoreCase(trainingStatus)) { %>

                                    <span class="badge badge-success">
                                        <i class="fas fa-graduation-cap"></i> Completed
                                    </span>

                                    <% } else if ("INCOMPLETE".equalsIgnoreCase(trainingStatus)) { %>

                                    <span class="badge badge-warning">
                                        <i class="fas fa-exclamation-circle"></i> Incomplete
                                    </span>

                                    <% } %>

                                </td>

                                <!-- Active -->
                                <td class="text-center">

                                    <% if ("YES".equalsIgnoreCase(obj.getActive())) { %>

                                    <span class="badge badge-success">
                                        <i class="fas fa-check-circle"></i> YES
                                    </span>

                                    <% } else { %>

                                    <span class="badge badge-danger">
                                        <i class="fas fa-user-slash"></i> NO
                                    </span>

                                    <% }%>

                                </td>

                                <!-- Action -->
                                <td class="text-center">

                                    <div class="btn-group btn-group-sm">

                                        <!-- Login -->
                                        <% if (obj.getUsername() == null || obj.getUsername().trim().isEmpty()) {%>

                                        <button class="btn btn-primary"
                                                data-toggle="modal"
                                                data-target="#loginModal"
                                                data-id="<%=obj.getTraineeId()%>"
                                                data-name="<%=obj.getTraineeName()%>"
                                                title="Set Login">

                                            <i class="fas fa-user-lock"></i>

                                        </button>

                                        <% } else { %>

                                        <button class="btn btn-primary" disabled
                                                title="Login Already Created">

                                            <i class="fas fa-user-check"></i>

                                        </button>

                                        <% } %>

                                        <!-- Reset Password -->
                                        <% if (obj.getUsername() != null && !obj.getUsername().trim().isEmpty()) {%>

                                        <button class="btn btn-warning"
                                                data-toggle="modal"
                                                data-target="#resetPasswordModal"
                                                data-id="<%=obj.getTraineeId()%>"
                                                data-name="<%=obj.getTraineeName()%>"
                                                title="Reset Password">

                                            <i class="fas fa-key"></i>

                                        </button>

                                        <% } else { %>

                                        <button class="btn btn-warning" disabled
                                                title="Login Not Created">

                                            <i class="fas fa-key"></i>

                                        </button>

                                        <% } %>

                                        <!-- Training Status -->
                                        <%
                                            if ("ACCEPTED".equalsIgnoreCase(status)
                                                    && (obj.getCompletionStatus() == null
                                                    || obj.getCompletionStatus().trim().isEmpty())) {
                                        %>

                                        <button class="btn btn-dark"
                                                data-toggle="modal"
                                                data-target="#trainingStatusModal"
                                                data-id="<%=obj.getTraineeId()%>"
                                                data-name="<%=obj.getTraineeName()%>"
                                                title="Training Status">

                                            <i class="fas fa-graduation-cap"></i>

                                        </button>

                                        <%
                                        } else {
                                        %>

                                        <button class="btn btn-dark" disabled
                                                title="Training Status Updated">

                                            <i class="fas fa-graduation-cap"></i>

                                        </button>

                                        <%
                                            }
                                        %>

                                        <!-- Activate / Deactivate -->
                                        <%
                                            if (obj.getCompletionStatus() == null
                                                    || obj.getCompletionStatus().trim().isEmpty()) {
                                        %>

                                        <% if ("YES".equalsIgnoreCase(obj.getActive())) {%>

                                        <a href="staffController?actionType=activeDeactive&traineeId=<%=obj.getTraineeId()%>&active=NO"
                                           class="btn btn-danger"
                                           title="Deactivate">

                                            <i class="fas fa-user-slash"></i>

                                        </a>

                                        <% } else {%>

                                        <a href="staffController?actionType=activeDeactive&traineeId=<%=obj.getTraineeId()%>&active=YES"
                                           class="btn btn-success"
                                           title="Activate">

                                            <i class="fas fa-user-check"></i>

                                        </a>

                                        <% } %>

                                        <%
                                        } else {
                                        %>

                                        <button class="btn btn-secondary" disabled
                                                title="Training Completed">

                                            <i class="fas fa-user-slash"></i>

                                        </button>

                                        <%
                                            }
                                        %>

                                        <!-- Accept -->
                                        <% if ("PENDING".equalsIgnoreCase(status)) {%>

                                        <a href="staffController?actionType=acceptTrainees&traineeId=<%=obj.getTraineeId()%>"
                                           class="btn btn-success"
                                           title="Accept">

                                            <i class="fas fa-thumbs-up"></i>

                                        </a>

                                        <% } else { %>

                                        <button class="btn btn-success" disabled>

                                            <i class="fas fa-thumbs-up"></i>

                                        </button>

                                        <% } %>

                                        <!-- Reject -->
                                        <% if ("PENDING".equalsIgnoreCase(status)) {%>

                                        <button class="btn btn-danger"
                                                data-toggle="modal"
                                                data-target="#rejectModal"
                                                data-id="<%=obj.getTraineeId()%>"
                                                data-name="<%=obj.getTraineeName()%>"
                                                title="Reject">

                                            <i class="fas fa-thumbs-down"></i>

                                        </button>

                                        <% } else { %>

                                        <button class="btn btn-danger" disabled>

                                            <i class="fas fa-thumbs-down"></i>

                                        </button>

                                        <% } %>

                                    </div>

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

<!-- Set Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="staffController" method="post">
                <input type="hidden" name="actionType" value="saveTraineeLogin">

                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="loginModalLabel">Set Trainee Login</h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <input type="hidden" id="traineeId" name="traineeId">

                    <div class="form-group">
                        <label>Trainee Name</label>
                        <input type="text" id="traineeName" class="form-control" readonly>
                    </div>

                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>

                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-success">Save Login</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Reset Password Modal -->
<div class="modal fade" id="resetPasswordModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <form action="staffController" method="post">

                <input type="hidden" name="actionType" value="resetTraineePassword">
                <input type="hidden" id="resetTraineeId" name="traineeId">

                <div class="modal-header bg-warning">
                    <h5 class="modal-title">
                        <i class="fas fa-key"></i>
                        Reset Password
                    </h5>

                    <button type="button" class="close" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>

                <div class="modal-body">

                    <div class="form-group">
                        <label><b>Trainee Name</b></label>
                        <input type="text"
                               id="resetTraineeName"
                               class="form-control"
                               readonly>
                    </div>

                    <div class="form-group">
                        <label><b>New Password</b></label>
                        <input type="password"
                               name="password"
                               class="form-control"
                               placeholder="Enter New Password"
                               required>
                    </div>

                    <div class="form-group">
                        <label><b>Confirm Password</b></label>
                        <input type="password"
                               name="confirmPassword"
                               class="form-control"
                               placeholder="Confirm Password"
                               required>
                    </div>

                </div>

                <div class="modal-footer">

                    <button type="button"
                            class="btn btn-secondary"
                            data-dismiss="modal">
                        Close
                    </button>

                    <button type="submit"
                            class="btn btn-warning">
                        <i class="fas fa-sync-alt"></i>
                        Reset Password
                    </button>

                </div>

            </form>

        </div>
    </div>
</div>

<!-- Reject Trainee Modal -->
<div class="modal fade" id="rejectModal" tabindex="-1" role="dialog" aria-labelledby="rejectModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="staffController" method="post">
                <input type="hidden" name="actionType" value="rejectTrainee">
                <input type="hidden" id="rejectTraineeId" name="traineeId">

                <div class="modal-header bg-secondary text-white">
                    <h5 class="modal-title" id="rejectModalLabel">Reject Trainee</h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Trainee Name</label>
                        <input type="text" id="rejectTraineeName" class="form-control" readonly>
                    </div>
                    <div class="form-group">
                        <label>Reason for Rejection</label>
                        <textarea class="form-control" name="reason" rows="3" required placeholder="Enter reason here..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger">Confirm Reject</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="trainingStatusModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <form action="staffController" method="post">

                <input type="hidden" name="actionType" value="updateTrainingStatus">
                <input type="hidden" id="trainingTraineeId" name="traineeId">

                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-graduation-cap"></i>
                        Update Training Status
                    </h5>
                    <button type="button" class="close text-white" data-dismiss="modal">
                        <span>&times;</span>
                    </button>
                </div>

                <div class="modal-body">

                    <label><b>Training Status</b></label><br>

                    <input type="radio"
                           name="trainingStatus"
                           value="COMPLETED"
                           checked>
                    Completed

                    <br><br>

                    <input type="radio"
                           name="trainingStatus"
                           value="INCOMPLETE">
                    Incomplete

                    <br><br>

                    <div id="reasonDiv" style="display:none;">

                        <label><b>Reason</b></label>

                        <textarea id="reason"
                                  name="reason"
                                  class="form-control"
                                  rows="3"
                                  placeholder="Enter reason"></textarea>

                    </div>

                </div>

                <div class="modal-footer">

                    <button type="button"
                            class="btn btn-secondary"
                            data-dismiss="modal">
                        Cancel
                    </button>

                    <button type="submit"
                            class="btn btn-primary">
                        Save
                    </button>

                </div>

            </form>

        </div>
    </div>
</div>

<!--<style>
    /* Make table cell content perfectly centered */
    .table td {
        vertical-align: middle !important;
    }

    /* Modern Outline Buttons */
    .btn-outline-primary, .btn-outline-warning, .btn-outline-success, .btn-outline-danger, .btn-outline-info, .btn-outline-secondary {
        border-width: 1px;
        transition: all 0.2s ease;
        width: 32px; /* Fixed width for perfect circles/squares */
        height: 32px;
        padding: 0;
        line-height: 30px;
        border-radius: 6px; /* Slightly rounded corners */
    }

    /* Hover effect: Scale up slightly */
    .btn-sm:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0,0,0,0.15) !important;
    }

    /* Ensure icons are centered */
    .btn-sm i {
        font-size: 13px;
    }
</style>-->

<script>

    $(document).ready(function () {

        if (!$.fn.DataTable.isDataTable('#dataTable')) {

            $('#dataTable').DataTable({
                responsive: true,
                autoWidth: false,
                columnDefs: [
                    {
                        orderable: false,
                        targets: -1
                    }
                ]
            });

        }

        $('[title]').tooltip();

    });

    $('#loginModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        $('#traineeId').val(button.data('id'));
        $('#traineeName').val(button.data('name'));
        $('#username').val(button.data('id'));
        $('#password').val('');

    });

    // Open modal
    $('#trainingStatusModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        $('#trainingTraineeId').val(button.data('id'));

        // Default
        $('input[value="COMPLETED"]').prop('checked', true);
        $('#reasonDiv').hide();
        $('#reason').prop('required', false).val('');
    });

// Show/Hide reason
    $('input[name="trainingStatus"]').change(function () {

        if ($(this).val() === "INCOMPLETE") {

            $('#reasonDiv').show();
            $('#reason').prop('required', true);

        } else {

            $('#reasonDiv').hide();
            $('#reason').prop('required', false);
            $('#reason').val('');

        }

    });

    $('#resetPasswordModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        $('#resetTraineeId').val(button.data('id'));
        $('#resetTraineeName').val(button.data('name'));

    });


</script>