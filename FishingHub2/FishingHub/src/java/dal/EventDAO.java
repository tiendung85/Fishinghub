/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;

import model.Events;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.EventParticipant;

/**
 *
 * @author LENOVO
 */
public class EventDAO extends DBConnect {

    public ArrayList<Events> getEvents(int hostID) {
        ArrayList<Events> events = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Event WHERE Status='approved' AND HostId != ? ORDER BY EventId DESC";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, hostID);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setDescription(rs.getString("Description"));
                event.setLakeName(rs.getString("LakeName"));
                event.setLocation(rs.getString("Location"));
                event.setHostId(rs.getInt("HostId"));
                event.setStartTime(rs.getTimestamp("StartTime"));
                event.setEndTime(rs.getTimestamp("EndTime"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                event.setPosterUrl(rs.getString("PosterUrl"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
                events.add(event);
            }
        } catch (Exception e) {
            System.err.println("Error while fetching events: " + e.getMessage());
            e.printStackTrace();
        }
        return events; // Trả về danh sách rỗng thay vì null nếu không có sự kiện
    }

    public Events addEvent(Events event) {

        try {
            String sql = "INSERT INTO Event (Title, LakeName, Description, Location, HostId, StartTime, EndTime, Status, PosterUrl, MaxParticipants, CurrentParticipants) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, event.getTitle());
            statement.setString(2, event.getLakeName());
            statement.setString(3, event.getDescription());
            statement.setString(4, event.getLocation());
            statement.setInt(5, event.getHostId());
            statement.setTimestamp(6, event.getStartTime());
            statement.setTimestamp(7, event.getEndTime());
            statement.setString(8, event.getStatus());
            statement.setString(9, event.getPosterUrl());
            statement.setInt(10, event.getMaxParticipants());
            statement.setInt(11, event.getCurrentParticipants());

            int rs = statement.executeUpdate();
            return rs > 0 ? event : null;
        } catch (Exception e) {
            System.err.println("Lỗi khi chèn sự kiện: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public EventParticipant register(EventParticipant ep) {
        String insertParticipantSQL = "INSERT INTO EventParticipant (EventId, UserId) VALUES (?, ?)";
        String updateEventSQL = "UPDATE Event SET CurrentParticipants = CurrentParticipants + 1 WHERE EventId = ?";

        try {
            connection.setAutoCommit(false); // Start transaction

            // Insert into EventParticipant
            try (PreparedStatement participantStmt = connection.prepareStatement(insertParticipantSQL)) {
                participantStmt.setInt(1, ep.getEventId());
                participantStmt.setInt(2, ep.getUserId());
                int rowsAffected = participantStmt.executeUpdate();

                if (rowsAffected > 0) {
                    // Update currentParticipants in Event table
                    try (PreparedStatement eventStmt = connection.prepareStatement(updateEventSQL)) {
                        eventStmt.setInt(1, ep.getEventId());
                        eventStmt.executeUpdate();
                    }

                    connection.commit(); // Commit transaction
                    return ep;
                }
            }
        } catch (Exception e) {
            try {
                connection.rollback(); // Rollback on error
            } catch (Exception rollbackEx) {
                System.err.println("Error during rollback: " + rollbackEx.getMessage());
                rollbackEx.printStackTrace();
            }
            System.err.println("Error registering for event: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true); // Reset auto-commit
            } catch (Exception e) {
                System.err.println("Error resetting auto-commit: " + e.getMessage());
            }
        }
        return null;
    }

    public boolean isUserRegistered(int eventId, int userId) {
        String sql = "SELECT COUNT(*) FROM EventParticipant WHERE EventId = ? AND UserId = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, eventId);
            statement.setInt(2, userId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.err.println("Error checking registration: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEventFull(int eventId) {
        String sql = "SELECT CurrentParticipants, MaxParticipants FROM Event WHERE EventId = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, eventId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int current = rs.getInt("CurrentParticipants");
                int max = rs.getInt("MaxParticipants");
                return current >= max;
            }
        } catch (Exception e) {
            System.err.println("Error checking event capacity: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public ArrayList<Events> searchEvents(String keyword, int hostID) {
        ArrayList<Events> events = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE Status = 'approved' AND HostId != ? "
                + "AND (Title LIKE ? OR LakeName LIKE ? OR Location LIKE ?)"
                + "ORDER BY EventId DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String kw = "%" + keyword + "%";
            ps.setInt(1, hostID);
            ps.setString(2, kw);
            ps.setString(3, kw);
            ps.setString(4, kw);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setLakeName(rs.getString("LakeName"));
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
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));

                events.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return events;
    }

    public ArrayList<Events> upComingEvents(int hostID) {
        ArrayList<Events> events = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Event Where StartTime > GETDATE() and Status='approved' and HostId != ? ORDER BY StartTime ASC";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, hostID);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setDescription(rs.getString("Description"));
                event.setLakeName(rs.getString("LakeName"));
                event.setLocation(rs.getString("Location"));
                event.setHostId(rs.getInt("HostId"));
                event.setStartTime(rs.getTimestamp("StartTime"));
                event.setEndTime(rs.getTimestamp("EndTime"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                event.setPosterUrl(rs.getString("PosterUrl"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));

                events.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return events;
    }

    public ArrayList<Events> getOngoingEvents(int userId) {
        ArrayList<Events> events = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE Status = 'approved' AND HostId != ? AND StartTime <= GETDATE() AND EndTime >= GETDATE() ORDER BY StartTime ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setDescription(rs.getString("Description"));
                event.setLakeName(rs.getString("LakeName"));
                event.setLocation(rs.getString("Location"));
                event.setHostId(rs.getInt("HostId"));
                event.setStartTime(rs.getTimestamp("StartTime"));
                event.setEndTime(rs.getTimestamp("EndTime"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                event.setPosterUrl(rs.getString("PosterUrl"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));

                events.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return events;
    }

    public boolean cancelRegistration(int eventId, int userId) {
        String deleteParticipantSQL = "DELETE FROM EventParticipant WHERE EventId = ? AND UserId = ?";
        String updateEventSQL = "UPDATE Event SET CurrentParticipants = CurrentParticipants - 1 WHERE EventId = ?";

        try {
            connection.setAutoCommit(false);
            try (PreparedStatement participantStmt = connection.prepareStatement(deleteParticipantSQL)) {
                participantStmt.setInt(1, eventId);
                participantStmt.setInt(2, userId);
                int rowsAffected = participantStmt.executeUpdate();

                if (rowsAffected > 0) {
                    try (PreparedStatement eventStmt = connection.prepareStatement(updateEventSQL)) {
                        eventStmt.setInt(1, eventId);
                        eventStmt.executeUpdate();
                    }
                    connection.commit();
                    return true;
                }
            }
        } catch (Exception e) {
            try {
                connection.rollback();
            } catch (Exception rollbackEx) {
                System.err.println("Error during rollback: " + rollbackEx.getMessage());
                rollbackEx.printStackTrace();
            }
            System.err.println("Error canceling registration: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (Exception e) {
                System.err.println("Error resetting auto-commit: " + e.getMessage());
            }
        }
        return false;
    }
}