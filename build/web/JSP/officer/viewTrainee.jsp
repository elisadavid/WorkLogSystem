<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.traineeDetails"%>
<%@page import="model.designation"%>

<%
    ArrayList<traineeDetails> arrtraineelist
            = (ArrayList<traineeDetails>) request.getAttribute("arrtraineelist");

    ArrayList<designation> arrDesignation
            = (ArrayList<designation>) request.getAttribute("arrDesignation");

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="officerSideMenu.jsp"/>

<div class="content-wrapper">

    <section class="content-header">

        <div class="container-fluid">

            <div class="row mb-2">

                <div class="col-sm-6">

                    <h1>View Trainees</h1>

                </div>

                <div class="col-sm-6">

                    <ol class="breadcrumb float-sm-right">

                        <li class="breadcrumb-item">
                            <a href="#">Dashboard</a>
                        </li>

                        <li class="breadcrumb-item active">
                            View Trainees
                        </li>

                    </ol>

                </div>

            </div>

        </div>

    </section>

    <%
        String strMessage = "";
        if (request.getAttribute("message") != null) {
            strMessage = (String) request.getAttribute("message");
        }
    %>

    <section class="content">
        <center> <% if (strMessage != null && !strMessage.equals("")) {%>
            <font size="3" style="color: #BA1E20" >
            <%=strMessage%></font> <%}%></center>

        <div class="container-fluid">


            <div class="card card-primary card-outline">

                <div class="card-header">

                    <h3 class="card-title">

                        Registered Trainees

                    </h3>

                </div>
                <div class="card-body">

                    <div class="table-responsive">

                        <table id="dataTable"
                               class="table table-bordered table-hover table-striped">

                            <thead class="bg-primary text-white">

                                <tr>

                                    <th>Sl No</th>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Gender</th>
                                    <th>DOB</th>
                                    <th>Place</th>
                                    <th>Branch</th>
                                    <th>Qualification</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Designation</th>
                                    <th>Joining</th>
                                    <th>Completion</th>
                                    <th>Division</th>
                                    <th>Status</th>
                                    <th>Action</th>

                                </tr>

                            </thead>

                            <tbody>

                                <%
                                    int count = 0;

                                    if (arrtraineelist != null && !arrtraineelist.isEmpty()) {

                                        for (traineeDetails obj : arrtraineelist) {

                                            count++;
                                %>

                                <tr>

                                    <td><%=count%></td>

                                    <td><%=obj.getTraineeId()%></td>

                                    <td><%=obj.getTraineeName()%></td>

                                    <td><%=obj.getGender()%></td>

                                    <td>
                                        <%=obj.getDob() != null ? sdf.format(obj.getDob()) : ""%>
                                    </td>

                                    <td><%=obj.getPlace()%></td>

                                    <td><%=obj.getBranch()%></td>

                                    <td><%=obj.getQualification()%></td>

                                    <td><%=obj.getEmailId()%></td>

                                    <td><%=obj.getPhonenumber()%></td>

                                    <td>
                                        <%=obj.getObjDesignationitems() != null
                                                ? obj.getObjDesignationitems().getDesignation() : ""%>
                                    </td>

                                    <td>
                                        <%=obj.getJoiningDate() != null
                                                ? sdf.format(obj.getJoiningDate()) : ""%>
                                    </td>

                                    <td>
                                        <%=obj.getCompletionDate() != null
                                                ? sdf.format(obj.getCompletionDate()) : ""%>
                                    </td>

                                    <td>
                                        <span class="badge badge-info">
                                            <%=obj.getDivision()%>
                                        </span>
                                    </td>

                                    <td>

                                        <% if ("YES".equalsIgnoreCase(obj.getActive())) { %>

                                        <span class="badge badge-success">
                                            <i class="fas fa-check-circle"></i>
                                            YES
                                        </span>

                                        <% } else { %>

                                        <span class="badge badge-danger">
                                            <i class="fas fa-times-circle"></i>
                                            NO
                                        </span>

                                        <% }%>

                                    </td>

                                    <td>

                                        <!-- Edit -->

                                        <% if ("YES".equalsIgnoreCase(obj.getActive())) {%>

                                        <button type="button"
                                                class="btn btn-warning btn-sm btnEdit"

                                                data-id="<%=obj.getTraineeId()%>"
                                                data-name="<%=obj.getTraineeName()%>"
                                                data-gender="<%=obj.getGender()%>"
                                                data-dob="<%=obj.getDob() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(obj.getDob()) : ""%>"
                                                data-place="<%=obj.getPlace()%>"
                                                data-branch="<%=obj.getBranch()%>"
                                                data-qualification="<%=obj.getQualification()%>"
                                                data-email="<%=obj.getEmailId()%>"
                                                data-phone="<%=obj.getPhonenumber()%>"
                                                data-designation="<%=obj.getObjDesignationitems().getDesignationId()%>"
                                                data-division="<%=obj.getDivision()%>"
                                                data-joiningdate="<%=obj.getJoiningDate() != null ? new java.text.SimpleDateFormat("yyyy-MM-dd").format(obj.getJoiningDate()) : ""%>"
                                                data-toggle="modal"
                                                data-target="#editModal">

                                            <i class="fas fa-edit"></i>

                                        </button>

                                        <% } else { %>

                                        <button type="button"
                                                class="btn btn-secondary btn-sm"
                                                disabled
                                                title="Inactive trainees cannot be edited">

                                            <i class="fas fa-edit"></i>

                                        </button>

                                        <% } %>

                                        <% if ("YES".equalsIgnoreCase(obj.getActive())) {%>

                                        <a href="officerController?actionType=changeStatus&traineeId=<%=obj.getTraineeId()%>&status=INACTIVE"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Deactivate this trainee?');">

                                            <i class="fas fa-user-slash"></i>

                                        </a>

                                        <% } else {%>

                                        <a href="officerController?actionType=changeStatus&traineeId=<%=obj.getTraineeId()%>&status=ACTIVE"
                                           class="btn btn-success btn-sm"
                                           onclick="return confirm('Activate this trainee?');">

                                            <i class="fas fa-user-check"></i>

                                        </a>

                                        <% } %>

                                    </td>

                                </tr>

                                <%
                                    }

                                } else {
                                %>

                                <tr>

                                    <td colspan="16" class="text-center text-danger">

                                        <b>No Trainee Records Found</b>

                                    </td>

                                </tr>

                                <%
                                    }
                                %>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

        </div>

    </section>

</div>
<jsp:include page="../../footer.jsp"/>
<!-- Edit Trainee Modal -->
<div class="modal fade" id="editModal" tabindex="-1">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <form action="officerController?actionType=updateTrainee"
                  method="post">

                <div class="modal-header bg-warning">

                    <h4 class="modal-title">
                        Edit Trainee
                    </h4>

                    <button type="button"
                            class="close"
                            data-dismiss="modal">

                        <span>&times;</span>

                    </button>

                </div>

                <div class="modal-body">

                    <div class="row">
                        <div class="form-group">
                            <label>Trainee ID</label>

                            <input type="text"
                                   id="editTraineeIdDisplay"
                                   class="form-control"
                                   readonly>

                            <input type="hidden"
                                   id="editTraineeId"
                                   name="traineeId">

                        </div>

                        <div class="col-md-6">

                            <div class="form-group">

                                <label>Trainee Name</label>

                                <input type="text"
                                       id="editName"
                                       name="traineeName"
                                       class="form-control">

                            </div>

                        </div>

                        <div class="col-md-6">

                            <div class="form-group">

                                <label>Gender</label>

                                <select id="editGender"
                                        name="gender"
                                        class="form-control">

                                    <option value="Male">Male</option>

                                    <option value="Female">Female</option>

                                </select>

                            </div>

                        </div>

                    </div>

                    <div class="row">

                        <div class="col-md-6">

                            <div class="form-group">

                                <label>Date of Birth</label>

                                <input type="date"
                                       id="editDob"
                                       name="dob"
                                       class="form-control">

                            </div>

                        </div>

                        <div class="col-md-6">

                            <div class="form-group">

                                <label>Place</label>

                                <input type="text"
                                       id="editPlace"
                                       name="place"
                                       class="form-control">

                            </div>

                        </div>

                    </div>

                    <div class="row">

                        <div class="col-md-6">

                            <div class="form-group">

                                <label>Branch</label>

                                <input type="text"
                                       id="editBranch"
                                       name="branch"
                                       class="form-control">

                            </div>

                        </div>

                        <div class="col-md-6">

                            <div class="form-group">

                                <label>Qualification</label>

                                <input type="text"
                                       id="editQualification"
                                       name="qualification"
                                       class="form-control">

                            </div>

                        </div>

                    </div>

                    <div class="row">

                        <div class="col-md-6">

                            <div class="form-group">

                                <label>Email</label>

                                <input type="email"
                                       id="editEmail"
                                       name="emailId"
                                       class="form-control">

                            </div>

                        </div>

                        <div class="col-md-6">

                            <div class="form-group">

                                <label>Phone</label>

                                <input type="text"
                                       id="editPhone"
                                       name="phoneNumber"
                                       class="form-control">

                            </div>

                        </div>

                    </div>

                    <div class="row">

                        <div class="col-md-6">

                            <div class="form-group">

                                <label>Designation</label>

                                <select id="editDesignation"
                                        name="designationId"
                                        class="form-control">

                                    <%
                                        if (arrDesignation != null) {

                                            for (designation d : arrDesignation) {
                                    %>

                                    <option value="<%=d.getDesignationId()%>">

                                        <%=d.getDesignation()%>

                                    </option>

                                    <%
                                            }
                                        }
                                    %>

                                </select>

                            </div>

                        </div>

                        <div class="col-md-6">

                            <div class="form-group">

                                <label>Division</label>

                                <select id="editDivision"
                                        name="division"
                                        class="form-control">

                                    <option value="COM">COM</option>
                                    <option value="ESIS">ESIS</option>

                                </select>

                            </div>

                        </div>
                        <div class="row">

                            <div class="col-md-6">

                                <div class="form-group">

                                    <label>Joining Date</label>

                                    <input type="date"
                                           id="editJoiningDate"
                                           name="joiningDate"
                                           class="form-control">

                                </div>

                            </div>

                            <div class="col-md-6">

                                <div class="form-group">

                                    <label>Completion Date</label>

                                    <input type="date"
                                           id="editCompletionDate"
                                           name="completionDate"
                                           class="form-control"
                                           readonly>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

                <div class="modal-footer">

                    <button type="submit"
                            class="btn btn-success">

                        <i class="fas fa-save"></i>
                        Update

                    </button>

                    <button type="button"
                            class="btn btn-secondary"
                            data-dismiss="modal">

                        Close

                    </button>

                </div>

            </form>

        </div>

    </div>

</div>
<script>

    $(document).ready(function () {

        $("#dataTable").DataTable({
            responsive: true,
            autoWidth: false
        });

        $(".btnEdit").click(function () {

            $("#editTraineeId").val($(this).data("id"));
            $("#editTraineeIdDisplay").val($(this).data("id"));

            $("#editName").val($(this).data("name"));
            $("#editGender").val($(this).data("gender"));
            $("#editDob").val($(this).data("dob"));
            $("#editPlace").val($(this).data("place"));
            $("#editBranch").val($(this).data("branch"));
            $("#editQualification").val($(this).data("qualification"));
            $("#editEmail").val($(this).data("email"));
            $("#editPhone").val($(this).data("phone"));
            $("#editDesignation").val($(this).data("designation"));
            $("#editDivision").val($(this).data("division"));

            // Joining Date
            $("#editJoiningDate").val($(this).data("joiningdate"));

            // Automatically calculate Completion Date
            var joining = new Date($(this).data("joiningdate"));

            if (!isNaN(joining.getTime())) {

                joining.setFullYear(joining.getFullYear() + 1);

                var yyyy = joining.getFullYear();
                var mm = ("0" + (joining.getMonth() + 1)).slice(-2);
                var dd = ("0" + joining.getDate()).slice(-2);

                $("#editCompletionDate").val(yyyy + "-" + mm + "-" + dd);
            }

        });

        // If Joining Date is changed manually
        $("#editJoiningDate").on("change", function () {

            var joining = new Date($(this).val());

            if (!isNaN(joining.getTime())) {

                joining.setFullYear(joining.getFullYear() + 1);

                var yyyy = joining.getFullYear();
                var mm = ("0" + (joining.getMonth() + 1)).slice(-2);
                var dd = ("0" + joining.getDate()).slice(-2);

                $("#editCompletionDate").val(yyyy + "-" + mm + "-" + dd);
            }

        });

    });

</script>