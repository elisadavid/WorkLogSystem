<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.TraineeLeave"%>
<jsp:include page="../../header.jsp"/>
<jsp:include page="staffSideMenu.jsp"/>

<%
    // Define formats once at the top to avoid errors and repetition
    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy");
%>

<div class="content-wrapper">
    <section class="content">
        <div class="container-fluid">
            <div class="card mt-3">
                <div class="card-header bg-primary">
                    <h3 class="card-title">Leave Approval</h3>
                </div>
                <div class="card-body">
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Trainee ID</th>
                                <th>Trainee Name</th>
                                <th>From</th>
                                <th>To</th>
                                <th>Days</th>
                                <th>Leave Type</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Remark</th>
                                <th>View</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ArrayList<TraineeLeave> leaveList = (ArrayList<TraineeLeave>) request.getAttribute("leaveList");
                                if (leaveList != null && !leaveList.isEmpty()) {
                                    for (TraineeLeave obj : leaveList) {
                            %>
                            <tr>
                        <form action="staffController" method="post">
                            <input type="hidden" name="leaveId" value="<%=obj.getLeaveId()%>">

                            <td><%=obj.getTraineeId()%></td>
                            <td><%=obj.getTraineeDetails().getTraineeName()%></td>

                            <!-- FORMATTED FROM DATE -->
                            <td>
                                <%
                                    String from = obj.getLeaveFrom();
                                    if (from != null) {
                                        try {
                                            out.print(outputFormat.format(inputFormat.parse(from)));
                                        } catch (Exception e) {
                                            out.print(from);
                                        }
                                    }
                                %>
                            </td>

                            <!-- FORMATTED TO DATE -->
                            <td>
                                <%
                                    String to = obj.getLeaveTo();
                                    if (to != null) {
                                        try {
                                            out.print(outputFormat.format(inputFormat.parse(to)));
                                        } catch (Exception e) {
                                            out.print(to);
                                        }
                                    }
                                %>
                            </td>

                            <td><%=obj.getTotalDays()%></td>
                            <td><%=obj.getLeaveType()%></td>
                            <td><%=obj.getReason()%></td>
                            <td><%=obj.getStatus()%></td>
                            <td>
                                <textarea name="mentorRemark" class="form-control" rows="2"><%=obj.getMentorRemark() == null ? "" : obj.getMentorRemark()%></textarea>
                            </td>
                            <td>
                                <button type="button" class="btn btn-info btn-sm" onclick="viewLeaveBalance('<%=obj.getTraineeId()%>')">
                                    <i class="fa fa-eye"></i>
                                </button>
                            </td>
                            <td>
                                <% if ("PENDING".equalsIgnoreCase(obj.getStatus())) { %>
                                <button type="submit" name="actionType" value="approveLeave" class="btn btn-success btn-sm">Approve</button>
                                <button type="submit" name="actionType" value="rejectLeave" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');">Reject</button>
                                <% } else { %>
                                <span class="badge badge-secondary">Completed</span>
                                <% } %>
                            </td>
                        </form>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="11" class="text-center">No Leave Requests Found</td>
                        </tr>
                        <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>
</div>
<jsp:include page="../../footer.jsp"/>
<!-- Modal and Script remain the same as your original code -->