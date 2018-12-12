package com.sylwesteroleszek.dao;

import com.sylwesteroleszek.entity.Route;

import java.util.List;

public interface RouteDao {
    void SaveOrUpdate(Route route);
    Route findBy(Long id);
    List<Route> findAll();
    void delete(Long id);
    void delete(Route route);
}
