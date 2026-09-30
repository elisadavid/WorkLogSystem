package Controller;

import Util.Db_MySqlUtil;
import java.sql.Connection;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.errorvalidate;
import model.registration;

public class registerController extends HttpServlet {

    HttpSession curSession = null;
    private Connection connection;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        response.setContentType("text/html;charset=UTF-8");


        RequestDispatcher view = null;

        try {

            Connection connection = Db_MySqlUtil.getConnection();

            String strAction = request.getParameter("actionType");

            // =====================================================
            // OPEN REGISTRATION ONLY FROM LOGIN PAGE
            // =====================================================

            if (strAction != null
                    && strAction.equalsIgnoreCase("openRegistration")) {

                HttpSession session = request.getSession(true);

                // Allow registration access
                session.setAttribute("allowRegistration", "YES");

                response.sendRedirect("registerController?actionType=registration");

                return;
            }

            // =====================================================
            // LOAD REGISTRATION PAGE
            // =====================================================

            if (strAction != null
                    && strAction.equalsIgnoreCase("registration")) {

                HttpSession session = request.getSession(true);

                // CHECK ACCESS
                 String allowRegistration = (String) session.getAttribute("allowRegistration");


                // BLOCK DIRECT URL ACCESS
                if (!"YES".equals(allowRegistration)) {

                    request.setAttribute("Message",
                            "Invalid Access. Please open registration from login page.");

                    view = request.getRequestDispatcher("JSP/errorMsg.jsp");
//
                    view.forward(request, response);

                    return;
                }

                // REMOVE ACCESS FLAG
                session.removeAttribute("allowRegistration");

                // GENERATE TOKEN
                String regToken = String.valueOf(System.currentTimeMillis());

                session.setAttribute("regToken", regToken);

                request.setAttribute("regToken", regToken);

                ArrayList<mentordesignation> arrmentordesignation
                        = mentordao.getmentorDesignations(connection);

                request.setAttribute("arrmentordesignation",
                        arrmentordesignation);

                ArrayList<registration> arrregistration
                        = mentordao.getregistration(connection);

                request.setAttribute("arrregistration",
                        arrregistration);

                view = request.getRequestDispatcher("JSP/registration.jsp");

                view.forward(request, response);
            }

            // =====================================================
            // SAVE REGISTRATION
            // =====================================================

            else if (strAction.equalsIgnoreCase("saveRegistration")) {

                 HttpSession session = request.getSession(false);

                String sessionToken = (session != null && session.getAttribute("regToken") != null)
                        ? session.getAttribute("regToken").toString()
                        : "";

                String requestToken = request.getParameter("regToken");

                if (requestToken == null || !sessionToken.equals(requestToken)) {

                    request.setAttribute("Message", "Registration Page Expired.");

                    view = request.getRequestDispatcher("mylogin.jsp");
                    view.forward(request, response);
                    return;
                }



                // =================================================
                // VALIDATION
                // =================================================

                validationController errorValidation
                        = new validationController();

                List<errorvalidate> errorList
                        = errorValidation.validateRegistrationFields(
                                request,
                                connection
                        );

                if (!errorList.isEmpty()) {

                    request.setAttribute("errorList", errorList);

                    ArrayList<mentordesignation> arrmentordesignation
                            = mentordao.getmentorDesignations(connection);

                    request.setAttribute("arrmentordesignation",
                            arrmentordesignation);

                    request.setAttribute("regToken",
                            sessionToken);

                    view = request.getRequestDispatcher(
                            "JSP/registration.jsp"
                    );

                    view.forward(request, response);

                    return;
                }

                // =================================================
                // GET VALUES
                // =================================================

                String staffCode = request.getParameter("staffcode");

                String fullName = request.getParameter("fullname");

                String email = request.getParameter("email");

                String password = request.getParameter("password");

                String phone = request.getParameter("phone");

                String department = request.getParameter("department");

                String desigId
                        = request.getParameter("mentdesignationId");

                // =================================================
                // SET MODEL
                // =================================================

                registration Registration = new registration();

                Registration.setStaffCode(staffCode);

                Registration.setFullName(fullName);

                Registration.setEmail(email);

                Registration.setPassword(password);

                Registration.setPhone(phone);

                Registration.setDepartment(department);

                Registration.setMentorDesignationId(desigId);

                // =================================================
                // SAVE DATABASE
                // =================================================

                boolean success
                        = mentordao.saveMentor(
                                Registration,
                                connection
                        );

                // =================================================
                // SUCCESS
                // =================================================

                if (success) {

                    session.removeAttribute("regToken");

                    response.sendRedirect(
                            "mylogin.jsp?msg=success"
                    );

                } else {

                    request.setAttribute("Message",
                            "Registration Failed");

                    view = request.getRequestDispatcher(
                            "JSP/registration.jsp"
                    );

                    view.forward(request, response);
                }
            }

        } catch (ServletException | IOException | SQLException e) {

            e.printStackTrace();

            request.setAttribute("Message", e.getMessage());

            request.getRequestDispatcher("message.jsp")
                    .forward(request, response);

        } finally {

            try {

                if (connection != null) {

                    connection.close();
                }

            } catch (Exception ex) {

                request.setAttribute("Message", ex);

                view = request.getRequestDispatcher(
                        "JSP/errorMsg.jsp"
                );

                view.forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            processRequest(request, response);

        } catch (SQLException ex) {

            Logger.getLogger(registerController.class.getName())
                    .log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            processRequest(request, response);

        } catch (SQLException ex) {

            Logger.getLogger(registerController.class.getName())
                    .log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {

        return "Short description";
    }
}

