/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;

import model.Events;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
<<<<<<< HEAD
import model.EventNotification;
=======
>>>>>>> origin/NgocDung
import model.EventParticipant;

/**
 *
 * @author LENOVO
 */
public class EventDAO extends DBConnect {

<<<<<<< HEAD
    public ArrayList<Events> getEvents() {
        ArrayList<Events> events = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Event WHERE Status='approved' ORDER BY EventId DESC";
            PreparedStatement statement = connection.prepareStatement(sql);
=======
    public ArrayList<Events> getEvents(int hostID) {
        ArrayList<Events> events = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Event WHERE Status='approved' AND HostId != ? ORDER BY EventId DESC";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, hostID);
>>>>>>> origin/NgocDung
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
<<<<<<< HEAD
        return events;
    }

    public ArrayList<Events> getEvents(int userId) {
        ArrayList<Events> events = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Event WHERE HostId=? ORDER BY EventId DESC";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
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
        return events;
    }

    public ArrayList<EventParticipant> getParticipantsByEventId(int eventId) {
        ArrayList<EventParticipant> participants = new ArrayList<>();
        try {
            String sql = """
                    SELECT
                          u.FullName,
                          ep.EventId,
                          ep.UserId,
                          ep.NumberPhone,
                          ep.Email,
                          ep.CCCD,
                          ep.Checkin,
                        ep.CheckinTime
                      FROM
                          EventParticipant ep
                      JOIN
                          Users u ON ep.UserId = u.UserId
                      WHERE
                          ep.EventId = ?;""";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, eventId);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                EventParticipant p = new EventParticipant();
                p.setFullName(rs.getString("FullName"));
                p.setEventId(rs.getInt("EventId"));
                p.setUserId(rs.getInt("UserId"));

                p.setNumberPhone(rs.getString("NumberPhone"));
                p.setEmail(rs.getString("Email"));
                p.setCccd(rs.getString("CCCD"));
                p.setCheckin(rs.getBoolean("Checkin"));
                p.setCheckinTime(rs.getTimestamp("CheckinTime"));
                participants.add(p);
            }
        } catch (Exception e) {
            System.err.println("Error while fetching participants: " + e.getMessage());
            e.printStackTrace();
        }
        return participants;
    }

    public ArrayList<EventParticipant> filterParticipantsByCheckin(int eventId, boolean checkinStatus) {
        ArrayList<EventParticipant> participants = new ArrayList<>();
        try {
            String sql = """
                        SELECT u.FullName, ep.NumberPhone, ep.Email, ep.CCCD, ep.Checkin,ep.CheckinTime
                        FROM EventParticipant ep
                        JOIN Users u ON ep.UserId = u.UserId
                        WHERE ep.EventId = ? AND ep.Checkin = ?
                    """;
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, eventId);
            statement.setBoolean(2, checkinStatus);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                EventParticipant p = new EventParticipant();
                p.setFullName(rs.getString("FullName"));
                p.setNumberPhone(rs.getString("NumberPhone"));
                p.setEmail(rs.getString("Email"));
                p.setCccd(rs.getString("CCCD"));
                p.setCheckin(rs.getBoolean("Checkin"));
                p.setCheckinTime(rs.getTimestamp("CheckinTime"));
                participants.add(p);
            }
        } catch (Exception e) {
            System.err.println("Error filtering participants: " + e.getMessage());
        }
        return participants;
    }

    public boolean updateCheckIn(int eventId, int userId) {
        String sql = "UPDATE EventParticipant SET Checkin = 1, CheckinTime = GETDATE() WHERE EventId = ? AND UserId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            stmt.setInt(2, userId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Events getDetailsEvents(int id) {
        Events event = null;
        try {
            String sql = "SELECT * FROM Event WHERE Status='approved' AND EventId=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                event = new Events();
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
            }
        } catch (Exception e) {
            System.err.println("Error while fetching event details: " + e.getMessage());
            e.printStackTrace();
        }
        return event;
    }

    public Events getUpdateEvents(int id) {
        Events event = null;
        try {
            String sql = "SELECT * FROM Event WHERE EventId=?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                event = new Events();
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
            }
        } catch (Exception e) {
            System.err.println("Error while fetching event details: " + e.getMessage());
            e.printStackTrace();
        }
        return event;
    }

    public ArrayList<Events> getSavedEvents(int userId) {
        ArrayList<Events> events = new ArrayList<>();
        try {
            String sql = """
                    SELECT e.EventId,
                               e.Title,
                               e.Description,
                               e.LakeName,
                               e.Location,
                               e.HostId,
                               e.StartTime,
                               e.EndTime,
                               e.Status,
                               e.CreatedAt,
                               e.ApprovedAt,
                               e.PosterUrl,
                               e.CurrentParticipants,
                               e.MaxParticipants
                        FROM Event e
                        JOIN EventParticipant ep ON e.EventId = ep.EventId
                        WHERE ep.UserId = ?""";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
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
        return events;
=======
        return events; // Trả về danh sách rỗng thay vì null nếu không có sự kiện
>>>>>>> origin/NgocDung
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

<<<<<<< HEAD
    public Events updateEvent(Events event) {
        try {
            String sql = "UPDATE Event SET Title = ?, LakeName = ?, Description = ?, Location = ?, "
                    + "StartTime = ?, EndTime = ?, Status = ?, PosterUrl = ?, MaxParticipants = ?, CurrentParticipants = ? "
                    + "WHERE EventId = ?";

            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, event.getTitle());
            statement.setString(2, event.getLakeName());
            statement.setString(3, event.getDescription());
            statement.setString(4, event.getLocation());
            statement.setTimestamp(5, event.getStartTime());
            statement.setTimestamp(6, event.getEndTime());
            statement.setString(7, event.getStatus());
            statement.setString(8, event.getPosterUrl());
            statement.setInt(9, event.getMaxParticipants());
            statement.setInt(10, event.getCurrentParticipants());
            statement.setInt(11, event.getEventId());

            int rs = statement.executeUpdate();
            return rs > 0 ? event : null;

        } catch (Exception e) {
            System.err.println("Lỗi khi cập nhật sự kiện: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public EventParticipant register(EventParticipant ep) {
        String insertParticipantSQL = "INSERT INTO EventParticipant (EventId, UserId,NumberPhone,Email,CCCD,Checkin) VALUES (?, ?,?,?,?,?)";
        String updateEventSQL = "UPDATE Event SET CurrentParticipants = CurrentParticipants + 1 WHERE EventId = ?";

        try {
            connection.setAutoCommit(false);

            try (PreparedStatement participantStmt = connection.prepareStatement(insertParticipantSQL)) {
                participantStmt.setInt(1, ep.getEventId());
                participantStmt.setInt(2, ep.getUserId());
                participantStmt.setString(3, ep.getNumberPhone());
                participantStmt.setString(4, ep.getEmail());
                participantStmt.setString(5, ep.getCccd());
                participantStmt.setBoolean(6, ep.isCheckin());
                int rowsAffected = participantStmt.executeUpdate();

                if (rowsAffected > 0) {

=======
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
>>>>>>> origin/NgocDung
                    try (PreparedStatement eventStmt = connection.prepareStatement(updateEventSQL)) {
                        eventStmt.setInt(1, ep.getEventId());
                        eventStmt.executeUpdate();
                    }

<<<<<<< HEAD
                    connection.commit();
=======
                    connection.commit(); // Commit transaction
>>>>>>> origin/NgocDung
                    return ep;
                }
            }
        } catch (Exception e) {
            try {
<<<<<<< HEAD
                connection.rollback();
=======
                connection.rollback(); // Rollback on error
>>>>>>> origin/NgocDung
            } catch (Exception rollbackEx) {
                System.err.println("Error during rollback: " + rollbackEx.getMessage());
                rollbackEx.printStackTrace();
            }
            System.err.println("Error registering for event: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
<<<<<<< HEAD
                connection.setAutoCommit(true);
=======
                connection.setAutoCommit(true); // Reset auto-commit
>>>>>>> origin/NgocDung
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

<<<<<<< HEAD
    public ArrayList<Events> searchEvents(String keyword) {
        ArrayList<Events> events = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE Status = 'approved' "
=======
    public ArrayList<Events> searchEvents(String keyword, int hostID) {
        ArrayList<Events> events = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE Status = 'approved' AND HostId != ? "
>>>>>>> origin/NgocDung
                + "AND (Title LIKE ? OR LakeName LIKE ? OR Location LIKE ?)"
                + "ORDER BY EventId DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String kw = "%" + keyword + "%";
<<<<<<< HEAD

            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);
=======
            ps.setInt(1, hostID);
            ps.setString(2, kw);
            ps.setString(3, kw);
            ps.setString(4, kw);
>>>>>>> origin/NgocDung

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

<<<<<<< HEAD
    public ArrayList<Events> upComingEvents() {
        ArrayList<Events> events = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Event Where StartTime > GETDATE() and Status='approved' ORDER BY StartTime ASC";
            PreparedStatement statement = connection.prepareStatement(sql);

=======
    public ArrayList<Events> upComingEvents(int hostID) {
        ArrayList<Events> events = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Event Where StartTime > GETDATE() and Status='approved' and HostId != ? ORDER BY StartTime ASC";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, hostID);
>>>>>>> origin/NgocDung
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

<<<<<<< HEAD
    public ArrayList<Events> getOngoingEvents() {
        ArrayList<Events> events = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE Status = 'approved' AND StartTime <= GETDATE() AND EndTime >= GETDATE() ORDER BY StartTime ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

=======
    public ArrayList<Events> getOngoingEvents(int userId) {
        ArrayList<Events> events = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE Status = 'approved' AND HostId != ? AND StartTime <= GETDATE() AND EndTime >= GETDATE() ORDER BY StartTime ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
>>>>>>> origin/NgocDung
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
<<<<<<< HEAD

    public boolean deleteEvent(int eventId) {
        try {
            String sql = "DELETE FROM Event WHERE EventId = ? AND Status != 'approved'";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, eventId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("Lỗi khi xóa sự kiện: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public EventNotification insertNotification(EventNotification notification) {
        String sql = "INSERT INTO EventNotification (EventId, SenderId, Message,Title) OUTPUT INSERTED.NotificationId, INSERTED.CreatedAt VALUES (?, ?, ?,?)";

        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, notification.getEventId());
            ps.setInt(2, notification.getSenderId());
            ps.setString(3, notification.getMessage());
            ps.setString(4, notification.getTitle());

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                notification.setNotificationId(rs.getInt("NotificationId"));
                notification.setCreatedAt(rs.getTimestamp("CreatedAt"));
                return notification;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
=======
}
>>>>>>> origin/NgocDung
