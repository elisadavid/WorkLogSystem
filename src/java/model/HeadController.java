package model;

import Dao.HeadDAO;
import Util.Db_MySqlUtil;
import jakarta.servlet.RequestDispatcher;
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

import Controller.validationController;
import model.Assignment;
import model.errorvalidate;
import model.staffDetails;
import model.traineeDetails;

@WebServlet(name = "HeadController", urlPatterns = {"/HeadController"})
public class HeadController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
                case "viewTrainee" -> {
                    String division = (String) session.getAttribute("division");
                    ArrayList<traineeDetails> arrTraineeList = objHeadDAO.getTraineesByDivision(connection, division);
                    request.setAttribute("arrtraineelist", arrTraineeList);
                    RequestDispatcher rd = request.getRequestDispatcher("JSP/Head/viewTraineesHead.jsp");
                    rd.forward(request, response);
                }
                case "AddStaff" -> {
                    RequestDispatcher rd = request.getRequestDispatcher("JSP/Head/addStaff.jsp");
                    rd.forward(request, response);
                }
                case "saveTraineeLogin" -> {
                    String traineeId = request.getParameter("traineeId");
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    objHeadDAO.saveTraineeLogin(connection, traineeId, username, password);
                    response.sendRedirect("HeadController?actionType=viewTrainee");
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
                    objHeadDAO.resetTraineePassword(connection, traineeId, password);
                    response.sendRedirect("HeadController?actionType=viewTrainee");
                }
                case "saveStaff" -> {
                    validationController validation = new validationController();
                    List<errorvalidate> errorList = validation.validateAddMentorFields(request, connection);
                    if (errorList != null && !errorList.isEmpty()) {
                        request.setAttribute("ErrorList", errorList);
                        request.setAttribute("message", "Please correct the errors highlighted below.");
                        RequestDispatcher rd = request.getRequestDispatcher("JSP/Head/addStaff.jsp");
                        rd.forward(request, response);
                        return;
                    }
                    staffDetails obj = new staffDetails();
                    obj.setStaffId(request.getParameter("staffId"));
                    obj.setStaffName(request.getParameter("staffName"));
                    obj.setGender(request.getParameter("gender"));
                    obj.setEmailId(request.getParameter("email"));
                    obj.setPhoneNumber(request.getParameter("phone"));
                    obj.setDesignation(request.getParameter("designation"));
                    obj.setUsername(request.getParameter("username"));
                    obj.setPassword(request.getParameter("password"));
                    obj.setDivision((String) session.getAttribute("division"));
                    obj.setStatus("ACTIVE");
                    boolean status = objHeadDAO.addStaff(connection, obj);
                    if (status) {
                        response.sendRedirect("HeadController?actionType=viewStaff");
                    } else {
                        request.setAttribute("msg", "Failed to save mentor.");
                        RequestDispatcher rd = request.getRequestDispatcher("JSP/errorMsg.jsp");
                        rd.forward(request, response);
                    }
                }
                case "viewStaff" -> {
                    String division = (String) session.getAttribute("division");
                    ArrayList<staffDetails> arrStaffList = objHeadDAO.getStaffList(connection, division);
                    request.setAttribute("arrStaffList", arrStaffList);
                    RequestDispatcher rd = request.getRequestDispatcher("JSP/Head/viewStaff.jsp");
                    rd.forward(request, response);
                }
                case "changeStaffStatus" -> {
                    String staffId = request.getParameter("staffId");
                    String status = request.getParameter("status");
                    objHeadDAO.changeStaffStatus(connection, staffId, status);
                    response.sendRedirect("HeadController?actionType=viewStaff");
                }
                case "updateStaff" -> {
                    staffDetails obj = new staffDetails();
                    obj.setStaffId(request.getParameter("staffId"));
                    obj.setStaffName(request.getParameter("staffName"));
                    obj.setGender(request.getParameter("gender"));
                    obj.setEmailId(request.getParameter("email"));
                    obj.setPhoneNumber(request.getParameter("phone"));
                    obj.setDesignation(request.getParameter("designation"));
                    obj.setUsername(request.getParameter("username"));
                    obj.setDivision((String) session.getAttribute("division"));
                    objHeadDAO.updateStaff(connection, obj);
                    response.sendRedirect("HeadController?actionType=viewStaff");
                }
                case "AssignMentor" -> {
                    String division = (String) session.getAttribute("division");
                    ArrayList<staffDetails> arrStaff = objHeadDAO.getStaffList(connection, division);
                    ArrayList<traineeDetails> arrTrainee = objHeadDAO.getTraineesByDivision(connection, division);
                    request.setAttribute("arrStaff", arrStaff);
                    request.setAttribute("arrTrainee", arrTrainee);
                    RequestDispatcher rd = request.getRequestDispatcher("JSP/Head/assignMentor.jsp");
                    rd.forward(request, response);
                }
                case "saveMentor" -> {
                    String traineeId = request.getParameter("traineeId");
                    String staffId = request.getParameter("staffId");
                    boolean status = objHeadDAO.assignMentor(connection, traineeId, staffId);
                    if (status) {
                        response.sendRedirect("HeadController?actionType=AssignMentor");
                    } else {
                        request.setAttribute("msg", "Mentor assignment failed.");
                        RequestDispatcher rd = request.getRequestDispatcher("JSP/errorMsg.jsp");
                        rd.forward(request, response);
                    }
                }
                case "viewAssignedMentors" -> {
                    String division = (String) session.getAttribute("division");
                    ArrayList<traineeDetails> arrAssignedList = objHeadDAO.getAssignedMentors(connection, division);
                    request.setAttribute("arrAssignedList", arrAssignedList);
                    RequestDispatcher rd = request.getRequestDispatcher("JSP/Head/viewAssignedMentors.jsp");
                    rd.forward(request, response);
                }
                case "assignedMentor" -> {
                    String traineeId = request.getParameter("traineeId");
                    String staffId = request.getParameter("staffId");
                    String headId = (String) session.getAttribute("headId");
                    boolean status = objHeadDAO.assignedMentor(connection, traineeId, staffId, headId);
                    if (status) {
                        objHeadDAO.addNotification(connection, staffId, "STAFF", "New Trainee Assigned", "A trainee has been assigned to you. Please Accept or Reject.");
                    }
                    response.sendRedirect("HeadController?actionType=viewAssignedMentors");

                }

                case "changePasswordPage" -> {

                    request.getRequestDispatcher(
                            "Head/changePassword.jsp")
                            .forward(request, response);
                }

                case "changePassword" -> {

                    String oldPassword = request.getParameter("oldPassword");
                    String newPassword = request.getParameter("newPassword");
                    String confirmPassword = request.getParameter("confirmPassword");

                    if (!newPassword.equals(confirmPassword)) {

                        request.setAttribute("msg", "Passwords do not match");

                        request.getRequestDispatcher(
                                "Head/changePassword.jsp")
                                .forward(request, response);

                        return;
                    }

                    //Check old password from database
                    //If correct
                    //Update password
                    request.setAttribute("msg", "Password Updated Successfully");

                    request.getRequestDispatcher(
                            "Head/changePassword.jsp")
                            .forward(request, response);

                }

                case "logout" -> {
                    session.invalidate();
                    response.sendRedirect("mylogin.jsp");
                }
                default ->
                    response.sendRedirect("mylogin.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}
