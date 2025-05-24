/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;

import model.Events;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author LENOVO
 */
public class EventDAO extends DBConnect{

    public   ArrayList<Events> getEvents() {
        ArrayList<Events> events = new ArrayList<>();
        

        try {
            String sql = "SELECT * FROM Event";
            PreparedStatement statement = c.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setDescription(rs.getString("Description"));
                event.setLocation(rs.getString("Location"));
                event.setHostId(rs.getInt("HostId"));
                event.setStartTime(rs.getTimestamp("StartTime"));
                event.setEndTime(rs.getTimestamp("EndTime"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                event.setPosterUrl(rs.getString("PosterUrl"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));

                events.add(event);
            }

        } catch (Exception e) {
            System.err.println("Error while fetching events: " + e.getMessage());
            e.printStackTrace();
            return null;
        }

        return events.isEmpty() ? null : events;
    }

    public Events addEvent(Events event) {
        
       
        try {
            String sql = "INSERT INTO Event (Title, Description, Location, HostId, StartTime, EndTime, Status, PosterUrl, MaxParticipants) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = c.prepareStatement(sql);

            statement.setString(1, event.getTitle());
            statement.setString(2, event.getDescription());
            statement.setString(3, event.getLocation());
            statement.setInt(4, event.getHostId());
            statement.setTimestamp(5, event.getStartTime());
            statement.setTimestamp(6, event.getEndTime());
            statement.setString(7, event.getStatus());
            statement.setString(8, event.getPosterUrl());
            statement.setInt(9, event.getMaxParticipants());

            int rs = statement.executeUpdate();
                return rs > 0 ? event : null;
        } catch (Exception e) {
            System.err.println("Lỗi khi chèn sự kiện: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
