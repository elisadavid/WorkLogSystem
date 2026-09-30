/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import model.Notification;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author kgaut
 */
public class notificationDAO {
    public ArrayList<Notification> getNotifications(Connection connection,  String recipientId,  String userRole) throws Exception {

        ArrayList<Notification> notificationList = new ArrayList<>();

        try {

            String sql = "SELECT * FROM notifications " + "WHERE recipient_id=? AND user_role=? "  + "ORDER BY created_at DESC";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, recipientId);
            ps.setString(2, userRole);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Notification obj = new Notification();
 obj.setNotifId(rs.getInt("notif_id"));
                obj.setRecipientId(rs.getString("recipient_id"));
                obj.setUserRole(rs.getString("user_role"));
                obj.setTitle(rs.getString("title"));
                obj.setMessage(rs.getString("message"));
                obj.setStatus(rs.getString("status"));
                obj.setCreatedAt(rs.getString("created_at"));

                notificationList.add(obj);
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
           throw e;
        }

        return notificationList;
    }

    // Mark notifications as READ
    public void markNotificationsAsRead(Connection connection,  String recipientId, String userRole) throws Exception {

        try {

            String sql = "UPDATE notifications "  + "SET status='READ' "  + "WHERE recipient_id=? " + "AND user_role=? " + "AND status='UNREAD'";

            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, recipientId);
            ps.setString(2, userRole);

            ps.executeUpdate();

            ps.close();

        } catch (SQLException e) {
            throw e;
        }
    }

    // Get unread notification count
    public int getUnreadNotificationCount(Connection connection,  String recipientId, String userRole) throws Exception {

        int count = 0;

        try {

            String sql = "SELECT COUNT(*) AS total " + "FROM notifications " + "WHERE recipient_id=? " + "AND user_role=? " + "AND status='UNREAD'";

            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, recipientId);
            ps.setString(2, userRole);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("total");
            }

            rs.close();
            ps.close();

        } catch (SQLException e) {
             throw e;
        }

        return count;
    }

    // Add a new notification
    public boolean addNotification(Connection connection,  String recipientId,  String userRole,  String title, String message) {

        try {

            String sql = "INSERT INTO notifications " + "(recipient_id,user_role,title,message,status,created_at) " + "VALUES(?,?,?,?, 'UNREAD', NOW())";

            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, recipientId);
            ps.setString(2, userRole);
            ps.setString(3, title);
            ps.setString(4, message);

            int rows = ps.executeUpdate();

            ps.close();

            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
