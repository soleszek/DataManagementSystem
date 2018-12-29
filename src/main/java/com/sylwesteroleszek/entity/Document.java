package com.sylwesteroleszek.entity;

import com.sylwesteroleszek.factory.TaskFactory;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDate;

@Entity
public class Document extends TaskFactory {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String name;
    private int revision;
    private String type;
    private String title;
    private String description;
    private String state;
    private String owner;
    private LocalDate creationDate;
    private LocalDate lastModification;
    private String link;

    public Document() {
    }

    public static class Builder{
        private String name;
        private int reivision;
        private String type;
        private String title;
        private String description;
        private String state;
        private String owner;
        private LocalDate creationDate;
        private LocalDate lastModification;
        private String link;

        public Builder name(String name){
            this.name = name;
            return this;
        }

        public Builder revision(int reivision){
            this.reivision = reivision;
            return this;
        }

        public Builder type(String type){
            this.type = type;
            return this;
        }

        public Builder title(String title){
            this.title = title;
            return this;
        }

        public Builder description(String description){
            this.description = description;
            return this;
        }

        public Builder state(String state){
            this.state = state;
            return this;
        }

        public Builder owner(String owner){
            this.owner = owner;
            return this;
        }

        public Builder creationDate(LocalDate creationDate){
            this.creationDate = creationDate;
            return this;
        }

        public Builder lastModification(LocalDate lastModification){
            this.lastModification = lastModification;
            return this;
        }

        public Builder link(String link){
            this.link = link;
            return this;
        }

        public Document build(){
            return new Document(this);
        }
    }

    private Document(Builder builder){
        this.name = builder.name;
        this.revision = builder.reivision;
        this.type = builder.type;
        this.title = builder.title;
        this.description = builder.description;
        this.state = builder.state;
        this.owner = builder.owner;
        this.creationDate = builder.creationDate;
        this.lastModification = builder.lastModification;
        this.link = builder.link;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getRevision() {
        return revision;
    }

    public String getType() {
        return type;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getState() {
        return state;
    }

    public String getOwner() {
        return owner;
    }

    public LocalDate getCreationDate() {
        return creationDate;
    }

    public LocalDate getLastModification() {
        return lastModification;
    }

    public String getLink() {
        return link;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setRevision(int revision) {
        this.revision = revision;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setState(String state) {
        this.state = state;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public void setCreationDate(LocalDate creationDate) {
        this.creationDate = creationDate;
    }

    public void setLastModification(LocalDate lastModification) {
        this.lastModification = lastModification;
    }

    public void setLink(String link) {
        this.link = link;
    }
}
