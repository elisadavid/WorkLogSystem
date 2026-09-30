/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Trainee2
 */
public class TraineeLeave {

    private int leaveId;
    private String traineeId;
    private String staffId;

    private String leaveFrom;
    private String leaveTo;
    private int totalDays;

    private String leaveType;
    private String reason;

    private String status;
    private String mentorRemark;

    private String appliedDate;
    private String updatedAt;
    
    

    // Optional Objects
    private traineeDetails traineeDetails;
    private staffDetails staffDetails;

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public int getTotalDays() {
        return totalDays;
    }

    public void setTotalDays(int totalDays) {
        this.totalDays = totalDays;
    }

    public String getAppliedDate() {
        return appliedDate;
    }

    public void setAppliedDate(String appliedDate) {
        this.appliedDate = appliedDate;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    public traineeDetails getTraineeDetails() {
        return traineeDetails;
    }

    public void setTraineeDetails(traineeDetails traineeDetails) {
        this.traineeDetails = traineeDetails;
    }

    public staffDetails getStaffDetails() {
        return staffDetails;
    }

    public void setStaffDetails(staffDetails staffDetails) {
        this.staffDetails = staffDetails;
    }
    
    

    
    
    
    
    public String getMentorRemark() {
        return mentorRemark;
    }

    public void setMentorRemark(String mentorRemark) {
        this.mentorRemark = mentorRemark;
    }
    
    

    public int getLeaveId() {
        return leaveId;
    }

    public void setLeaveId(int leaveId) {
        this.leaveId = leaveId;
    }

    public String getTraineeId() {
        return traineeId;
    }

    public void setTraineeId(String traineeId) {
        this.traineeId = traineeId;
    }

    public String getLeaveFrom() {
        return leaveFrom;
    }

    public void setLeaveFrom(String leaveFrom) {
        this.leaveFrom = leaveFrom;
    }

    public String getLeaveTo() {
        return leaveTo;
    }

    public void setLeaveTo(String leaveTo) {
        this.leaveTo = leaveTo;
    }

    public String getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
