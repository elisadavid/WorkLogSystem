/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import java.sql.Connection;
import java.sql.SQLException;
import model.headDetails;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Assignment;
import model.Notification;
import model.designation;
import model.staffDetails;
import model.traineeDetails;

/**
 *
 * @author kgaut
 */
public class HeadDAO {

    public headDetails validateHead(Connection connection, String username, String password) throws SQLException {
        headDetails objHead = null;
        String sql = "SELECT * FROM head_details " + "WHERE username=? AND password=? " + "AND status='ACTIVE'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    objHead = new headDetails();
                    objHead.setHeadId(rs.getInt("headId"));
                    objHead.setHeadName(rs.getString("headName"));
                    objHead.setUsername(rs.getString("username"));
                    objHead.setPassword(rs.getString("password"));
                    objHead.setDivision(rs.getString("division"));
                    objHead.setStatus(rs.getString("status"));

                }
            }
        }

        return objHead;
    }

    public ArrayList<traineeDetails> getTraineesByDivision(Connection connection, String division) throws SQLException {
        ArrayList<traineeDetails> list = new ArrayList<>();
        String sql = "SELECT t.*, d.designation, " + "s.staffId, s.staffName, " + "ta.assignmentId, ta.assignedBy, ta.assignedDate, " + "ta.status, ta.remarks, ta.acceptedDate, ta.rejectedDate "
                + "FROM trainee_details t " + "INNER JOIN designation d " + "ON t.designationId = d.designationId " + "LEFT JOIN trainee_assignment ta " + "ON t.traineeId = ta.traineeId "
                + "LEFT JOIN staff_details s " + "ON ta.staffId = s.staffId " + "WHERE t.division=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, division);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    traineeDetails obj = new traineeDetails();
                    designation des = new designation();
                    obj.setTraineeId(rs.getString("traineeId"));
                    obj.setTraineeName(rs.getString("traineeName"));
                    obj.setGender(rs.getString("gender"));
                    obj.setDob(rs.getDate("dob"));
                    obj.setPlace(rs.getString("place"));
                    obj.setBranch(rs.getString("branch"));
                    obj.setQualification(rs.getString("qualification"));
                    obj.setEmailId(rs.getString("emailId"));
                    obj.setPhonenumber(rs.getString("phoneNumber"));
                    obj.setJoiningDate(rs.getDate("joiningDate"));
                    obj.setCompletionDate(rs.getDate("completionDate"));
                    obj.setDivision(rs.getString("division"));

                    obj.setUsername(rs.getString("username"));
                    obj.setPassword(rs.getString("password"));

                    obj.setActive(rs.getString("active"));
                    obj.setCompletionStatus(rs.getString("completionStatus"));
                    obj.setCompletionReason(rs.getString("completionReason"));

                    des.setDesignationId(rs.getInt("designationId"));
                    des.setDesignation(rs.getString("designation"));
                    obj.setObjDesignationitems(des);

                    // Mentor Details
                    if (rs.getString("staffId") != null) {
                        staffDetails staff = new staffDetails();
                        staff.setStaffId(rs.getString("staffId"));
                        staff.setStaffName(rs.getString("staffName"));

                        obj.setObjStaff(staff);
                    }

                    // Assignment Details
                    if (rs.getObject("assignmentId") != null) {
                        Assignment assign = new Assignment();
                        assign.setAssignmentId(rs.getInt("assignmentId"));
                        assign.setTraineeId(rs.getString("traineeId"));
                        assign.setStaffId(rs.getString("staffId"));
                        assign.setAssignedBy(rs.getString("assignedBy"));
                        assign.setAssignedDate(rs.getDate("assignedDate"));
                        assign.setStatus(rs.getString("status"));
                        assign.setRemarks(rs.getString("remarks"));
                        assign.setAcceptedDate(rs.getString("acceptedDate"));
                        assign.setRejectedDate(rs.getString("rejectedDate"));

                        obj.setObjAssignment(assign);
                    }

                    list.add(obj);
                }
            }
        }

        return list;
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

    public ArrayList<designation> getDesignationList(Connection connection) throws SQLException {
        ArrayList<designation> list = new ArrayList<>();
        String sql = "SELECT designationId, designation " + "FROM designation " + "ORDER BY designation";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                designation obj = new designation();
                obj.setDesignationId(rs.getInt("designationId"));
                obj.setDesignation(rs.getString("designation"));
                list.add(obj);
            }
        }
        return list;
    }

    public boolean addStaff(Connection connection, staffDetails obj) throws SQLException {
        boolean status = false;
        String sql = "INSERT INTO staff_details " + "(staffId, staffName, gender, emailId, phoneNumber, " + "designation, division, username, password, active) " + "VALUES (?,?,?,?,?,?,?,?,?,?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, obj.getStaffId());
            ps.setString(2, obj.getStaffName());
            ps.setString(3, obj.getGender());
            ps.setString(4, obj.getEmailId());
            ps.setString(5, obj.getPhoneNumber());
            ps.setString(6, obj.getDesignation());
            ps.setString(7, obj.getDivision());     // Automatically from Head login
            ps.setString(8, obj.getUsername());
            ps.setString(9, obj.getPassword());
            ps.setString(10, obj.getActive());

            int i = ps.executeUpdate();

            if (i > 0) {
                status = true;
            }
        }

        return status;
    }

    public ArrayList<staffDetails> getStaffList(Connection connection, String division) throws SQLException {
        ArrayList<staffDetails> list = new ArrayList<>();
        String sql = "SELECT * FROM staff_details WHERE division=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, division);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    staffDetails obj = new staffDetails();
                    obj.setStaffId(rs.getString("staffId"));
                    obj.setStaffName(rs.getString("staffName"));
                    obj.setGender(rs.getString("gender"));
                    obj.setEmailId(rs.getString("emailId"));
                    obj.setPhoneNumber(rs.getString("phoneNumber"));
                    obj.setDesignation(rs.getString("designation"));
                    obj.setDivision(rs.getString("division"));
                    obj.setUsername(rs.getString("username"));
                    obj.setActive(rs.getString("active"));

                    list.add(obj);
                }
            }
        }

        return list;
    }

    public ArrayList<staffDetails> getactiveStaffLists(Connection connection, String division) throws SQLException {
        ArrayList<staffDetails> list = new ArrayList<>();
        String sql = "SELECT * FROM staff_details WHERE division=? and active='YES'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, division);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {

                    staffDetails obj = new staffDetails();

                    obj.setStaffId(rs.getString("staffId"));
                    obj.setStaffName(rs.getString("staffName"));
                    obj.setGender(rs.getString("gender"));
                    obj.setEmailId(rs.getString("emailId"));
                    obj.setPhoneNumber(rs.getString("phoneNumber"));
                    obj.setDesignation(rs.getString("designation"));
                    obj.setDivision(rs.getString("division"));
                    obj.setUsername(rs.getString("username"));
                    obj.setActive(rs.getString("active"));

                    list.add(obj);
                }
            }
        }

        return list;
    }

    public void changeStaffStatus(Connection connection, String staffId, String active) throws SQLException {
        String sql = "UPDATE staff_details SET active=? WHERE staffId=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, active);
            ps.setString(2, staffId);
            ps.executeUpdate();
        }
    }

    public staffDetails getStaffById(Connection connection, String staffId) throws SQLException {
        String sql = "SELECT * FROM staff_details WHERE staffId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staffId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    staffDetails obj = new staffDetails();
                    obj.setStaffId(rs.getString("staffId"));
                    obj.setStaffName(rs.getString("staffName"));
                    obj.setGender(rs.getString("gender"));
                    obj.setEmailId(rs.getString("emailId"));
                    obj.setPhoneNumber(rs.getString("phoneNumber"));
                    obj.setDesignation(rs.getString("designation"));
                    obj.setUsername(rs.getString("username"));
                    obj.setDivision(rs.getString("division"));
                    return obj;
                }
            }
        }
        return null;
    }

    public boolean updateStaff(Connection connection, staffDetails obj) throws SQLException {
        boolean status = false;
        String sql = "UPDATE staff_details SET " + "staffName=?," + "gender=?," + "emailId=?," + "phoneNumber=?," + "designation=?," + "username=?," + "division=? " + "WHERE staffId=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, obj.getStaffName());
            ps.setString(2, obj.getGender());
            ps.setString(3, obj.getEmailId());
            ps.setString(4, obj.getPhoneNumber());
            ps.setString(5, obj.getDesignation());
            ps.setString(6, obj.getUsername());
            ps.setString(7, obj.getDivision());
            ps.setString(8, obj.getStaffId());
            if (ps.executeUpdate() > 0) {
                status = true;
            }
        }
        return status;
    }

    public boolean assignMentor(Connection connection, String traineeId, String staffId) throws SQLException {
        boolean status = false;
        String sql = "UPDATE trainee_details SET staffId=? WHERE traineeId=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staffId);
            ps.setString(2, traineeId);
            if (ps.executeUpdate() > 0) {
                status = true;
            }
        }
        return status;
    }

    public ArrayList<traineeDetails> getAssignedMentors(Connection connection, String division) throws SQLException {
        ArrayList<traineeDetails> list = new ArrayList<>();
        String sql = "SELECT t.traineeId," + "t.traineeName," + "t.division," + "s.staffId," + "s.staffName " + "FROM trainee_details t " + "INNER JOIN staff_details s " + "ON t.staffId=s.staffId " + "WHERE t.division=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, division);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            traineeDetails obj = new traineeDetails();
            obj.setTraineeId(rs.getString("traineeId"));
            obj.setTraineeName(rs.getString("traineeName"));
            obj.setDivision(rs.getString("division"));
            staffDetails staff = new staffDetails();
            staff.setStaffId(rs.getString("staffId"));
            staff.setStaffName(rs.getString("staffName"));
            obj.setObjStaff(staff);
            list.add(obj);
        }
        return list;
    }

    public boolean assignedMentor(Connection connection, String traineeId, String staffId, String headId) throws SQLException {
        String sql = "INSERT INTO trainee_assignment " + "(traineeId, staffId, assignedBy, assignedDate, status) " + "VALUES (?, ?, ?, NOW(), 'PENDING')";
        boolean result;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, traineeId);
            ps.setString(2, staffId);
            ps.setString(3, headId);
            result = ps.executeUpdate() > 0;
        }
        return result;
    }

    public ArrayList<Assignment> getAssignmentList(Connection connection, String division) throws SQLException {
        ArrayList<Assignment> list = new ArrayList<>();
        String sql = "SELECT a.assignmentId," + "a.traineeId," + "a.staffId," + "a.status," + "a.assignedDate," + "a.remarks," + "t.traineeName,"
                + "s.staffName " + "FROM trainee_assignment a " + "INNER JOIN trainee_details t " + "ON a.traineeId=t.traineeId " + "INNER JOIN staff_details s "
                + "ON a.staffId=s.staffId " + "WHERE t.division=? " + "ORDER BY a.assignmentId DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, division);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Assignment obj = new Assignment();
                    obj.setAssignmentId(rs.getInt("assignmentId"));
                    obj.setTraineeId(rs.getString("traineeId"));
                    obj.setStaffId(rs.getString("staffId"));
                    obj.setStatus(rs.getString("status"));
                    obj.setAssignedDate(rs.getTimestamp("assignedDate"));
                    obj.setRemarks(rs.getString("remarks"));
                    traineeDetails trainee = new traineeDetails();
                    trainee.setTraineeName(rs.getString("traineeName"));
                    obj.setObjTrainee(trainee);
                    staffDetails staff = new staffDetails();
                    staff.setStaffName(rs.getString("staffName"));
                    obj.setObjStaff(staff);
                    list.add(obj);
                }
            }
        }
        return list;
    }

    public boolean addNotification(Connection connection, String recipientId, String userRole, String title, String message) throws SQLException {
        String sql = "INSERT INTO notifications " + "(recipient_id, user_role, title, message, status, created_at) " + "VALUES (?, ?, ?, ?, ?, NOW())";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, recipientId);
        ps.setString(2, userRole);
        ps.setString(3, title);
        ps.setString(4, message);
        ps.setString(5, "UNREAD");   // or "NEW" depending on your application
        return ps.executeUpdate() > 0;
    }

    public ArrayList<Assignment> getPendingAssignments(Connection connection, String staffId) throws SQLException {
        ArrayList<Assignment> list = new ArrayList<>();
        String sql = "SELECT a.assignmentId," + "a.traineeId," + "a.staffId," + "a.assignedDate," + "a.status," + "t.traineeName " + "FROM trainee_assignment a "
                + "INNER JOIN trainee_details t " + "ON a.traineeId=t.traineeId " + "WHERE a.staffId=? " + "AND a.status='PENDING'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staffId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Assignment obj = new Assignment();
                    obj.setAssignmentId(rs.getInt("assignmentId"));
                    obj.setTraineeId(rs.getString("traineeId"));
                    obj.setStaffId(rs.getString("staffId"));
                    obj.setAssignedDate(rs.getTimestamp("assignedDate"));
                    obj.setStatus(rs.getString("status"));
                    traineeDetails trainee = new traineeDetails();
                    trainee.setTraineeName(rs.getString("traineeName"));
                    obj.setObjTrainee(trainee);
                    list.add(obj);
                }
            }
        }
        return list;
    }

    public boolean acceptAssignment(Connection connection, int assignmentId) throws SQLException {
        String sql = "UPDATE trainee_assignment " + "SET status='ACCEPTED', " + "acceptedDate=NOW() " + "WHERE traineeId=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, assignmentId);
        boolean result = ps.executeUpdate() > 0;
        ps.close();

        if (result) {
            sql = "SELECT traineeId, staffId " + "FROM trainee_assignment " + "WHERE assignmentId=?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, assignmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String traineeId = rs.getString("traineeId");
                    String staffId = rs.getString("staffId");
                    try (PreparedStatement ps2 = connection.prepareStatement("UPDATE trainee_details " + "SET status='ACCEPTED', " + "staffId=? " + "WHERE traineeId=?")) {
                        ps2.setString(1, staffId);
                        ps2.setString(2, traineeId);
                        ps2.executeUpdate();
                    }
                }
            }
            ps.close();
        }
        return result;
    }

    public boolean rejectAssignment(Connection connection, int assignmentId, String remarks) throws SQLException {
        String sql = "UPDATE trainee_assignment " + "SET status='REJECTED', " + "remarks=?, " + "rejectedDate=NOW() " + "WHERE assignmentId=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, remarks);
        ps.setInt(2, assignmentId);
        boolean result = ps.executeUpdate() > 0;
        ps.close();
        if (result) {
            sql = "SELECT traineeId " + "FROM trainee_assignment " + "WHERE assignmentId=?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, assignmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String traineeId = rs.getString("traineeId");
                    try (PreparedStatement ps2 = connection.prepareStatement("UPDATE trainee_details " + "SET status='REJECTED', " + "staffId=NULL " + "WHERE traineeId=?")) {
                        ps2.setString(1, traineeId);
                        ps2.executeUpdate();
                    }
                }
            }
            ps.close();
        }
        return result;
    }

    public Assignment getAssignmentById(Connection connection, int assignmentId) throws SQLException {
        Assignment obj = null;
        String sql = "SELECT * FROM trainee_assignment WHERE assignmentId=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, assignmentId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            obj = new Assignment();
            obj.setAssignmentId(rs.getInt("assignmentId"));
            obj.setTraineeId(rs.getString("traineeId"));
            obj.setStaffId(rs.getString("staffId"));
            obj.setAssignedBy(rs.getString("assignedBy"));
            obj.setStatus(rs.getString("status"));
            obj.setRemarks(rs.getString("remarks"));
        }
        return obj;
    }

    public boolean updateTraineeMentor(Connection connection, String traineeId, String staffId) throws SQLException {
        String sql = "UPDATE trainee_details " + "SET staffId=? " + "WHERE traineeId=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, staffId);
        ps.setString(2, traineeId);
        return ps.executeUpdate() > 0;
    }

    public boolean acceptTraineeStatus(Connection connection, String traineeId, String staffId) throws SQLException {
        String sql = "UPDATE trainee_details SET staffId = ?, status = 'ACTIVE' WHERE traineeId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, staffId);
            ps.setString(2, traineeId);
            return ps.executeUpdate() > 0;
        }
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
    


    public int getTotalTraineesCount(Connection conn, String division) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM trainee WHERE division = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, division);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getTotalMentorsCount(Connection conn, String division) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM staff WHERE division = ? AND active = 'YES'";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, division);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int getUnreadNotificationsCount(Connection conn, String headId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM notifications WHERE userId = ? AND status = 'unread'";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, headId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public ArrayList<Notification> getNotificationsForHead(Connection conn, String headId) {
        ArrayList<Notification> list = new ArrayList<>();
        String sql = "SELECT * FROM notifications WHERE userId = ? ORDER BY id DESC LIMIT 5";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, headId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notification n = new Notification();
                n.setNotifId(rs.getInt("id"));
                n.setMessage(rs.getString("message"));
                n.setStatus(rs.getString("status"));
                list.add(n);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
