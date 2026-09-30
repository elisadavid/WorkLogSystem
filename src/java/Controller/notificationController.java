/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.HeadDAO;
import Dao.notificationDAO;
import Dao.staffDAO;
import Util.Db_MySqlUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Notification;
import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author kgaut
 */
@WebServlet(name = "notificationController", urlPatterns = {"/notificationController"})
public class notificationController extends HttpServlet {

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
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        Connection connection = null;
        try {
            connection = Db_MySqlUtil.getConnection();
            String actionType = request.getParameter("actionType");
            HttpSession session = request.getSession();
            notificationDAO objNotificationDAO = new notificationDAO();
            switch (actionType) {
               case "viewNotifications" -> {

    String recipientId = (String) session.getAttribute("userId");
    String userRole = (String) session.getAttribute("userRole");

    System.out.println("recipientId = " + recipientId);
    System.out.println("userRole = " + userRole);

    if (recipientId == null || userRole == null) {

        response.getWriter().println("Session Expired");
        return;
    }

    int unreadCount =
            objNotificationDAO.getUnreadNotificationCount(
                    connection,
                    recipientId,
                    userRole);

    System.out.println("Unread = " + unreadCount);

    ArrayList<Notification> notificationList =
            objNotificationDAO.getNotifications(
                    connection,
                    recipientId,
                    userRole);

    System.out.println("List Size = " + notificationList.size());

    request.setAttribute("unreadCount", unreadCount);
    request.setAttribute("notificationList", notificationList);

    objNotificationDAO.markNotificationsAsRead(
            connection,
            recipientId,
            userRole);

    request.setAttribute("activeMenu", "notifications");

    if ("HEAD".equalsIgnoreCase(userRole)) {

        System.out.println("Forward Head");

        request.getRequestDispatcher(
                "JSP/Head/viewHeadnotifications.jsp")
                .forward(request, response);

    } else if ("STAFF".equalsIgnoreCase(userRole)) {

        System.out.println("Forward Staff");

        request.getRequestDispatcher(
                "JSP/Staff/viewStaffnotifications.jsp")
                .forward(request, response);

    } else {

        System.out.println("Forward Trainee");

        request.getRequestDispatcher(
                "JSP/Trainee/viewTraineenotifications.jsp")
                .forward(request, response);

    }

    return;
}
            }

        } catch (ServletException | IOException | NumberFormatException e) {
            throw e;
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
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
        } catch (Exception ex) {
            Logger.getLogger(notificationController.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Exception ex) {
            Logger.getLogger(notificationController.class.getName()).log(Level.SEVERE, null, ex);
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
