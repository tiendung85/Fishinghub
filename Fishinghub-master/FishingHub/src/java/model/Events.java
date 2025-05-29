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
public class Events {
    private int EventId;
    private String Title;
    private String Description;
    private String Location;
    private int HostId;
    private Timestamp StartTime;
    private Timestamp EndTime;
    private String Status;
    private Timestamp CreatedAt;
    private Timestamp ApprovedAt;
    private String PosterUrl;
    private int MaxParticipants;

    public Events() {
    }

    public int getEventId() {
        return EventId;
    }

    public void setEventId(int EventId) {
        this.EventId = EventId;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String Title) {
        this.Title = Title;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public String getLocation() {
        return Location;
    }

    public void setLocation(String Location) {
        this.Location = Location;
    }

    public int getHostId() {
        return HostId;
    }

    public void setHostId(int HostId) {
        this.HostId = HostId;
    }

    public Timestamp getStartTime() {
        return StartTime;
    }

    public void setStartTime(Timestamp StartTime) {
        this.StartTime = StartTime;
    }

    public Timestamp getEndTime() {
        return EndTime;
    }

    public void setEndTime(Timestamp EndTime) {
        this.EndTime = EndTime;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    public Timestamp getCreatedAt() {
        return CreatedAt;
    }

    public void setCreatedAt(Timestamp CreatedAt) {
        this.CreatedAt = CreatedAt;
    }

    public Timestamp getApprovedAt() {
        return ApprovedAt;
    }

    public void setApprovedAt(Timestamp ApprovedAt) {
        this.ApprovedAt = ApprovedAt;
    }

    public String getPosterUrl() {
        return PosterUrl;
    }

    public void setPosterUrl(String PosterUrl) {
        this.PosterUrl = PosterUrl;
    }

    public int getMaxParticipants() {
        return MaxParticipants;
    }

    public void setMaxParticipants(int MaxParticipants) {
        this.MaxParticipants = MaxParticipants;
    }

    
    
    
    
}