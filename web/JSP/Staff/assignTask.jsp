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
<jsp:include page="staffSideMenu.jsp"/>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">
            <h3>Assign Tasks</h3>
        </div>
    </section>

    <section class="content">

        <div class="container-fluid">

            <div class="card card-primary card-outline">

                <div class="card-header">
                    <h3 class="card-title">Accepted Trainees</h3>
                </div>

                <div class="card-body">

                    <table id="dataTable"
                           class="table table-bordered table-striped">

                        <thead>

                            <tr>

                                <th>Sl No</th>
                                <th>Trainee ID</th>
                                <th>Name</th>
                                <th>Action</th>

                            </tr>

                        </thead>

                        <tbody>

                            <%
                                int count = 0;

                                if (arrtraineelist != null) {

                                    for (traineeDetails obj : arrtraineelist) {

                                        if (obj.getObjAssign() != null
                                                && "ACCEPTED".equalsIgnoreCase(obj.getObjAssign().getStatus())) {

                                            count++;
                            %>

                            <tr>

                                <td><%=count%></td>

                                <td><%=obj.getTraineeId()%></td>

                                <td><%=obj.getTraineeName()%></td>

                                <td>

                                    <button class="btn btn-primary btn-sm"
                                            data-toggle="modal"
                                            data-target="#assignTaskModal"
                                            data-id="<%=obj.getTraineeId()%>"
                                            data-name="<%=obj.getTraineeName()%>">

                                        <i class="fas fa-tasks"></i>
                                        Assign Task

                                    </button>

                                </td>

                            </tr>

                            <%
                                        }
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

<!-- Assign Task Modal -->

<div class="modal fade" id="assignTaskModal">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <form action="staffController" method="post">

                <input type="hidden"
                       name="actionType"
                       value="saveTask">

                <input type="hidden"
                       id="traineeId"
                       name="traineeId">

                <div class="modal-header bg-primary">

                    <h5 class="modal-title text-white">

                        Assign Task

                    </h5>

                    <button type="button"
                            class="close text-white"
                            data-dismiss="modal">

                        <span>&times;</span>

                    </button>

                </div>

                <div class="modal-body">

                    <div class="form-group">

                        <label>Trainee Name</label>

                        <input type="text"
                               id="traineeName"
                               class="form-control"
                               readonly>

                    </div>

                    <div class="form-group">

                        <label>Task Title</label>

                        <input type="text"
                               name="taskTitle"
                               class="form-control"
                               required>

                    </div>

                    <div class="form-group">

                        <label>Task Description</label>

                        <textarea class="form-control"
                                  name="taskDescription"
                                  rows="5"
                                  required></textarea>

                    </div>

                    <div class="form-group">

                        <label>Due Date</label>

                        <input type="date"
                               name="dueDate"
                               class="form-control"
                               required>

                    </div>

                </div>

                <div class="modal-footer">

                    <button type="button"
                            class="btn btn-secondary"
                            data-dismiss="modal">

                        Cancel

                    </button>

                    <button type="submit"
                            class="btn btn-success">

                        <i class="fas fa-save"></i>
                        Assign Task

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>

<jsp:include page="../../footer.jsp"/>

<script>

    $(document).ready(function () {

        $('#dataTable').DataTable({
            responsive: true,
            autoWidth: false
        });

    });

    $('#assignTaskModal').on('show.bs.modal', function (event) {

        var button = $(event.relatedTarget);

        $('#traineeId').val(button.data('id'));
        $('#traineeName').val(button.data('name'));

    });

</script>