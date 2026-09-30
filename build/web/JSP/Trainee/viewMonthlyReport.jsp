<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="model.MonthlyReport"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="traineeSideMenu.jsp"/>

<%
    ArrayList<MonthlyReport> reportList = (ArrayList<MonthlyReport>) request.getAttribute("reportList");
%>

<div class="content-wrapper">
    <section class="content">
        <div class="container-fluid">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Monthly Reports</h3>
                </div>
                <div class="card-body">
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Month</th>
                                <th>Year</th>
                                <th>Submitted Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (reportList != null && !reportList.isEmpty()) {
                                    int i = 1;
                                    for (MonthlyReport report : reportList) {

                                        // --- CORRECTED LOGIC ---
                                        String monthName = "N/A";
                                        int monthInt = report.getMonth(); // Get as int directly

                                        if (monthInt > 0 && monthInt <= 12) {
                                            try {
                                                java.util.Calendar cal = java.util.Calendar.getInstance();
                                                cal.set(java.util.Calendar.MONTH, monthInt - 1);
                                                monthName = new SimpleDateFormat("MMMM", Locale.ENGLISH).format(cal.getTime());
                                            } catch (Exception e) {
                                                monthName = String.valueOf(monthInt);
                                            }
                                        } else {
                                            monthName = String.valueOf(monthInt);
                                        }

                                        String formattedDate = "N/A";
                                        if (report.getSubmittedDate() != null) {
                                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                                            formattedDate = sdf.format(report.getSubmittedDate());
                                        }
                                        // --- END OF LOGIC ---
                            %>
                            <tr>
                                <td><%=i++%></td> <!-- Only one index column -->
                                <td><%= monthName%></td>
                                <td><%= report.getYear()%></td>
                                <td><%= formattedDate%></td>
                                <td>
                                    <%
                                        if ("PENDING".equals(report.getStatus())) {
                                    %>
                                    <span class="badge badge-warning">Pending</span>
                                    <%
                                    } else if ("APPROVED".equals(report.getStatus())) {
                                    %>
                                    <span class="badge badge-success">Approved</span>
                                    <%
                                    } else {
                                    %>
                                    <span class="badge badge-danger">Rejected</span>
                                    <%
                                        }
                                    %>
                                </td>
                                <td>
                                    <% if("APPROVED".equals(report.getStatus())){ %>
                                        <a href="traineesController?actionType=printMonthlyReport&reportId=<%=report.getReportId()%>"
                                           class="btn btn-success btn-sm">Print PDF</a>
                                    <% } else { %>
                                        <a href="traineesController?actionType=viewSingleMonthlyReport&reportId=<%=report.getReportId()%>"
                                           class="btn btn-primary btn-sm">View</a>
                                    <% } %>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="6" class="text-center">No Monthly Reports Found</td>
                            </tr>
                            <%
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