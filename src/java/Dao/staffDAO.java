/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import java.sql.Connection;
import java.util.ArrayList;
import model.traineeDetails;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import model.Assignment;
import model.MonthlyReport;
import model.TraineeLeave;
import model.designation;
import model.staffDetails;
import model.trainee_task;
import model.work_log;

/**
 *
 * @author Trainee2
 */
public class staffDAO {

    public staffDetails validateStaff(Connection connection, String username, String password) throws SQLException {

        staffDetails objStaff = null;

        String sql = "SELECT * FROM staff_details " + "WHERE username=? AND password=? " + "AND active='YES'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {

                    objStaff = new staffDetails();

                    objStaff.setStaffId(rs.getString("staffId"));
                    objStaff.setStaffName(rs.getString("staffName"));
                    objStaff.setDesignation(rs.getString("designation"));
                    objStaff.setDivision(rs.getString("division"));
                    objStaff.setEmailId(rs.getString("emailId"));
                    objStaff.setPhoneNumber(rs.getString("phoneNumber"));
                    objStaff.setUsername(rs.getString("username"));
                    objStaff.setPassword(rs.getString("password"));
                    objStaff.setActive(rs.getString("active"));

                }
            }
        }

        return objStaff;
    }

    public ArrayList<traineeDetails> getAssignedTrainees(Connection connection, String staffId) throws SQLException {

        ArrayList<traineeDetails> list = new ArrayList<>();

        String sql = "SELECT a.status, t.*, d.designation " + "FROM trainee_assignment a " + "INNER JOIN trainee_details t ON a.traineeId = t.traineeId " + "INNER JOIN designation d ON t.designationId = d.designationId "
                + "WHERE a.staffId=? " + "ORDER BY t.traineeName";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staffId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    traineeDetails trainee = new traineeDetails();
                    designation des = new designation();
                    Assignment assign = new Assignment();

                    trainee.setTraineeId(rs.getString("traineeId"));
                    trainee.setTraineeName(rs.getString("traineeName"));
                    trainee.setGender(rs.getString("gender"));
                    trainee.setDob(rs.getDate("dob"));
                    trainee.setPlace(rs.getString("place"));
                    trainee.setBranch(rs.getString("branch"));
                    trainee.setQualification(rs.getString("qualification"));
                    trainee.setEmailId(rs.getString("emailId"));
                    trainee.setPhonenumber(rs.getString("phoneNumber"));
                    trainee.setJoiningDate(rs.getDate("joiningDate"));
                    trainee.setCompletionDate(rs.getDate("completionDate"));
                    trainee.setDivision(rs.getString("division"));
                    trainee.setActive(rs.getString("active"));
                    trainee.setUsername(rs.getString("username"));
                    trainee.setPassword(rs.getString("password"));

                    // NEW
                    trainee.setCompletionStatus(rs.getString("completionStatus"));
                    trainee.setCompletionReason(rs.getString("completionReason"));

                    des.setDesignationId(rs.getInt("designationId"));
                    des.setDesignation(rs.getString("designation"));
                    trainee.setObjDesignationitems(des);

                    assign.setStatus(rs.getString("status"));
                    trainee.setObjAssign(assign);

                    list.add(trainee);
                }
            }
        }

        return list;
    }

    public boolean acceptTrainees(Connection connection, String traineeId) throws SQLException {
        // 1. Update the assignment table to set status to ACCEPTED and set the date
        String sql1 = "UPDATE trainee_assignment SET status='ACCEPTED', acceptedDate=NOW() WHERE traineeId=?";
        int rowsUpdated;
        try (PreparedStatement ps1 = connection.prepareStatement(sql1)) {
            ps1.setString(1, traineeId);
            rowsUpdated = ps1.executeUpdate();
        }

        if (rowsUpdated > 0) {
            // 2. Fetch the staffId assigned to this trainee from the assignment table
            String sql2 = "SELECT staffId FROM trainee_assignment WHERE traineeId=?";
            try (PreparedStatement ps2 = connection.prepareStatement(sql2)) {
                ps2.setString(1, traineeId);
                try (ResultSet rs = ps2.executeQuery()) {
                    if (rs.next()) {
                        String staffId = rs.getString("staffId");

                        // 3. Update ONLY the staffId in trainee_details (removed status column)
                        String sql3 = "UPDATE trainee_details SET staffId=? WHERE traineeId=?";
                        try (PreparedStatement ps3 = connection.prepareStatement(sql3)) {
                            ps3.setString(1, staffId);
                            ps3.setString(2, traineeId);
                            ps3.executeUpdate();
                        }
                    }
                }
            }
            return true;
        }
        return false;
    }

    public boolean rejectAssignment(Connection connection, String traineeId, String remarks) throws SQLException {
        // 1. Update trainee_assignment using traineeId
        String sql = "UPDATE trainee_assignment " + "SET status='REJECTED', " + "remarks=?, "
                + "rejectedDate=NOW() " + "WHERE traineeId=?";

        boolean result;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, remarks);
            ps.setString(2, traineeId);
            result = ps.executeUpdate() > 0;
        }

        if (result) {
            // 2. Update trainee_details: Remove staffId assignment 
            // REMOVED: status='REJECTED' because the column does not exist in this table
            String sqlDetails = "UPDATE trainee_details " + "SET staffId=NULL " + "WHERE traineeId=?";

            try (PreparedStatement ps2 = connection.prepareStatement(sqlDetails)) {
                ps2.setString(1, traineeId);
                ps2.executeUpdate();
            }
        }

        return result;
    }

    public boolean changePassword(Connection connection, String username, String oldPassword, String newPassword) throws SQLException {

        String sql = "UPDATE staff_details " + "SET password=? " + "WHERE username=? AND password=?";

        int rows;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, username);
            ps.setString(3, oldPassword);
            rows = ps.executeUpdate();
        }

        return rows > 0;
    }

    public boolean deactivateTrainee(Connection con, String traineeId, String status, String reason) throws SQLException {

        String sql = "UPDATE trainee_details " + "SET active='NO', " + "completionStatus=?, " + "completionReason=? " + "WHERE traineeId=?";

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, status);
        ps.setString(2, reason);
        ps.setString(3, traineeId);

        return ps.executeUpdate() > 0;
    }

    public boolean activeDeactive(Connection connection, String traineeId, String active) throws SQLException {

        String sql = "UPDATE trainee_details " + "SET active=? " + "WHERE traineeId=?";

        int rows;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, active);
            ps.setString(2, traineeId);
            rows = ps.executeUpdate();
        }

        return rows > 0;
    }

    public boolean saveTraineeLogin(Connection connection, String traineeId, String username, String password) throws SQLException {

        String sql = "UPDATE trainee_details " + "SET username=?, password=? " + "WHERE traineeId=?";

        boolean status;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, traineeId);
            status = ps.executeUpdate() > 0;
        }

        return status;
    }

    public boolean resetTraineePassword(Connection connection, String traineeId, String password) throws SQLException {

        String sql = "UPDATE trainee_details " + "SET password=? " + "WHERE traineeId=?";

        boolean status;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, password);
            ps.setString(2, traineeId);
            status = ps.executeUpdate() > 0;
        }

        return status;
    }

    public boolean saveTask(Connection connection, trainee_task objTask) throws SQLException {
        boolean status = false;
        String sql = "INSERT INTO trainee_task " + "(trainee_id, staff_id, task_title, task_description, " + "assigned_date, due_date, status) " + "VALUES (?,?,?,?,?,?,?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, objTask.getTraineeId());
            ps.setString(2, objTask.getStaffId());
            ps.setString(3, objTask.getTaskTitle());
            ps.setString(4, objTask.getTaskDescription());
            ps.setString(5, objTask.getAssignedDate());
            ps.setString(6, objTask.getDueDate());
            ps.setString(7, objTask.getStatus());

            if (ps.executeUpdate() > 0) {
                status = true;
            }
        }

        return status;
    }

    public ArrayList<trainee_task> getTaskList(Connection connection, String staffId) throws SQLException {
        ArrayList<trainee_task> arrTaskList = new ArrayList<>();
        String sql = "SELECT tt.*, t.traineeName " + "FROM trainee_task tt " + "INNER JOIN trainee_details t " + "ON tt.trainee_id = t.traineeId " + "WHERE tt.staff_id = ? " + "ORDER BY tt.assigned_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staffId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    trainee_task objTask = new trainee_task();

                    objTask.setTaskId(rs.getInt("task_id"));
                    objTask.setTraineeId(rs.getString("trainee_id"));
                    objTask.setStaffId(rs.getString("staff_id"));
                    objTask.setTaskTitle(rs.getString("task_title"));
                    objTask.setTaskDescription(rs.getString("task_description"));
                    objTask.setAssignedDate(rs.getString("assigned_date"));
                    objTask.setDueDate(rs.getString("due_date"));
                    objTask.setStatus(rs.getString("status"));
                    objTask.setRemarks(rs.getString("remarks"));

                    traineeDetails objTrainee = new traineeDetails();
                    objTrainee.setTraineeName(rs.getString("traineeName"));

                    objTask.setObjTrainee(objTrainee);

                    arrTaskList.add(objTask);
                }
            }
        }

        return arrTaskList;
    }

    public boolean updateTask(Connection connection, trainee_task objTask) throws SQLException {

        boolean status = false;
        String sql = "UPDATE trainee_task " + "SET task_title=?, task_description=?, due_date=? " + "WHERE task_id=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, objTask.getTaskTitle());
            ps.setString(2, objTask.getTaskDescription());
            ps.setString(3, objTask.getDueDate());
            ps.setInt(4, objTask.getTaskId());

            status = ps.executeUpdate() > 0;
        }

        return status;
    }

    public boolean deleteTask(Connection connection, int taskId) throws SQLException {
        boolean status = false;
        String sql = "DELETE FROM trainee_task WHERE task_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, taskId);
            status = ps.executeUpdate() > 0;
        }
        return status;
    }

    public ArrayList<work_log> getAssignedWorkLogs(Connection connection, String staffId) throws SQLException {

        ArrayList<work_log> arrWorkLogList = new ArrayList<>();

        String sql = "SELECT tw.*, t.traineeName " + "FROM trainee_worklog tw " + "INNER JOIN trainee_details t " + "ON tw.trainee_id = t.traineeId "
                + "WHERE tw.staff_id = ? " + "ORDER BY tw.work_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staffId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    work_log objWorkLog = new work_log();

                    objWorkLog.setWorklogId(rs.getInt("worklog_id"));
                    objWorkLog.setTraineeId(rs.getString("trainee_id"));
                    objWorkLog.setStaffId(rs.getString("staff_id"));
                    objWorkLog.setWorkDate(rs.getString("work_date"));
                    objWorkLog.setWorkTitle(rs.getString("work_title"));
                    objWorkLog.setWorkDescription(rs.getString("work_description"));
                    objWorkLog.setHoursWorked(rs.getString("hours_worked"));
                    objWorkLog.setStatus(rs.getString("status"));
                    objWorkLog.setMentorRemarks(rs.getString("mentor_remarks"));

                    traineeDetails objTrainee = new traineeDetails();
                    objTrainee.setTraineeName(rs.getString("traineeName"));

                    objWorkLog.setObjTrainee(objTrainee);

                    arrWorkLogList.add(objWorkLog);
                }
            }
        }

        return arrWorkLogList;
    }

    public boolean updateWorkLogStatus(Connection connection, work_log objWorkLog) throws SQLException {

        boolean status = false;

        String sql = "UPDATE trainee_worklog " + "SET status=?, mentor_remarks=? " + "WHERE worklog_id=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, objWorkLog.getStatus());
            ps.setString(2, objWorkLog.getMentorRemarks());
            ps.setInt(3, objWorkLog.getWorklogId());

            status = ps.executeUpdate() > 0;
        }

        return status;
    }

    public work_log getWorkLogById(Connection connection, int worklogId) throws SQLException {

        work_log objWorkLog = null;

        String sql = "SELECT * FROM trainee_worklog WHERE worklog_id=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, worklogId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {

                    objWorkLog = new work_log();

                    objWorkLog.setWorklogId(rs.getInt("worklog_id"));
                    objWorkLog.setTraineeId(rs.getString("trainee_id"));
                    objWorkLog.setStaffId(rs.getString("staff_id"));
                    objWorkLog.setWorkDate(rs.getString("work_date"));
                    objWorkLog.setWorkTitle(rs.getString("work_title"));
                    objWorkLog.setWorkDescription(rs.getString("work_description"));
                    objWorkLog.setHoursWorked(rs.getString("hours_worked"));
                    objWorkLog.setStatus(rs.getString("status"));
                    objWorkLog.setMentorRemarks(rs.getString("mentor_remarks"));
                }
            }
        }

        return objWorkLog;
    }

    public ArrayList<TraineeLeave> getPendingLeaveRequests(Connection connection, String staffId) throws Exception {

        ArrayList<TraineeLeave> leaveList = new ArrayList<>();

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            String sql = "SELECT td.traineeName,tl.leave_id, " + "tl.trainee_id, " + "tl.leave_from, " + "tl.leave_to, "
                    + "tl.total_days, " + "tl.leave_type, " + "tl.reason, " + "tl.status, "
                    + "tl.mentor_remark " + "FROM trainee_leave tl " + "INNER JOIN trainee_details td " + "ON tl.trainee_id = td.traineeId "
                    + "WHERE td.staffId = ? " + "ORDER BY tl.leave_from DESC";

            ps = connection.prepareStatement(sql);
            ps.setString(1, staffId);

            rs = ps.executeQuery();

            while (rs.next()) {

                TraineeLeave obj = new TraineeLeave();

                obj.setLeaveId(rs.getInt("leave_id"));
                obj.setTraineeId(rs.getString("trainee_id"));
                obj.setLeaveFrom(rs.getString("leave_from"));
                obj.setLeaveTo(rs.getString("leave_to"));
                obj.setTotalDays(rs.getInt("total_days"));
                obj.setLeaveType(rs.getString("leave_type"));
                obj.setReason(rs.getString("reason"));
                obj.setStatus(rs.getString("status"));
                obj.setMentorRemark(rs.getString("mentor_remark"));
                traineeDetails objTrainee = new traineeDetails();
                objTrainee.setTraineeName(rs.getString("traineeName"));
                obj.setTraineeDetails(objTrainee);

                leaveList.add(obj);
            }

        } finally {

            if (rs != null) {
                rs.close();
            }

            if (ps != null) {
                ps.close();
            }
        }

        return leaveList;
    }

    public boolean updateLeaveStatus(Connection connection, int leaveId, String status, String mentorRemark) throws SQLException {

        String sql = "UPDATE trainee_leave " + "SET status=?, mentor_remark=? " + "WHERE leave_id=?";

        boolean result;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, mentorRemark);
            ps.setInt(3, leaveId);
            result = ps.executeUpdate() > 0;
        }

        return result;
    }

    public int getLeaveCountByType(Connection connection, String traineeId, String leaveType) {

        int days = 0;

        try {

            String sql = "SELECT IFNULL(SUM(total_days),0) total " + "FROM trainee_leave " + "WHERE trainee_id=? " + "AND leave_type=? " + "AND status='APPROVED'";

            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, traineeId);
            ps.setString(2, leaveType);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                days = rs.getInt("total");

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return days;
    }

    public int getAllowedLeave(Connection connection, String leaveType) throws SQLException {

        int allowedDays = 0;

        try {

            String sql = "SELECT total_days FROM leave_master WHERE leave_type=?";

            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, leaveType);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        allowedDays = rs.getInt("total_days");
                    }
                }
            }

        } catch (SQLException e) {
            throw e;
        }

        return allowedDays;
    }

    public int getTakenLeave(Connection connection, String traineeId, String leaveType) {

        int takenDays = 0;

        try {

            String sql = "SELECT IFNULL(SUM(total_days),0) AS taken " + "FROM trainee_leave " + "WHERE trainee_id=? " + "AND leave_type=? " + "AND status='APPROVED'";

            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, traineeId);
                ps.setString(2, leaveType);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        takenDays = rs.getInt("taken");
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return takenDays;
    }

    public ArrayList<MonthlyReport> getPendingMonthlyReports(Connection connection, String staffId) throws SQLException {

        ArrayList<MonthlyReport> list = new ArrayList<>();

        String sql = "SELECT * FROM trainee_monthly_report " + "WHERE staff_id=? " + "AND status='PENDING' " + "ORDER BY submitted_date DESC";

        PreparedStatement ps = connection.prepareStatement(sql);

        ps.setString(1, staffId);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {

            MonthlyReport report
                    = new MonthlyReport();

            report.setReportId(rs.getInt("report_id"));
            report.setTraineeId(rs.getString("trainee_id"));
            report.setMonth(rs.getInt("month"));
            report.setYear(rs.getInt("year"));
            report.setSubmittedDate(
                    rs.getTimestamp("submitted_date"));
            report.setStatus(rs.getString("status"));

            list.add(report);
        }

        rs.close();
        ps.close();

        return list;
    }

    public MonthlyReport getMonthlyReportForStaff(Connection connection, int reportId) throws SQLException {

        MonthlyReport report = null;

        String sql = "SELECT * FROM trainee_monthly_report WHERE report_id=?";

        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, reportId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            report = new MonthlyReport();

            report.setReportId(rs.getInt("report_id"));
            report.setTraineeId(rs.getString("trainee_id"));
            report.setStaffId(rs.getString("staff_id"));
            report.setMonth(rs.getInt("month"));
            report.setYear(rs.getInt("year"));

            report.setWorkDone(rs.getString("work_done"));
            report.setLeaveDetails(rs.getString("leave_details"));

            report.setProgress(rs.getString("progress"));
            report.setConduct(rs.getString("conduct"));
            report.setAssessment(rs.getString("assessment"));

            report.setStaffRemark(rs.getString("staff_remark"));
            report.setHeadRemark(rs.getString("head_remark"));

            report.setStatus(rs.getString("status"));

            report.setSubmittedDate(rs.getTimestamp("submitted_date"));
            report.setUpdatedAt(rs.getTimestamp("updated_at"));
        }

        rs.close();
        ps.close();

        return report;
    }

    public ArrayList<TraineeLeave> getMonthlyLeaveDetails(
            Connection connection,
            String traineeId,
            int month,
            int year) throws SQLException {

        ArrayList<TraineeLeave> leaveList = new ArrayList<>();

        String sql = "SELECT leave_from, leave_to, total_days, leave_type "
                + "FROM trainee_leave "
                + "WHERE trainee_id=? "
                + "AND MONTH(leave_from)=? "
                + "AND YEAR(leave_from)=? "
                + "AND status='APPROVED' "
                + "ORDER BY leave_from";

        PreparedStatement ps = connection.prepareStatement(sql);

        ps.setString(1, traineeId);
        ps.setInt(2, month);
        ps.setInt(3, year);

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {

            TraineeLeave leave = new TraineeLeave();

            leave.setLeaveFrom(rs.getString("leave_from"));
            leave.setLeaveTo(rs.getString("leave_to"));
            leave.setTotalDays(rs.getInt("total_days"));
            leave.setLeaveType(rs.getString("leave_type"));

            leaveList.add(leave);
        }

        rs.close();
        ps.close();

        return leaveList;
    }

    public int getLeaveTaken(Connection connection,
            String traineeId,
            String leaveType,
            int month,
            int year) throws SQLException {

        int totalDays = 0;

        String sql = "SELECT IFNULL(SUM(total_days),0) total "
                + "FROM trainee_leave "
                + "WHERE trainee_id=? "
                + "AND leave_type=? "
                + "AND status='APPROVED' "
                + "AND MONTH(leave_from)=? "
                + "AND YEAR(leave_from)=?";

        PreparedStatement ps = connection.prepareStatement(sql);

        ps.setString(1, traineeId);
        ps.setString(2, leaveType);
        ps.setInt(3, month);
        ps.setInt(4, year);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            totalDays = rs.getInt("total");
        }

        rs.close();
        ps.close();

        return totalDays;
    }

    public int getLeaveTakenTillLastMonth(Connection connection,
            String traineeId,
            String leaveType,
            int month,
            int year) throws SQLException {

        int totalDays = 0;

        String sql = "SELECT IFNULL(SUM(total_days),0) AS total "
                + "FROM trainee_leave "
                + "WHERE trainee_id=? "
                + "AND leave_type=? "
                + "AND status='APPROVED' "
                + "AND (YEAR(leave_from) < ? "
                + "OR (YEAR(leave_from)=? AND MONTH(leave_from) < ?))";

        PreparedStatement ps = connection.prepareStatement(sql);

        ps.setString(1, traineeId);
        ps.setString(2, leaveType);
        ps.setInt(3, year);
        ps.setInt(4, year);
        ps.setInt(5, month);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            totalDays = rs.getInt("total");
        }

        rs.close();
        ps.close();

        return totalDays;
    }

    public boolean approveMonthlyReport(Connection connection,
            MonthlyReport report) throws SQLException {

        String sql = "UPDATE trainee_monthly_report "
                + "SET progress=?, "
                + "conduct=?, "
                + "assessment=?, "
                + "staff_remark=?, "
                + "status=?, "
                + "updated_at=NOW() "
                + "WHERE report_id=?";

        PreparedStatement ps = connection.prepareStatement(sql);

        ps.setString(1, report.getProgress());
        ps.setString(2, report.getConduct());
        ps.setString(3, report.getAssessment());
        ps.setString(4, report.getStaffRemark());
        ps.setString(5, report.getStatus());
        ps.setInt(6, report.getReportId());

        boolean result = ps.executeUpdate() > 0;

        ps.close();

        return result;
    }

    public int getTraineeCount(Connection connection, String staffId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
