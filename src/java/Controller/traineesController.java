/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.DashboardDAO;
import Dao.HeadDAO;
import Dao.traineeDAO;
import java.io.IOException;
import Util.Db_MySqlUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.MonthlyReport;
import model.TraineeLeave;
import model.staffDetails;
import model.traineeDetails;
import model.trainee_task;
import model.work_log;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import com.itextpdf.layout.borders.SolidBorder;
import com.itextpdf.layout.properties.HorizontalAlignment;
import model.Notification;

/**
 *
 * @author kgaut
 */
@WebServlet(name = "traineesController", urlPatterns = {"/traineesController"})
public class traineesController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        Connection connection = null;
        try {
            connection = Db_MySqlUtil.getConnection();
            String actionType = request.getParameter("actionType");
            String msg = "";
            HttpSession session = request.getSession();
            traineeDAO objtraineeDAO = new traineeDAO();
            HeadDAO objHeadDAO = new HeadDAO();
            DashboardDAO dao = new DashboardDAO();
            String traineeId = session.getAttribute("traineeId").toString();
            if (actionType == null) {
                response.sendRedirect("mylogin.jsp");
                return;
            }
            switch (actionType) {

                case "dashboard" -> {
                    String division = (String) session.getAttribute("division");
                    int taskCount = dao.getTaskCount(connection, traineeId);
                    int logCount = dao.getWorkLogCount(connection, traineeId);
                    int pendingLeaves = dao.getLeaveCountByStatus(connection, traineeId, "PENDING");
                    int approvedLeaves = dao.getLeaveCountByStatus(connection, traineeId, "APPROVED");
                    int rejectedLeaves = dao.getLeaveCountByStatus(connection, traineeId, "REJECTED");
                    int approvedReports = dao.getReportCountByStatus(connection, traineeId, "APPROVED");
                    int rejectedReports = dao.getReportCountByStatus(connection, traineeId, "REJECTED");

                    request.setAttribute("taskCount", taskCount);
                    request.setAttribute("logCount", logCount);
                    request.setAttribute("pendingLeaves", pendingLeaves);
                    request.setAttribute("approvedLeaves", approvedLeaves);
                    request.setAttribute("rejectedLeaves", rejectedLeaves);
                    request.setAttribute("approvedReports", approvedReports);
                    request.setAttribute("rejectedReports", rejectedReports);
                    request.setAttribute("activeMenu", "dashboard");

                    request.getRequestDispatcher("JSP/Trainee/traineeDashboard.jsp").forward(request, response);
                }

                case "viewTasks" -> {
                    ArrayList<trainee_task> arrTaskList = objtraineeDAO.getMyTasks(connection, traineeId);
                    request.setAttribute("arrTaskList", arrTaskList);
                    request.getRequestDispatcher("/JSP/Trainee/myTasks.jsp")
                            .forward(request, response);
                }

                case "updateTaskStatus" -> {
                    int taskId = Integer.parseInt(request.getParameter("taskId"));
                    String newStatus = request.getParameter("status");
                    String newRemarks = request.getParameter("remarks");

                    // 1. Fetch the current state of the task from DB
                    trainee_task existingTask = objtraineeDAO.getTaskById(connection, taskId);

                    if (existingTask == null) {
                        request.setAttribute("msg", "Task not found.");
                        request.getRequestDispatcher("JSP/errorMsg.jsp").forward(request, response);
                        return;
                    }

                    // 2. Determine what changed (using Objects.equals to avoid NullPointerException)
                    StringBuilder msgBuilder = new StringBuilder();
                    boolean statusChanged = !java.util.Objects.equals(newStatus, existingTask.getStatus());
                    boolean remarksChanged = !java.util.Objects.equals(newRemarks, existingTask.getRemarks());

                    if (statusChanged) {
                        msgBuilder.append("Status updated successfully. ");
                    }
                    if (remarksChanged) {
                        msgBuilder.append("Remarks updated successfully. ");
                    }

                    // 3. Perform the update
                    trainee_task objTask = new trainee_task();
                    objTask.setTaskId(taskId);
                    objTask.setStatus(newStatus);
                    objTask.setRemarks(newRemarks);

                    // The DAO returns a String, not a boolean
                    String daoResult = objtraineeDAO.updateTaskStatus(connection, objTask);

                    if (daoResult != null && !daoResult.isEmpty()) {
                        // Handle Notifications only if status actually changed
                        if (statusChanged) {
                            if ("COMPLETED".equalsIgnoreCase(newStatus)) {
                                objHeadDAO.addNotification(connection, existingTask.getStaffId(), "STAFF", "Task Completed", "Trainee " + existingTask.getTraineeId() + " has completed the task: " + existingTask.getTaskTitle());
                            } else if ("IN_PROGRESS".equalsIgnoreCase(newStatus)) {
                                objHeadDAO.addNotification(connection, existingTask.getStaffId(), "STAFF", "Task In Progress", "Trainee " + existingTask.getTraineeId() + " started working on: " + existingTask.getTaskTitle());
                            }
                        }

                        // 4. Store the specific field-level message in the session
                        if (msgBuilder.length() > 0) {
                            request.getSession().setAttribute("successMsg", msgBuilder.toString());
                        } else {
                            request.getSession().setAttribute("successMsg", "No changes were made.");
                        }

                        response.sendRedirect("traineesController?actionType=viewTasks");
                    } else {
                        request.setAttribute("msg", "Task Status Update Failed");
                        request.getRequestDispatcher("JSP/errorMsg.jsp").forward(request, response);
                    }
                }

                case "viewWorkLogs" -> {
                    ArrayList<work_log> arrWorkLogList = objtraineeDAO.getMyWorkLogs(connection, traineeId);
                    request.setAttribute("arrWorkLogList", arrWorkLogList);
                    request.getRequestDispatcher("JSP/Trainee/workLog.jsp")
                            .forward(request, response);
                }

                case "saveWorkLog" -> {
                    String workDate = request.getParameter("workDate");
                    String workTitle = request.getParameter("workTitle");
                    String workDescription = request.getParameter("workDescription");
                    String hoursWorked = request.getParameter("hoursWorked");
                    String staffId = objtraineeDAO.getAssignedStaffId(connection, traineeId);
                    work_log objWorkLog = new work_log();
                    objWorkLog.setTraineeId(traineeId);
                    objWorkLog.setStaffId(staffId);
                    objWorkLog.setWorkDate(workDate);
                    objWorkLog.setWorkTitle(workTitle);
                    objWorkLog.setWorkDescription(workDescription);
                    objWorkLog.setHoursWorked(hoursWorked);
                    objWorkLog.setStatus("PENDING");
                    objWorkLog.setMentorRemarks("");
                    boolean result = objtraineeDAO.saveWorkLog(connection, objWorkLog);
                    if (result) {
                        objHeadDAO.addNotification(connection, staffId, "STAFF", "New Work Log", "A trainee has submitted a new work log for your review.");
                        response.sendRedirect("traineesController?actionType=viewWorkLogs");
                    } else {
                        request.setAttribute("msg", "Work Log Submission Failed");
                        request.getRequestDispatcher("JSP/errorMsg.jsp")
                                .forward(request, response);
                    }
                }

                case "viewLeave" -> {
                    ArrayList<TraineeLeave> arrLeaveList = objtraineeDAO.getMyLeaves(connection, traineeId);
                    request.setAttribute("arrLeaveList", arrLeaveList);
                    int clTaken = objtraineeDAO.getLeaveCountByType(connection, traineeId, "Casual Leave");
                    int sclTaken = objtraineeDAO.getLeaveCountByType(connection, traineeId, "Special Leave");
                    int mlTaken = objtraineeDAO.getLeaveCountByType(connection, traineeId, "Medical Leave");
                    int eolTaken = objtraineeDAO.getLeaveCountByType(connection, traineeId, "EOL");
                    int clEntitlement = 8;
                    int sclEntitlement = 2;
                    int mlEntitlement = 15;
                    int eolEntitlement = 7;

                    int clBalance = Math.max(clEntitlement - clTaken, 0);
                    int sclBalance = Math.max(sclEntitlement - sclTaken, 0);
                    int mlBalance = Math.max(mlEntitlement - mlTaken, 0);
                    int eolBalance = Math.max(eolEntitlement - eolTaken, 0);

                    // Send values to JSP
                    request.setAttribute("clTaken", clTaken);
                    request.setAttribute("sclTaken", sclTaken);
                    request.setAttribute("mlTaken", mlTaken);
                    request.setAttribute("eolTaken", eolTaken);

                    request.setAttribute("clBalance", clBalance);
                    request.setAttribute("sclBalance", sclBalance);
                    request.setAttribute("mlBalance", mlBalance);
                    request.setAttribute("eolBalance", eolBalance);

                    request.getRequestDispatcher("JSP/Trainee/leave.jsp")
                            .forward(request, response);
                }

                case "saveLeave" -> {
                    String[] leaveFrom = request.getParameterValues("leaveFrom[]");
                    String[] leaveTo = request.getParameterValues("leaveTo[]");
                    String[] leaveType = request.getParameterValues("leaveType[]");
                    String[] reasons = request.getParameterValues("reason[]");
                    if (leaveFrom == null || leaveTo == null
                            || leaveType == null || reasons == null
                            || leaveFrom.length == 0
                            || leaveTo.length == 0
                            || leaveType.length == 0
                            || reasons.length == 0) {
                        request.setAttribute("msg", "Please fill all leave details.");
                        request.getRequestDispatcher("JSP/errorMsg.jsp")
                                .forward(request, response);
                        return;
                    }

                    String staffId = objtraineeDAO.getAssignedStaffId(connection, traineeId);
                    boolean result = true;
                    for (int i = 0; i < leaveFrom.length; i++) {
                        int totalDays = objtraineeDAO.calculateLeaveDays(leaveFrom[i], leaveTo[i]);
                        if (totalDays <= 0) {
                            request.setAttribute("msg", "Invalid leave dates in row " + (i + 1));
                            request.getRequestDispatcher("JSP/errorMsg.jsp")
                                    .forward(request, response);
                            return;
                        }

                        TraineeLeave objLeave = new TraineeLeave();

                        objLeave.setTraineeId(traineeId);
                        objLeave.setStaffId(staffId);
                        objLeave.setLeaveFrom(leaveFrom[i]);
                        objLeave.setLeaveTo(leaveTo[i]);
                        objLeave.setTotalDays(totalDays);
                        objLeave.setLeaveType(leaveType[i]);
                        objLeave.setReason(reasons[i]);
                        objLeave.setStatus("PENDING");
                        objLeave.setMentorRemark("");

                        if (!objtraineeDAO.saveLeave(connection, objLeave)) {
                            result = false;
                            break;
                        }
                    }

                    if (result) {

                        if (staffId != null && !staffId.trim().isEmpty()) {

                            objHeadDAO.addNotification(connection, staffId, "STAFF", "New Leave Request", "Trainee " + traineeId + " has submitted a new leave request.");
                        }

                        response.sendRedirect(
                                "traineesController?actionType=viewLeave");

                    } else {

                        request.setAttribute("msg",
                                "Leave Submission Failed.");

                        request.getRequestDispatcher("JSP/errorMsg.jsp")
                                .forward(request, response);
                    }
                }

                case "addLeave" -> {
                    request.getRequestDispatcher(
                            "JSP/Trainee/addLeave.jsp"
                    ).forward(
                            request,
                            response
                    );
                }

                case "updateLeave" -> {
                    String leaveIdParam
                            = request.getParameter("leaveId");

                    if (leaveIdParam == null
                            || leaveIdParam.trim().isEmpty()) {

                        request.setAttribute("msg", "Invalid Leave ID.");

                        request.getRequestDispatcher("JSP/errorMsg.jsp"
                        ).forward(
                                request,
                                response
                        );

                        return;
                    }

                    int leaveId = Integer.parseInt(leaveIdParam);

                    String leaveFrom = request.getParameter("leaveFrom");
                    String leaveTo = request.getParameter("leaveTo");
                    String leaveType = request.getParameter("leaveType");
                    String reason = request.getParameter("reason");
                    int totalDays = objtraineeDAO.calculateLeaveDays(leaveFrom, leaveTo);

                    if (totalDays <= 0) {
                        request.setAttribute("msg", "Invalid leave date range.");
                        request.getRequestDispatcher("JSP/errorMsg.jsp").forward(request, response);

                        return;
                    }
                    TraineeLeave objLeave = new TraineeLeave();
                    objLeave.setLeaveId(leaveId);
                    objLeave.setTraineeId(traineeId);
                    objLeave.setLeaveFrom(leaveFrom);
                    objLeave.setLeaveTo(leaveTo);
                    objLeave.setTotalDays(totalDays);
                    objLeave.setLeaveType(leaveType);
                    objLeave.setReason(reason);

                    boolean result = objtraineeDAO.updateLeave(connection, objLeave);

                    if (result) {

                        response.sendRedirect(
                                "traineesController?actionType=viewLeave"
                        );

                    } else {

                        request.setAttribute("msg", "Leave Update Failed.");

                        request.getRequestDispatcher(
                                "JSP/errorMsg.jsp"
                        ).forward(
                                request,
                                response
                        );
                    }
                }

                case "deleteLeave" -> {
                    String leaveIdParam = request.getParameter("leaveId");
                    if (leaveIdParam == null
                            || leaveIdParam.trim().isEmpty()) {

                        request.setAttribute("msg", "Invalid Leave ID.");

                        request.getRequestDispatcher("JSP/errorMsg.jsp")
                                .forward(request, response);

                        return;
                    }

                    int leaveId = Integer.parseInt(leaveIdParam);

                    boolean result = objtraineeDAO.deleteLeave(connection, leaveId, traineeId);

                    if (result) {
                        response.sendRedirect("traineesController?actionType=viewLeave");

                    } else {

                        request.setAttribute("msg", "Leave Delete Failed.");

                        request.getRequestDispatcher(
                                "JSP/errorMsg.jsp"
                        ).forward(
                                request,
                                response
                        );
                    }
                }

                case "generateMonthlyReport" -> {
                    request.getRequestDispatcher("JSP/Trainee/generateMonthlyReport.jsp")
                            .forward(request, response);

                }

                case "createMonthlyReport" -> {
                    int month = Integer.parseInt(request.getParameter("month"));
                    int year = Integer.parseInt(request.getParameter("year"));
                    traineeDetails trainee = objtraineeDAO.getTraineeDetails(connection, traineeId);
                    staffDetails mentor = objtraineeDAO.getAssignedStaffDetails(connection, traineeId);
                    ArrayList<MonthlyReport> workList = objtraineeDAO.getMonthlyWorkDone(connection, traineeId, month, year);
                    ArrayList<TraineeLeave> leaveList = objtraineeDAO.getMonthlyLeaveDetails(connection, traineeId, month, year);
                    int clTaken = objtraineeDAO.getLeaveCountByType(connection, traineeId, "Casual Leave");
                    int sclTaken = objtraineeDAO.getLeaveCountByType(connection, traineeId, "Special Leave");
                    int mlTaken = objtraineeDAO.getLeaveCountByType(connection, traineeId, "Medical Leave");
                    int eolTaken = objtraineeDAO.getLeaveCountByType(connection, traineeId, "EOL");

                    request.setAttribute("trainee", trainee);
                    request.setAttribute("mentor", mentor);
                    request.setAttribute("workList", workList);
                    request.setAttribute("leaveList", leaveList);
                    request.setAttribute("clTaken", clTaken);
                    request.setAttribute("sclTaken", sclTaken);
                    request.setAttribute("mlTaken", mlTaken);
                    request.setAttribute("eolTaken", eolTaken);
                    request.setAttribute("month", month);
                    request.setAttribute("year", year);
                    request.getRequestDispatcher(
                            "JSP/Trainee/monthlyReportPreview.jsp")
                            .forward(request, response);
                }

                case "saveMonthlyReport" -> {
                    int month = Integer.parseInt(request.getParameter("month"));
                    int year = Integer.parseInt(request.getParameter("year"));
                    String workDone = request.getParameter("workDone");
                    String leaveDetails = request.getParameter("leaveDetails");
                    String staffId = objtraineeDAO.getAssignedStaffId(connection, traineeId);

                    boolean result = objtraineeDAO.saveMonthlyReport(connection, traineeId, staffId, month, year, workDone, leaveDetails);

                    if (result) {

                        objHeadDAO.addNotification(connection, staffId, "STAFF", "Monthly Report", "A new monthly report has been submitted.");

                        response.sendRedirect("traineesController?actionType=viewMonthlyReport");

                    } else {
                        request.setAttribute("msg", "Monthly Report Submission Failed.");
                        request.getRequestDispatcher(
                                "JSP/errorMsg.jsp")
                                .forward(request, response);
                    }
                }

                case "viewMonthlyReport" -> {
                    ArrayList<MonthlyReport> reportList = objtraineeDAO.getMonthlyReports(connection, traineeId);
                    request.setAttribute("reportList", reportList);
                    request.getRequestDispatcher(
                            "JSP/Trainee/viewMonthlyReport.jsp")
                            .forward(request, response);
                }

                case "printMonthlyReport" -> {

                    int reportId = Integer.parseInt(request.getParameter("reportId"));

                    MonthlyReport report = objtraineeDAO.getMonthlyReportById(connection, reportId);

                    if (report == null) {
                        response.sendRedirect("traineesController?actionType=viewMonthlyReport");
                        return;
                    }

                    traineeDetails trainee
                            = objtraineeDAO.getTraineeDetails(connection, report.getTraineeId());

                    staffDetails mentor
                            = objtraineeDAO.getAssignedStaffDetails(connection, report.getTraineeId());

                    ArrayList<TraineeLeave> leaveList
                            = objtraineeDAO.getMonthlyLeaveDetails(
                                    connection,
                                    report.getTraineeId(),
                                    report.getMonth(),
                                    report.getYear());

                    response.setContentType("application/pdf");

                    response.setHeader(
                            "Content-Disposition",
                            "inline; filename=Monthly_Report.pdf");

                    PdfWriter writer = new PdfWriter(response.getOutputStream());

                    PdfDocument pdf = new PdfDocument(writer);

                    Document document = new Document(pdf);
                    Table page = new Table(1);
                    page.setWidth(UnitValue.createPercentValue(100));

                    Cell pageCell = new Cell();
                    pageCell.setBorder(new SolidBorder(1));
                    pageCell.setPadding(15);
                    Paragraph p1 = new Paragraph("GOVERNMENT OF INDIA")
                            .setBold()
                            .setFontSize(16)
                            .setTextAlignment(TextAlignment.CENTER);

                    Paragraph p2 = new Paragraph("Department of Space")
                            .setFontSize(12)
                            .setTextAlignment(TextAlignment.CENTER);

                    Paragraph p3 = new Paragraph("VIKRAM SARABHAI SPACE CENTRE")
                            .setBold()
                            .setFontSize(15)
                            .setTextAlignment(TextAlignment.CENTER);

                    Paragraph p4 = new Paragraph("THIRUVANANTHAPURAM - 695022")
                            .setFontSize(12)
                            .setTextAlignment(TextAlignment.CENTER);

                    Paragraph p5 = new Paragraph(
                            "MONTHLY TRAINEE REPORT\n("
                            + report.getMonth() + " / " + report.getYear() + ")")
                            .setBold()
                            .setFontSize(14)
                            .setTextAlignment(TextAlignment.CENTER);

                    pageCell.add(p1);
                    pageCell.add(p2);
                    pageCell.add(p3);
                    pageCell.add(p4);
                    pageCell.add(new Paragraph(""));
                    pageCell.add(p5);
                    pageCell.add(new Paragraph(""));

                    Table info = new Table(UnitValue.createPercentArray(new float[]{3, 7}))
                            .useAllAvailableWidth();

                    info.addCell(new Cell().add(new Paragraph("Name of Trainee").setBold()));
                    info.addCell(new Cell().add(new Paragraph(trainee.getTraineeName())));

                    info.addCell(new Cell().add(new Paragraph("Trainee No.").setBold()));
                    info.addCell(new Cell().add(new Paragraph(trainee.getTraineeId())));

                    info.addCell(new Cell().add(new Paragraph("Branch").setBold()));
                    info.addCell(new Cell().add(new Paragraph(
                            trainee.getObjDesignationitems().getDesignation())));

                    info.addCell(new Cell().add(new Paragraph("Division").setBold()));
                    info.addCell(new Cell().add(new Paragraph(
                            trainee.getDivision())));

                    pageCell.add(info);
                    pageCell.add(new Paragraph(""));
                    pageCell.add(
                            new Paragraph("1. WORK DONE BY THE TRAINEE")
                                    .setBold()
                                    .setFontSize(13)
                                    .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                                    .setPadding(5)
                    );

                    pageCell.add(new Paragraph(""));

                    String workDone = report.getWorkDone();

                    if (workDone != null && !workDone.trim().isEmpty()) {

                        String[] works = workDone.split("\\r?\\n");

                        int i = 1;

                        for (String work : works) {

                            if (!work.trim().isEmpty()) {

                                pageCell.add(
                                        new Paragraph(i + ". " + work)
                                                .setFontSize(11)
                                );

                                i++;
                            }
                        }

                    } else {

                        pageCell.add(
                                new Paragraph("No work details available.")
                                        .setItalic()
                        );

                    }

                    pageCell.add(new Paragraph(""));

                    //=================== PROGRESS ===================
                    pageCell.add(
                            new Paragraph("2. Aptitude for training")
                                    .setBold()
                                    .setFontSize(13)
                                    .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                                    .setPadding(5)
                    );

                    String progress = report.getProgress() == null ? "" : report.getProgress();

                    pageCell.add(new Paragraph(
                            (progress.equalsIgnoreCase("Excellent") ? "☑" : "☐")
                            + " Excellent"));

                    pageCell.add(new Paragraph(
                            (progress.equalsIgnoreCase("Very Good") ? "☑" : "☐")
                            + " Very Good"));

                    pageCell.add(new Paragraph(
                            (progress.equalsIgnoreCase("Good") ? "☑" : "☐")
                            + " Good"));

                    pageCell.add(new Paragraph(
                            (progress.equalsIgnoreCase("Fair") ? "☑" : "☐")
                            + " Fair"));

                    pageCell.add(new Paragraph(""));

                    //=================== CONDUCT ===================
                    //=================== CONDUCT ===================
                    pageCell.add(
                            new Paragraph("3. CONDUCT")
                                    .setBold()
                                    .setFontSize(13)
                                    .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                                    .setPadding(5)
                    );

                    String conduct = report.getConduct() == null ? "" : report.getConduct();

                    pageCell.add(new Paragraph(
                            (conduct.equalsIgnoreCase("Very Good") ? "☑" : "☐")
                            + " Very Good"));

                    pageCell.add(new Paragraph(
                            (conduct.equalsIgnoreCase("Good") ? "☑" : "☐")
                            + " Good"));

                    pageCell.add(new Paragraph(
                            (conduct.equalsIgnoreCase("Fair") ? "☑" : "☐")
                            + " Fair"));

                    pageCell.add(new Paragraph(""));

                    //=================== ASSESSMENT ===================
                    //=================== ASSESSMENT ===================
                    pageCell.add(
                            new Paragraph("4. ASSESSMENT")
                                    .setBold()
                                    .setFontSize(13)
                                    .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                                    .setPadding(5)
                    );

                    String assessment = report.getAssessment() == null ? "" : report.getAssessment();

                    pageCell.add(new Paragraph(
                            (assessment.equalsIgnoreCase("Excellent") ? "☑" : "☐")
                            + " Excellent"));

                    pageCell.add(new Paragraph(
                            (assessment.equalsIgnoreCase("Some Scope for Improvement") ? "☑" : "☐")
                            + " Some Scope for Improvement"));

                    pageCell.add(new Paragraph(
                            (assessment.equalsIgnoreCase("Lot of Scope for Improvement") ? "☑" : "☐")
                            + " Lot of Scope for Improvement"));

                    pageCell.add(new Paragraph(""));

                    //=================== LEAVE DETAILS ===================
                    //=================== LEAVE DETAILS ===================
                    pageCell.add(
                            new Paragraph("5. LEAVE DETAILS")
                                    .setBold()
                                    .setFontSize(13)
                                    .setBackgroundColor(ColorConstants.LIGHT_GRAY)
                                    .setPadding(5)
                    );

                    Table leaveTable = new Table(UnitValue.createPercentArray(new float[]{2, 2, 2, 1.5f, 4}))
                            .useAllAvailableWidth();

                    leaveTable.addHeaderCell(new Cell().add(new Paragraph("From").setBold()));
                    leaveTable.addHeaderCell(new Cell().add(new Paragraph("To").setBold()));
                    leaveTable.addHeaderCell(new Cell().add(new Paragraph("Leave Type").setBold()));
                    leaveTable.addHeaderCell(new Cell().add(new Paragraph("Days").setBold()));
                    leaveTable.addHeaderCell(new Cell().add(new Paragraph("Reason").setBold()));

                    if (leaveList != null && !leaveList.isEmpty()) {

                        for (TraineeLeave leave : leaveList) {

                            leaveTable.addCell(new Cell().add(
                                    new Paragraph(String.valueOf(leave.getLeaveFrom() == null ? "" : leave.getLeaveFrom()))));

                            leaveTable.addCell(new Cell().add(
                                    new Paragraph(String.valueOf(leave.getLeaveTo() == null ? "" : leave.getLeaveTo()))));

                            leaveTable.addCell(new Cell().add(
                                    new Paragraph(String.valueOf(leave.getLeaveType() == null ? "" : leave.getLeaveType()))));

                            leaveTable.addCell(new Cell().add(
                                    new Paragraph(String.valueOf(leave.getTotalDays()))));

                            leaveTable.addCell(new Cell().add(
                                    new Paragraph(String.valueOf(leave.getReason() == null ? "" : leave.getReason()))));
                        }

                    } else {

                        leaveTable.addCell(
                                new Cell(1, 5)
                                        .add(new Paragraph("No Leave Taken"))
                                        .setTextAlignment(TextAlignment.CENTER)
                        );
                    }

                    pageCell.add(leaveTable);
                    pageCell.add(new Paragraph(""));

                    pageCell.add(new Paragraph(
                            report.getHeadRemark() == null
                            ? ""
                            : report.getHeadRemark()));

                    pageCell.add(new Paragraph(""));

                    Table signTable = new Table(UnitValue.createPercentArray(new float[]{1, 1}))
                            .useAllAvailableWidth();

                    Cell left = new Cell();

                    left.setBorder(null);

                    left.add(new Paragraph("Date : __________________"));

                    left.add(new Paragraph("\n"));

                    left.add(new Paragraph("Place : __________________"));

                    signTable.addCell(left);

                    Cell right = new Cell();

                    right.setBorder(null);

                    right.add(new Paragraph("Supervisor / Mentor")
                            .setBold());

                    right.add(new Paragraph("\n\n"));

                    right.add(new Paragraph("Signature : __________________"));

                    right.add(new Paragraph("Name : "
                            + (mentor != null ? mentor.getStaffName() : "")));

                    right.add(new Paragraph("Designation : "
                            + (mentor != null ? mentor.getDesignation() : "")));

                    signTable.addCell(right);

                    pageCell.add(signTable);

                    pageCell.add(new Paragraph(""));

                    Paragraph admin = new Paragraph(
                            "Administrative Officer\nCSS")
                            .setBold()
                            .setTextAlignment(TextAlignment.RIGHT);

                    pageCell.add(admin);

                    page.addCell(pageCell);
                    document.add(page);

                    document.close();
                    return;

                }

            }

        } catch (IOException e) {
            throw e;
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                throw e;
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(traineesController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(traineesController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(traineesController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(traineesController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
