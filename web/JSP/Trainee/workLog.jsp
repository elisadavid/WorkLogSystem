<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.work_log"%>

<%
    ArrayList<work_log> arrWorkLogList
            = (ArrayList<work_log>) request.getAttribute("arrWorkLogList");
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="traineeSideMenu.jsp"/>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">

            <div class="row mb-2">

                <div class="col-sm-6">
                    <h3>Daily Work Log</h3>
                </div>

                <div class="col-sm-6 text-right">

                    <button class="btn btn-primary"
                            data-toggle="modal"
                            data-target="#workLogModal">

                        <i class="fas fa-plus"></i>
                        Add Work Log

                    </button>

                </div>

            </div>

        </div>
    </section>

    <section class="content">

        <div class="container-fluid">

            <div class="card">

                <div class="card-header">

                    <h3 class="card-title">My Work Logs</h3>

                </div>

                <div class="card-body">

                    <table id="example1" class="table table-bordered table-striped">

                        <thead>

                            <tr>

                                <th>Sl No</th>
                                <th>Date</th>
                                <th>Title</th>
                                <th>Hours</th>
                                <th>Mentor</th>
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

                                <td><%=obj.getObjStaff().getStaffName()%></td>

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

                                    <button class="btn btn-info btn-sm"

                                            data-toggle="modal"

                                            data-target="#viewModal"

                                            data-title="<%=obj.getWorkTitle()%>"

                                            data-description="<%=obj.getWorkDescription()%>"

                                            data-remarks="<%=obj.getMentorRemarks() == null ? "" : obj.getMentorRemarks()%>">

                                        <i class="fas fa-eye"></i>

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


<!-- Add Work Log Modal -->

<div class="modal fade" id="workLogModal">

    <div class="modal-dialog">

        <div class="modal-content">

            <form action="traineesController" method="post">

                <input type="hidden" name="actionType" value="saveWorkLog">

                <div class="modal-header bg-primary">

                    <h5 class="modal-title">Add Work Log</h5>

                    <button type="button" class="close" data-dismiss="modal">

                        <span>&times;</span>

                    </button>

                </div>

                <div class="modal-body">

                    <div class="form-group">

                        <label>Work Date</label>

                        <input type="date"
                               name="workDate"
                               class="form-control"
                               required>

                    </div>

                    <div class="form-group">

                        <label>Work Title</label>

                        <input type="text"
                               name="workTitle"
                               class="form-control"
                               required>

                    </div>

                    <div class="form-group">

                        <label>Description</label>

                        <textarea
                            name="workDescription"
                            class="form-control"
                            rows="4"
                            required></textarea>

                    </div>

                    <div class="form-group">

                        <label>Hours Worked</label>

                        <input type="number"
                               step="0.5"
                               min="0"
                               max="24"
                               name="hoursWorked"
                               class="form-control"
                               required>

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


<!-- View Modal -->

<div class="modal fade" id="viewModal">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header bg-info">

                <h5 class="modal-title">Work Log Details</h5>

                <button type="button" class="close" data-dismiss="modal">

                    <span>&times;</span>

                </button>

            </div>

            <div class="modal-body">

                <div class="form-group">

                    <label>Title</label>

                    <input type="text"
                           id="title"
                           class="form-control"
                           readonly>

                </div>

                <div class="form-group">

                    <label>Description</label>

                    <textarea
                        id="description"
                        class="form-control"
                        rows="5"
                        readonly></textarea>

                </div>

                <div class="form-group">

                    <label>Mentor Remarks</label>

                    <textarea
                        id="remarks"
                        class="form-control"
                        rows="3"
                        readonly></textarea>

                </div>

            </div>

        </div>

    </div>

</div>

<jsp:include page="../../footer.jsp"/>

<script>

    $(function () {

        $('#example1').DataTable();

    });

    $('#viewModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        $('#title').val(button.data('title'));

        $('#description').val(button.data('description'));

        $('#remarks').val(button.data('remarks'));

    });

</script>