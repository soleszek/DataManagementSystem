package com.sylwesteroleszek.dao;

import com.sylwesteroleszek.entity.User;

import java.util.List;

public interface UserDao {
    void SaveOrUpdate(User user);
    User findBy(Long id);
    User findBy(String username);
    List<User> findAll();
    void delete(Long id);
    void delete (User user);
}
