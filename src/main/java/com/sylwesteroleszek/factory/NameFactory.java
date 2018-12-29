package com.sylwesteroleszek.factory;

import java.time.LocalDate;

public class NameFactory {

    public String createName (Long id, String type) {

        int year = LocalDate.now().getYear();
        String yearStr = String.valueOf(year);

        int numberOfDigits = 6;

        String name = "";

        String idString = String.valueOf(id);

        if(type.equals("user")){

            int length = idString.length();

            for(int i = 0; i < (numberOfDigits - length); i++){
                name = name + "0";
            }

            return name = "U-" + yearStr + "-" + name + idString;

        } else if (type.equals("drawing")){

            int length = idString.length();

            for(int i = 0; i < (numberOfDigits - length); i++){
                name = name + "0";
            }

            return name = "drw-" + yearStr + "-" + name + idString;

        } else if (type.equals("image")) {

            int length = idString.length();

            for(int i = 0; i < (numberOfDigits - length); i++){
                name = name + "0";
            }

            return name = "img-" + yearStr + "-" + name + idString;

        } else if (type.equals("document")) {

            int length = idString.length();

            for(int i = 0; i < (numberOfDigits - length); i++){
                name = name + "0";
            }

            return name = "doc-" + yearStr + "-" + name + idString;

        } else if (type.equals("route")) {

            int length = idString.length();

            for(int i = 0; i < (numberOfDigits - length); i++){
                name = name + "0";
            }

            return name = "R-" + yearStr + "-" + name + idString;

        } else if (type.equals("task")) {

            int length = idString.length();

            for(int i = 0; i < (numberOfDigits - length); i++){
                name = name + "0";
            }

            return name = "T-" + yearStr + "-" + name + idString;

        }

        return null;
    }
}
