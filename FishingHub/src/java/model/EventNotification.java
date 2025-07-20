/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 *
 * @author LENOVO
 */
public class EventNotification {

    private int notificationId;
    private int eventId;
    private int senderId;
    private String title;
    private String message;
    private Timestamp createdAt;
    
       private String formattedCreatedAt;

    public EventNotification(int notificationId, int eventId, int senderId, String message, Timestamp createdAt) {
        this.notificationId = notificationId;
        this.eventId = eventId;
        this.senderId = senderId;
        this.message = message;
        this.createdAt = createdAt;
    }

    public EventNotification() {
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getSenderId() {
        return senderId;
    }

    public void setSenderId(int senderId) {
        this.senderId = senderId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
         this.createdAt = createdAt;
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        this.formattedCreatedAt = sdf.format(createdAt);
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

   

   

    public String getFormattedCreatedAt() {
        return formattedCreatedAt;
    }
    
     public void setFormattedCreatedAt(String formattedCreatedAt) {
        this.formattedCreatedAt = formattedCreatedAt;
    }
}
