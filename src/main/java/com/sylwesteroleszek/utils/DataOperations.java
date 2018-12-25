package com.sylwesteroleszek.utils;

import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DataOperations {

    private static final Logger LOGGER = Logger.getLogger(DataOperations.class.getName());

    public static final String drawingsPath = "/home/sylwester/Dokumenty/DMSfiles/drawings/";
    public static final String documentsPath = "/home/sylwester/Dokumenty/DMSfiles/documents/";
    public static final String imagesPath = "/home/sylwester/Dokumenty/DMSfiles/images/";

    public static void saveData(String docType, InputStream fileContent, String fileName){
        if(docType.equals("2D drawing")){

            save(drawingsPath, fileContent, fileName);

        } else if (docType.equals("document")){

            save(documentsPath, fileContent, fileName);

        } else if(docType.equals("image")) {

            save(imagesPath, fileContent, fileName);

        }
    }

    //TODO: implement method
    public static void loadData(String docType){

    }

    public static void deleteData(String docType){

    }

    private static void save(String path, InputStream fileContent, String fileName){
        try {
            byte[] buffer = new byte[fileContent.available()];
            fileContent.read(buffer);

            File targetFile = new File(path + fileName);
            OutputStream outputStream = new FileOutputStream(targetFile);
            outputStream.write(buffer);

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Problem z zapisem", e);
            e.printStackTrace();
        }
    }
}
