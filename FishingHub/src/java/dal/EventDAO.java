/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Timestamp;
import java.util.ArrayList;

import model.Events;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.EventNotification;
import model.EventParticipant;
import model.EventRejections;

/**
 *
 * @author LENOVO
 */
public class EventDAO extends DBConnect {

    public ArrayList<Events> getEvents() {
        ArrayList<Events> events = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Event WHERE Status='approved' ORDER BY EventId DESC";
            PreparedStatement statement = connection.prepareStatement(sql);
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

    public ArrayList<Events> getEventsList() {
        ArrayList<Events> events = new ArrayList<>();
        try {
            String sql = """
                    SELECT
                        e.*,
                        u.FullName,
                        u.Email,
                        u.Phone
                    FROM
                        Event e
                    JOIN
                        Users u ON e.HostId = u.UserId
                    ORDER BY
                        e.EventId DESC;""";
            PreparedStatement statement = connection.prepareStatement(sql);
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
                event.setFullName(rs.getString("FullName"));
                event.setEmail(rs.getString("Email"));
                event.setPhone(rs.getString("Phone"));
                events.add(event);
            }
        } catch (Exception e) {
            System.err.println("Error while fetching events: " + e.getMessage());
            e.printStackTrace();
        }
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

    public Events getDetailsEvents2(int id) {
        Events event = null;
        try {
            String sql = """
                    SELECT
                        e.*,
                        u.FullName,
                        u.Email,
                        u.Phone
                    FROM
                        Event e
                    JOIN
                        Users u ON e.HostId = u.UserId
                    Where e.EventId=?""";
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
                event.setFullName(rs.getString("FullName"));
                event.setEmail(rs.getString("Email"));
                event.setPhone(rs.getString("Phone"));
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

                    try (PreparedStatement eventStmt = connection.prepareStatement(updateEventSQL)) {
                        eventStmt.setInt(1, ep.getEventId());
                        eventStmt.executeUpdate();
                    }

                    connection.commit();
                    return ep;
                }
            }
        } catch (Exception e) {
            try {
                connection.rollback();
            } catch (Exception rollbackEx) {
                System.err.println("Error during rollback: " + rollbackEx.getMessage());
                rollbackEx.printStackTrace();
            }
            System.err.println("Error registering for event: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
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

    public ArrayList<Events> searchEvents(String keyword) {
        ArrayList<Events> events = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE Status = 'approved' "
                + "AND (Title LIKE ? OR LakeName LIKE ? OR Location LIKE ?)"
                + "ORDER BY EventId DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String kw = "%" + keyword + "%";

            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);

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

    public ArrayList<Events> upComingEvents() {
        ArrayList<Events> events = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Event Where StartTime > GETDATE() and Status='approved' ORDER BY StartTime ASC";
            PreparedStatement statement = connection.prepareStatement(sql);

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

    public ArrayList<Events> getOngoingEvents() {
        ArrayList<Events> events = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE Status = 'approved' AND StartTime <= GETDATE() AND EndTime >= GETDATE() ORDER BY StartTime ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

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

    public boolean approveEvent(int eventId) {
        String sql = "UPDATE Event SET status = ?, approvedAt = ? WHERE eventId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "approved");
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(3, eventId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean rejectEvent(int eventId, String rejectReason) {
        String updateSql = "UPDATE Event SET Status = ?, ApprovedAt = ? WHERE EventId = ?";
        String insertSql = "INSERT INTO EventRejections (EventId, RejectReason, RejectedAt) VALUES (?, ?, ?)";

        try {
            connection.setAutoCommit(false);

            try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                updateStmt.setString(1, "rejected");
                updateStmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                updateStmt.setInt(3, eventId);
                updateStmt.executeUpdate();
            }

            try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                insertStmt.setInt(1, eventId);
                insertStmt.setString(2, rejectReason);
                insertStmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
                insertStmt.executeUpdate();
            }

            connection.commit();
            return true;
        } catch (Exception e) {
            try {
                connection.rollback();
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public ArrayList<Events> getEvents(int page, int pageSize) {
        ArrayList<Events> list = new ArrayList<>();
        String sql = "SELECT * FROM Event where Status='approved' ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (page - 1) * pageSize);
            st.setInt(2, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setDescription(rs.getString("Description"));
                event.setLocation(rs.getString("Location"));
                event.setLakeName(rs.getString("LakeName"));
                event.setHostId(rs.getInt("HostId"));
                event.setStartTime(rs.getTimestamp("StartTime"));
                event.setEndTime(rs.getTimestamp("EndTime"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                event.setPosterUrl(rs.getString("PosterUrl"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
                list.add(event);
            }
            System.out.println("getEvents: Page " + page + ", Size " + list.size());
        } catch (Exception e) {
            System.err.println("SQL Error in getEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalEvents() {
        String sql = "SELECT COUNT(*) FROM Event";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int total = rs.getInt(1);
                System.out.println("Total Events: " + total);
                return total;
            }
        } catch (Exception e) {
            System.err.println("SQL Error in getTotalEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<Events> upComingEvents(int page, int pageSize) {
        ArrayList<Events> list = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE StartTime > GETDATE() AND Status = 'approved' ORDER BY StartTime ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (page - 1) * pageSize);
            st.setInt(2, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setDescription(rs.getString("Description"));
                event.setLocation(rs.getString("Location"));
                event.setLakeName(rs.getString("LakeName"));
                event.setHostId(rs.getInt("HostId"));
                event.setStartTime(rs.getTimestamp("StartTime"));
                event.setEndTime(rs.getTimestamp("EndTime"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                event.setPosterUrl(rs.getString("PosterUrl"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
                list.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalUpcomingEvents() {
        String sql = "SELECT COUNT(*) FROM Event WHERE StartTime > GETDATE() AND Status = 'approved'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<Events> getOngoingEvents(int page, int pageSize) {
        ArrayList<Events> list = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE StartTime <= GETDATE() AND EndTime >= GETDATE() AND Status = 'approved' ORDER BY StartTime ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, (page - 1) * pageSize);
            st.setInt(2, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setDescription(rs.getString("Description"));
                event.setLocation(rs.getString("Location"));
                event.setLakeName(rs.getString("LakeName"));
                event.setHostId(rs.getInt("HostId"));
                event.setStartTime(rs.getTimestamp("StartTime"));
                event.setEndTime(rs.getTimestamp("EndTime"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                event.setPosterUrl(rs.getString("PosterUrl"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
                list.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalOngoingEvents() {
        String sql = "SELECT COUNT(*) FROM Event WHERE StartTime <= GETDATE() AND EndTime >= GETDATE() AND Status = 'approved'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<Events> getSavedEvents(int userId, int page, int pageSize) {
        ArrayList<Events> list = new ArrayList<>();
        String sql = "SELECT e.* FROM Event e INNER JOIN EventParticipant ep ON e.EventId = ep.EventId WHERE ep.UserId = ? ORDER BY e.CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, (page - 1) * pageSize);
            st.setInt(3, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setDescription(rs.getString("Description"));
                event.setLocation(rs.getString("Location"));
                event.setLakeName(rs.getString("LakeName"));
                event.setHostId(rs.getInt("HostId"));
                event.setStartTime(rs.getTimestamp("StartTime"));
                event.setEndTime(rs.getTimestamp("EndTime"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                event.setPosterUrl(rs.getString("PosterUrl"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
                list.add(event);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalSavedEvents(int userId) {
        String sql = "SELECT COUNT(*) FROM Event e INNER JOIN EventParticipant ep ON e.EventId = ep.EventId WHERE ep.UserId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<Events> getEvents(int userId, int page, int pageSize) {
        ArrayList<Events> list = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE HostId = ? ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, (page - 1) * pageSize);
            st.setInt(3, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setDescription(rs.getString("Description"));
                event.setLocation(rs.getString("Location"));
                event.setLakeName(rs.getString("LakeName"));
                event.setHostId(rs.getInt("HostId"));
                event.setStartTime(rs.getTimestamp("StartTime"));
                event.setEndTime(rs.getTimestamp("EndTime"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                event.setPosterUrl(rs.getString("PosterUrl"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
                list.add(event);
            }
            System.out.println("getEvents: Page " + page + ", Size " + list.size());
        } catch (Exception e) {
            System.err.println("SQL Error in getEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalEvents(int userId) {
        String sql = "SELECT COUNT(*) FROM Event WHERE HostId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int total = rs.getInt(1);
                System.out.println("Total Events for user " + userId + ": " + total);
                return total;
            }
        } catch (Exception e) {
            System.err.println("SQL Error in getTotalEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<Events> searchEvents(int userId, String search, int page, int pageSize) {
        ArrayList<Events> list = new ArrayList<>();
        String sql = "SELECT * FROM Event WHERE HostId = ? AND (Title LIKE ? OR Location LIKE ?) ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, "%" + search + "%");
            st.setString(3, "%" + search + "%");
            st.setInt(4, (page - 1) * pageSize);
            st.setInt(5, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setDescription(rs.getString("Description"));
                event.setLocation(rs.getString("Location"));
                event.setLakeName(rs.getString("LakeName"));
                event.setHostId(rs.getInt("HostId"));
                event.setStartTime(rs.getTimestamp("StartTime"));
                event.setEndTime(rs.getTimestamp("EndTime"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                event.setPosterUrl(rs.getString("PosterUrl"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
                list.add(event);
            }
            System.out.println("searchEvents: Search '" + search + "', Page " + page + ", Size " + list.size());
        } catch (Exception e) {
            System.err.println("SQL Error in searchEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalSearchEvents(int userId, String search) {
        String sql = "SELECT COUNT(*) FROM Event WHERE HostId = ? AND (Title LIKE ? OR Location LIKE ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, "%" + search + "%");
            st.setString(3, "%" + search + "%");
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int total = rs.getInt(1);
                System.out.println("Total Search Events: " + total);
                return total;
            }
        } catch (Exception e) {
            System.err.println("SQL Error in getTotalSearchEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<Events> filterEvents(int userId, String statusFilter, int page, int pageSize) {
        ArrayList<Events> list = new ArrayList<>();
        String sql = "";
        if ("upcoming".equals(statusFilter)) {
            sql = "SELECT * FROM Event WHERE HostId = ? AND StartTime > GETDATE() AND Status = 'approved' ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        } else if ("ongoing".equals(statusFilter)) {
            sql = "SELECT * FROM Event WHERE HostId = ? AND StartTime <= GETDATE() AND EndTime >= GETDATE() AND Status = 'approved' ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        } else if ("ended".equals(statusFilter)) {
            sql = "SELECT * FROM Event WHERE HostId = ? AND EndTime < GETDATE() AND Status = 'approved' ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        } else if ("pass".equals(statusFilter)) {
            sql = "SELECT * FROM Event WHERE HostId = ? AND Status = 'approved' ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        } else if ("pending".equals(statusFilter)) {
            sql = "SELECT * FROM Event WHERE HostId = ? AND Status = 'pending' ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        } else if ("reject".equals(statusFilter)) {
            sql = "SELECT * FROM Event WHERE HostId = ? AND Status = 'rejected' ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        } else {
            sql = "SELECT * FROM Event WHERE HostId = ? ORDER BY CreatedAt DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setInt(2, (page - 1) * pageSize);
            st.setInt(3, pageSize);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events();
                event.setEventId(rs.getInt("EventId"));
                event.setTitle(rs.getString("Title"));
                event.setDescription(rs.getString("Description"));
                event.setLocation(rs.getString("Location"));
                event.setLakeName(rs.getString("LakeName"));
                event.setHostId(rs.getInt("HostId"));
                event.setStartTime(rs.getTimestamp("StartTime"));
                event.setEndTime(rs.getTimestamp("EndTime"));
                event.setStatus(rs.getString("Status"));
                event.setCreatedAt(rs.getTimestamp("CreatedAt"));
                event.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                event.setPosterUrl(rs.getString("PosterUrl"));
                event.setMaxParticipants(rs.getInt("MaxParticipants"));
                event.setCurrentParticipants(rs.getInt("CurrentParticipants"));
                list.add(event);
            }
            System.out.println("filterEvents: Filter '" + statusFilter + "', Page " + page + ", Size " + list.size());
        } catch (Exception e) {
            System.err.println("SQL Error in filterEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalFilterEvents(int userId, String statusFilter) {
        String sql = "";
        if ("upcoming".equals(statusFilter)) {
            sql = "SELECT COUNT(*) FROM Event WHERE HostId = ? AND StartTime > GETDATE() AND Status = 'approved'";
        } else if ("ongoing".equals(statusFilter)) {
            sql = "SELECT COUNT(*) FROM Event WHERE HostId = ? AND StartTime <= GETDATE() AND EndTime >= GETDATE() AND Status = 'approved'";
        } else if ("ended".equals(statusFilter)) {
            sql = "SELECT COUNT(*) FROM Event WHERE HostId = ? AND EndTime < GETDATE() AND Status = 'approved'";
        } else if ("pass".equals(statusFilter)) {
            sql = "SELECT COUNT(*) FROM Event WHERE HostId = ? AND Status = 'approved'";
        } else if ("pending".equals(statusFilter)) {
            sql = "SELECT COUNT(*) FROM Event WHERE HostId = ? AND Status = 'pending'";
        } else if ("reject".equals(statusFilter)) {
            sql = "SELECT COUNT(*) FROM Event WHERE HostId = ? AND Status = 'rejected'";
        } else {
            sql = "SELECT COUNT(*) FROM Event WHERE HostId = ?";
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int total = rs.getInt(1);
                System.out.println("Total Filter Events (" + statusFilter + "): " + total);
                return total;
            }
        } catch (Exception e) {
            System.err.println("SQL Error in getTotalFilterEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<EventParticipant> getParticipantsByEventId(int eventId, int page, int pageSize) {
        ArrayList<EventParticipant> participants = new ArrayList<>();
        String sql = """
                SELECT u.FullName, ep.EventId, ep.UserId, ep.NumberPhone, ep.Email, ep.CCCD, ep.Checkin, ep.CheckinTime
                FROM EventParticipant ep
                JOIN Users u ON ep.UserId = u.UserId
                WHERE ep.EventId = ?
                ORDER BY ep.UserId
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, eventId);
            statement.setInt(2, (page - 1) * pageSize);
            statement.setInt(3, pageSize);
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
            System.err.println("Error while fetching paginated participants: " + e.getMessage());
            e.printStackTrace();
        }
        return participants;
    }

    // Get total number of participants for an event
    public int getTotalParticipantsByEventId(int eventId) {
        String sql = "SELECT COUNT(*) FROM EventParticipant WHERE EventId = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, eventId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.err.println("Error counting participants: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // Search participants with pagination
    public ArrayList<EventParticipant> searchParticipantsByEventId(int eventId, String keyword, int page,
            int pageSize) {
        ArrayList<EventParticipant> participants = new ArrayList<>();
        String sql = """
                SELECT u.FullName, ep.EventId, ep.UserId, ep.NumberPhone, ep.Email, ep.CCCD, ep.Checkin, ep.CheckinTime
                FROM EventParticipant ep
                JOIN Users u ON ep.UserId = u.UserId
                WHERE ep.EventId = ? AND
                      (u.FullName LIKE ? OR ep.Email LIKE ? OR ep.CCCD LIKE ? OR ep.NumberPhone LIKE ?)
                ORDER BY ep.UserId
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            String kw = "%" + keyword + "%";
            statement.setInt(1, eventId);
            statement.setString(2, kw);
            statement.setString(3, kw);
            statement.setString(4, kw);
            statement.setString(5, kw);
            statement.setInt(6, (page - 1) * pageSize);
            statement.setInt(7, pageSize);
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
            System.err.println("Error while searching participants: " + e.getMessage());
            e.printStackTrace();
        }
        return participants;
    }

    // Get total number of searched participants
    public int getTotalSearchParticipants(int eventId, String keyword) {
        String sql = """
                SELECT COUNT(*)
                FROM EventParticipant ep
                JOIN Users u ON ep.UserId = u.UserId
                WHERE ep.EventId = ? AND
                      (u.FullName LIKE ? OR ep.Email LIKE ? OR ep.CCCD LIKE ? OR ep.NumberPhone LIKE ?)""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            String kw = "%" + keyword + "%";
            statement.setInt(1, eventId);
            statement.setString(2, kw);
            statement.setString(3, kw);
            statement.setString(4, kw);
            statement.setString(5, kw);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.err.println("Error counting searched participants: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // Filter participants by check-in status with pagination
    public ArrayList<EventParticipant> filterParticipantsByCheckin(int eventId, boolean checkinStatus, int page,
            int pageSize) {
        ArrayList<EventParticipant> participants = new ArrayList<>();
        String sql = """
                SELECT u.FullName, ep.EventId, ep.UserId, ep.NumberPhone, ep.Email, ep.CCCD, ep.Checkin, ep.CheckinTime
                FROM EventParticipant ep
                JOIN Users u ON ep.UserId = u.UserId
                WHERE ep.EventId = ? AND ep.Checkin = ?
                ORDER BY ep.UserId
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, eventId);
            statement.setBoolean(2, checkinStatus);
            statement.setInt(3, (page - 1) * pageSize);
            statement.setInt(4, pageSize);
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
            System.err.println("Error filtering participants: " + e.getMessage());
            e.printStackTrace();
        }
        return participants;
    }

    // Get total number of filtered participants
    public int getTotalFilterParticipants(int eventId, boolean checkinStatus) {
        String sql = "SELECT COUNT(*) FROM EventParticipant WHERE EventId = ? AND Checkin = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, eventId);
            statement.setBoolean(2, checkinStatus);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.err.println("Error counting filtered participants: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    // -----
    public ArrayList<Events> getEventsList(int page, int pageSize) {
        ArrayList<Events> events = new ArrayList<>();
        String sql = """
                SELECT e.*, u.FullName, u.Email, u.Phone
                FROM Event e
                JOIN Users u ON e.HostId = u.UserId
                ORDER BY e.EventId DESC
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, (page - 1) * pageSize);
            statement.setInt(2, pageSize);
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
                event.setFullName(rs.getString("FullName"));
                event.setEmail(rs.getString("Email"));
                event.setPhone(rs.getString("Phone"));
                events.add(event);
            }
            System.out.println("getEventsList: Page " + page + ", Size " + events.size());
        } catch (Exception e) {
            System.err.println("Error in getEventsList: " + e.getMessage());
            e.printStackTrace();
        }
        return events;
    }

    public ArrayList<Events> searchEvents(String keyword, int page, int pageSize) {
        ArrayList<Events> events = new ArrayList<>();
        String sql = """
                SELECT e.*, u.FullName, u.Email, u.Phone
                FROM Event e
                JOIN Users u ON e.HostId = u.UserId
                WHERE e.Title LIKE ? OR u.FullName LIKE ?
                ORDER BY e.EventId DESC
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            String kw = "%" + keyword + "%";
            statement.setString(1, kw);
            statement.setString(2, kw);
            statement.setInt(3, (page - 1) * pageSize);
            statement.setInt(4, pageSize);
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
                event.setFullName(rs.getString("FullName"));
                event.setEmail(rs.getString("Email"));
                event.setPhone(rs.getString("Phone"));
                events.add(event);
            }
            System.out.println("searchEvents: Keyword '" + keyword + "', Page " + page + ", Size " + events.size());
        } catch (Exception e) {
            System.err.println("Error in searchEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return events;
    }

    public int getTotalSearchEvents(String keyword) {
        String sql = """
                SELECT COUNT(*)
                FROM Event e
                JOIN Users u ON e.HostId = u.UserId
                WHERE e.Title LIKE ? OR u.FullName LIKE ?""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            String kw = "%" + keyword + "%";
            statement.setString(1, kw);
            statement.setString(2, kw);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Total Search Events for '" + keyword + "': " + count);
                return count;
            }
        } catch (Exception e) {
            System.err.println("Error in getTotalSearchEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<Events> filterEvents(String statusFilter, int page, int pageSize) {
        ArrayList<Events> events = new ArrayList<>();
        String sql = """
                SELECT e.*, u.FullName, u.Email, u.Phone
                FROM Event e
                JOIN Users u ON e.HostId = u.UserId
                WHERE e.Status = ?
                ORDER BY e.EventId DESC
                OFFSET ? ROWS FETCH NEXT ? ROWS ONLY""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, statusFilter);
            statement.setInt(2, (page - 1) * pageSize);
            statement.setInt(3, pageSize);
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
                event.setFullName(rs.getString("FullName"));
                event.setEmail(rs.getString("Email"));
                event.setPhone(rs.getString("Phone"));
                events.add(event);
            }
            System.out.println("filterEvents: Status '" + statusFilter + "', Page " + page + ", Size " + events.size());
        } catch (Exception e) {
            System.err.println("Error in filterEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return events;
    }

    public int getTotalFilterEvents(String statusFilter) {
        String sql = "SELECT COUNT(*) FROM Event WHERE Status = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, statusFilter);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("Total Filter Events for '" + statusFilter + "': " + count);
                return count;
            }
        } catch (Exception e) {
            System.err.println("Error in getTotalFilterEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<Events> getEventsOnTop() {
        ArrayList<Events> events = new ArrayList<>();
        String sql = """
                    SELECT TOP 3 *
                    FROM Event
                    WHERE
                      Status = 'Approved'
                      AND StartTime > GETDATE()
                      AND CurrentParticipants < MaxParticipants
                    ORDER BY
                      CurrentParticipants DESC,
                      StartTime ASC;
                """;

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
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

            System.out.println("getEventsOnTop: Size " + events.size());
        } catch (Exception e) {
            System.err.println("Error in getEventsOnTop: " + e.getMessage());
            e.printStackTrace();
        }

        return events;
    }

    public int getApprovedToday() {
        String sql = """
                SELECT COUNT(*) AS ApprovedToday
                FROM Event
                WHERE Status = 'approved'
                  AND CAST(ApprovedAt AS DATE) = CAST(GETDATE() AS DATE)""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("ApprovedToday");
                System.out.println("Approved Today: " + count);
                return count;
            }
        } catch (Exception e) {
            System.err.println("Error in getApprovedToday: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public int getRejectedToday() {
        String sql = """
                SELECT COUNT(*) AS RejectedToday
                FROM Event
                WHERE Status = 'rejected'
                  AND CAST(ApprovedAt AS DATE) = CAST(GETDATE() AS DATE)""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("RejectedToday");
                System.out.println("Rejected Today: " + count);
                return count;
            }
        } catch (Exception e) {
            System.err.println("Error in getRejectedToday: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public int getNewEventsToday() {
        String sql = """
                SELECT COUNT(*) AS NewEvents
                FROM Event
                WHERE CAST(CreatedAt AS DATE) = CAST(GETDATE() AS DATE)""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("NewEvents");
                System.out.println("New Events Today: " + count);
                return count;
            }
        } catch (Exception e) {
            System.err.println("Error in getNewEventsToday: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public int getPendingEvents() {
        String sql = """
                SELECT COUNT(*) AS PendingEvents
                FROM Event
                WHERE Status = 'pending'""";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("PendingEvents");
                System.out.println("Pending Events: " + count);
                return count;
            }
        } catch (Exception e) {
            System.err.println("Error in getPendingEvents: " + e.getMessage());
            e.printStackTrace();
        }
        return 0;
    }

    public ArrayList<EventNotification> getNotificationsByUserId(int userId) {
        ArrayList<EventNotification> list = new ArrayList<>();
        String sql = """
                SELECT en.*
                FROM EventNotification en
                JOIN EventParticipant ep ON en.EventId = ep.EventId
                WHERE ep.UserId = ?
                ORDER BY en.CreatedAt DESC
                """;
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                EventNotification en = new EventNotification();
                en.setNotificationId(rs.getInt("NotificationId"));
                en.setEventId(rs.getInt("EventId"));
                en.setSenderId(rs.getInt("SenderId"));
                en.setTitle(rs.getString("Title"));
                en.setMessage(rs.getString("Message"));
                en.setCreatedAt(rs.getTimestamp("CreatedAt"));

                list.add(en);
            }
        } catch (Exception e) {
            System.err.println("Error in getNotificationsByUserId: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public EventRejections getRejectionByEventId(int eventId) {
        String sql = "SELECT EventId, RejectReason, RejectedAt FROM EventRejections WHERE EventId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                EventRejections rejection = new EventRejections();
                rejection.setEventId(rs.getInt("EventId"));
                rejection.setRejectReason(rs.getString("RejectReason"));
                rejection.setRejectedAt(rs.getTimestamp("RejectedAt"));
                return rejection;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public ArrayList<EventNotification> getNotificationsSentByUser(int userId, String search) {
        ArrayList<EventNotification> list = new ArrayList<>();
        String sql = """
                    SELECT en.NotificationId, en.Title AS NotificationTitle, en.Message, en.CreatedAt,
                           e.Title AS EventTitle
                    FROM EventNotification en
                    JOIN Event e ON en.EventId = e.EventId
                    JOIN Users u ON en.SenderId = u.UserId
                    WHERE en.SenderId = ?
                    AND (en.Title LIKE ? OR e.Title LIKE ?)
                    ORDER BY en.CreatedAt DESC
                """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, "%" + search + "%");
            ps.setString(3, "%" + search + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EventNotification en = new EventNotification();
                    en.setNotificationId(rs.getInt("NotificationId"));
                    en.setTitle(rs.getString("NotificationTitle"));
                    en.setMessage(rs.getString("Message"));
                    en.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    en.setEventTitle(rs.getString("EventTitle"));
                    list.add(en);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in getNotificationsSentByUser: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

}