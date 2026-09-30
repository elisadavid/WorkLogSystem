/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.DashboardDAO;
import Dao.HeadDAO;
import Dao.staffDAO;
import Util.Db_MySqlUtil;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.MonthlyReport;
import model.TraineeLeave;
import model.errorvalidate;
import model.traineeDetails;
import model.trainee_task;
import model.work_log;

/**
 *
 * @author Trainee2
 */
@WebServlet(name = "staffController", urlPatterns = {"/staffController"})
public class staffController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        Connection connection = null;
        try {
            connection = Db_MySqlUtil.getConnection();
            String actionType = request.getParameter("actionType");
            HeadDAO objHeadDAO = new HeadDAO();
            HttpSession session = request.getSession();
            staffDAO objStaffDAO = new staffDAO();
             DashboardDAO dao = new DashboardDAO();
            String staffId = (String) session.getAttribute("staffId");
            if (actionType == null) {
                response.sendRedirect("mylogin.jsp");
                return;
            }
            switch (actionType) {
//                case "dashboard" -> {
//                    RequestDispatcher rd = request.getRequestDispatcher("JSP/Staff/staffDashboard.jsp");
//                    rd.forward(request, response);
//                }
                
               case "dashboard" -> {
    // 1. Fetch counts from DAO
    int totalTrainees = dao.getTraineeCount(connection, staffId);
    int pendingLogs = dao.getPendingWorkLogsCount(connection, staffId);
    int pendingLeaves = dao.getPendingLeavesCount(connection, staffId);
    int pendingReports = dao.getPendingReportsCount(connection, staffId);
      int rejectedLeaves = dao.getRejectedLeavesCount(connection, staffId);
    // 2. Fetch unread notifications (using HeadDAO or NotificationDAO)
    int unreadCount = objHeadDAO.getUnreadNotificationsCount(connection, staffId);

    // 3. Set attributes for JSP
    request.setAttribute("totalTrainees", totalTrainees);
    request.setAttribute("pendingWorkLogs", pendingLogs);
    request.setAttribute("pendingLeaves", pendingLeaves);
    request.setAttribute("pendingReports", pendingReports);
    request.setAttribute("unreadCount", unreadCount);
     request.setAttribute("rejectedLeaves", rejectedLeaves); 

    RequestDispatcher rd = request.getRequestDispatcher("JSP/Staff/staffDashboard.jsp");
    rd.forward(request, response);
}

                case "viewTrainees" -> {

                    ArrayList<traineeDetails> arrTraineeList = objStaffDAO.getAssignedTrainees(connection, staffId);
                    request.setAttribute("arrtraineelist", arrTraineeList);
                    RequestDispatcher rd = request.getRequestDispatcher("JSP/Staff/viewTraineeStaff.jsp");
                    rd.forward(request, response);
                }

                case "acceptTrainees" -> {
                    String traineeId = request.getParameter("traineeId");
                    if (objStaffDAO.acceptTrainees(connection, traineeId)) {
                        response.sendRedirect("staffController?actionType=viewTrainees&msg=accepted");

                    } else {
                        response.sendRedirect("staffController?actionType=viewTrainees&msg=failed");

                    }
                }

                case "rejectTrainee" -> { // Changed from rejectAssignment to match JSP actionType
                    String traineeId = request.getParameter("traineeId");
                    String remarks = request.getParameter("reason"); // Matches the 'name="reason"' in the modal

                    if (objStaffDAO.rejectAssignment(connection, traineeId, remarks)) {
                        response.sendRedirect("staffController?actionType=viewTrainees&msg=rejected");
                    } else {
                        response.sendRedirect("staffController?actionType=viewTrainees&msg=failed");
                    }
                }

                case "activeDeactive" -> {

                    String traineeId = request.getParameter("traineeId");
                    String active = request.getParameter("active");

                    boolean result = objStaffDAO.activeDeactive(connection, traineeId, active);

                    if (result) {

                        response.sendRedirect(
                                "staffController?actionType=viewTrainees&msg=updated");

                    } else {

                        response.sendRedirect(
                                "staffController?actionType=viewTrainees&msg=failed");
                    }

                }

                case "saveTraineeLogin" -> {
                    String traineeId = request.getParameter("traineeId");
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    objStaffDAO.saveTraineeLogin(connection, traineeId, username, password);
                    response.sendRedirect("staffController?actionType=viewTrainees");
                }

                case "resetTraineePassword" -> {
                    String traineeId = request.getParameter("traineeId");
                    String password = request.getParameter("password");
                    String confirmPassword = request.getParameter("confirmPassword");
                    if (!password.equals(confirmPassword)) {
                        session.setAttribute("msg", "Password and Confirm Password do not match.");
                        response.sendRedirect("HeadController?actionType=viewTrainee");
                        return;
                    }
                    objStaffDAO.resetTraineePassword(connection, traineeId, password);
                    response.sendRedirect("staffController?actionType=viewTrainees");
                }

                case "updateTrainingStatus" -> {

                    String traineeId = request.getParameter("traineeId");
                    String completionStatus = request.getParameter("trainingStatus");
                    String reason = request.getParameter("reason");

                    // Reason is mandatory for INCOMPLETE
                    if ("INCOMPLETE".equalsIgnoreCase(completionStatus)
                            && (reason == null || reason.trim().isEmpty())) {

                        response.sendRedirect(
                                "staffController?actionType=viewTrainees&msg=reasonRequired");
                        return;
                    }

                    boolean result = objStaffDAO.deactivateTrainee(connection, traineeId, completionStatus, reason);
                    if (result) {
                        response.sendRedirect(
                                "staffController?actionType=viewTrainees&msg=deactivated");
                    } else {
                        response.sendRedirect(
                                "staffController?actionType=viewTrainees&msg=failed");
                    }
                }

                case "changePasswordPage" -> {
                    request.getRequestDispatcher("JSP/Staff/changePassword.jsp")
                            .forward(request, response);
                }

                case "changePassword" -> {

    validationController validation = new validationController();

    List<errorvalidate> errorList =
            validation.validateChangePassword(request);

    if (!errorList.isEmpty()) {

        request.setAttribute("ErrorList", errorList);

        request.getRequestDispatcher(
                "JSP/Staff/changePassword.jsp")
                .forward(request, response);

        return;
    }

    String username = (String) session.getAttribute("username");

    if (username == null) {

        request.setAttribute("msg",
                "Session Expired. Please Login Again.");

        request.getRequestDispatcher("mylogin.jsp")
                .forward(request, response);

        return;
    }

    boolean status = objStaffDAO.changePassword(
            connection,
            username,
            request.getParameter("oldPassword"),
            request.getParameter("newPassword"));

    if (status) {

        request.setAttribute("msg",
                "Password Updated Successfully.");

    } else {

        request.setAttribute("msg",
                "Current Password is Incorrect.");
    }

    request.getRequestDispatcher(
            "JSP/Staff/changePassword.jsp")
            .forward(request, response);
}
                case "viewAssignTasks" -> {
                    ArrayList<traineeDetails> arrtraineelist = objStaffDAO.getAssignedTrainees(connection, staffId);
                    request.setAttribute("arrtraineelist", arrtraineelist);
                    request.getRequestDispatcher("JSP/Staff/assignTask.jsp")
                            .forward(request, response);
                }

                case "saveTask" -> {
                    String traineeId = request.getParameter("traineeId");
                    String taskTitle = request.getParameter("taskTitle");
                    String taskDescription = request.getParameter("taskDescription");
                    String dueDate = request.getParameter("dueDate");

                    trainee_task objTask = new trainee_task();

                    objTask.setTraineeId(traineeId);
                    objTask.setStaffId(staffId);
                    objTask.setTaskTitle(taskTitle);
                    objTask.setTaskDescription(taskDescription);

                    String assignedDate = java.time.LocalDate.now().toString();

                    objTask.setAssignedDate(assignedDate);
                    objTask.setDueDate(dueDate);

                    objTask.setStatus("PENDING");

                    boolean result = objStaffDAO.saveTask(connection, objTask);
                    if (result) {
                        objHeadDAO.addNotification(connection, traineeId, "TRAINEE", "New Task Assigned", "Your mentor has assigned a new task.");
                        response.sendRedirect("staffController?actionType=viewAssignTasks");
                    } else {
                        request.setAttribute("msg", "Task Assignment Failed");
                        request.getRequestDispatcher("JSP/errorMsg.jsp")
                                .forward(request, response);
                    }
                }

                case "viewTaskList" -> {
                    ArrayList<trainee_task> arrTaskList = objStaffDAO.getTaskList(connection, staffId);
                    request.setAttribute("arrTaskList", arrTaskList);
                    request.getRequestDispatcher("JSP/Staff/taskList.jsp")
                            .forward(request, response);
                }

                case "updateTask" -> {
                    trainee_task objTask = new trainee_task();
                    objTask.setTaskId(Integer.parseInt(request.getParameter("taskId")));
                    objTask.setTaskTitle(request.getParameter("taskTitle"));
                    objTask.setTaskDescription(request.getParameter("taskDescription"));
                    objTask.setDueDate(request.getParameter("dueDate"));

                    boolean result = objStaffDAO.updateTask(connection, objTask);
                    if (result) {
                        response.sendRedirect("staffController?actionType=viewTaskList");
                    } else {
                        request.setAttribute("msg", "Task Updation Failed");
                        request.getRequestDispatcher("JSP/errorMsg.jsp")
                                .forward(request, response);
                    }
                }

                case "deleteTask" -> {
                    int taskId = Integer.parseInt(request.getParameter("taskId"));
                    boolean result = objStaffDAO.deleteTask(connection, taskId);
                    if (result) {
                        response.sendRedirect("staffController?actionType=viewTaskList");
                    } else {
                        request.setAttribute("msg", "Task Deletion Failed");
                        request.getRequestDispatcher("JSP/errorMsg.jsp")
                                .forward(request, response);
                    }
                }

                case "viewWorkLogs" -> {
                    ArrayList<work_log> arrWorkLogList = objStaffDAO.getAssignedWorkLogs(connection, staffId);
                    request.setAttribute("arrWorkLogList", arrWorkLogList);
                    request.getRequestDispatcher("JSP/Staff/staffWorkLogs.jsp")
                            .forward(request, response);
                }

                case "updateWorkLogStatus" -> {
                    int worklogId = Integer.parseInt(request.getParameter("worklogId"));
                    String status = request.getParameter("status");
                    String mentorRemarks = request.getParameter("mentorRemarks");
                    work_log objWorkLog = new work_log();
                    objWorkLog.setWorklogId(worklogId);
                    objWorkLog.setStatus(status);
                    objWorkLog.setMentorRemarks(mentorRemarks);
                    boolean result = objStaffDAO.updateWorkLogStatus(connection, objWorkLog);
                    if (result) {
                        work_log objLog = objStaffDAO.getWorkLogById(connection, worklogId);
                        objHeadDAO.addNotification(connection, objLog.getTraineeId(), "TRAINEE", "Work Log " + status, "Your work log '" + objLog.getWorkTitle() + "' has been " + status.toLowerCase() + ".");
                        response.sendRedirect("staffController?actionType=viewWorkLogs");
                    } else {
                        request.setAttribute("msg", "Work Log Status Update Failed");
                        request.getRequestDispatcher("JSP/errorMsg.jsp")
                                .forward(request, response);
                    }
                }

                case "viewLeaveApproval" -> {
                    ArrayList<TraineeLeave> leaveList = objStaffDAO.getPendingLeaveRequests(connection, staffId);
                    request.setAttribute("leaveList", leaveList);
                    request.getRequestDispatcher(
                            "JSP/Staff/mentorLeaveApproval.jsp")
                            .forward(request, response);
                }

                case "approveLeave" -> {
                    int leaveId = Integer.parseInt(request.getParameter("leaveId"));
                    String mentorRemark = request.getParameter("mentorRemark");
                    boolean result = objStaffDAO.updateLeaveStatus(connection, leaveId, "APPROVED", mentorRemark);
                    if (result) {
                        response.sendRedirect(
                                "staffController?actionType=viewLeaveApproval&msg=approved");
                    } else {
                        response.sendRedirect(
                                "staffController?actionType=viewLeaveApproval&msg=failed");

                    }
                }

                case "rejectLeave" -> {
                    int leaveId = Integer.parseInt(request.getParameter("leaveId"));
                    String mentorRemark = request.getParameter("mentorRemark");
                    if (mentorRemark == null || mentorRemark.trim().isEmpty()) {
                        response.sendRedirect(
                                "staffController?actionType=viewLeaveApproval&msg=remarkRequired");
                        return;
                    }

                    boolean result = objStaffDAO.updateLeaveStatus(connection, leaveId, "REJECTED", mentorRemark);
                    if (result) {
                        response.sendRedirect(
                                "staffController?actionType=viewLeaveApproval&msg=rejected");
                    } else {
                        response.sendRedirect(
                                "staffController?actionType=viewLeaveApproval&msg=failed");
                    }
                }

                case "viewLeaveBalance" -> {
                    String traineeId = request.getParameter("traineeId");
                    int clAllowed = objStaffDAO.getAllowedLeave(connection, "Casual Leave");
                    int clTaken = objStaffDAO.getTakenLeave(connection, traineeId, "Casual Leave");
                    int mlAllowed = objStaffDAO.getAllowedLeave(connection, "Medical Leave");
                    int mlTaken = objStaffDAO.getTakenLeave(connection, traineeId, "Medical Leave");
                    int sclAllowed = objStaffDAO.getAllowedLeave(connection, "Special Leave");
                    int sclTaken = objStaffDAO.getTakenLeave(connection, traineeId, "Special Leave");
                    int eolAllowed = objStaffDAO.getAllowedLeave(connection, "EOL");
                    int eolTaken = objStaffDAO.getTakenLeave(connection, traineeId, "EOL");
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    out.print("{");
                    out.print("\"clTaken\":" + clTaken + ",");
                    out.print("\"clBalance\":" + (clAllowed - clTaken) + ",");
                    out.print("\"mlTaken\":" + mlTaken + ",");
                    out.print("\"mlBalance\":" + (mlAllowed - mlTaken) + ",");
                    out.print("\"sclTaken\":" + sclTaken + ",");
                    out.print("\"sclBalance\":" + (sclAllowed - sclTaken) + ",");
                    out.print("\"eolTaken\":" + eolTaken + ",");
                    out.print("\"eolBalance\":" + (eolAllowed - eolTaken));

                    out.print("}");
                    return;
                }

                case "viewPendingMonthlyReports" -> {
                    ArrayList<MonthlyReport> reportList = objStaffDAO.getPendingMonthlyReports(connection, staffId);
                    request.setAttribute("reportList", reportList);
                    request.getRequestDispatcher(
                            "JSP/Staff/monthlyReportApproval.jsp")
                            .forward(request, response);
                }

                case "viewMonthlyReport" -> {

                    int reportId = Integer.parseInt(request.getParameter("reportId"));

                    MonthlyReport report = objStaffDAO.getMonthlyReportForStaff(connection, reportId);

                    ArrayList<TraineeLeave> leaveList = objStaffDAO.getMonthlyLeaveDetails(
                            connection,
                            report.getTraineeId(),
                            report.getMonth(),
                            report.getYear());

                    // Allowed Leaves
                    int clAllowed = objStaffDAO.getAllowedLeave(connection, "Casual Leave");
                    int sclAllowed = objStaffDAO.getAllowedLeave(connection, "Special Leave");
                    int mlAllowed = objStaffDAO.getAllowedLeave(connection, "Medical Leave");
                    int eolAllowed = objStaffDAO.getAllowedLeave(connection, "EOL");

                    // Current Month Leave
                    int clCurrent = objStaffDAO.getLeaveTaken(connection,
                            report.getTraineeId(),
                            "Casual Leave",
                            report.getMonth(),
                            report.getYear());

                    int sclCurrent = objStaffDAO.getLeaveTaken(connection,
                            report.getTraineeId(),
                            "Special Leave",
                            report.getMonth(),
                            report.getYear());

                    int mlCurrent = objStaffDAO.getLeaveTaken(connection,
                            report.getTraineeId(),
                            "Medical Leave",
                            report.getMonth(),
                            report.getYear());

                    int eolCurrent = objStaffDAO.getLeaveTaken(connection,
                            report.getTraineeId(),
                            "EOL",
                            report.getMonth(),
                            report.getYear());

                    // Previous Leave
                    int clPrevious = objStaffDAO.getLeaveTakenTillLastMonth(connection,
                            report.getTraineeId(),
                            "Casual Leave",
                            report.getMonth(),
                            report.getYear());

                    int sclPrevious = objStaffDAO.getLeaveTakenTillLastMonth(connection,
                            report.getTraineeId(),
                            "Special Leave",
                            report.getMonth(),
                            report.getYear());

                    int mlPrevious = objStaffDAO.getLeaveTakenTillLastMonth(connection,
                            report.getTraineeId(),
                            "Medical Leave",
                            report.getMonth(),
                            report.getYear());

                    int eolPrevious = objStaffDAO.getLeaveTakenTillLastMonth(connection,
                            report.getTraineeId(),
                            "EOL",
                            report.getMonth(),
                            report.getYear());

                    request.setAttribute("report", report);
                    request.setAttribute("leaveList", leaveList);

                    request.setAttribute("clTaken", clCurrent);
                    request.setAttribute("sclTaken", sclCurrent);
                    request.setAttribute("mlTaken", mlCurrent);
                    request.setAttribute("eolTaken", eolCurrent);

                    request.setAttribute("clPrevious", clPrevious);
                    request.setAttribute("sclPrevious", sclPrevious);
                    request.setAttribute("mlPrevious", mlPrevious);
                    request.setAttribute("eolPrevious", eolPrevious);

                    request.setAttribute("clBalance", clAllowed - (clCurrent + clPrevious));
                    request.setAttribute("sclBalance", sclAllowed - (sclCurrent + sclPrevious));
                    request.setAttribute("mlBalance", mlAllowed - (mlCurrent + mlPrevious));
                    request.setAttribute("eolBalance", eolAllowed - (eolCurrent + eolPrevious));

                    request.getRequestDispatcher("JSP/Staff/reviewMonthlyReport.jsp")
                            .forward(request, response);
                }

                case "approveMonthlyReport" -> {

                    int reportId = Integer.parseInt(request.getParameter("reportId"));

                    String status = request.getParameter("status");

                    String aptitude = request.getParameter("aptitude");
                    String performance = request.getParameter("performance");
                    String shortcomings = request.getParameter("shortcomings");
                    String reaction = request.getParameter("reaction");
                    String conduct = request.getParameter("conduct");
                    String assessment = request.getParameter("assessment");
                    String staffRemark = request.getParameter("staffRemark");

                    MonthlyReport report = new MonthlyReport();

                    report.setReportId(reportId);
                    report.setStatus(status);

                    report.setProgress(
                            "Aptitude : " + aptitude
                            + "\nPerformance : " + performance
                            + "\nShortcomings : " + shortcomings
                            + "\nReaction : " + reaction);

                    report.setConduct(conduct);
                    report.setAssessment(assessment);
                    report.setStaffRemark(staffRemark);

                    boolean result = objStaffDAO.approveMonthlyReport(connection, report);

                    if (result) {
                        response.sendRedirect(
                                "staffController?actionType=viewPendingMonthlyReports&msg=success");
                    } else {
                        response.sendRedirect(
                                "staffController?actionType=viewPendingMonthlyReports&msg=failed");
                    }
                }
            }

        } catch (ServletException | IOException | NumberFormatException | SQLException e) {
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
        } catch (Exception ex) {
            Logger.getLogger(staffController.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Exception ex) {
            Logger.getLogger(staffController.class.getName()).log(Level.SEVERE, null, ex);
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
