package com.sylwesteroleszek.Enums;

public enum TaskStates {
    ACTIVE("active"),
    COMPLETED("completed");

    String state;

    TaskStates(String state) {
        this.state = state;
    }

    public String getState() {
        return state;
    }
}
