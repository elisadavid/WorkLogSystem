/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Trainee2
 */
public class Assignment {
    private int assignmentId;

    private String traineeId;

    private String staffId;

    private String assignedBy;
    
    private Date assignedDate;
    private String status;
    private String remarks;
    private String acceptedDate;
    private String rejectedDate;
    
    private traineeDetails objTrainee;

    private staffDetails objStaff;

    public traineeDetails getObjTrainee() {
        return objTrainee;
    }

    public void setObjTrainee(traineeDetails objTrainee) {
        this.objTrainee = objTrainee;
    }

    public staffDetails getObjStaff() {
        return objStaff;
    }

    public void setObjStaff(staffDetails objStaff) {
        this.objStaff = objStaff;
    }
    
    

    public Date getAssignedDate() {
        return assignedDate;
    }

    public void setAssignedDate(Date assignedDate) {
        this.assignedDate = assignedDate;
    }

    

    public String getAcceptedDate() {
        return acceptedDate;
    }

    public void setAcceptedDate(String acceptedDate) {
        this.acceptedDate = acceptedDate;
    }

    public String getRejectedDate() {
        return rejectedDate;
    }

    public void setRejectedDate(String rejectedDate) {
        this.rejectedDate = rejectedDate;
    }
    
    

    
    public int getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(int assignmentId) {
        this.assignmentId = assignmentId;
    }

    public String getTraineeId() {
        return traineeId;
    }

    public void setTraineeId(String traineeId) {
        this.traineeId = traineeId;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public String getAssignedBy() {
        return assignedBy;
    }

    public void setAssignedBy(String assignedBy) {
        this.assignedBy = assignedBy;
    }

  

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

  

 
}
