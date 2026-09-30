<%-- 
    Document   : reassignMentor
    Created on : 09-Jul-2026, 12:00:24 pm
    Author     : Trainee2
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Assignment"%>
<%@page import="model.staffDetails"%>

<%
    ArrayList<Assignment> assignmentList
            = (ArrayList<Assignment>) request.getAttribute("assignmentList");

    ArrayList<staffDetails> staffList
            = (ArrayList<staffDetails>) request.getAttribute("staffList");
%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="headSideMenu.jsp"/>

<div class="content-wrapper">

    <section class="content">

        <div class="card">

            <div class="card-header">

                <h3>Rejected Assignments</h3>

            </div>

            <div class="card-body">

                <table class="table table-bordered">

                    <thead>

                        <tr>

                            <th>Trainee</th>

                            <th>Rejected By</th>

                            <th>Reason</th>

                            <th>Assign New Mentor</th>

                        </tr>

                    </thead>

                    <tbody>

                        <%
                            for (Assignment obj : assignmentList) {
                        %>

                        <tr>

                            <td><%=obj.getObjTrainee().getTraineeName()%></td>

                            <td><%=obj.getObjStaff().getStaffName()%></td>

                            <td><%=obj.getRemarks()%></td>

                            <td>

                                <form action="HeadController" method="post">

                                    <input type="hidden"
                                           name="actionType"
                                           value="reAssignMentor">

                                    <input type="hidden"
                                           name="assignmentId"
                                           value="<%=obj.getAssignmentId()%>">

                                    <input type="hidden"
                                           name="traineeId"
                                           value="<%=obj.getTraineeId()%>">

                                    <select name="staffId"
                                            class="form-control">

                                        <%
                                            for (staffDetails s : staffList) {
                                        %>

                                        <option value="<%=s.getStaffId()%>">

                                            <%=s.getStaffName()%>

                                        </option>

                                        <%
                                            }
                                        %>

                                    </select>

                                    <br>

                                    <button class="btn btn-success">

                                        Assign

                                    </button>

                                </form>

                            </td>

                        </tr>

                        <%
                            }
                        %>

                    </tbody>

                </table>

            </div>

        </div>

    </section>

</div>

