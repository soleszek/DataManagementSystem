package com.sylwesteroleszek.providers;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.daoImpl.DocumentDaoImpl;
import com.sylwesteroleszek.daoImpl.RouteDaoImpl;
import com.sylwesteroleszek.daoImpl.TaskDaoImpl;
import com.sylwesteroleszek.daoImpl.UserDaoImpl;

public class DaoProvider {
    private static final DaoProvider instance = new DaoProvider();

    private DocumentDao documentDao;
    private RouteDao routeDao;
    private UserDao userDao;
    private TaskDao taskDao;

    private DaoProvider(){
        documentDao = new DocumentDaoImpl();
        routeDao = new RouteDaoImpl();
        userDao = new UserDaoImpl();
        taskDao = new TaskDaoImpl();
    }

    public static DaoProvider getInstance(){
        return instance;
    }

    public DocumentDao getDocumentDao() {
        return documentDao;
    }

    public RouteDao getRouteDao() {
        return routeDao;
    }

    public UserDao getUserDao() {
        return userDao;
    }

    public TaskDao getTaskDao() {
        return taskDao;
    }
}
