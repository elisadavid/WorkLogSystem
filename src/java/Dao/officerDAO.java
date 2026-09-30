/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import java.sql.Connection;
import java.util.ArrayList;
import model.designation;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.List;
import model.StaffDesignation;
import model.officerDetails;
import model.registration;
import model.traineeDetails;

/**
 *
 * @author kgaut
 */
public class officerDAO {

    // Load Designation
    public ArrayList<designation> getDesignationList(Connection connection) throws SQLException {

        ArrayList<designation> list = new ArrayList<>();

        String sql = "SELECT designationId, designation FROM designation";

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
    // Save Trainee

    public boolean saveTrainee(Connection connection, traineeDetails obj) throws SQLException {

        boolean flag = false;

        String sql = "INSERT INTO trainee_details " + "(traineeId, traineeName, gender, dob, place, " + "branch, qualification, designationId, " + "emailId, phoneNumber, joiningDate, completionDate, "
                + "division, active) " + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, obj.getTraineeId());
            ps.setString(2, obj.getTraineeName());
            ps.setString(3, obj.getGender());
            ps.setDate(4, new java.sql.Date(obj.getDob().getTime()));
            ps.setString(5, obj.getPlace());
            ps.setString(6, obj.getBranch());
            ps.setString(7, obj.getQualification());

            ps.setInt(8,
                    obj.getObjDesignationitems().getDesignationId());

            ps.setString(9, obj.getEmailId());
            ps.setString(10, obj.getPhonenumber());

            ps.setDate(11,
                    new java.sql.Date(obj.getJoiningDate().getTime()));

            ps.setDate(12,
                    new java.sql.Date(obj.getCompletionDate().getTime()));

            ps.setString(13, obj.getDivision());
            ps.setString(14, obj.getActive());

            flag = ps.executeUpdate() > 0;
        }

        return flag;
    }

    // Load Trainee List
    public ArrayList<traineeDetails> getTraineeList(Connection connection) throws SQLException {

        ArrayList<traineeDetails> list = new ArrayList<>();

        String sql = "SELECT t.*, d.designation " + "FROM trainee_details t " + "LEFT JOIN designation d " + "ON t.designationId = d.designationId";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

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
                obj.setActive(rs.getString("active"));

                des.setDesignationId(rs.getInt("designationId"));
                des.setDesignation(rs.getString("designation"));

                obj.setObjDesignationitems(des);

                list.add(obj);
            }
        }

        return list;
    }

    public boolean changeStatus(Connection connection, String traineeId, String status) throws SQLException {

        String sql = "UPDATE trainee_details SET active=? WHERE traineeId=?";

        PreparedStatement ps = connection.prepareStatement(sql);

        ps.setString(1, status);
        ps.setString(2, traineeId);

        return ps.executeUpdate() > 0;
    }

//    public String  updateTrainee(Connection connection, traineeDetails obj) throws SQLException {
//
//        String msg = "";
//
//
//        String sql = "UPDATE trainee_details SET " + "traineeName=?," + "gender=?," + "dob=?," + "place=?," + "branch=?," + "qualification=?,"
//                + "emailId=?," + "phoneNumber=?," + "designationId=?," + "joiningDate=?," + "completionDate=?," + "division=? " + "WHERE traineeId=?";
//
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, obj.getTraineeName());
//            ps.setString(2, obj.getGender());
//            ps.setDate(3, new java.sql.Date(obj.getDob().getTime()));
//            ps.setString(4, obj.getPlace());
//            ps.setString(5, obj.getBranch());
//            ps.setString(6, obj.getQualification());
//            ps.setString(7, obj.getEmailId());
//            ps.setString(8, obj.getPhonenumber());
//            ps.setInt(9, obj.getObjDesignationitems().getDesignationId());
//            ps.setDate(10, new java.sql.Date(obj.getJoiningDate().getTime()));
//            ps.setDate(11, new java.sql.Date(obj.getCompletionDate().getTime()));
//            ps.setString(12, obj.getDivision());
//            ps.setString(13, obj.getTraineeId());
//            ps.executeUpdate();
//
//        }
//        connection.commit();
//        msg = "Trainee '" + obj.getTraineeName() + "' updated successfully!";
//
//         } catch (SQLException e) {
//            connection.rollback();
//            throw e;
//        } finally {
//            connection.setAutoCommit(true);
//        }
//        return msg;
//
//    }
    public String updateTrainee(Connection connection, traineeDetails obj) throws SQLException {
        String msg = "";
        String sql = "UPDATE trainee_details SET " + "traineeName=?," + "gender=?," + "dob=?," + "place=?," + "branch=?," + "qualification=?,"
                + "emailId=?," + "phoneNumber=?," + "designationId=?," + "joiningDate=?," + "completionDate=?," + "division=? " + "WHERE traineeId=?";
        try {
            connection.setAutoCommit(false);

            // Update the batch if no duplicate exists
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, obj.getTraineeName());
                ps.setString(2, obj.getGender());
                ps.setDate(3, new java.sql.Date(obj.getDob().getTime()));
                ps.setString(4, obj.getPlace());
                ps.setString(5, obj.getBranch());
                ps.setString(6, obj.getQualification());
                ps.setString(7, obj.getEmailId());
                ps.setString(8, obj.getPhonenumber());
                ps.setInt(9, obj.getObjDesignationitems().getDesignationId());
                ps.setDate(10, new java.sql.Date(obj.getJoiningDate().getTime()));
                ps.setDate(11, new java.sql.Date(obj.getCompletionDate().getTime()));
                ps.setString(12, obj.getDivision());
                ps.setString(13, obj.getTraineeId());
                ps.executeUpdate();
            }
            connection.commit();
            msg = "Trainee '" + obj.getTraineeName() + "' updated successfully!";

        } catch (SQLException e) {
            connection.rollback();
            throw e;
        } finally {
            connection.setAutoCommit(true);
        }
        return msg;
    }

    public officerDetails validateOfficer(Connection connection, String username, String password) {

        officerDetails officer = null;
        String sql = "SELECT * FROM officer WHERE username = ? AND password = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                officer = new officerDetails();
                officer.setStaffid(rs.getString("officerId"));
                officer.setStaffname(rs.getString("officerName"));
                officer.setUsername(rs.getString("username"));
                officer.setPassword(rs.getString("password"));
//                officer.setStatus(rs.getString("status"));
//                officer.setActive(rs.getString("active"));
//                officer.setDivision(rs.getString("division"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return officer;
    }

//    public ArrayList<registration> getRegistrationList(Connection connection) {
//    ArrayList<registration> list = new ArrayList<>();
//    
//    // IMPORTANT: Make sure 'registration_table' matches your actual MySQL table name
//    String sql = "SELECT * FROM registration_table"; 
//    
//    try (PreparedStatement ps = connection.prepareStatement(sql); 
//         ResultSet rs = ps.executeQuery()) {
//        
//        while (rs.next()) {
//            registration reg = new registration();
//            
//            // Map the database columns to your registration model fields
//            // Ensure these column names match your MySQL table exactly
//            reg.setMentorId(rs.getInt("mentor_id"));
//            reg.setStaffCode(rs.getString("staff_code"));
//            reg.setFullName(rs.getString("full_name"));
//            reg.setEmail(rs.getString("email"));
//            reg.setPassword(rs.getString("password"));
//            reg.setPhone(rs.getString("phone"));
//            reg.setDepartment(rs.getString("department")); 
//            reg.setMentorDesignationId(rs.getString("designation_id"));
//            
//            list.add(reg);
//        }
//    } catch (SQLException e) {
//        e.printStackTrace();
//    }
//    return list;
//}
// public ArrayList<StaffDesignation> getStaffDesignationList(Connection connection) {
//    ArrayList<StaffDesignation> list = new ArrayList<>();
//    // Use actual column names from your DB (no spaces!)
//    String sql = "SELECT staff_designation_id, designation_name FROM staff_designation";
//    try (PreparedStatement ps = connection.prepareStatement(sql); 
//         ResultSet rs = ps.executeQuery()) {
//        while (rs.next()) {
//            StaffDesignation obj = new StaffDesignation();
//            obj.setStaffDesignationid(rs.getInt("staff_designation_id"));
//            obj.setStaffDesignation(rs.getString("designation_name"));
//            list.add(obj);
//        }
//    } catch (SQLException e) {
//        e.printStackTrace();
//    }
//    return list;
//}
    public boolean saveOfficerRegistration(Connection connection, officerDetails officer) {

        String sql = "INSERT INTO officer (officerId, officerName, username, password, email, phone, division, staffDesignationId, status, active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, officer.getStaffid());
            ps.setString(2, officer.getStaffname());
            ps.setString(3, officer.getUsername());
            ps.setString(4, officer.getPassword());
            ps.setString(5, officer.getEmail());
            ps.setString(6, officer.getPhone());
            ps.setString(7, officer.getDivision());
            ps.setInt(8, officer.getStaffDesignationid());
            ps.setString(9, "ACTIVE");
            ps.setString(10, "YES");

            int row = ps.executeUpdate();
            return row > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<StaffDesignation> getAllDesignations(Connection conn) throws SQLException {
        List<StaffDesignation> list = new ArrayList<>();
        String sql = "SELECT staffDesignation_id, staffDesignation FROM staff_designation";
        try {
            java.sql.PreparedStatement ps = conn.prepareStatement(sql);
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StaffDesignation sd = new StaffDesignation();
                // Make sure these column names match your DB exactly
                sd.setStaffDesignationid(rs.getInt("staffDesignation_id"));
                sd.setStaffDesignation(rs.getString("staffDesignation"));
                list.add(sd);
            }
        } catch (java.sql.SQLException e) {
            throw e;
        }
        return list;
    }

    // Add this method to officerDAO.java
    public traineeDetails getTraineeById(Connection connection, String traineeId) throws SQLException {
        String sql = "SELECT t.*, d.designation FROM trainee_details t LEFT JOIN designation d ON t.designationId = d.designationId WHERE t.traineeId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, traineeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
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
                    obj.setActive(rs.getString("active"));
                    des.setDesignationId(rs.getInt("designationId"));
                    des.setDesignation(rs.getString("designation"));
                    obj.setObjDesignationitems(des);
                    return obj;
                }
            }
        }
        return null;
    }

    public boolean saveHeadRegistration(Connection conn, officerDetails head) throws SQLException {

        String sql = "INSERT INTO head_details (headId, headName, username, password, division, email, phone, staffDesignationId, status, active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, head.getStaffid());
            ps.setString(2, head.getStaffname());
            ps.setString(3, head.getUsername());
            ps.setString(4, head.getPassword());
            ps.setString(5, head.getDivision());
            ps.setString(6, head.getEmail());
            ps.setString(7, head.getPhone());

            ps.setInt(8, head.getStaffDesignationid());
            ps.setString(9, "YES");
            ps.setString(10, "ACTIVE");

            return ps.executeUpdate() > 0;
        }
    }
    
 
    public int getTotalTraineeCount(Connection connection) throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM trainee_details";
        try (PreparedStatement ps = connection.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }
        return count;
    }

   
    public int getActiveTraineeCount(Connection connection) throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM trainee_details WHERE active = 'YES'";
        try (PreparedStatement ps = connection.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }
        return count;
    }

  
    public int getInactiveTraineeCount(Connection connection) throws SQLException {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM trainee_details WHERE active = 'NO'";
        try (PreparedStatement ps = connection.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }
        return count;
    }

}
