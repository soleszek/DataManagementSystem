package com.sylwesteroleszek.utils;

import com.sylwesteroleszek.Enums.ObjectTypes;

import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DataOperations {

    private static final Logger LOGGER = Logger.getLogger(DataOperations.class.getName());

    public static final String drawingsPath = "/home/sylwester/Dokumenty/DMSfiles/drawings/";
    public static final String documentsPath = "/home/sylwester/Dokumenty/DMSfiles/documents/";
    public static final String imagesPath = "/home/sylwester/Dokumenty/DMSfiles/images/";

    public static void saveData(String docType, InputStream fileContent, String fileName){
        if(docType.equals(ObjectTypes.DRAWING.getObjectType())){

            save(drawingsPath, fileContent, fileName);

        } else if (docType.equals(ObjectTypes.DOCUMENT.getObjectType())){

            save(documentsPath, fileContent, fileName);

        } else if(docType.equals(ObjectTypes.IMAGE.getObjectType())) {

            save(imagesPath, fileContent, fileName);
        }
    }

    public static void deleteData(String docType, String fileName){
        if(docType.equals(ObjectTypes.DRAWING.getObjectType())){

            delete(drawingsPath, fileName);

        } else if (docType.equals(ObjectTypes.DOCUMENT.getObjectType())){

            delete(documentsPath, fileName);

        } else if(docType.equals(ObjectTypes.IMAGE.getObjectType())) {

            delete(imagesPath, fileName);
        }
    }

    public static DataInputStream loadData(String docType, String fileName){
        if(docType.equals(ObjectTypes.DRAWING.getObjectType())){

            return read(drawingsPath, fileName);

        } else if (docType.equals(ObjectTypes.DOCUMENT.getObjectType())){

            return read(documentsPath, fileName);


        } else if(docType.equals(ObjectTypes.IMAGE.getObjectType())) {

            return read(imagesPath, fileName);

        }
        return null;
    }

    private static boolean delete(String path, String fileName){

        File targetFile = new File(path + fileName);
        boolean isFileDeleted = false;

        isFileDeleted = targetFile.delete();

        return isFileDeleted;

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

    private static DataInputStream read(String path, String fileName){

        try {
            DataInputStream reader = new DataInputStream(new FileInputStream(path));
            return reader;

        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }
}
