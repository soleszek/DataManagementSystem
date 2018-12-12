package com.sylwesteroleszek.dao;

import com.sylwesteroleszek.entity.Document;

import javax.print.Doc;
import java.util.List;

public interface DocumentDao {
    void SaveOrUpdate(Document document);
    Document findBy (Long id);
    List<Document> findAll();
    void delete(Long id);
    void delete(Document document);
}
