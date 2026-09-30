<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.staffDetails"%>

<%
    ArrayList<staffDetails> arrStaffList = (ArrayList<staffDetails>) request.getAttribute("arrStaffList");
    int count = 0;
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="headSidemenu.jsp"/>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">
            <h1>View Mentors</h1>
        </div>
    </section>

    <section class="content">
        <div class="container-fluid">

            <%
                String msg = (String) request.getAttribute("message");
                String type = (String) request.getAttribute("msgType");
                if (msg != null) {
            %>
            <div class="alert alert-<%= type%> alert-dismissible fade show" role="alert">
                <%= msg%>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <% } %>


            <!-- ... existing table code ... -->
            <div class="card card-primary card-outline">

                <div class="card-header">
                    <h3 class="card-title">Mentor Details</h3>
                </div>
                <div class="card-body">
                    <table id="dataTable" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Sl No</th>
                                <th>Staff ID</th>
                                <th>Name</th>
                                <th>Gender</th>
                                <th>Designation</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Active</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%  if (arrStaffList != null) {
                                    for (staffDetails obj : arrStaffList) {
                                        count++;%>
                            <tr>
                                <td><%=count%></td>
                                <td><%=obj.getStaffId()%></td>
                                <td><%=obj.getStaffName()%></td>
                                <td><%=obj.getGender()%></td>
                                <td><%=obj.getDesignation()%></td>
                                <td><%=obj.getEmailId()%></td>
                                <td><%=obj.getPhoneNumber()%></td>
                                <td>
                                    <% if ("YES".equalsIgnoreCase(obj.getActive())) { %>
                                    <span class="badge badge-success"> <i class="fas fa-check-circle"></i> YES  </span>
                                    <% } else { %>
                                    <span class="badge badge-danger"> <i class="fas fa-times-circle"></i> NO  </span>
                                    <% }%>
                                </td>
                                <td>
                                    <% if ("YES".equalsIgnoreCase(obj.getActive())) {%>
                                    <button type="button"class="btn btn-warning btn-sm btnEdit"
                                            data-id="<%=obj.getStaffId()%>"
                                            data-name="<%=obj.getStaffName()%>"
                                            data-gender="<%=obj.getGender()%>"
                                            data-email="<%=obj.getEmailId()%>"
                                            data-phone="<%=obj.getPhoneNumber()%>"
                                            data-designation="<%=obj.getDesignation()%>"
                                            data-username="<%=obj.getUsername()%>"
                                            data-toggle="modal"
                                            data-target="#editModal">
                                        <i class="fas fa-edit"></i> </button>
                                        <% } else { %>
                                    <button type="button" class="btn btn-secondary btn-sm"  disabled title="Inactive mentors cannot be edited">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <% } %>
                                    <% if ("YES".equalsIgnoreCase(obj.getActive())) {%>
                                    <a href="HeadController?actionType=changeStaffStatus&staffId=<%=obj.getStaffId()%>&active=NO" class="btn btn-danger btn-sm" onclick="return confirm('Deactivate this mentor?');">
                                        <i class="fas fa-user-slash"></i>
                                    </a>
                                    <% } else {%>
                                    <a href="HeadController?actionType=changeStaffStatus&staffId=<%=obj.getStaffId()%>&active=YES"  class="btn btn-success btn-sm"
                                       onclick="return confirm('Activate this mentor?');">
                                        <i class="fas fa-user-check"></i>
                                    </a>
                                    <% } %>
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

<div class="modal fade" id="editModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="HeadController?actionType=updateStaff" method="post">
                <div class="modal-header">
                    <h4 class="modal-title">Edit Mentor</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <!-- Hidden Staff ID -->
                    <input type="hidden" id="editStaffId" name="staffId">

                    <div class="form-group">
                        <label>Name <span class="text-danger">*</span></label>
                        <input type="text" id="editStaffName" name="staffName" class="form-control" 
                               placeholder="Enter Staff Name"
                               onkeydown="if (this.value.length == 0 && event.key === ' ') event.preventDefault();"
                               oninput="this.value = this.value.replace(/[^A-Za-z\s]/g,'').replace(/^\s+/,'');">
                    </div>

                    <div class="form-group">
                        <label>Gender <span class="text-danger">*</span></label>
                        <select id="editGender" name="gender" class="form-control">
                            <option value="">Select Gender</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Email <span class="text-danger">*</span></label>
                        <input type="email" id="editEmail" name="email" class="form-control" 
                               placeholder="Enter Email"
                               onkeydown="if (this.value.length == 0 && event.key === ' ') event.preventDefault();"
                               oninput="this.value = this.value.replace(/\s/g,'');">
                    </div>

                    <div class="form-group">
                        <label>Phone <span class="text-danger">*</span></label>
                        <input type="text" id="editPhone" name="phone" class="form-control" 
                               maxlength="10" placeholder="Enter Phone Number"
                               onkeydown="if (this.value.length == 0 && event.key === ' ') event.preventDefault();"
                               oninput="this.value = this.value.replace(/[^0-9]/g,'');">
                    </div>

                    <div class="form-group">
                        <label>Designation <span class="text-danger">*</span></label>
                        <input type="text" id="editDesignation" name="designation" class="form-control" 
                               placeholder="Enter Designation"
                               onkeydown="if (this.value.length == 0 && event.key === ' ') event.preventDefault();"
                               oninput="this.value = this.value.replace(/[^A-Za-z\s]/g,'').replace(/^\s+/,'');">
                    </div>

                    <div class="form-group">
                        <label>Username <span class="text-danger">*</span></label>
                        <input type="text" id="editUsername" name="username" class="form-control" 
                               placeholder="Enter Username"
                               onkeydown="if (this.value.length == 0 && event.key === ' ') event.preventDefault();"
                               oninput="this.value = this.value.replace(/[^A-Za-z0-9_]/g,'');">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Update
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
    <% if (request.getAttribute("errors") != null) { %>
        $('#editModal').modal('show');
    <% } %>
});
    
    
    $(document).ready(function () {

        $("#dataTable").DataTable({
            responsive: true,
            autoWidth: false
        });

        $(".btnEdit").click(function () {

            $("#editStaffId").val($(this).data("id"));
            $("#editStaffName").val($(this).data("name"));
            $("#editGender").val($(this).data("gender"));
            $("#editEmail").val($(this).data("email"));
            $("#editPhone").val($(this).data("phone"));
            $("#editDesignation").val($(this).data("designation"));
            $("#editUsername").val($(this).data("username"));

        });

    });
</script>