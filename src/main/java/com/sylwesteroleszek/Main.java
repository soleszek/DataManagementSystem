package com.sylwesteroleszek;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.User;
import com.sylwesteroleszek.providers.DaoProvider;
import com.sylwesteroleszek.utils.HibernateUtils;

import java.time.LocalDate;
import java.time.Month;

public class Main {
    public static void main(String[] args) {
        /*DocumentDao documentDao = DaoProvider.getInstance().getDocumentDao();
        RouteDao routeDao = DaoProvider.getInstance().getRouteDao();
        UserDao userDao = DaoProvider.getInstance().getUserDao();

        Document document = new Document();
        Route route = new Route();
        User user = new User();

        //document.setId(1l);
        document.setRevision(1);
        document.setType("Document");
        document.setTitle("Dokument testowy");
        document.setDescription("Takim tam dokument testowy");
        document.setState("In work");
        document.setOwner("soleszek");
        document.setCreationDate(LocalDate.of(2018, Month.DECEMBER, 12));
        document.setLastModification(LocalDate.of(2018, Month.DECEMBER, 12));
        document.setLink("https://onet.pl");

        documentDao.SaveOrUpdate(document);

        user.setName("Sylwester");
        user.setLastName("Oleszek");
        user.setUsername("soleszek");
        user.setPassword("Samsunge1080");
        user.setRole("admin");

        userDao.SaveOrUpdate(user);

        route.setState("start");
        route.setCreationDate(LocalDate.of(2018, Month.DECEMBER, 12));
        route.setFinishDate(null);
        route.setCheckedBy("soleszek");
        route.setApprovedBy("soleszek");
        route.setComments("Sprawdź i zatwierdź");


        routeDao.SaveOrUpdate(route);

        HibernateUtils.getInstance().getSessionFactory().close();*/
    }
}
