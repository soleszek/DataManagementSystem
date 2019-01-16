package com.sylwesteroleszek.Enums;

public enum DocumentStates {
    INWORK("in work"),
    FROZEN("frozen"),
    RELEASED("released"),
    CANCELED("cancelled");

    String state;

    DocumentStates(String state) {
        this.state = state;
    }

    public String getState() {
        return state;
    }
}
