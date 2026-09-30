<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.TraineeLeave"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.MonthlyReport"%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="staffSideMenu.jsp"/>

<%
    MonthlyReport report
            = (MonthlyReport) request.getAttribute("report");
    ArrayList<TraineeLeave> leaveList
            = (ArrayList<TraineeLeave>) request.getAttribute("leaveList");
    Integer clTaken = (Integer) request.getAttribute("clTaken");
    Integer sclTaken = (Integer) request.getAttribute("sclTaken");
    Integer mlTaken = (Integer) request.getAttribute("mlTaken");
    Integer eolTaken = (Integer) request.getAttribute("eolTaken");

    if (clTaken == null) {
        clTaken = 0;
    }
    if (sclTaken == null) {
        sclTaken = 0;
    }
    if (mlTaken == null) {
        mlTaken = 0;
    }
    if (eolTaken == null) {
        eolTaken = 0;
    }

    String clFrom = "-", clTo = "-";
    String sclFrom = "-", sclTo = "-";
    String mlFrom = "-", mlTo = "-";
    String eolFrom = "-", eolTo = "-";

    int clDays = 0;
    int sclDays = 0;
    int mlDays = 0;
    int eolDays = 0;

    SimpleDateFormat inFmt = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat outFmt = new SimpleDateFormat("dd-MM-yyyy");

    if (leaveList != null) {

        for (TraineeLeave leave : leaveList) {

            String from = "-";
            String to = "-";

            try {

                if (leave.getLeaveFrom() != null) {
                    from = outFmt.format(inFmt.parse(leave.getLeaveFrom()));
                }

                if (leave.getLeaveTo() != null) {
                    to = outFmt.format(inFmt.parse(leave.getLeaveTo()));
                }

            } catch (Exception e) {
            }

            if ("Casual Leave".equalsIgnoreCase(leave.getLeaveType())) {

                clFrom = from;
                clTo = to;
                clDays = leave.getTotalDays();

            } else if ("Special Leave".equalsIgnoreCase(leave.getLeaveType())) {

                sclFrom = from;
                sclTo = to;
                sclDays = leave.getTotalDays();

            } else if ("Medical Leave".equalsIgnoreCase(leave.getLeaveType())) {

                mlFrom = from;
                mlTo = to;
                mlDays = leave.getTotalDays();

            } else if ("EOL".equalsIgnoreCase(leave.getLeaveType())) {

                eolFrom = from;
                eolTo = to;
                eolDays = leave.getTotalDays();

            }
        }
    }
%>

<div class="content-wrapper">

    <section class="content-header">
        <div class="container-fluid">
            <h3>Review Monthly Report</h3>
        </div>
    </section>

    <section class="content">

        <div class="container-fluid">

            <div class="card card-primary">

                <div class="card-header">
                    <h3 class="card-title">Monthly Report Review</h3>
                </div>

                <form action="staffController" method="post">

                    <input type="hidden" name="actionType" value="approveMonthlyReport">
                    <input type="hidden" name="reportId" value="<%=report.getReportId()%>">

                    <div class="card-body">

                        <div class="row">

                            <div class="col-md-4">
                                <label>Trainee ID</label>
                                <input type="text" class="form-control"
                                       value="<%=report.getTraineeId()%>" readonly>
                            </div>

                            <%
                                // --- MONTH NAME LOGIC ---
                                String monthName = "N/A";
                                int monthInt = report.getMonth();

                                if (monthInt >= 1 && monthInt <= 12) {
                                    try {
                                        java.util.Calendar cal = java.util.Calendar.getInstance();
                                        cal.set(java.util.Calendar.MONTH, monthInt - 1);
                                        monthName = new java.text.SimpleDateFormat("MMMM", java.util.Locale.ENGLISH).format(cal.getTime());
                                    } catch (Exception e) {
                                        monthName = String.valueOf(monthInt);
                                    }
                                } else {
                                    monthName = String.valueOf(monthInt);
                                }
                            %>

                            <div class="col-md-4">
                                <label>Month</label>
                                <input type="text" class="form-control" 
                                       value="<%= monthName%>" readonly>
                            </div>

                            <div class="col-md-4">
                                <label>Year</label>
                                <input type="text" class="form-control"
                                       value="<%=report.getYear()%>" readonly>
                            </div>

                        </div>

                        <br>

                        <div class="form-group">
                            <label>Work Done</label>
                            <textarea class="form-control"
                                      rows="10"
                                      readonly><%=report.getWorkDone()%></textarea>
                        </div>

                        <div class="form-group">
                            <h5><b>9. Leave Details</b></h5>

                            <table class="table table-bordered table-striped text-center">

                                <tr>
                                    <th rowspan="2">Eligible Leave</th>
                                    <th colspan="2">Leave Availed During the Month</th>
                                    <th rowspan="2">No. of Days</th>
                                    <th rowspan="2">No. of Leaves Availed Till Last Month</th>
                                    <th rowspan="2">Balance</th>
                                </tr>

                                <tr>
                                    <th>From</th>
                                    <th>To</th>
                                </tr>

                                <tr>
                                    <td>Casual Leave (08 Days)</td>
                                    <td><%=clFrom%></td>
                                    <td><%=clTo%></td>
                                    <td><%=clDays%></td>
                                    <td><%=clTaken%></td>
                                    <td><%=8 - clTaken%></td>
                                </tr>

                                <tr>
                                    <td>Special CL (02 Days)</td>
                                    <td><%=sclFrom%></td>
                                    <td><%=sclTo%></td>
                                    <td><%=sclDays%></td>
                                    <td><%=sclTaken%></td>
                                    <td><%=2 - sclTaken%></td>
                                </tr>

                                <tr>
                                    <td>Medical Leave (15 Days)</td>
                                    <td><%=mlFrom%></td>
                                    <td><%=mlTo%></td>
                                    <td><%=mlDays%></td>
                                    <td><%=mlTaken%></td>
                                    <td><%=15 - mlTaken%></td>
                                </tr>

                                <tr>
                                    <td>EOL (07 Days)</td>
                                    <td><%=eolFrom%></td>
                                    <td><%=eolTo%></td>
                                    <td><%=eolDays%></td>
                                    <td><%=eolTaken%></td>
                                    <td><%=7 - eolTaken%></td>
                                </tr>

                            </table>
                        </div>

                        <hr>

                        <hr>

                        <h5><b>6. Progress</b></h5>

                        <div class="form-group">
                            <label>a) Aptitude for Training</label><br>

                            <input type="radio" name="aptitude" value="Excellent" required> Excellent
                            <input type="radio" name="aptitude" value="Very Good"> Very Good
                            <input type="radio" name="aptitude" value="Good"> Good
                            <input type="radio" name="aptitude" value="Fair"> Fair
                        </div>

                        <div class="form-group">
                            <label>b) Performance</label><br>

                            <input type="radio" name="performance" value="Excellent" required> Excellent
                            <input type="radio" name="performance" value="Very Good"> Very Good
                            <input type="radio" name="performance" value="Good"> Good
                            <input type="radio" name="performance" value="Fair"> Fair
                        </div>

                        <div class="form-group">
                            <label>c) Shortcomings, if any</label>

                            <textarea name="shortcomings"
                                      class="form-control"
                                      rows="3"></textarea>
                        </div>

                        <div class="form-group">
                            <label>d) Reaction of Trainee to Corrective Action</label><br>

                            <input type="radio" name="reaction" value="Positive" required> Positive
                            <input type="radio" name="reaction" value="Negative"> Negative
                        </div>

                        <hr>

                        <h5><b>7. Conduct</b></h5>

                        <div class="form-group">

                            <input type="radio" name="conduct" value="Very Good" required> Very Good
                            <input type="radio" name="conduct" value="Good"> Good
                            <input type="radio" name="conduct" value="Fair"> Fair

                        </div>

                        <hr>

                        <h5><b>8. Assessment</b></h5>

                        <div class="form-group">

                            <table class="table table-bordered text-center">

                                <tr>

                                    <td>
                                        <input type="radio"
                                               name="assessment"
                                               value="Excellent"
                                               required>
                                        Excellent
                                    </td>

                                    <td>
                                        <input type="radio"
                                               name="assessment"
                                               value="Some Scope for Improvements">

                                        Some Scope for Improvements
                                    </td>

                                    <td>
                                        <input type="radio"
                                               name="assessment"
                                               value="Lot of Scope for Improvement">

                                        Lot of Scope for Improvement
                                    </td>

                                </tr>

                            </table>

                        </div>

                        <hr>

                        <div class="form-group">

                            <label>Staff Remark</label>

                            <textarea name="staffRemark"
                                      class="form-control"
                                      rows="4"></textarea>

                        </div>



                    </div>

                    <div class="card-footer">

                        <button type="submit"
                                name="status"
                                value="APPROVED"
                                class="btn btn-success">
                            <i class="fas fa-check"></i>
                            Approve
                        </button>

                        <button type="submit"
                                name="status"
                                value="REJECTED"
                                class="btn btn-danger">
                            <i class="fas fa-times"></i>
                            Reject
                        </button>

                        <a href="staffController?actionType=viewPendingMonthlyReports"
                           class="btn btn-secondary">
                            Back
                        </a>

                    </div>

                </form>

            </div>

        </div>

    </section>

</div>

<jsp:include page="../../footer.jsp"/> 