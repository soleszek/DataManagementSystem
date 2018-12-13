package com.sylwesteroleszek.factory;

import com.sylwesteroleszek.entity.Document;
import com.sylwesteroleszek.entity.Route;
import com.sylwesteroleszek.entity.User;

public class DmsObject {

    public String getObject(){
        return "Unknown object type";
    }

    public DmsObject getDmsObject(String objectType){
        DmsObject dmsObject;

        if(objectType.equals("user")){
            dmsObject = new User();
        } else if (objectType.equals("document")){
            dmsObject = new Document();
        } else if (objectType.equals("route")){
            dmsObject = new Route();
        } else {
            dmsObject = new DmsObject();
        }

        return dmsObject;
    }

}
