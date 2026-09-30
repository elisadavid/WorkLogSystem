<%@page import="model.trainee_task"%>
<%@page import="java.util.ArrayList"%>

<%
    ArrayList<trainee_task> arrTaskList
            = (ArrayList<trainee_task>) request.getAttribute("arrTaskList");
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="staffSideMenu.jsp"/>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">
            <h3>Assigned Tasks</h3>
        </div>
    </section>

    <section class="content">

        <div class="container-fluid">

            <div class="card">

                <div class="card-header">
                    <h3 class="card-title">Task List</h3>
                </div>

                <div class="card-body">

                    <table id="example1" class="table table-bordered table-striped">

                        <thead>

                            <tr>

                                <th>Sl No</th>
                                <th>Trainee</th>
                                <th>Task Title</th>
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

                                <td><%=objTask.getObjTrainee().getTraineeName()%></td>

                                <td><%=objTask.getTaskTitle()%></td>

                                <td> 
                                    <%
                                        String assignedDateStr = objTask.getAssignedDate(); // Assuming this returns a String
                                        if (assignedDateStr != null) {
                                            try {
                                                java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                java.util.Date date = inputFormat.parse(assignedDateStr);
                                                java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                                out.print(outputFormat.format(date));
                                            } catch (Exception e) {
                                                out.print(assignedDateStr);
                                            }
                                        } else {
                                            out.print("N/A");
                                        }
                                    %>
                                </td>
                                <td>
                                    <%
                                        String dueDateStr = objTask.getDueDate(); // Assuming this returns a String
                                        if (dueDateStr != null) {
                                            try {
                                                java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
                                                java.util.Date date = inputFormat.parse(dueDateStr);
                                                java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                                out.print(outputFormat.format(date));
                                            } catch (Exception e) {
                                                out.print(dueDateStr);
                                            }
                                        } else {
                                            out.print("N/A");
                                        }
                                    %>
                                </td>



                                <td>

                                    <% if ("PENDING".equalsIgnoreCase(objTask.getStatus())) { %>

                                    <span class="badge badge-warning">
                                        PENDING
                                    </span>

                                    <% } else if ("IN_PROGRESS".equalsIgnoreCase(objTask.getStatus())) { %>

                                    <span class="badge badge-primary">
                                        IN PROGRESS
                                    </span>

                                    <% } else { %>

                                    <span class="badge badge-success">
                                        COMPLETED
                                    </span>

                                    <% }%>

                                </td>

                                <td>

                                    <button
                                        class="btn btn-info btn-sm"
                                        data-toggle="modal"
                                        data-target="#viewTaskModal"
                                        data-title="<%=objTask.getTaskTitle()%>"
                                        data-description="<%=objTask.getTaskDescription()%>"
                                        data-remarks="<%=objTask.getRemarks() == null ? "" : objTask.getRemarks()%>">

                                        View

                                    </button>

                                    <!-- Edit -->

                                    <button class="btn btn-warning btn-sm"
                                            data-toggle="modal"
                                            data-target="#editTaskModal"
                                            data-id="<%=objTask.getTaskId()%>"
                                            data-title="<%=objTask.getTaskTitle()%>"
                                            data-description="<%=objTask.getTaskDescription()%>"
                                            data-duedate="<%=objTask.getDueDate()%>">

                                        <i class="fas fa-edit"></i>

                                    </button>

                                    <!-- Delete -->

                                    <a href="staffController?actionType=deleteTask&taskId=<%=objTask.getTaskId()%>"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to delete this task?');">

                                        <i class="fas fa-trash"></i>

                                    </a>

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

<!-- View Task Modal -->

<div class="modal fade" id="viewTaskModal">

    <div class="modal-dialog">

        <div class="modal-content">

            <div class="modal-header bg-info">

                <h5 class="modal-title">Task Details</h5>

                <button type="button" class="close" data-dismiss="modal">

                    <span>&times;</span>

                </button>

            </div>

            <div class="modal-body">

                <div class="form-group">

                    <label>Task Title</label>

                    <input type="text"
                           id="taskTitle"
                           class="form-control"
                           readonly>

                </div>

                <div class="form-group">

                    <label>Description</label>

                    <textarea id="taskDescription"
                              class="form-control"
                              rows="5"
                              readonly></textarea>

                </div>

                <div class="form-group">

                    <label>Remarks</label>

                    <textarea id="remarks"
                              class="form-control"
                              rows="3"
                              readonly></textarea>

                </div>

            </div>

        </div>

    </div>

</div>

<div class="modal fade" id="editTaskModal">

    <div class="modal-dialog">

        <div class="modal-content">

            <form action="staffController" method="post">

                <input type="hidden" name="actionType" value="updateTask">

                <input type="hidden" name="taskId" id="editTaskId">

                <div class="modal-header bg-warning">

                    <h5 class="modal-title">Edit Task</h5>

                    <button type="button"
                            class="close"
                            data-dismiss="modal">

                        <span>&times;</span>

                    </button>

                </div>

                <div class="modal-body">

                    <div class="form-group">

                        <label>Task Title</label>

                        <input type="text"
                               class="form-control"
                               name="taskTitle"
                               id="editTitle"
                               required>

                    </div>

                    <div class="form-group">

                        <label>Description</label>

                        <textarea class="form-control"
                                  rows="5"
                                  name="taskDescription"
                                  id="editDescription"
                                  required></textarea>

                    </div>

                    <div class="form-group">

                        <label>Due Date</label>

                        <input type="date"
                               class="form-control"
                               name="dueDate"
                               id="editDueDate"
                               required>

                    </div>

                </div>

                <div class="modal-footer">

                    <button class="btn btn-success">

                        Update Task

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

    $('#viewTaskModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        $('#taskTitle').val(button.data('title'));
        $('#taskDescription').val(button.data('description'));
        $('#remarks').val(button.data('remarks'));

    });

    $('#editTaskModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        $('#editTaskId').val(button.data('id'));
        $('#editTitle').val(button.data('title'));
        $('#editDescription').val(button.data('description'));
        $('#editDueDate').val(button.data('duedate'));

    });

</script>