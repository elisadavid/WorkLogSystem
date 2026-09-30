<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.trainee_task"%>

<%
    ArrayList<trainee_task> arrTaskList = (ArrayList<trainee_task>) request.getAttribute("arrTaskList");
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="traineeSideMenu.jsp"/>

<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <h3>My Tasks</h3>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">
            
            <!-- SUCCESS MESSAGE DISPLAY START -->
            <% 
                String sMsg = (String) session.getAttribute("successMsg");
                if (sMsg != null) { 
            %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> <%= sMsg %>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            <% 
                session.removeAttribute("successMsg"); // Clear after showing
                } 
            %>
            <!-- SUCCESS MESSAGE DISPLAY END -->

            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Assigned Tasks</h3>
                </div>
                <div class="card-body">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead class="bg-primary text-white">
                            <tr>
                                <th>Sl No</th>
                                <th>Task Title</th>
                                <th>Mentor</th>
                                <th>Assigned Date</th>
                                <th>Due Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int i = 1;
                                if (arrTaskList != null) {
                                    for (trainee_task objTask : arrTaskList) {
                            %>
                            <tr>
                                <td><%=i++%></td>
                                <td><%=objTask.getTaskTitle()%></td>
                                <td><%=objTask.getObjStaff().getStaffName()%></td>
                                <td>
                                    <%
                                        String assignedDateStr = objTask.getAssignedDate();
                                        if (assignedDateStr != null) {
                                            try {
                                                java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                java.util.Date date = inputFormat.parse(assignedDateStr);
                                                java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                                out.print(outputFormat.format(date));
                                            } catch (Exception e) { out.print(assignedDateStr); }
                                        } else { out.print("N/A"); }
                                    %>
                                </td>
                                <td>
                                    <%
                                        String dueDateStr = objTask.getDueDate();
                                        if (dueDateStr != null) {
                                            try {
                                                java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                java.util.Date date = inputFormat.parse(dueDateStr);
                                                java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                                out.print(outputFormat.format(date));
                                            } catch (Exception e) { out.print(dueDateStr); }
                                        } else { out.print("N/A"); }
                                    %>
                                </td>
                                <td>
                                    <% if ("PENDING".equalsIgnoreCase(objTask.getStatus())) { %>
                                        <span class="badge badge-warning">PENDING</span>
                                    <% } else if ("IN_PROGRESS".equalsIgnoreCase(objTask.getStatus())) { %>
                                        <span class="badge badge-primary">IN PROGRESS</span>
                                    <% } else { %>
                                        <span class="badge badge-success">COMPLETED</span>
                                    <% }%>
                                </td>
                                <td>
                                    <button class="btn btn-info btn-sm"
                                            data-toggle="modal"
                                            data-target="#taskModal"
                                            data-id="<%=objTask.getTaskId()%>"
                                            data-title="<%=objTask.getTaskTitle()%>"
                                            data-description="<%=objTask.getTaskDescription()%>"
                                            data-status="<%=objTask.getStatus()%>"
                                            data-remarks="<%=objTask.getRemarks() == null ? "" : objTask.getRemarks()%>">
                                        <i class="fas fa-edit"></i>
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

<!-- Modal remains the same as your provided code -->
<div class="modal fade" id="taskModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="traineesController" method="post">
                <input type="hidden" name="actionType" value="updateTaskStatus">
                <input type="hidden" id="taskId" name="taskId">
                <div class="modal-header bg-primary">
                    <h5 class="modal-title">Task Details</h5>
                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label>Task Title</label>
                        <input type="text" id="taskTitle" class="form-control" readonly>
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <textarea id="taskDescription" class="form-control" rows="4" readonly></textarea>
                    </div>
                    <div class="form-group">
                        <label>Status</label>
                        <select class="form-control" id="status" name="status">
                            <option value="PENDING">PENDING</option>
                            <option value="IN_PROGRESS">IN PROGRESS</option>
                            <option value="COMPLETED">COMPLETED</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Remarks</label>
                        <textarea class="form-control" id="remarks" name="remarks" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success">Update Status</button>
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
    $('#taskModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        $('#taskId').val(button.data('id'));
        $('#taskTitle').val(button.data('title'));
        $('#taskDescription').val(button.data('description'));
        $('#status').val(button.data('status'));
        $('#remarks').val(button.data('remarks'));
    });
</script>