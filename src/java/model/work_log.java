/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author kgaut
 */
public class work_log {

    private int worklogId;
    private String traineeId;
    private String staffId;
    private String workDate;
    private String workTitle;
    private String workDescription;
    private String hoursWorked;
    private String status;
    private String mentorRemarks;

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
    
    
    

    public int getWorklogId() {
        return worklogId;
    }

    public void setWorklogId(int worklogId) {
        this.worklogId = worklogId;
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

    public String getWorkDate() {
        return workDate;
    }

    public void setWorkDate(String workDate) {
        this.workDate = workDate;
    }

    public String getWorkTitle() {
        return workTitle;
    }

    public void setWorkTitle(String workTitle) {
        this.workTitle = workTitle;
    }

    public String getWorkDescription() {
        return workDescription;
    }

    public void setWorkDescription(String workDescription) {
        this.workDescription = workDescription;
    }

    public String getHoursWorked() {
        return hoursWorked;
    }

    public void setHoursWorked(String hoursWorked) {
        this.hoursWorked = hoursWorked;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMentorRemarks() {
        return mentorRemarks;
    }

    public void setMentorRemarks(String mentorRemarks) {
        this.mentorRemarks = mentorRemarks;
    }

}
