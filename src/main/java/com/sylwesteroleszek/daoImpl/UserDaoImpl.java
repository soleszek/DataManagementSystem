package com.sylwesteroleszek.daoImpl;

import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.entity.User;
import com.sylwesteroleszek.utils.HibernateUtils;
import org.hibernate.Session;
import javax.persistence.NoResultException;
import java.util.List;

public class UserDaoImpl implements UserDao {
    @Override
    public void SaveOrUpdate(User user) {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.saveOrUpdate(user);
        session.getTransaction().commit();
        session.close();
    }

    @Override
    public User findBy(Long id) {
        try {
            Session session = HibernateUtils.getInstance()
                    .getSessionFactory().getCurrentSession();
            session.beginTransaction();
            User user = (User)session
                    .createQuery("from User where id=:id")
                    .setParameter("id", id).getSingleResult();
            session.getTransaction().commit();
            session.close();
            return user;
        }catch (NoResultException e) {
            return null;
        }
    }

    public User findBy(String username) {
        try{
            Session session = HibernateUtils.getInstance()
                    .getSessionFactory().getCurrentSession();
            session.beginTransaction();
            User user = (User)session
                    .createQuery("from User where username=:username")
                    .setParameter("username", username).getSingleResult();
            session.getTransaction().commit();
            session.close();
            return user;
        } catch (NoResultException e){
            return null;
        }
    }

    @Override
    public List<User> findAll() {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List<User> users = session.createQuery("from User")
                .list();
        session.getTransaction().commit();
        session.close();
        return users;
    }

    @Override
    public void delete(Long id) {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session
                .createQuery("delete User where id=:id")
                .setParameter("id", id)
                .executeUpdate();
        session.getTransaction().commit();
        session.close();
    }

    @Override
    public void delete(User user) {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.delete(user);
        session.getTransaction().commit();
        session.close();
    }
}
