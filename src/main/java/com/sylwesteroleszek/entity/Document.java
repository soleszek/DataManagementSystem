package com.sylwesteroleszek.entity;

import com.sylwesteroleszek.factory.DmsObject;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDate;

@Entity
public class Document extends DmsObject {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
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

    public Document(int revision, String type, String title, String description, String state, String owner, LocalDate creationDate, LocalDate lastModification, String link) {
        this.revision = revision;
        this.type = type;
        this.title = title;
        this.description = description;
        this.state = state;
        this.owner = owner;
        this.creationDate = creationDate;
        this.lastModification = lastModification;
        this.link = link;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getRevision() {
        return revision;
    }

    public void setRevision(int revision) {
        this.revision = revision;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public LocalDate getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(LocalDate creationDate) {
        this.creationDate = creationDate;
    }

    public LocalDate getLastModification() {
        return lastModification;
    }

    public void setLastModification(LocalDate lastModification) {
        this.lastModification = lastModification;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    @Override
    public String toString() {
        return "Document{" +
                "id=" + id +
                ", revision=" + revision +
                ", type='" + type + '\'' +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", state='" + state + '\'' +
                ", owner='" + owner + '\'' +
                ", creationDate=" + creationDate +
                ", lastModification=" + lastModification +
                ", link='" + link + '\'' +
                '}';
    }
}
