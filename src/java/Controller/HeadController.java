package Controller;

import Dao.DashboardDAO;
import Dao.HeadDAO;
import Util.Db_MySqlUtil;
import java.sql.Connection;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Notification;
import model.errorvalidate;
import model.staffDetails;
import model.traineeDetails;

@WebServlet(name = "HeadController", urlPatterns = {"/HeadController"})
public class HeadController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        Connection connection = null;
        try {
            connection = Db_MySqlUtil.getConnection();
            String actionType = request.getParameter("actionType");
            HeadDAO objHeadDAO = new HeadDAO();

            HttpSession session = request.getSession();

            if (actionType == null) {
                response.sendRedirect("mylogin.jsp");
                return;
            }

            switch (actionType) {

                case "dashboard" -> {
                    String division = (String) session.getAttribute("division");
                    String headId = session.getAttribute("headId").toString();
                    DashboardDAO dao = new DashboardDAO();
                    int traineeCount = dao.getTotalTrainees(connection, division);
                    int mentorCount = dao.getTotalMentors(connection, division);
                    ArrayList<Notification> notifList = objHeadDAO.getNotificationsForHead(connection, headId);
                    int unreadCount = objHeadDAO.getUnreadNotificationsCount(connection, headId);
                    request.setAttribute("totalTrainees", traineeCount);
                    request.setAttribute("totalMentors", mentorCount);
                    request.setAttribute("notifList", notifList);
                    request.setAttribute("unreadNotifCount", unreadCount);
                    request.getRequestDispatcher("JSP/Head/headDashboard.jsp").forward(request, response);
                }

                case "viewTrainee" -> {
                    String division = (String) session.getAttribute("division");
                    ArrayList<traineeDetails> arrTraineeList = objHeadDAO.getTraineesByDivision(connection, division);
                    ArrayList<staffDetails> arrStaff = objHeadDAO.getactiveStaffLists(connection, division);
                    ArrayList<traineeDetails> arrTrainee = objHeadDAO.getTraineesByDivision(connection, division);
                    request.setAttribute("arrStaff", arrStaff);
                    request.setAttribute("arrTrainee", arrTrainee);
                    request.setAttribute("arrtraineelist", arrTraineeList);
                    request.getRequestDispatcher("JSP/Head/viewTraineesHead.jsp").forward(request, response);
                }
                case "AddStaff" -> {
                    request.getRequestDispatcher("JSP/Head/addStaff.jsp").forward(request, response);
                }

                case "saveStaff" -> {
                    validationController validation = new validationController();
                    List<errorvalidate> errorList = validation.validateAddMentorFields(request, connection);
                    if (errorList != null && !errorList.isEmpty()) {
                        request.setAttribute("ErrorList", errorList);
                        request.setAttribute("message", "Please correct the errors highlighted below.");
                        request.setAttribute("staffId", request.getParameter("staffId"));
                        request.setAttribute("staffName", request.getParameter("staffName"));
                        request.setAttribute("gender", request.getParameter("gender"));
                        request.setAttribute("email", request.getParameter("email"));
                        request.setAttribute("phone", request.getParameter("phone"));
                        request.setAttribute("designation", request.getParameter("designation"));
                        request.setAttribute("username", request.getParameter("username"));
                        request.getRequestDispatcher("JSP/Head/addStaff.jsp").forward(request, response);
                        return;
                    }

                    String division = (String) session.getAttribute("division");
                    if (division == null || division.trim().isEmpty()) {
                        request.setAttribute("msg", "Session expired. Please login again.");
                        request.getRequestDispatcher("JSP/errorMsg.jsp").forward(request, response);
                        return;
                    }

                    staffDetails obj = new staffDetails();
                    obj.setStaffId(request.getParameter("staffId").trim());
                    obj.setStaffName(request.getParameter("staffName").trim());
                    obj.setGender(request.getParameter("gender").trim());
                    obj.setEmailId(request.getParameter("email").trim());
                    obj.setPhoneNumber(request.getParameter("phone").trim());
                    obj.setDesignation(request.getParameter("designation").trim());
                    obj.setUsername(request.getParameter("username").trim());
                    obj.setPassword(request.getParameter("password"));
                    obj.setDivision(division);
                    obj.setActive("YES");

                    boolean status = objHeadDAO.addStaff(connection, obj);
                    if (status) {
                        response.sendRedirect("HeadController?actionType=viewStaff");
                    } else {
                        request.setAttribute("msg", "Failed to save mentor. Staff ID, Email, Phone or Username may already exist.");
                        request.getRequestDispatcher("JSP/errorMsg.jsp").forward(request, response);
                    }
                }

                case "viewStaff" -> {
                    String division = (String) session.getAttribute("division");
                    ArrayList<staffDetails> arrStaffList = objHeadDAO.getStaffList(connection, division);
                    request.setAttribute("arrStaffList", arrStaffList);
                    request.getRequestDispatcher("JSP/Head/viewStaff.jsp").forward(request, response);
                }
                
  

                case "changeStaffStatus" -> {
                    String staffId = request.getParameter("staffId");
                    String status = request.getParameter("active");
                    objHeadDAO.changeStaffStatus(connection, staffId, status);
                    response.sendRedirect("HeadController?actionType=viewStaff");
                }

//                case "updateStaff" -> {
//                    staffDetails obj = new staffDetails();
//                    obj.setStaffId(request.getParameter("staffId"));
//                    obj.setStaffName(request.getParameter("staffName"));
//                    obj.setGender(request.getParameter("gender"));
//                    obj.setEmailId(request.getParameter("email"));
//                    obj.setPhoneNumber(request.getParameter("phone"));
//                    obj.setDesignation(request.getParameter("designation"));
//                    obj.setUsername(request.getParameter("username"));
//                    obj.setDivision((String) session.getAttribute("division"));
//                    objHeadDAO.updateStaff(connection, obj);
//                    response.sendRedirect("HeadController?actionType=viewStaff");
//                }
                
             case "updateStaff" -> {
    String staffId = request.getParameter("staffId");
    validationController validation = new validationController();
    List<errorvalidate> errorList = validation.validateUpdateMentorFields(request, connection, staffId);

    if (errorList == null || errorList.isEmpty()) {
        try {
            // 1. Get OLD data from DB
            staffDetails oldData = objHeadDAO.getStaffById(connection, staffId);
            
            // 2. Get NEW data from Request
            staffDetails newData = new staffDetails();
            newData.setStaffId(staffId);
            newData.setStaffName(request.getParameter("staffName"));
            newData.setGender(request.getParameter("gender"));
            newData.setEmailId(request.getParameter("email"));
            newData.setPhoneNumber(request.getParameter("phone"));
            newData.setDesignation(request.getParameter("designation"));
            newData.setUsername(request.getParameter("username"));
            newData.setDivision((String) session.getAttribute("division"));

            // 3. Compare fields to build the custom message
            StringBuilder updatedFields = new StringBuilder();
            if (!oldData.getStaffName().equals(newData.getStaffName())) updatedFields.append("Name, ");
            if (!oldData.getGender().equals(newData.getGender())) updatedFields.append("Gender, ");
            if (!oldData.getEmailId().equals(newData.getEmailId())) updatedFields.append("Email, ");
            if (!oldData.getPhoneNumber().equals(newData.getPhoneNumber())) updatedFields.append("Phone, ");
            if (!oldData.getDesignation().equals(newData.getDesignation())) updatedFields.append("Designation, ");
            if (!oldData.getUsername().equals(newData.getUsername())) updatedFields.append("Username, ");

            String finalMsg;
            if (updatedFields.length() == 0) {
                finalMsg = "No changes were made.";
                request.setAttribute("msgType", "info");
            } else {
                // Remove trailing comma and space
                String fields = updatedFields.substring(0, updatedFields.length() - 2);
                finalMsg = fields + " successfully updated!";
                request.setAttribute("msgType", "success");
            }

            // 4. Perform the actual update
            boolean success = objHeadDAO.updateStaff(connection, newData);
            if (success) {
                request.setAttribute("message", finalMsg);
            } else {
                request.setAttribute("message", "Database error: Update failed.");
                request.setAttribute("msgType", "danger");
            }

        } catch (SQLException e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("msgType", "danger");
        }
    } else {
        request.setAttribute("message", "Please correct the errors in the form.");
        request.setAttribute("msgType", "warning");
    }
    request.getRequestDispatcher("HeadController?actionType=viewStaff").forward(request, response);
}

                case "saveMentor" -> {
                    String traineeId = request.getParameter("traineeId");
                    String staffId = request.getParameter("staffId");
                    String headId = session.getAttribute("headId").toString();

                    boolean status = objHeadDAO.assignedMentor(connection, traineeId, staffId, headId);
                    if (status) {
                        objHeadDAO.addNotification(connection, staffId, "STAFF", "New Trainee Assignment", "Please Accept or Reject the trainee.");
                        response.sendRedirect("HeadController?actionType=viewTrainee");
                    } else {
                        request.setAttribute("msg", "Assignment Failed");
                        request.getRequestDispatcher("JSP/errorMsg.jsp").forward(request, response);
                    }
                }

                case "changePasswordPage" -> {
                    request.getRequestDispatcher("JSP/Head/changePassword.jsp").forward(request, response);
                }

//               case "changePassword" -> {
//    validationController validation = new validationController();
//    List<errorvalidate> errorList = validation.validateChangePassword(request);
//    
//    if (errorList != null && !errorList.isEmpty()) {
//        request.setAttribute("ErrorList", errorList);
//        request.setAttribute("msg", "Please correct the errors in the form.");
//        request.setAttribute("msgType", "warning");
//        request.getRequestDispatcher("JSP/Head/changePassword.jsp").forward(request, response);
//        return;
//    }
//
//    String username = (String) session.getAttribute("username");
//    if (username == null) {
//        request.setAttribute("msg", "Session Expired. Please Login Again.");
//        request.setAttribute("msgType", "danger");
//        request.getRequestDispatcher("mylogin.jsp").forward(request, response);
//        return;
//    }
//
//    String oldPass = request.getParameter("oldPassword");
//    String newPass = request.getParameter("newPassword");
//
//    try {
//        boolean status = objHeadDAO.changePassword(connection, username, oldPass, newPass);
//        if (status) {
//            request.setAttribute("msg", "Password Updated Successfully.");
//            request.setAttribute("msgType", "success");
//        } else {
//            request.setAttribute("msg", "Current Password is Incorrect or Update Failed.");
//            request.setAttribute("msgType", "danger");
//        }
//    } catch (SQLException e) {
//        request.setAttribute("msg", "Database Error: " + e.getMessage());
//        request.setAttribute("msgType", "danger");
//    }
//    request.getRequestDispatcher("JSP/Head/changePassword.jsp").forward(request, response);
//}
                
                case "changePassword" -> {
                    validationController validation = new validationController();
                    List<errorvalidate> errorList = validation.validateChangePassword(request);
                    if (!errorList.isEmpty()) {
                        request.setAttribute("ErrorList", errorList);
                        request.getRequestDispatcher("JSP/Head/changePassword.jsp").forward(request, response);
                        return;
                    }

                    String username = (String) session.getAttribute("username");
                    if (username == null) {
                        request.setAttribute("msg", "Session Expired. Please Login Again.");
                        request.getRequestDispatcher("mylogin.jsp").forward(request, response);
                        return;
                    }

                    boolean status = objHeadDAO.changePassword(connection, username, request.getParameter("oldPassword"), request.getParameter("newPassword"));
                    if (status) {
                        request.setAttribute("msg", "Password Updated Successfully.");
                    } else {
                        request.setAttribute("msg", "Current Password is Incorrect.");
                    }
                    request.getRequestDispatcher("JSP/Head/changePassword.jsp").forward(request, response);
                }

                case "logout" -> {
                    session.invalidate();
                    response.sendRedirect("mylogin.jsp");
                }
                default ->
                    response.sendRedirect("mylogin.jsp");
            }

        } catch (ServletException | IOException | SQLException e) {
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(HeadController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(HeadController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
