package com.sylwesteroleszek.daoImpl;

import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.utils.HibernateUtils;
import org.hibernate.Session;
import javax.persistence.NoResultException;
import java.util.List;

public class RouteDaoImpl implements RouteDao {
    @Override
    public void SaveOrUpdate(Route route) {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.saveOrUpdate(route);
        session.getTransaction().commit();
        session.close();
    }

    @Override
    public Route findBy(Long id) {
        try {
            Session session = HibernateUtils.getInstance()
                    .getSessionFactory().getCurrentSession();
            session.beginTransaction();
            Route route = (Route) session
                    .createQuery("from Route where id=:id")
                    .setParameter("id", id).getSingleResult();
            session.getTransaction().commit();
            session.clear();
            return route;
        }catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public List<Route> findAll() {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List<Route> routes = session.createQuery("from Route")
                .list();
        session.getTransaction().commit();
        session.close();
        return routes;
    }

    @Override
    public void delete(Long id) {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session
                .createQuery("delete Route where id=:id")
                .setParameter("id", id)
                .executeUpdate();
        session.getTransaction().commit();
        session.close();
    }

    @Override
    public void delete(Route route) {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.delete(route);
        session.getTransaction().commit();
        session.close();
    }
}
