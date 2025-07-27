/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author LENOVO
 */
public class EventRejections {
    private int eventId;
    private String rejectReason;
    private Timestamp rejectedAt;

    public EventRejections() {
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getRejectReason() {
        return rejectReason;
    }

    public void setRejectReason(String rejectReason) {
        this.rejectReason = rejectReason;
    }

    public Timestamp getRejectedAt() {
        return rejectedAt;
    }

    public void setRejectedAt(Timestamp rejectedAt) {
        this.rejectedAt = rejectedAt;
    }

}