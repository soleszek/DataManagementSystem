package com.sylwesteroleszek.dao;

import com.sylwesteroleszek.entity.Task;

import java.util.List;

public interface TaskDao {
    void SaveOrUpdate(Task task);
    Task findBy(Long id);
    List<Task> findAll();
    void delete(Long id);
    void delete(Task task);
}

