package com.sylwesteroleszek.factory;

import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.Task;
import com.sylwesteroleszek.providers.DaoProvider;

public class TaskFactory {

    private TaskDao taskDao = DaoProvider.getInstance().getTaskDao();

    public void createTask(Route route){

        String routeState = route.getState();

        if(routeState.equals("not started")){

            Task task = new Task.Builder()
                    .owner(route.getOwner())
                    .assignedTo(route.getResponsibleForChecking())
                    .documentBeingApprovedId(route.getDocumentBeingApprovedId())
                    .documentBeingApprovedName(route.getDocumentBeingApprovedName())
                    .state("active")
                    .dueDate(route.getCheckingDueDate())
                    .completionDate(null)
                    .comments("Please check")
                    .parentId(String.valueOf(route.getId()))
                    .build();

            taskDao.SaveOrUpdate(task);

            Long taskId = taskDao.findBy(task.getId()).getId();
            NameFactory nameFactory = new NameFactory();
            String name = nameFactory.createName(taskId, "task");

            task.setName(name);

            taskDao.SaveOrUpdate(task);

            assignTaskName(task);

        } else if (routeState.equals("checking")){

            Task task = new Task.Builder()
                    .owner(route.getOwner())
                    .assignedTo(route.getResponsibleForApproving())
                    .documentBeingApprovedId(route.getDocumentBeingApprovedId())
                    .documentBeingApprovedName(route.getDocumentBeingApprovedName())
                    .state("active")
                    .dueDate(route.getCheckingDueDate())
                    .completionDate(null)
                    .comments("Please approve")
                    .parentId(String.valueOf(route.getId()))
                    .build();

            taskDao.SaveOrUpdate(task);

            assignTaskName(task);

        }
    }


    private void assignTaskName(Task task) {
        Long taskId = taskDao.findBy(task.getId()).getId();
        NameFactory nameFactory = new NameFactory();
        String name = nameFactory.createName(taskId, "task");

        task.setName(name);

        taskDao.SaveOrUpdate(task);
    }


}
