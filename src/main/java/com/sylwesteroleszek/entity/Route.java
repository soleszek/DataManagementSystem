package com.sylwesteroleszek.entity;

import com.sylwesteroleszek.factory.DmsObject;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDate;

@Entity
public class Route extends DmsObject {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String state;
    private LocalDate creationDate;
    private LocalDate finishDate;
    private String checkedBy;
    private String approvedBy;
    private String comments;

    public Route() {
    }

    public static class Builder {
        private String state;
        private LocalDate creationDate;
        private LocalDate finishDate;
        private String checkedBy;
        private String approvedBy;
        private String comments;

        public Builder state(String state){
            this.state = state;
            return this;
        }

        public Builder creationDate(LocalDate creationDate){
            this.creationDate = creationDate;
            return this;
        }

        public Builder finishDate(LocalDate finishDate){
            this.finishDate = finishDate;
            return this;
        }

        public Builder checkedBy (String checkedBy){
            this.checkedBy = checkedBy;
            return this;
        }

        public Builder approvedBy(String approvedBy){
            this.approvedBy = approvedBy;
            return this;
        }

        public Builder comments(String comments){
            this.comments = comments;
            return this;
        }
    }

    private Route(Builder builder){
        this.state = builder.state;
        this.creationDate = builder.creationDate;
        this.finishDate = builder.finishDate;
        this.checkedBy = builder.checkedBy;
        this.approvedBy = builder.approvedBy;
        this.comments = builder.comments;
    }

    public String getState() {
        return state;
    }

    public LocalDate getCreationDate() {
        return creationDate;
    }

    public LocalDate getFinishDate() {
        return finishDate;
    }

    public String getCheckedBy() {
        return checkedBy;
    }

    public String getApprovedBy() {
        return approvedBy;
    }

    public String getComments() {
        return comments;
    }

/*    public Route(String state, LocalDate creationDate, LocalDate finishDate, String checkedBy, String approvedBy, String comments) {
        this.state = state;
        this.creationDate = creationDate;
        this.finishDate = finishDate;
        this.checkedBy = checkedBy;
        this.approvedBy = approvedBy;
        this.comments = comments;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public LocalDate getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(LocalDate creationDate) {
        this.creationDate = creationDate;
    }

    public LocalDate getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(LocalDate finishDate) {
        this.finishDate = finishDate;
    }

    public String getCheckedBy() {
        return checkedBy;
    }

    public void setCheckedBy(String checkedBy) {
        this.checkedBy = checkedBy;
    }

    public String getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(String approvedBy) {
        this.approvedBy = approvedBy;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }*/
}
