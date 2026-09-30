<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Assignment"%>

<%
    ArrayList<Assignment> assignmentList
            = (ArrayList<Assignment>) request.getAttribute("assignmentList");
    int sl = 1;
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="staffSideMenu.jsp"/>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">
            <h3>Pending Trainee Assignments</h3>
        </div>
    </section>

    <section class="content">

        <div class="container-fluid">

            <div class="card card-primary card-outline">

                <div class="card-body">

                    <table id="dataTable" class="table table-bordered table-hover">

                        <thead class="bg-primary">

                            <tr>
                                <th>Sl No</th>
                                <th>Trainee ID</th>
                                <th>Trainee Name</th>
                                <th>Assigned Date</th>
                                <th>Status</th>
                                <th width="180">Action</th>
                            </tr>

                        </thead>

                        <tbody>

                            <%
                                if (assignmentList != null) {

                                    for (Assignment obj : assignmentList) {
                            %>

                            <tr>

                                <td><%=sl++%></td>

                                <td><%=obj.getTraineeId()%></td>

                                <td><%=obj.getTraineeName()%></td>

                                <td><%=obj.getAssignedDate()%></td>

                                <td>

                                    <span class="badge badge-warning">

                                        <%=obj.getStatus()%>

                                    </span>

                                </td>

                                <td>

                                    <!-- Accept -->

                                    <a href="staffController?actionType=acceptAssignment&assignmentId=<%=obj.getAssignmentId()%>"
                                       class="btn btn-success btn-sm"
                                       onclick="return confirm('Accept this trainee?');">

                                        <i class="fas fa-check"></i>

                                        Accept

                                    </a>

                                    <!-- Reject -->

                                    <button
                                        class="btn btn-danger btn-sm"
                                        data-toggle="modal"
                                        data-target="#rejectModal"
                                        data-id="<%=obj.getAssignmentId()%>">

                                        <i class="fas fa-times"></i>

                                        Reject

                                    </button>

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

<!-- Reject Modal -->

<div class="modal fade" id="rejectModal">

    <div class="modal-dialog">

        <div class="modal-content">

            <form action="staffController" method="post">

                <input type="hidden" name="actionType" value="rejectAssignment">

                <input type="hidden" id="assignmentId" name="assignmentId">

                <div class="modal-header bg-danger text-white">

                    <h5>Reject Trainee</h5>

                    <button class="close" data-dismiss="modal">

                        &times;

                    </button>

                </div>

                <div class="modal-body">

                    <div class="form-group">

                        <label>Reason</label>

                        <textarea class="form-control"
                                  name="remarks"
                                  rows="4"
                                  required></textarea>

                    </div>

                </div>

                <div class="modal-footer">

                    <button class="btn btn-secondary"
                            data-dismiss="modal"
                            type="button">

                        Cancel

                    </button>

                    <button class="btn btn-danger">

                        Reject

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>

<jsp:include page="../../footer.jsp"/>

<script>

    $(function () {

        $("#dataTable").DataTable({
            responsive: true,
            autoWidth: false
        });

    });

    $('#rejectModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        var assignmentId = button.data('id');

        $('#assignmentId').val(assignmentId);

    });

</script>


