package com.sylwesteroleszek.Enums;

public enum ObjectTypes {
    USER("user"),
    DRAWING("drawing"),
    IMAGE("image"),
    DOCUMENT("document"),
    ROUTE("route"),
    TASK("task");

    String objectType;

    ObjectTypes(String objectType) {
        this.objectType = objectType;
    }

    public String getObjectType() {
        return objectType;
    }
}
