<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.MonthlyReport"%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="staffSideMenu.jsp"/>

<%
    ArrayList<MonthlyReport> reportList
            = (ArrayList<MonthlyReport>) request.getAttribute("reportList");
%>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h3>Monthly Report Approval</h3>
                </div>
            </div>
        </div>
    </section>

    <section class="content">

        <div class="container-fluid">

            <div class="card">

                <div class="card-header">
                    <h3 class="card-title">Pending Monthly Reports</h3>
                </div>

                <div class="card-body">

                    <table id="example1" class="table table-bordered table-striped">

                        <thead>

                            <tr>
                                <th>Sl.No</th>
                                <th>Report ID</th>
                                <th>Trainee ID</th>
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

                            %>


                            <tr>

                                <td><%=i++%></td>

                                <td>
                                    <%=report.getReportId()%>
                                </td>

                                <td>
                                    <%=report.getTraineeId()%>
                                </td>

                                <td><%= monthName%></td>
                                <td><%= report.getYear()%></td>
                                <td><%= formattedDate%></td>

                                <td>

                                    <span class="badge badge-warning">
                                        <%=report.getStatus()%>
                                    </span>

                                </td>

                                <td>

                                    <a href="staffController?actionType=viewMonthlyReport&reportId=<%=report.getReportId()%>"
                                       class="btn btn-primary btn-sm">

                                        <i class="fas fa-eye"></i>

                                        Review

                                    </a>

                                </td>

                            </tr>

                            <%
                                }

                            } else {
                            %>

                            <tr>

                                <td colspan="8" class="text-center text-danger">

                                    No Pending Monthly Reports

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

    </section>

</div>

<jsp:include page="../../footer.jsp"/>