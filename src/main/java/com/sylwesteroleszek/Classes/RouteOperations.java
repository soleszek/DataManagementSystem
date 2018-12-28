package com.sylwesteroleszek.Classes;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.daoImpl.DocumentDaoImpl;
import com.sylwesteroleszek.daoImpl.RouteDaoImpl;
import com.sylwesteroleszek.daoImpl.TaskDaoImpl;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.Task;
import com.sylwesteroleszek.factory.TaskFactory;

public class RouteOperations {
    Route route;

    private RouteDao routeDao = new RouteDaoImpl();
    private DocumentDao documentDao = new DocumentDaoImpl();
    /*private TaskDao taskDao = new TaskDaoImpl();*/

    public RouteOperations(Route route) {
        this.route = route;
    }

    public Route promoteRoute() {

        if(route.getState().equals("not started")) {

            /*Task task = new Task.Builder()
                    .owner(route.getOwner())
                    .assignedTo(route.getResponsibleForChecking())
                    .documentBeingApprovedId(route.getDocumentBeingApprovedId())
                    .state("active")
                    .dueDate(route.getCheckingDueDate())
                    .completionDate(null)
                    .comments("Please check")
                    .parentId(String.valueOf(route.getId()))
                    .build();

            taskDao.SaveOrUpdate(task);*/

            TaskFactory taskFactory = new TaskFactory();
            taskFactory.createTask(route);

            route.setState("checking");

            routeDao.SaveOrUpdate(route);

        } else if (route.getState().equals("checking")){

            String promotedDocumentIdString = route.getDocumentBeingApprovedId();
            Long promotedDocumentId = Long.parseLong(promotedDocumentIdString);
            Document document = documentDao.findBy(promotedDocumentId);
            document.setState("frozen");
            documentDao.SaveOrUpdate(document);

            TaskFactory taskFactory = new TaskFactory();
            taskFactory.createTask(route);

            route.setState("approving");
            routeDao.SaveOrUpdate(route);


        } else if (route.getState().equals("approving")){

            String promotedDocumentIdString = route.getDocumentBeingApprovedId();
            Long promotedDocumentId = Long.parseLong(promotedDocumentIdString);
            Document document = documentDao.findBy(promotedDocumentId);
            document.setState("released");
            documentDao.SaveOrUpdate(document);

            route.setState("completed");
            routeDao.SaveOrUpdate(route);

        }

        return route;
    }
}
