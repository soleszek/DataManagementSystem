package com.sylwesteroleszek.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDate;

@Entity
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String owner;
    private String assignedTo;
    private String documentBeingApprovedId;
    private String state; //Active, Completed
    private LocalDate dueDate;
    private LocalDate completionDate;
    private String comments;
    private String parent;

    public Task(){

    }

    public static class Builder {
        private String owner;
        private String assignedTo;
        private String documentBeingApprovedId;
        private String state;
        private LocalDate dueDate;
        private LocalDate completionDate;
        private String comments;
        private String parent;

        public Builder owner (String owner){
            this.owner = owner;
            return this;
        }

        public Builder assignedTo (String assignedTo){
            this.assignedTo = assignedTo;
            return this;
        }

        public Builder documentBeingApprovedId(String documentBeingApprovedId){
            this.documentBeingApprovedId = documentBeingApprovedId;
            return this;
        }

        public Builder state (String state) {
            this.state = state;
            return this;
        }

        public Builder dueDate (LocalDate dueDate) {
            this.dueDate = dueDate;
            return this;
        }

        public Builder completionDate (LocalDate completionDate) {
            this.completionDate = completionDate;
            return this;
        }

        public Builder comments(String comments) {
            this.comments = comments;
            return this;
        }

        public Builder parent(String parent) {
            this.parent = parent;
            return this;
        }

        public Task build() {
            return new Task(this);
        }
    }

    private Task (Builder builder){
        this.owner = builder.owner;
        this.assignedTo = builder.assignedTo;
        this.documentBeingApprovedId = builder.documentBeingApprovedId;
        this.state = builder.state;
        this.dueDate = builder.dueDate;
        this.completionDate = builder.completionDate;
        this.comments = builder.comments;
        this.parent = builder.parent;
    }

    public Long getId() {
        return id;
    }

    public String getOwner() {
        return owner;
    }

    public String getAssignedTo() {
        return assignedTo;
    }

    public String getDocumentBeingApprovedId() {
        return documentBeingApprovedId;
    }

    public String getState() {
        return state;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public LocalDate getCompletionDate() {
        return completionDate;
    }

    public String getComments() {
        return comments;
    }

    public String getParent() {
        return parent;
    }
}
