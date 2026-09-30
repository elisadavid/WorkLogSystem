package Controller;

import Dao.HeadDAO;
import Dao.officerDAO;
import Dao.staffDAO;
import Dao.traineeDAO;
import Util.Db_MySqlUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import model.errorvalidate;

import model.headDetails;
import model.officerDetails;
import model.staffDetails;
import model.traineeDetails;

public class loginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        Connection connection = null;
        RequestDispatcher view = null;

        try {

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            validationController validator = new validationController();

            List<errorvalidate> errors = validator.validateLoginFields(request);

            if (!errors.isEmpty()) {

                request.setAttribute("arrError", errors);

                request.getRequestDispatcher("mylogin.jsp")
                        .forward(request, response);

                return;
            }

            connection = Db_MySqlUtil.getConnection();

            HeadDAO headDAO = new HeadDAO();
            staffDAO staffDAO = new staffDAO();
            traineeDAO traineeDAO = new traineeDAO();
            officerDAO officerDAO = new officerDAO();
            HttpSession session = request.getSession(true);
//            
//            officerDetails officer = officerDAO.validateOfficer(connection, username, password);

            officerDetails officer = officerDAO.validateOfficer(connection, username, password);
            if (officer != null) {
                session.setAttribute("role", "OFFICER");
                session.setAttribute("userRole", "OFFICER");
                session.setAttribute("officerId", officer.getStaffid());
                session.setAttribute("userId", officer.getStaffid());
                session.setAttribute("userName", officer.getStaffname());
                session.setAttribute("username", officer.getUsername());
                session.setAttribute("division", officer.getDivision());

                // Redirect to Officer's specific controller
                request.getRequestDispatcher("officerController").forward(request, response);
                return; // Stop further checks once logged in
            }

            // ==========================
            // HEAD LOGIN
            // ==========================
            headDetails head = headDAO.validateHead(connection, username, password);

            if (head != null) {

                session.setAttribute("role", "HEAD");
                session.setAttribute("userRole", "HEAD");

                session.setAttribute("headId", head.getHeadId());
                session.setAttribute("userId", String.valueOf(head.getHeadId()));

                session.setAttribute("userName", head.getHeadName());
                session.setAttribute("division", head.getDivision());

                view = request.getRequestDispatcher("HeadController");
                view.forward(request, response);
            }

            // ==========================
            // STAFF LOGIN
            // ==========================
            staffDetails staff = staffDAO.validateStaff(connection, username, password);

            if (staff != null) {

                session.setAttribute("role", "STAFF");
                session.setAttribute("userRole", "STAFF");

                session.setAttribute("staffId", staff.getStaffId());
                session.setAttribute("userId", staff.getStaffId());

                session.setAttribute("userName", staff.getStaffName());
                session.setAttribute("username", staff.getUsername());
                session.setAttribute("division", staff.getDivision());

                view = request.getRequestDispatcher("staffController");
                view.forward(request, response);
            }

            // ==========================
            // TRAINEE LOGIN
            // ==========================
            traineeDetails trainee = traineeDAO.validateTrainee(connection, username, password);

            if (trainee != null) {

                session.setAttribute("role", "TRAINEE");
                session.setAttribute("userRole", "TRAINEE");

                session.setAttribute("traineeId", trainee.getTraineeId());
                session.setAttribute("userId", trainee.getTraineeId());

                session.setAttribute("userName", trainee.getTraineeName());
                session.setAttribute("division", trainee.getDivision());

                view = request.getRequestDispatcher("traineesController");
                view.forward(request, response);
            }

            //officer login
            // ==========================
            // INVALID LOGIN
            // ==========================
            request.setAttribute("msg", "Invalid Username or Password");
            request.getRequestDispatcher("mylogin.jsp").forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();
//
            request.setAttribute("msg", "Something went wrong: " + e.getMessage());

            request.getRequestDispatcher("mylogin.jsp").forward(request, response);

        } finally {

            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Login Controller";
    }
}
