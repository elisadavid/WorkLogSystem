package Controller;

import jakarta.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import model.errorvalidate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.time.LocalDate;

/**
 * Server-side validation controller aligned with JSP client-side logic.
 *
 * @author Trainee2
 */
public class validationController {
    
    private static final Pattern LOGIN_USERNAME_PATTERN =
        Pattern.compile("^[A-Za-z0-9_-]{3,20}$");

private static final Pattern LOGIN_PASSWORD_PATTERN =
        Pattern.compile("^.{4,30}$");

    // ============================================================
    // REGEX PATTERNS (Strict Limits)
    // ============================================================
    

    
    // Password: 8-15 chars, must have Upper, Lower, Digit, and Special Char
//    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,15}$");

    private errorvalidate createError(String id, String msg) {
        errorvalidate error = new errorvalidate();
        error.setErrorid(id);
        error.setErrorMsg(msg);
        return error;
    }

    private String getParameter(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        return (value == null) ? "" : value.trim();
    }

    // ============================================================
    // TRAINEE VALIDATION (Complete with Place, Branch, Qualification)
    // ============================================================
  public List<errorvalidate> validateAddTraineeFields(HttpServletRequest request, Connection connection) {
    List<errorvalidate> errorList = new ArrayList<>();
    
    // REMOVED .trim() here to detect leading spaces
    String traineeId = getParameter(request, "traineeId");
    String traineeName = getParameter(request, "TraineeName");
    String gender = getParameter(request, "gender");
    String dob = getParameter(request, "dob");
    String place = getParameter(request, "place");
    String branch = getParameter(request, "branch");
    String qualification = getParameter(request, "qualification");
    String email = getParameter(request, "EmailId");
    String phone = getParameter(request, "PhoneNumber");
    String designation = getParameter(request, "combodesignationId");
    String joiningDate = getParameter(request, "joiningDate");
    String division = getParameter(request, "Division");

    // =====================================================
    // TRAINEE ID: Allow Alphanumeric/Special, No leading space, Max 8
    // =====================================================
    if (traineeId == null || traineeId.isEmpty()) {
        errorList.add(createError("traineeId", "Trainee ID is required."));
    } else if (traineeId.startsWith(" ")) {
        errorList.add(createError("traineeId", "Leading spaces are not allowed."));
    } else if (traineeId.length() > 8) {
        errorList.add(createError("traineeId", "Trainee ID cannot exceed 8 characters."));
    } else if (isDuplicate(connection, "trainee_table", "trainee_id", traineeId)) {
        errorList.add(createError("traineeId", "Trainee ID already exists."));
    }

    // =====================================================
    // TRAINEE NAME: Only characters, No leading space, Max 25
    // =====================================================
    if (traineeName == null || traineeName.isEmpty()) {
        errorList.add(createError("TraineeName", "Trainee Name is required."));
    } else if (traineeName.startsWith(" ")) {
        errorList.add(createError("TraineeName", "Leading spaces are not allowed."));
    } else if (!traineeName.matches("^[A-Za-z ]+$")) {
        errorList.add(createError("TraineeName", "Only alphabets are allowed."));
    } else if (traineeName.length() > 25) {
        errorList.add(createError("TraineeName", "Trainee Name cannot exceed 25 characters."));
    }

    // =====================================================
    // GENDER
    // =====================================================
    if (gender == null || (!(gender.equals("Male") || gender.equals("Female")))) {
        errorList.add(createError("gender", "Please select Gender."));
    }

    // =====================================================
    // DATE OF BIRTH
    // =====================================================
    if (dob == null || dob.isEmpty()) {
        errorList.add(createError("dob", "Date of Birth is required."));
    } else {
        try {
            LocalDate birth = LocalDate.parse(dob);
            LocalDate today = LocalDate.now();
            if (birth.isAfter(today)) {
                errorList.add(createError("dob", "Date of Birth cannot be in the future."));
            } else if (birth.isAfter(today.minusYears(18))) {
                errorList.add(createError("dob", "Age must be 18 years or above."));
            }
        } catch (Exception e) {
            errorList.add(createError("dob", "Invalid Date of Birth."));
        }
    }

    // =====================================================
    // PLACE: Only characters, No leading space, Max 25
    // =====================================================
    if (place == null || place.isEmpty()) {
        errorList.add(createError("place", "Place is required."));
    } else if (place.startsWith(" ")) {
        errorList.add(createError("place", "Leading spaces are not allowed."));
    } else if (!place.matches("^[A-Za-z ]+$")) {
        errorList.add(createError("place", "Only alphabets are allowed."));
    } else if (place.length() > 25) {
        errorList.add(createError("place", "Place cannot exceed 25 characters."));
    }

    // =====================================================
    // BRANCH: Only characters, No leading space, Max 25
    // =====================================================
    if (branch == null || branch.isEmpty()) {
        errorList.add(createError("branch", "Branch is required."));
    } else if (branch.startsWith(" ")) {
        errorList.add(createError("branch", "Leading spaces are not allowed."));
    } else if (!branch.matches("^[A-Za-z ]+$")) {
        errorList.add(createError("branch", "Only alphabets are allowed."));
    } else if (branch.length() > 25) {
        errorList.add(createError("branch", "Branch cannot exceed 25 characters."));
    }

    // =====================================================
    // QUALIFICATION: Only characters, No leading space, Max 25
    // =====================================================
    if (qualification == null || qualification.isEmpty()) {
        errorList.add(createError("qualification", "Qualification is required."));
    } else if (qualification.startsWith(" ")) {
        errorList.add(createError("qualification", "Leading spaces are not allowed."));
    } else if (!qualification.matches("^[A-Za-z ]+$")) {
        errorList.add(createError("qualification", "Only alphabets are allowed."));
    } else if (qualification.length() > 25) {
        errorList.add(createError("qualification", "Qualification cannot exceed 25 characters."));
    }

    // =====================================================
    // DESIGNATION
    // =====================================================
    if (designation == null || designation.isEmpty()) {
        errorList.add(createError("combodesignationId", "Please select Designation."));
    }

    // =====================================================
    // EMAIL
    // =====================================================
    if (email == null || email.isEmpty()) {
        errorList.add(createError("EmailId", "Email is required."));
    } else if (!email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {
        errorList.add(createError("EmailId", "Enter a valid Email Address."));
    } else if (isDuplicate(connection, "trainee_table", "email_id", email)) {
        errorList.add(createError("EmailId", "Email already exists."));
    }

    // =====================================================
    // PHONE NUMBER: Only numbers, No leading space, Max 10
    // =====================================================
    if (phone == null || phone.isEmpty()) {
        errorList.add(createError("PhoneNumber", "Phone Number is required."));
    } else if (phone.startsWith(" ")) {
        errorList.add(createError("PhoneNumber", "Leading spaces are not allowed."));
    } else if (!phone.matches("^\\d{10}$")) {
        errorList.add(createError("PhoneNumber", "Enter exactly 10 digits."));
    }

    // =====================================================
    // JOINING DATE
    // =====================================================
    if (joiningDate == null || joiningDate.isEmpty()) {
        errorList.add(createError("joiningDate", "Joining Date is required."));
    } else {
        try {
            LocalDate join = LocalDate.parse(joiningDate);
            if (join.isAfter(LocalDate.now())) {
                errorList.add(createError("joiningDate", "Joining Date cannot be in the future."));
            }
        } catch (Exception e) {
            errorList.add(createError("joiningDate", "Invalid Joining Date."));
        }
    }

    // =====================================================
    // DIVISION
    // =====================================================
    if (division == null || division.isEmpty()) {
        errorList.add(createError("Division", "Please select Division."));
    }

    return errorList;
}
    
  
    public List<errorvalidate> validateAddMentorFields(HttpServletRequest request, Connection connection) {

    List<errorvalidate> errorList = new ArrayList<>();

    String staffId = getParameter(request, "staffId");
    String staffName = getParameter(request, "staffName");
    String gender = getParameter(request, "gender");
    String email = getParameter(request, "email");
    String phone = getParameter(request, "phone");
    String designation = getParameter(request, "designation");
    String username = getParameter(request, "username");
    String password = getParameter(request, "password");

    // ===========================
    // STAFF ID
    // ===========================

    if (staffId.isBlank()) {

        errorList.add(createError("staffId", "Staff ID is required."));

    } else if (!staffId.matches("^[A-Za-z0-9]{7}$")) {

        errorList.add(createError("staffId",
                "Staff ID must contain exactly 7 letters or numbers."));

    } else if (isDuplicate(connection, "mentor_table", "staff_id", staffId)) {

        errorList.add(createError("staffId",
                "Staff ID already exists."));
    }

    // ===========================
    // STAFF NAME
    // ===========================

    if (staffName.isBlank()) {

        errorList.add(createError("staffName",
                "Staff Name is required."));

    } else if (!staffName.matches("^[A-Za-z ]{2,100}$")) {

        errorList.add(createError("staffName",
                "Only letters and spaces are allowed."));
    }

    // ===========================
    // GENDER
    // ===========================

    if (gender.isBlank()) {

        errorList.add(createError("gender",
                "Please select gender."));

    } else if (!(gender.equals("Male") || gender.equals("Female"))) {

        errorList.add(createError("gender",
                "Invalid gender."));
    }

    // ===========================
    // EMAIL
    // ===========================

    if (email.isBlank()) {

        errorList.add(createError("email",
                "Email is required."));

    } else if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {

        errorList.add(createError("email",
                "Invalid email address."));

    } else if (isDuplicate(connection, "mentor_table", "email", email)) {

        errorList.add(createError("email",
                "Email already exists."));
    }

    // ===========================
    // PHONE
    // ===========================

    if (phone.isBlank()) {

        errorList.add(createError("phone",
                "Phone Number is required."));

    } else if (!phone.matches("^[0-9]{10}$")) {

        errorList.add(createError("phone",
                "Phone Number must contain exactly 10 digits."));
    }

    // ===========================
    // DESIGNATION
    // ===========================

    if (designation.isBlank()) {

        errorList.add(createError("designation",
                "Designation is required."));

    } else if (!designation.matches("^[A-Za-z ]{2,100}$")) {

        errorList.add(createError("designation",
                "Only letters and spaces are allowed."));
    }

    // ===========================
    // USERNAME
    // ===========================

    if (username.isBlank()) {

        errorList.add(createError("username",
                "Username is required."));

    } else if (!username.matches("^[A-Za-z0-9_]{5,30}$")) {

        errorList.add(createError("username",
                "Username must be 5-30 letters, numbers or underscore."));

    } else if (isDuplicate(connection, "mentor_table", "username", username)) {

        errorList.add(createError("username",
                "Username already exists."));
    }

    // ===========================
    // PASSWORD
    // ===========================

    if (password.isBlank()) {

        errorList.add(createError("password",
                "Password is required."));

    } else if (!password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,15}$")) {

        errorList.add(createError("password",
                "Password must contain Uppercase, Lowercase, Number and Special Character."));
    }

    return errorList;
}

    private boolean isDuplicate(Connection connection, String table, String column, String value) {
        String query = "SELECT 1 FROM " + table + " WHERE " + column + " = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, value);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            return false;
        }
    }
    
    // ============================================================
// LOGIN VALIDATION
// ============================================================

public List<errorvalidate> validateLoginFields(HttpServletRequest request) {

    List<errorvalidate> errorList = new ArrayList<>();

    String username = getParameter(request, "username");
    String password = getParameter(request, "password");

    // USERNAME
    if (username.isEmpty()) {

        errorList.add(createError("username",
                "Username is required."));

    } else if (!LOGIN_USERNAME_PATTERN.matcher(username).matches()) {

        errorList.add(createError("username",
                "Username must be 3-20 characters and contain only letters, numbers and underscore."));
    }

    // PASSWORD
    if (password.isEmpty()) {

        errorList.add(createError("password",
                "Password is required."));

    } else if (!LOGIN_PASSWORD_PATTERN.matcher(password).matches()) {

        errorList.add(createError("password",
                "Password must be between 4 and 30 characters."));
    }

    return errorList;
}

//public List<errorvalidate> validateChangePassword(HttpServletRequest request) {
//
//    List<errorvalidate> errorList = new ArrayList<>();
//
//    String oldPassword = getParameter(request, "oldPassword");
//    String newPassword = getParameter(request, "newPassword");
//    String confirmPassword = getParameter(request, "confirmPassword");
//
//    // Current Password
//    if (oldPassword.isEmpty()) {
//        errorList.add(createError("oldPassword",
//                "Current Password is required."));
//    }
//
//    // New Password
//    if (newPassword.isEmpty()) {
//
//        errorList.add(createError("newPassword",
//                "New Password is required."));
//
//    } else if (!PASSWORD_PATTERN.matcher(newPassword).matches()) {
//
//        errorList.add(createError("newPassword",
//                "Password must be 8-15 characters with uppercase, lowercase, number and special character."));
//    }
//
//    // Confirm Password
//    if (confirmPassword.isEmpty()) {
//
//        errorList.add(createError("confirmPassword",
//                "Confirm Password is required."));
//
//    } else if (!newPassword.equals(confirmPassword)) {
//
//        errorList.add(createError("confirmPassword",
//                "New Password and Confirm Password do not match."));
//    }
//
//    return errorList;
//}

public List<errorvalidate> validateUpdateMentorFields(HttpServletRequest request, Connection connection, String staffId) {
    List<errorvalidate> errorList = new ArrayList<>();
    String staffName = getParameter(request, "staffName");
    String gender = getParameter(request, "gender");
    String email = getParameter(request, "email");
    String phone = getParameter(request, "phone");
    String designation = getParameter(request, "designation");
    String username = getParameter(request, "username");

    // STAFF NAME
    if (staffName.isBlank()) {
        errorList.add(createError("staffName", "Staff Name is required."));
    } else if (!staffName.matches("^[A-Za-z ]{2,100}$")) {
        errorList.add(createError("staffName", "Only letters and spaces are allowed."));
    }

    // GENDER
    if (gender.isBlank() || (!(gender.equals("Male") || gender.equals("Female")))) {
        errorList.add(createError("gender", "Please select a valid gender."));
    }

    // EMAIL
    if (email.isBlank()) {
        errorList.add(createError("email", "Email is required."));
    } else if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
        errorList.add(createError("email", "Invalid email address."));
    } else if (isDuplicateExceptId(connection, "mentor_table", "email", email, "staff_id", staffId)) {
        errorList.add(createError("email", "Email already exists for another staff member."));
    }

    // PHONE
    if (phone.isBlank()) {
        errorList.add(createError("phone", "Phone Number is required."));
    } else if (!phone.matches("^[0-9]{10}$")) {
        errorList.add(createError("phone", "Phone Number must contain exactly 10 digits."));
    }

    // DESIGNATION
    if (designation.isBlank()) {
        errorList.add(createError("designation", "Designation is required."));
    } else if (!designation.matches("^[A-Za-z ]{2,100}$")) {
        errorList.add(createError("designation", "Only letters and spaces are allowed."));
    }

    // USERNAME
    if (username.isBlank()) {
        errorList.add(createError("username", "Username is required."));
    } else if (!username.matches("^[A-Za-z0-9_]{5,30}$")) {
        errorList.add(createError("username", "Username must be 5-30 characters."));
    } else if (isDuplicateExceptId(connection, "mentor_table", "username", username, "staff_id", staffId)) {
        errorList.add(createError("username", "Username already exists for another staff member."));
    }

    return errorList;
}

// Helper method to check duplicates while ignoring the current record being updated
private boolean isDuplicateExceptId(Connection connection, String table, String column, String value, String idColumn, String idValue) {
    String query = "SELECT 1 FROM " + table + " WHERE " + column + " = ? AND " + idColumn + " != ?";
    try (PreparedStatement ps = connection.prepareStatement(query)) {
        ps.setString(1, value);
        ps.setString(2, idValue);
        try (ResultSet rs = ps.executeQuery()) {
            return rs.next();
        }
    } catch (SQLException e) {
        return false;
    }
}

// Change this line in your validationController class
private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,20}$");

public List<errorvalidate> validateChangePassword(HttpServletRequest request) {
    List<errorvalidate> errorList = new ArrayList<>();
    String oldPassword = getParameter(request, "oldPassword");
    String newPassword = getParameter(request, "newPassword");
    String confirmPassword = getParameter(request, "confirmPassword");

    if (oldPassword.isEmpty()) {
        errorList.add(createError("oldPassword", "Current Password is required."));
    }
    if (newPassword.isEmpty()) {
        errorList.add(createError("newPassword", "New Password is required."));
    } else if (!PASSWORD_PATTERN.matcher(newPassword).matches()) {
        // Updated message to match the 8-20 limit
        errorList.add(createError("newPassword", 
            "Password must be 8-20 characters with uppercase, lowercase, number and special character."));
    }
    if (confirmPassword.isEmpty()) {
        errorList.add(createError("confirmPassword", "Confirm Password is required."));
    } else if (!newPassword.equals(confirmPassword)) {
        errorList.add(createError("confirmPassword", "New Password and Confirm Password do not match."));
    }
    if (!newPassword.isEmpty() && newPassword.equals(oldPassword)) {
        errorList.add(createError("newPassword", "New Password cannot be the same as Current Password."));
    }
    return errorList;
}
}