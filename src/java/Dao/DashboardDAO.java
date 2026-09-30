/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

/**
 *
 * @author david
 */

   

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DashboardDAO {

    public int getTotalTrainees(Connection con, String division) throws SQLException {

        int count = 0;

        try {

            String sql = "SELECT COUNT(*) FROM trainee_details WHERE division=?" ;

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, division);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (SQLException e) {

            throw e;

        }

        return count;
    }

    public int getTotalMentors(Connection con, String division) throws SQLException {

        int count = 0;

        try {

            String sql = "SELECT COUNT(*) FROM staff_details WHERE division=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, division);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                count = rs.getInt(1);

            }

        } catch (SQLException e) {
            throw e;
        }

        return count;
    }
    
    
    //staffdahboard
    public int getTraineeCount(Connection connection, String staffId) throws SQLException {
    String sql = "SELECT COUNT(*) FROM trainee_assignment WHERE staffId = ? AND status = 'ACCEPTED'";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, staffId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    }
    return 0;
}

public int getPendingWorkLogsCount(Connection connection, String staffId) throws SQLException {
    String sql = "SELECT COUNT(*) FROM trainee_worklog WHERE staff_id = ? AND status = 'PENDING'";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, staffId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    }
    return 0;
}

public int getPendingLeavesCount(Connection connection, String staffId) throws SQLException {
    String sql = "SELECT COUNT(*) FROM trainee_leave tl " +
                 "INNER JOIN trainee_details td ON tl.trainee_id = td.traineeId " +
                 "WHERE td.staffId = ? AND tl.status = 'PENDING'";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, staffId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    }
    return 0;
}

public int getPendingReportsCount(Connection connection, String staffId) throws SQLException {
    String sql = "SELECT COUNT(*) FROM trainee_monthly_report WHERE staff_id = ? AND status = 'PENDING'";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, staffId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    }
    return 0;
}

public int getRejectedLeavesCount(Connection connection, String staffId) throws SQLException {
    int count = 0;
    
    String sql = "SELECT COUNT(*) FROM trainee_leave tl " +
                 "INNER JOIN trainee_details td ON tl.trainee_id = td.traineeId " +
                 "WHERE td.staffId = ? AND tl.status = 'REJECTED'";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, staffId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }
    }
    return count;
}

// Add these methods to your traineeDAO class

public int getTaskCount(Connection connection, String traineeId) throws SQLException {
    String sql = "SELECT COUNT(*) FROM trainee_task WHERE trainee_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, traineeId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    }
    return 0;
}

public int getWorkLogCount(Connection connection, String traineeId) throws SQLException {
    String sql = "SELECT COUNT(*) FROM trainee_worklog WHERE trainee_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, traineeId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    }
    return 0;
}

public int getLeaveCountByStatus(Connection connection, String traineeId, String status) throws SQLException {
    String sql = "SELECT COUNT(*) FROM trainee_leave WHERE trainee_id = ? AND status = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, traineeId);
        ps.setString(2, status);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    }
    return 0;
}

public int getReportCountByStatus(Connection connection, String traineeId, String status) throws SQLException {
    String sql = "SELECT COUNT(*) FROM trainee_monthly_report WHERE trainee_id = ? AND status = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, traineeId);
        ps.setString(2, status);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) return rs.getInt(1);
    }
    return 0;
}

}

