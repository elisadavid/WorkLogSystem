<%@page import="model.TraineeLeave"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.MonthlyReport"%>
<%@page import="model.traineeDetails"%>
<%-- Added imports for date formatting --%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<jsp:include page="../../header.jsp"/>
<jsp:include page="traineeSideMenu.jsp"/>
<%
    // Helper method to format date from yyyy-MM-dd to dd-MM-yyyy
    // We define this as a local function logic inside the scriptlet
    
    traineeDetails trainee
            = (traineeDetails) request.getAttribute("trainee");
    ArrayList<MonthlyReport> workList
            = (ArrayList<MonthlyReport>) request.getAttribute("workList");
    ArrayList<TraineeLeave> leaveList
            = (ArrayList<TraineeLeave>) request.getAttribute("leaveList");
    int month = (Integer) request.getAttribute("month");
    int year = (Integer) request.getAttribute("year");
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
    if (eolTaken == null)
        eolTaken = 0;
%>
<div class="content-wrapper">
    <section class="content">
        <div class="container-fluid">
            <div class="card">
                <div class="card-body">
                    <center>
                        <h4><b>GOVERNMENT OF INDIA</b></h4>
                        <h5>Department of Space</h5>
                        <h5>VIKRAM SARABHAI SPACE CENTRE</h5>
                        <h4><b>MONTHLY TRAINEE REPORT</b></h4>
                    </center>
                    <hr>
                    <table class="table table-bordered">
                        <%
                            // 1. Convert the month number to a name
                            String monthName = "N/A";

                            // Assuming 'month' is an integer variable available in your JSP
                            int monthInt = Integer.parseInt(String.valueOf(month));

                            if (monthInt > 0 && monthInt <= 12) {
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

<tr>
    <th width="25%">Month</th>
    <td><%= monthName %> <%= year %></td>
</tr>
                        
                        
                        <tr>
                            <th>Name</th>
                            <td><%=trainee.getTraineeName()%></td>
                        </tr>
                        <tr>
                            <th>Trainee No</th>
                            <td><%=trainee.getTraineeId()%></td>
                        </tr>
                        <tr>
                            <th>Branch</th>
                            <td><%=trainee.getObjDesignationitems().getDesignation()%></td>
                        </tr>
                        <tr>
                            <th>Division</th>
                            <td><%=trainee.getDivision()%></td>
                        </tr>
                    </table>
                    <br>
                    <h5><b>5. Work done by the Trainee</b></h5>
                    <textarea class="form-control"
                              name="workDone"
                              rows="8"
                              readonly
                              style="resize:none;background:white;"><%
                                  if (workList != null) {
                                      int i = 1;
                                      for (MonthlyReport report : workList) {
                        %><%=i++%>. <%=report.getWorkDescription()%>
                        <%
                                }
                            }
                        %></textarea>
                    <br>
                    <%
                        String clFrom = "-", clTo = "-";
                        String sclFrom = "-", sclTo = "-";
                        String mlFrom = "-", mlTo = "-";
                        String eolFrom = "-", eolTo = "-";
                        int clDays = 0;
                        int sclDays = 0;
                        int mlDays = 0;
                        int eolDays = 0;

                        // Date Formatters
                        SimpleDateFormat inFmt = new SimpleDateFormat("yyyy-MM-dd");
                        SimpleDateFormat outFmt = new SimpleDateFormat("dd-MM-yyyy");

                        if (leaveList != null) {
                            for (TraineeLeave leave : leaveList) {
                                // Logic to format date if it's not null
                                String fDate = leave.getLeaveFrom();
                                String tDate = leave.getLeaveTo();
                                
                                String formattedFrom = "-";
                                String formattedTo = "-";
                                
                                try {
                                    if(fDate != null && !fDate.equals("-")) 
                                        formattedFrom = outFmt.format(inFmt.parse(fDate));
                                    if(tDate != null && !tDate.equals("-")) 
                                        formattedTo = outFmt.format(inFmt.parse(tDate));
                                } catch(Exception e) {
                                    formattedFrom = fDate;
                                    formattedTo = tDate;
                                }

                                if ("Casual Leave".equalsIgnoreCase(leave.getLeaveType())) {
                                    clFrom = formattedFrom;
                                    clTo = formattedTo;
                                    clDays = leave.getTotalDays();
                                } else if ("Special Leave".equalsIgnoreCase(leave.getLeaveType())) {
                                    sclFrom = formattedFrom;
                                    sclTo = formattedTo;
                                    sclDays = leave.getTotalDays();
                                } else if ("Medical Leave".equalsIgnoreCase(leave.getLeaveType())) {
                                    mlFrom = formattedFrom;
                                    mlTo = formattedTo;
                                    mlDays = leave.getTotalDays();
                                } else if ("EOL".equalsIgnoreCase(leave.getLeaveType())) {
                                    eolFrom = formattedFrom;
                                    eolTo = formattedTo;
                                    eolDays = leave.getTotalDays();
                                }
                            }
                        }
                    %>
                    <h5><b>9. Leave Details</b></h5>
                    <table class="table table-bordered text-center">
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
                    <br>
                    <form action="traineesController" method="post">
                        <input type="hidden" name="actionType" value="saveMonthlyReport"/>
                        <input type="hidden" name="month" value="<%=month%>"/>
                        <input type="hidden" name="year" value="<%=year%>"/>
                        <input type="hidden" name="workDone"
                               value="<%
                                   if (workList != null) {
                                       for (MonthlyReport report : workList) {
                                           out.print(report.getWorkDescription().replace("\"", "&quot;") + " ");
                                       }
                                   }
                               %>"/>
                        <input type="hidden"
                               name="leaveDetails"
                               value="CL:<%=clTaken%>, SCL:<%=sclTaken%>, ML:<%=mlTaken%>, EOL:<%=eolTaken%>"/>
                        <center>
                            <button type="submit" class="btn btn-success">
                                Submit To Mentor
                            </button>
                        </center>
                    </form>
                </div>
            </div>
        </div>
    </section>
</div>
<jsp:include page="../../footer.jsp"/>