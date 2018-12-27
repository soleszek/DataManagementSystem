package com.sylwesteroleszek.daoImpl;

import com.sylwesteroleszek.dao.TaskDao;
import com.sylwesteroleszek.entity.Task;
import com.sylwesteroleszek.utils.HibernateUtils;
import org.hibernate.Session;

import javax.persistence.NoResultException;
import java.util.List;

public class TaskDaoImpl implements TaskDao {
    @Override
    public void SaveOrUpdate(Task task) {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.saveOrUpdate(task);
        session.getTransaction().commit();
        session.close();
    }

    @Override
    public Task findBy(Long id) {
        try {
            Session session = HibernateUtils.getInstance()
                    .getSessionFactory().getCurrentSession();
            session.beginTransaction();
            Task task = (Task) session
                    .createQuery("from Task where id=:id")
                    .setParameter("id", id).getSingleResult();
            session.getTransaction().commit();
            session.close();
            return task;
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public List<Task> findAll() {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List<Task> tasks = session.createQuery("from Task")
                .list();
        session.getTransaction().commit();
        session.close();
        return tasks;
    }

    @Override
    public void delete(Long id) {

    }

    @Override
    public void delete(Task task) {

    }
}
