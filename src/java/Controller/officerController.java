/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.officerDAO;
import Util.Db_MySqlUtil;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
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
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.StaffDesignation;
import model.designation;
import model.errorvalidate;
import model.officerDetails;
import model.registration;
import model.traineeDetails;

/**
 *
 * @author kgaut
 */
@WebServlet(name = "officerController", urlPatterns = {"/officerController"})
public class officerController extends HttpServlet {

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
            throws ServletException, IOException, SQLException {

        String actionType = request.getParameter("actionType");
        officerDAO objOfficerDAO = new officerDAO();
        Connection connection = Db_MySqlUtil.getConnection();
        RequestDispatcher view = null;
        String msg = "";

        // ============================================================
        // DEFAULT ACTION: If no action is specified, go to addTrainee
        // ============================================================
        if (actionType == null || actionType.isEmpty()) {
            actionType = "addTrainee";
        }

        switch (actionType) {

case "dashboard" -> {
    // These now match the methods added to officerDAO
    int totalTrainees = objOfficerDAO.getTotalTraineeCount(connection); 
    int activeTrainees = objOfficerDAO.getActiveTraineeCount(connection);
    
    request.setAttribute("totalTrainees", totalTrainees);
    request.setAttribute("activeTrainees", activeTrainees);
    request.setAttribute("unreadCount", 0); 

    request.getRequestDispatcher("JSP/officer/officerDashboard.jsp").forward(request, response);
}

            case "openRegistration" -> {
                HttpSession session = request.getSession(true);
                session.setAttribute("allowRegistration", "YES");
                // Redirect to the controller that handles the actual registration form/process
                response.sendRedirect("officerController?actionType=registration");
                return;
            }

            case "saveRegistration" -> {
                Connection conn = Db_MySqlUtil.getConnection();
                officerDAO dao = new officerDAO();
                String role = request.getParameter("role");

                if ("OFFICER".equalsIgnoreCase(role)) {
                    officerDetails officer = new officerDetails();
                    officer.setStaffid(request.getParameter("staffcode"));
                    officer.setStaffname(request.getParameter("fullname"));
                    officer.setUsername(request.getParameter("username"));
                    officer.setPassword(request.getParameter("password"));
                    officer.setEmail(request.getParameter("email"));
                    officer.setPhone(request.getParameter("phone"));
                    officer.setDivision(request.getParameter("department"));
                    officer.setStaffDesignationid(Integer.parseInt(request.getParameter("mentdesignationId")));

                    boolean success
                            = dao.saveOfficerRegistration(conn, officer);

                    if (success) {

                        request.setAttribute(
                                "msg",
                                "Officer registration successful."
                        );

                        request.getRequestDispatcher(
                                "JSP/successMsg.jsp"
                        ).forward(request, response);

                    } else {

                        request.setAttribute(
                                "msg",
                                "Officer registration failed. Officer ID or Username may already exist."
                        );

                        request.getRequestDispatcher(
                                "JSP/errorMsg.jsp"
                        ).forward(request, response);
                    }
                } else if ("HEAD".equalsIgnoreCase(role)) {
                    officerDetails head = new officerDetails();
                    head.setStaffid(request.getParameter("staffcode"));
                    head.setStaffname(request.getParameter("fullname"));
                    head.setUsername(request.getParameter("username"));
                    head.setPassword(request.getParameter("password"));
                    head.setEmail(request.getParameter("email"));
                    head.setPhone(request.getParameter("phone"));
                    head.setDivision(request.getParameter("department"));
                    head.setStaffDesignationid(Integer.parseInt(request.getParameter("mentdesignationId")));
                    boolean success
                            = dao.saveHeadRegistration(conn, head);

                    if (success) {

                        request.setAttribute(
                                "msg",
                                "Head registration successful."
                        );

                        request.getRequestDispatcher("JSP/successMsg.jsp").forward(request, response);
                    } else {
                        request.setAttribute("msg", "Head registration failed. Username may already exist."
                        );

                        request.getRequestDispatcher(
                                "JSP/errorMsg.jsp"
                        ).forward(request, response);
                    }

                } // =====================================================
                // INVALID ROLE
                // =====================================================
                else {

                    request.setAttribute("msg", "Invalid registration role.");
                    request.getRequestDispatcher("JSP/errorMsg.jsp"
                    ).forward(request, response);
                }
            }

            case "registration" -> {
                HttpSession session = request.getSession(true);
                String allowRegistration = (String) session.getAttribute("allowRegistration");
                if (!"YES".equals(allowRegistration)) {
                    request.setAttribute("Message", "Invalid Access.");
                    request.getRequestDispatcher("JSP/errorMsg.jsp").forward(request, response);
                    return;
                }
                session.removeAttribute("allowRegistration");
                String regToken = String.valueOf(System.currentTimeMillis());
                session.setAttribute("regToken", regToken);
                request.setAttribute("regToken", regToken);

                List<StaffDesignation> list = objOfficerDAO.getAllDesignations(connection);
                request.setAttribute("arrDesignation", list);
                request.getRequestDispatcher("JSP/registration.jsp").forward(request, response);
            }

            case "addTrainee" -> {
                ArrayList<designation> arrDesignation = objOfficerDAO.getDesignationList(connection);
                request.setAttribute("arrDesignation", arrDesignation);
                RequestDispatcher rd = request.getRequestDispatcher("JSP/officer/addTrainee.jsp");
                rd.forward(request, response);
            }
            case "saveTraineeDetails" -> {
                validationController validation = new validationController();
                List<errorvalidate> errorList = validation.validateAddTraineeFields(request, connection);

                if (errorList != null && !errorList.isEmpty()) {
                    request.setAttribute("ErrorList", errorList);
                    request.setAttribute("message", "Please correct the errors highlighted below.");

                    // Preserve values
                    request.setAttribute("traineeId", request.getParameter("traineeId"));
                    request.setAttribute("TraineeName", request.getParameter("TraineeName"));
                    request.setAttribute("gender", request.getParameter("gender"));
                    request.setAttribute("dob", request.getParameter("dob"));
                    request.setAttribute("place", request.getParameter("place"));
                    request.setAttribute("branch", request.getParameter("branch"));
                    request.setAttribute("qualification", request.getParameter("qualification"));
                    request.setAttribute("EmailId", request.getParameter("EmailId"));
                    request.setAttribute("PhoneNumber", request.getParameter("PhoneNumber"));
                    request.setAttribute("joiningDate", request.getParameter("joiningDate"));
                    request.setAttribute("Division", request.getParameter("Division"));

                    ArrayList<designation> arrDesignation = objOfficerDAO.getDesignationList(connection);
                    request.setAttribute("arrDesignation", arrDesignation);
                    request.getRequestDispatcher("JSP/officer/addTrainee.jsp").forward(request, response);
                    return;
                }

                try {
                    traineeDetails objTrainee = new traineeDetails();
                    // Use .trim() only for the object, validation already checked leading spaces
                    objTrainee.setTraineeId(request.getParameter("traineeId").trim());
                    objTrainee.setTraineeName(request.getParameter("TraineeName").trim());
                    objTrainee.setGender(request.getParameter("gender").trim());
                    objTrainee.setDob(java.sql.Date.valueOf(request.getParameter("dob")));
                    objTrainee.setPlace(request.getParameter("place"));
                    objTrainee.setBranch(request.getParameter("branch"));
                    objTrainee.setQualification(request.getParameter("qualification"));

                    designation objDesignation = new designation();
                    objDesignation.setDesignationId(Integer.parseInt(request.getParameter("combodesignationId")));
                    objTrainee.setObjDesignationitems(objDesignation);

                    objTrainee.setEmailId(request.getParameter("EmailId").trim());
                    objTrainee.setPhonenumber(request.getParameter("PhoneNumber").trim());
                    objTrainee.setJoiningDate(java.sql.Date.valueOf(request.getParameter("joiningDate")));
                    objTrainee.setCompletionDate(java.sql.Date.valueOf(request.getParameter("completionDate")));
                    objTrainee.setDivision(request.getParameter("Division").trim());
                    objTrainee.setActive("YES");

                    boolean status = objOfficerDAO.saveTrainee(connection, objTrainee);
                    if (status) {
                        response.sendRedirect("officerController?actionType=viewTrainee");
                    } else {
                        request.setAttribute("msg", "Failed to save trainee. Trainee ID or Email may already exist.");
                        request.getRequestDispatcher("JSP/errorMsg.jsp").forward(request, response);
                    }
                } catch (ServletException | IOException | NumberFormatException | SQLException e) {
                    request.setAttribute("msg", "Data Format Error: " + e.getMessage());
                    request.getRequestDispatcher("JSP/errorMsg.jsp").forward(request, response);
                }
            }
            case "viewTrainee" -> {
                if (request.getParameter("message") != null) {
                    msg = request.getParameter("message");
                }
                ArrayList<traineeDetails> arrTraineeList = objOfficerDAO.getTraineeList(connection);
                ArrayList<designation> arrDesignation = objOfficerDAO.getDesignationList(connection);
                request.setAttribute("arrtraineelist", arrTraineeList);
                request.setAttribute("arrDesignation", arrDesignation);
                request.setAttribute("message", msg);
                request.getRequestDispatcher("JSP/officer/viewTrainee.jsp").forward(request, response);
            }
            case "changeStatus" -> {
                String traineeId = request.getParameter("traineeId");
                String status = request.getParameter("status");
                objOfficerDAO.changeStatus(connection, traineeId, status);
                response.sendRedirect("officerController?actionType=viewTrainee");
            }
            case "updateTrainee" -> {
                traineeDetails obj = new traineeDetails();
                designation des = new designation();

                // Populate object from request
                obj.setTraineeId(request.getParameter("traineeId"));
                obj.setTraineeName(request.getParameter("traineeName"));
                obj.setGender(request.getParameter("gender"));
                obj.setDob(java.sql.Date.valueOf(request.getParameter("dob")));
                obj.setPlace(request.getParameter("place"));
                obj.setBranch(request.getParameter("branch"));
                obj.setQualification(request.getParameter("qualification"));
                obj.setEmailId(request.getParameter("emailId"));
                obj.setPhonenumber(request.getParameter("phoneNumber"));
                des.setDesignationId(Integer.parseInt(request.getParameter("designationId")));
                obj.setObjDesignationitems(des);
                obj.setJoiningDate(java.sql.Date.valueOf(request.getParameter("joiningDate")));
                obj.setCompletionDate(java.sql.Date.valueOf(request.getParameter("completionDate")));
                obj.setDivision(request.getParameter("division"));

                // --- LOGIC TO TRACK CHANGED FIELDS ---
                traineeDetails oldObj = objOfficerDAO.getTraineeById(connection, obj.getTraineeId());
                java.util.List<String> changedFields = new java.util.ArrayList<>();

                if (oldObj != null) {
                    // Use a null-safe comparison helper
                    if (!Objects.equals(obj.getTraineeName(), oldObj.getTraineeName())) {
                        changedFields.add("Name");
                    }
                    if (!Objects.equals(obj.getGender(), oldObj.getGender())) {
                        changedFields.add("Gender");
                    }
                    if (!Objects.equals(obj.getPlace(), oldObj.getPlace())) {
                        changedFields.add("Place");
                    }
                    if (!Objects.equals(obj.getBranch(), oldObj.getBranch())) {
                        changedFields.add("Branch");
                    }
                    if (!Objects.equals(obj.getQualification(), oldObj.getQualification())) {
                        changedFields.add("Qualification");
                    }
                    if (!Objects.equals(obj.getEmailId(), oldObj.getEmailId())) {
                        changedFields.add("Email");
                    }
                    if (!Objects.equals(obj.getPhonenumber(), oldObj.getPhonenumber())) {
                        changedFields.add("Phone");
                    }
                    if (!Objects.equals(obj.getDivision(), oldObj.getDivision())) {
                        changedFields.add("Division");
                    }
                    if (!Objects.equals(obj.getJoiningDate(), oldObj.getJoiningDate())) {
                        changedFields.add("Joining Date");
                    }

                    // Designation comparison
                    if (oldObj.getObjDesignationitems() != null
                            && obj.getObjDesignationitems().getDesignationId() != oldObj.getObjDesignationitems().getDesignationId()) {
                        changedFields.add("Designation");
                    }
                }
                msg = objOfficerDAO.updateTrainee(connection, obj);
                // Forward back to view
                ArrayList<traineeDetails> arrTraineeList = objOfficerDAO.getTraineeList(connection);
                ArrayList<designation> arrDesignation = objOfficerDAO.getDesignationList(connection);
                request.setAttribute("arrtraineelist", arrTraineeList);
                request.setAttribute("arrDesignation", arrDesignation);
                view = request.getRequestDispatcher("officerController?actionType=viewTrainee&message=" + msg);
                view.forward(request, response);
//                request.getRequestDispatcher("JSP/officer/viewTrainee.jsp").forward(request, response);
            }
            default -> {
                // If an unknown action is passed, default to addTrainee
                response.sendRedirect("officerController?actionType=addTrainee");
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
            Logger.getLogger(officerController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(officerController.class.getName()).log(Level.SEVERE, null, ex);
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
