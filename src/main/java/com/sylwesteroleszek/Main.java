package com.sylwesteroleszek;

import com.sylwesteroleszek.dao.DocumentDao;
import com.sylwesteroleszek.dao.RouteDao;
import com.sylwesteroleszek.dao.UserDao;
import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.User;
import com.sylwesteroleszek.factory.NameFactory;
import com.sylwesteroleszek.providers.DaoProvider;
import com.sylwesteroleszek.utils.HibernateUtils;

import java.time.LocalDate;
import java.time.Month;

public class Main {
    public static void main(String[] args) {

        NameFactory nameFactory = new NameFactory();

        String name = nameFactory.createName(1l, "user");

        System.out.println(name);
    }
}
