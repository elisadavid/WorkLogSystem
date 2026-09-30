/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author Trainee2
 */
public class traineeDetails {

    private String traineeId;
    private String traineeName;
    private String gender;
    private Date dob;
    private String place;
    private String branch;
    private String qualification;
    private String emailId;
    private String phonenumber;
    private Date joiningDate;
    private Date completionDate;
    private String division;
    private String active;
    private String completionStatus, completionReason;
    private String username;
    private String password;

    private Assignment objAssignment;
    private designation objDesignationitems;
    private Assignment objAssign;
  
    
    

    public Assignment getObjAssignment() {
        return objAssignment;
    }

    public void setObjAssignment(Assignment objAssignment) {
        this.objAssignment = objAssignment;
    }
    
    

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCompletionStatus() {
        return completionStatus;
    }

    public void setCompletionStatus(String completionStatus) {
        this.completionStatus = completionStatus;
    }

    public String getCompletionReason() {
        return completionReason;
    }

    public void setCompletionReason(String completionReason) {
        this.completionReason = completionReason;
    }

    

    public Assignment getObjAssign() {
        return objAssign;
    }

    public void setObjAssign(Assignment objAssign) {
        this.objAssign = objAssign;
    }

    private staffDetails objStaff;

    public staffDetails getObjStaff() {
        return objStaff;
    }

    public void setObjStaff(staffDetails objStaff) {
        this.objStaff = objStaff;
    }

    public String getTraineeId() {
        return traineeId;
    }

    public void setTraineeId(String traineeId) {
        this.traineeId = traineeId;
    }

    public String getTraineeName() {
        return traineeName;
    }

    public void setTraineeName(String traineeName) {
        this.traineeName = traineeName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public Date getJoiningDate() {
        return joiningDate;
    }

    public void setJoiningDate(Date joiningDate) {
        this.joiningDate = joiningDate;
    }

    public Date getCompletionDate() {
        return completionDate;
    }

    public void setCompletionDate(Date completionDate) {
        this.completionDate = completionDate;
    }

    public String getDivision() {
        return division;
    }

    public void setDivision(String division) {
        this.division = division;
    }

    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    public designation getObjDesignationitems() {
        return objDesignationitems;
    }

    public void setObjDesignationitems(designation objDesignationitems) {
        this.objDesignationitems = objDesignationitems;
    }

}
