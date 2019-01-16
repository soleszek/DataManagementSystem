package com.sylwesteroleszek.Classes;

import com.sylwesteroleszek.Enums.DocumentStates;
import com.sylwesteroleszek.Enums.RouteStates;
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

    public RouteOperations(Route route) {
        this.route = route;
    }

    public Route promoteRoute() {

        if(route.getState().equals(RouteStates.NOT_STARTED.getState())) {

            TaskFactory taskFactory = new TaskFactory();
            taskFactory.createTask(route);

            route.setState(RouteStates.CHECKING.getState());

            routeDao.SaveOrUpdate(route);

        } else if (route.getState().equals(RouteStates.CHECKING.getState())){

            String promotedDocumentIdString = route.getDocumentBeingApprovedId();
            Long promotedDocumentId = Long.parseLong(promotedDocumentIdString);
            Document document = documentDao.findBy(promotedDocumentId);
            document.setState(DocumentStates.FROZEN.getState());
            documentDao.SaveOrUpdate(document);

            TaskFactory taskFactory = new TaskFactory();
            taskFactory.createTask(route);

            route.setState(RouteStates.APPROVING.getState());
            routeDao.SaveOrUpdate(route);


        } else if (route.getState().equals(RouteStates.APPROVING.getState())){

            String promotedDocumentIdString = route.getDocumentBeingApprovedId();
            Long promotedDocumentId = Long.parseLong(promotedDocumentIdString);
            Document document = documentDao.findBy(promotedDocumentId);
            document.setState(DocumentStates.RELEASED.getState());
            documentDao.SaveOrUpdate(document);

            route.setState(RouteStates.COMPLETED.getState());
            routeDao.SaveOrUpdate(route);

        }

        return route;
    }
}
