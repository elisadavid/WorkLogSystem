<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.work_log"%>

<%
    ArrayList<work_log> arrWorkLogList
            = (ArrayList<work_log>) request.getAttribute("arrWorkLogList");
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="staffSideMenu.jsp"/>

<div class="content-wrapper">

    <section class="content-header">

        <div class="container-fluid">

            <h3>Daily Work Logs</h3>

        </div>

    </section>

    <section class="content">

        <div class="container-fluid">

            <div class="card">

                <div class="card-header">

                    <h3 class="card-title">Submitted Work Logs</h3>

                </div>

                <div class="card-body">

                    <table id="example1" class="table table-bordered table-striped">

                        <thead>

                            <tr>

                                <th>Sl No</th>
                                <th>Trainee</th>
                                <th>Date</th>
                                <th>Title</th>
                                <th>Hours</th>
                                <th>Status</th>
                                <th>Action</th>

                            </tr>

                        </thead>

                        <tbody>

                            <%
                                int i = 1;

                                if (arrWorkLogList != null) {

                                    for (work_log obj : arrWorkLogList) {

                            %>

                            <tr>

                                <td><%=i++%></td>

                                <td><%=obj.getObjTrainee().getTraineeName()%></td>

                                <td>
                                    <%
                                        String rawDate = obj.getWorkDate();
                                        if (rawDate != null) {
                                            try {
                                                // Assuming the date comes from DB/Form as yyyy-MM-dd
                                                java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                java.util.Date date = inputFormat.parse(rawDate);
                                                java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                                out.print(outputFormat.format(date));
                                            } catch (Exception e) {
                                                out.print(rawDate); // Fallback to original string if parsing fails
                                            }
                                        }
                                    %>
                                </td>



                                <td><%=obj.getWorkTitle()%></td>

                                <td><%=obj.getHoursWorked()%></td>

                                <td>

                                    <%

                                        if ("PENDING".equalsIgnoreCase(obj.getStatus())) {

                                    %>

                                    <span class="badge badge-warning">PENDING</span>

                                    <%} else if ("APPROVED".equalsIgnoreCase(obj.getStatus())) {

                                    %>

                                    <span class="badge badge-success">APPROVED</span>

                                    <%} else {

                                    %>

                                    <span class="badge badge-danger">REJECTED</span>

                                    <%    }

                                    %>

                                </td>

                                <td>

                                    <button class="btn btn-primary btn-sm"

                                            data-toggle="modal"

                                            data-target="#reviewModal"

                                            data-id="<%=obj.getWorklogId()%>"

                                            data-title="<%=obj.getWorkTitle()%>"

                                            data-description="<%=obj.getWorkDescription()%>"

                                            data-status="<%=obj.getStatus()%>"

                                            data-remarks="<%=obj.getMentorRemarks() == null ? "" : obj.getMentorRemarks()%>">

                                        <i class="fas fa-eye"></i>

                                        Review

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


<!-- Review Modal -->

<div class="modal fade" id="reviewModal">

    <div class="modal-dialog">

        <div class="modal-content">

            <form action="staffController" method="post">

                <input type="hidden" name="actionType" value="updateWorkLogStatus">

                <input type="hidden" id="worklogId" name="worklogId">

                <div class="modal-header bg-primary">

                    <h5 class="modal-title">Review Work Log</h5>

                    <button type="button" class="close" data-dismiss="modal">

                        <span>&times;</span>

                    </button>

                </div>

                <div class="modal-body">

                    <div class="form-group">

                        <label>Work Title</label>

                        <input type="text"
                               id="workTitle"
                               class="form-control"
                               readonly>

                    </div>

                    <div class="form-group">

                        <label>Description</label>

                        <textarea id="workDescription"
                                  class="form-control"
                                  rows="5"
                                  readonly></textarea>

                    </div>

                    <div class="form-group">

                        <label>Status</label>

                        <select name="status"
                                id="status"
                                class="form-control">

                            <option value="PENDING">PENDING</option>

                            <option value="APPROVED">APPROVED</option>

                            <option value="REJECTED">REJECTED</option>

                        </select>

                    </div>

                    <div class="form-group">

                        <label>Mentor Remarks</label>

                        <textarea name="mentorRemarks"
                                  id="mentorRemarks"
                                  class="form-control"
                                  rows="4"></textarea>

                    </div>

                </div>

                <div class="modal-footer">

                    <button class="btn btn-success">

                        Update

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>

<jsp:include page="../../footer.jsp"/>

<script>

    $(function () {

        $('#example1').DataTable();

    });

    $('#reviewModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        $('#worklogId').val(button.data('id'));

        $('#workTitle').val(button.data('title'));

        $('#workDescription').val(button.data('description'));

        $('#status').val(button.data('status'));

        $('#mentorRemarks').val(button.data('remarks'));

    });

</script>