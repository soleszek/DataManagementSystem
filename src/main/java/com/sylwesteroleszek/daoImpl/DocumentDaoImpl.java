package com.sylwesteroleszek.daoImpl;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.utils.HibernateUtils;
import org.hibernate.Session;

import javax.persistence.NoResultException;
import java.util.List;

public class DocumentDaoImpl implements DocumentDao {
    @Override
    public void SaveOrUpdate(Document document) {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.saveOrUpdate(document);
        session.getTransaction().commit();
        session.close();
    }

    @Override
    public Document findBy(Long id) {
        try {
            Session session = HibernateUtils.getInstance()
                    .getSessionFactory().getCurrentSession();
            session.beginTransaction();
            Document document = (Document)session
                    .createQuery("from Document where id=:id")
                    .setParameter("id",id).getSingleResult();
            session.getTransaction().commit();
            session.clear();
            return document;
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public List<Document> findAll() {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        List<Document> documents = session.createQuery("from Document ")
                .list();
        session.getTransaction().commit();
        session.close();
        return documents;
    }

    @Override
    public void delete(Long id) {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session
                .createQuery("delete Document where id=:id")
                .setParameter("id", id)
                .executeUpdate();
        session.getTransaction().commit();
        session.close();
    }

    @Override
    public void delete(Document document) {
        Session session = HibernateUtils.getInstance()
                .getSessionFactory().getCurrentSession();
        session.beginTransaction();
        session.delete(document);
        session.getTransaction().commit();
        session.close();
    }
}
