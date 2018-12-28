package com.sylwesteroleszek.factory;

import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.daoImpl.RouteDaoImpl;
import com.sylwesteroleszek.daoImpl.TaskDaoImpl;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.Task;
import com.sylwesteroleszek.entity.User;

public class TaskFactory {
    private TaskDao taskDao = new TaskDaoImpl();

    public void createTask(Route route){

        String routeState = route.getState();

        if(routeState.equals("not started")){

            Task task = new Task.Builder()
                    .owner(route.getOwner())
                    .assignedTo(route.getResponsibleForChecking())
                    .documentBeingApprovedId(route.getDocumentBeingApprovedId())
                    .state("active")
                    .dueDate(route.getCheckingDueDate())
                    .completionDate(null)
                    .comments("Please check")
                    .parentId(String.valueOf(route.getId()))
                    .build();

            taskDao.SaveOrUpdate(task);

        } else if (routeState.equals("checking")){

            Task task = new Task.Builder()
                    .owner(route.getOwner())
                    .assignedTo(route.getResponsibleForApproving())
                    .documentBeingApprovedId(route.getDocumentBeingApprovedId())
                    .state("active")
                    .dueDate(route.getCheckingDueDate())
                    .completionDate(null)
                    .comments("Please check")
                    .parentId(String.valueOf(route.getId()))
                    .build();

            taskDao.SaveOrUpdate(task);
        }
    }

}
