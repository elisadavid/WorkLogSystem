/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.MonthlyReport;
import model.TraineeLeave;
import model.designation;
import model.staffDetails;
import model.traineeDetails;
import model.trainee_task;
import model.work_log;

/**
 *
 * @author kgaut
 */
public class traineeDAO {

    public traineeDetails validateTrainee(Connection connection, String username, String password) throws SQLException {
        traineeDetails objtraineeDetails = null;

        String sql = "SELECT * FROM trainee_details " + "WHERE username=? AND password=? " + "AND active='YES'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {

                    objtraineeDetails = new traineeDetails();

                    objtraineeDetails.setTraineeId(rs.getString("traineeId"));
                    objtraineeDetails.setTraineeName(rs.getString("traineeName"));
                    objtraineeDetails.setGender(rs.getString("gender"));

                    objtraineeDetails.setDob(rs.getDate("dob"));

                    objtraineeDetails.setPlace(rs.getString("place"));
                    objtraineeDetails.setBranch(rs.getString("branch"));
                    objtraineeDetails.setQualification(rs.getString("qualification"));
                    objtraineeDetails.setEmailId(rs.getString("emailId"));
                    objtraineeDetails.setPhonenumber(rs.getString("phonenumber"));

                    objtraineeDetails.setJoiningDate(rs.getDate("joiningDate"));
                    objtraineeDetails.setCompletionDate(rs.getDate("completionDate"));

                    objtraineeDetails.setDivision(rs.getString("division"));
                    objtraineeDetails.setActive(rs.getString("active"));

                }
            }
        }

        return objtraineeDetails;
    }

    public ArrayList<trainee_task> getMyTasks(Connection connection, String traineeId) throws SQLException {

        ArrayList<trainee_task> arrTaskList = new ArrayList<>();

        String sql = "SELECT tt.*, s.staffName " + "FROM trainee_task tt " + "INNER JOIN staff_details s " + "ON tt.staff_id = s.staffId " + "WHERE tt.trainee_id = ? " + "ORDER BY tt.assigned_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, traineeId);

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

                    // Staff Details
                    staffDetails objStaff = new staffDetails();
                    objStaff.setStaffName(rs.getString("staffName"));

                    objTask.setObjStaff(objStaff);

                    arrTaskList.add(objTask);
                }
            }
        }

        return arrTaskList;
    }

    public String updateTaskStatus(Connection connection, trainee_task objTask) throws SQLException {
        String msg = "";
        String sql = "UPDATE trainee_task SET status=?, remarks=? WHERE task_id=?";

        try {
            connection.setAutoCommit(false);
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, objTask.getStatus());
                ps.setString(2, objTask.getRemarks());
                ps.setInt(3, objTask.getTaskId());
                ps.executeUpdate();
            }
            connection.commit();
            msg = "Task updated successfully!";
        } catch (SQLException e) {
            if (connection != null) {
                connection.rollback();
            }
            throw e;
        } finally {
            if (connection != null) {
                connection.setAutoCommit(true);
            }
        }
        return msg;
    }

    public trainee_task getTaskById(Connection connection, int taskId) throws SQLException {

        trainee_task objTask = null;

        String sql = "SELECT * FROM trainee_task WHERE task_id=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, taskId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {

                    objTask = new trainee_task();

                    objTask.setTaskId(rs.getInt("task_id"));
                    objTask.setTraineeId(rs.getString("trainee_id"));
                    objTask.setStaffId(rs.getString("staff_id"));
                    objTask.setTaskTitle(rs.getString("task_title"));
                    objTask.setTaskDescription(rs.getString("task_description"));
                    objTask.setAssignedDate(rs.getString("assigned_date"));
                    objTask.setDueDate(rs.getString("due_date"));
                    objTask.setStatus(rs.getString("status"));
                    objTask.setRemarks(rs.getString("remarks"));
                }
            }
        }

        return objTask;
    }

    public ArrayList<work_log> getMyWorkLogs(Connection connection, String traineeId) throws SQLException {

        ArrayList<work_log> arrWorkLogList = new ArrayList<>();

        String sql = "SELECT tw.*, s.staffName " + "FROM trainee_worklog tw " + "INNER JOIN staff_details s " + "ON tw.staff_id = s.staffId "
                + "WHERE tw.trainee_id = ? " + "ORDER BY tw.work_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, traineeId);

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

                    staffDetails objStaff = new staffDetails();
                    objStaff.setStaffName(rs.getString("staffName"));

                    objWorkLog.setObjStaff(objStaff);

                    arrWorkLogList.add(objWorkLog);
                }
            }
        }

        return arrWorkLogList;
    }

    public String getAssignedStaffId(Connection connection, String traineeId) throws SQLException {

        String staffId = "";

        String sql = "SELECT staffId " + "FROM trainee_assignment " + "WHERE traineeId=? " + "AND status='ACCEPTED'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, traineeId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {

                    staffId = rs.getString("staffId");

                }
            }
        }

        return staffId;
    }

    public boolean saveWorkLog(Connection connection, work_log objWorkLog) throws SQLException {

        boolean status = false;

        String sql = "INSERT INTO trainee_worklog " + "(trainee_id, staff_id, work_date, work_title, " + "work_description, hours_worked, status, mentor_remarks) " + "VALUES (?,?,?,?,?,?,?,?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, objWorkLog.getTraineeId());
            ps.setString(2, objWorkLog.getStaffId());
            ps.setString(3, objWorkLog.getWorkDate());
            ps.setString(4, objWorkLog.getWorkTitle());
            ps.setString(5, objWorkLog.getWorkDescription());
            ps.setString(6, objWorkLog.getHoursWorked());
            ps.setString(7, objWorkLog.getStatus());
            ps.setString(8, objWorkLog.getMentorRemarks());

            status = ps.executeUpdate() > 0;
        }

        return status;
    }

//   getMyLeaves()
    public ArrayList<TraineeLeave> getMyLeaves(Connection connection, String traineeId) throws SQLException {

        ArrayList<TraineeLeave> arrLeaveList
                = new ArrayList<>();

        String sql = "SELECT " + "leave_id, " + "trainee_id, " + "staff_id, " + "leave_from, " + "leave_to, " + "total_days, " + "leave_type, "
                + "reason, " + "status, " + "mentor_remark " + "FROM trainee_leave " + "WHERE trainee_id=? " + "ORDER BY leave_id DESC";

        try (PreparedStatement ps
                = connection.prepareStatement(sql)) {
            ps.setString(1, traineeId);
            try (ResultSet rs
                    = ps.executeQuery()) {
                while (rs.next()) {
                    TraineeLeave objLeave = new TraineeLeave();

                    objLeave.setLeaveId(rs.getInt("leave_id"));
                    objLeave.setTraineeId(rs.getString("trainee_id"));

                    objLeave.setStaffId(rs.getString("staff_id"));

                    objLeave.setLeaveFrom(rs.getString("leave_from"));

                    objLeave.setLeaveTo(rs.getString("leave_to"));
                    objLeave.setTotalDays(rs.getInt("total_days"));

                    objLeave.setLeaveType(rs.getString("leave_type"));
                    objLeave.setReason(rs.getString("reason"));
                    objLeave.setStatus(rs.getString("status"));
                    objLeave.setMentorRemark(rs.getString("mentor_remark"));
                    arrLeaveList.add(objLeave);
                }
            }
        }
        return arrLeaveList;
    }
//calculateLeaveDays()

    public int calculateLeaveDays(String leaveFrom, String leaveTo) {

        try {

            java.sql.Date fromDate = java.sql.Date.valueOf(leaveFrom);

            java.sql.Date toDate
                    = java.sql.Date.valueOf(
                            leaveTo
                    );

            long difference
                    = toDate.getTime()
                    - fromDate.getTime();

            int totalDays
                    = (int) (difference
                    / (1000 * 60 * 60 * 24)) + 1;

            return totalDays;

        } catch (Exception e) {

            e.printStackTrace();

            return 0;
        }
    }

//saveLeave()
    public boolean saveLeave(Connection connection, TraineeLeave objLeave) throws SQLException {

        String sql = "INSERT INTO trainee_leave " + "(trainee_id, staff_id, leave_from, leave_to, " + "total_days, leave_type, reason, status, "
                + "mentor_remark, applied_date) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

        try (PreparedStatement ps
                = connection.prepareStatement(sql)) {

            ps.setString(
                    1,
                    objLeave.getTraineeId()
            );

            ps.setString(
                    2,
                    objLeave.getStaffId()
            );

            ps.setString(
                    3,
                    objLeave.getLeaveFrom()
            );

            ps.setString(
                    4,
                    objLeave.getLeaveTo()
            );

            ps.setInt(
                    5,
                    objLeave.getTotalDays()
            );

            ps.setString(
                    6,
                    objLeave.getLeaveType()
            );

            ps.setString(
                    7,
                    objLeave.getReason()
            );

            ps.setString(
                    8,
                    objLeave.getStatus()
            );

            ps.setString(
                    9,
                    objLeave.getMentorRemark()
            );

            return ps.executeUpdate() > 0;
        }
    }

//updateLeave()
    public boolean updateLeave(Connection connection, TraineeLeave objLeave) throws SQLException {

        String sql = "UPDATE trainee_leave " + "SET leave_from=?, " + "leave_to=?, " + "total_days=?, "
                + "leave_type=?, " + "reason=?, " + "updated_at=NOW() " + "WHERE leave_id=? "
                + "AND trainee_id=? " + "AND status='PENDING'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, objLeave.getLeaveFrom()
            );

            ps.setString(2, objLeave.getLeaveTo()
            );

            ps.setInt(3, objLeave.getTotalDays()
            );

            ps.setString(4, objLeave.getLeaveType()
            );

            ps.setString(5, objLeave.getReason()
            );

            ps.setInt(6, objLeave.getLeaveId()
            );

            ps.setString(7, objLeave.getTraineeId()
            );

            return ps.executeUpdate() > 0;
        }
    }
//deleteLeave()

    public boolean deleteLeave(Connection connection, int leaveId, String traineeId) throws SQLException {

        String sql = "DELETE FROM trainee_leave " + "WHERE leave_id=? " + "AND trainee_id=? " + "AND status='PENDING'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, leaveId);
            ps.setString(2, traineeId);

            return ps.executeUpdate() > 0;
        }
    }

//Get Leave Count
    public int getLeaveCountByType(Connection connection, String traineeId, String leaveType) throws SQLException {

        int totalDays = 0;

        String sql = "SELECT COALESCE(SUM(total_days), 0) " + "FROM trainee_leave " + "WHERE trainee_id=? " + "AND leave_type=? " + "AND status='APPROVED'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(
                    1, traineeId
            );

            ps.setString(
                    2, leaveType
            );

            try (ResultSet rs
                    = ps.executeQuery()) {

                if (rs.next()) {

                    totalDays
                            = rs.getInt(1);
                }
            }
        }

        return totalDays;
    }

//Get Trainee Details
    public traineeDetails getTraineeDetails(Connection connection, String traineeId) throws SQLException {

        traineeDetails objTrainee = null;

        String sql = "SELECT td.*, d.designation " + "FROM trainee_details td " + "LEFT JOIN designation d "
                + "ON td.designationId = d.designationId " + "WHERE td.traineeId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, traineeId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    objTrainee = new traineeDetails();

                    objTrainee.setTraineeId(rs.getString("traineeId"));
                    objTrainee.setTraineeName(rs.getString("traineeName"));
                    objTrainee.setGender(rs.getString("gender"));
                    objTrainee.setDob(rs.getDate("dob"));
                    objTrainee.setPlace(rs.getString("place"));
                    objTrainee.setBranch(rs.getString("branch"));
                    objTrainee.setQualification(rs.getString("qualification"));
                    objTrainee.setEmailId(rs.getString("emailId"));
                    objTrainee.setPhonenumber(rs.getString("phonenumber"));
                    objTrainee.setJoiningDate(rs.getDate("joiningDate"));
                    objTrainee.setCompletionDate(rs.getDate("completionDate"));
                    objTrainee.setDivision(rs.getString("division"));
                    objTrainee.setActive(rs.getString("active"));

                    // Designation name from designation table
                    designation objDesignation = new designation();
                    objDesignation.setDesignation(rs.getString("designation"));

                    objTrainee.setObjDesignationitems(objDesignation);
                }
            }
        }

        return objTrainee;
    }

//Get Assigned Mentor
    public staffDetails getAssignedStaffDetails(Connection connection, String traineeId) throws SQLException {

        staffDetails objStaff = null;

        String sql = "SELECT s.* " + "FROM staff_details s " + "INNER JOIN trainee_assignment ta " + "ON s.staffId = ta.staffId "
                + "WHERE ta.traineeId=? " + "AND ta.status='ACCEPTED' " + "LIMIT 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(
                    1,
                    traineeId
            );

            try (ResultSet rs
                    = ps.executeQuery()) {

                if (rs.next()) {

                    objStaff
                            = new staffDetails();

                    objStaff.setStaffName(
                            rs.getString(
                                    "staffName"
                            )
                    );

                    objStaff.setDesignation(
                            rs.getString(
                                    "designation"
                            )
                    );
                }
            }
        }

        return objStaff;
    }

    public ArrayList<MonthlyReport> getMonthlyWorkDone(Connection connection, String traineeId,
            int month, int year) throws SQLException {

        ArrayList<MonthlyReport> reportList = new ArrayList<>();

        String sql = "SELECT tw.work_date, tw.work_title, " + "tw.work_description, tw.hours_worked, " + "tw.status, tw.mentor_remarks, " + "td.traineeName, sd.staffName "
                + "FROM trainee_worklog tw " + "INNER JOIN trainee_details td " + "ON tw.trainee_id = td.traineeId " + "INNER JOIN staff_details sd "
                + "ON tw.staff_id = sd.staffId " + "WHERE tw.trainee_id = ? " + "AND MONTH(tw.work_date) = ? " + "AND YEAR(tw.work_date) = ? "
                + "ORDER BY tw.work_date";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, traineeId);
            ps.setInt(2, month);
            ps.setInt(3, year);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    MonthlyReport report = new MonthlyReport();

                    report.setTraineeName(rs.getString("traineeName"));
                    report.setStaffName(rs.getString("staffName"));
                    report.setWorkDate(rs.getDate("work_date"));
                    report.setWorkTitle(rs.getString("work_title"));
                    report.setWorkDescription(rs.getString("work_description"));
                    report.setHoursWorked(rs.getDouble("hours_worked"));
                    report.setStatus(rs.getString("status"));
                    report.setMentorRemarks(rs.getString("mentor_remarks"));

                    reportList.add(report);
                }
            }
        }

        return reportList;
    }

    public ArrayList<TraineeLeave> getMonthlyLeaveDetails(Connection connection, String traineeId, int month, int year) throws SQLException {

        ArrayList<TraineeLeave> leaveList = new ArrayList<>();

        String sql = "SELECT leave_from, leave_to, total_days, leave_type " + "FROM trainee_leave " + "WHERE trainee_id=? " + "AND MONTH(leave_from)=? "
                + "AND YEAR(leave_from)=? " + "AND status='APPROVED'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, traineeId);
            ps.setInt(2, month);
            ps.setInt(3, year);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    TraineeLeave leave = new TraineeLeave();

                    leave.setLeaveFrom(rs.getString("leave_from"));
                    leave.setLeaveTo(rs.getString("leave_to"));
                    leave.setTotalDays(rs.getInt("total_days"));
                    leave.setLeaveType(rs.getString("leave_type"));

                    leaveList.add(leave);
                }
            }
        }
        return leaveList;
    }

    public boolean saveMonthlyReport(Connection connection, String traineeId, String staffId, int month,
            int year, String workDone, String leaveDetails) throws SQLException {
        String sql = "INSERT INTO trainee_monthly_report " + "(trainee_id,staff_id,month,year," + "work_done,leave_details,"
                + "status,submitted_date)" + " VALUES(?,?,?,?,?,?,?,NOW())";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, traineeId);
        ps.setString(2, staffId);
        ps.setInt(3, month);
        ps.setInt(4, year);
        ps.setString(5, workDone);
        ps.setString(6, leaveDetails);
        ps.setString(7, "PENDING");
        return ps.executeUpdate() > 0;
    }

    public ArrayList<MonthlyReport> getMonthlyReports(Connection connection, String traineeId) throws SQLException {
        ArrayList<MonthlyReport> reportList = new ArrayList<>();
        String sql = "SELECT * FROM trainee_monthly_report " + "WHERE trainee_id=? " + "ORDER BY year DESC, month DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, traineeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    MonthlyReport report = new MonthlyReport();
                    report.setReportId(rs.getInt("report_id"));
                    report.setMonth(rs.getInt("month"));
                    report.setYear(rs.getInt("year"));
                    report.setStatus(rs.getString("status"));
                    report.setSubmittedDate(rs.getTimestamp("submitted_date"));
                    reportList.add(report);
                }
            }
        }
        return reportList;
    }

    public MonthlyReport getApprovedMonthlyReport(Connection connection, int reportId, String traineeId) throws SQLException {
        MonthlyReport report = null;
        String sql = "SELECT * FROM trainee_monthly_report " + "WHERE report_id=? " + "AND trainee_id=? " + "AND status='APPROVED'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reportId);
            ps.setString(2, traineeId);
            try (ResultSet rs = ps.executeQuery()) {
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
                }
            }
        }
        return report;
    }

    public MonthlyReport getMonthlyReportById(Connection connection, int reportId) throws SQLException {

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
}
