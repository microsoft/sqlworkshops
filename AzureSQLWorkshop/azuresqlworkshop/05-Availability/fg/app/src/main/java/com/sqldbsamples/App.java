package com.sqldbsamples;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.sql.DriverManager;
import java.util.Date;
import java.util.concurrent.TimeUnit;

public class App {

   // UPDATE WITH YOUR INFO
   private static final String FAILOVER_GROUP_NAME = "aw-server-fg-ID";  // add workshop ID
   // UPDATE WITH YOUR INFO
   private static final String DB_NAME = "AdventureWorksID";  // add workshop ID
   // UPDATE WITH YOUR INFO
   private static final String USER = "cloudadmin";  // add database user
   // UPDATE WITH YOUR INFO
   private static final String PASSWORD = "password";  // add database password
   // DO NOT MODIFY
   private static final String READ_WRITE_URL = String.format("jdbc:" +
      "sqlserver://%s.database.windows.net:1433;database=%s;user=%s;password=%s;encrypt=true;" +
      "hostNameInCertificate=*.database.windows.net;loginTimeout=30;", 
      FAILOVER_GROUP_NAME, DB_NAME, USER, PASSWORD);
   private static final String READ_ONLY_URL = String.format("jdbc:" +
      "sqlserver://%s.secondary.database.windows.net:1433;database=%s;user=%s;password=%s;encrypt=true;" +
      "hostNameInCertificate=*.database.windows.net;loginTimeout=30;", 
      FAILOVER_GROUP_NAME, DB_NAME, USER, PASSWORD);

   public static void main(String[] args) {
      System.out.println("#######################################");
      System.out.println("## GEO DISTRIBUTED DATABASE TUTORIAL ##");
      System.out.println("#######################################");
      System.out.println("");

      int highWaterMark = getHighWaterMarkId();

      try {
         for(int i = 1; i < 1000; i++) {
             //  loop will run for about 1 hour
             System.out.print(i + ": insert on primary " +
                (insertData((highWaterMark + i))?"successful":"failed"));
             TimeUnit.SECONDS.sleep(1);
             System.out.print(", read from secondary " +
                (selectData((highWaterMark + i))?"successful":"failed") + "\n");
             TimeUnit.SECONDS.sleep(3);
         }
      } catch(Exception e) {
         e.printStackTrace();
   }
}

private static boolean insertData(int id) {
   // Insert data into the product table with a unique product name so we can find the product again
   String sql = "INSERT INTO SalesLT.Product " +
      "(Name, ProductNumber, Color, StandardCost, ListPrice, SellStartDate) VALUES (?,?,?,?,?,?);";

   try (Connection connection = DriverManager.getConnection(READ_WRITE_URL);
           PreparedStatement pstmt = connection.prepareStatement(sql)) {
      pstmt.setString(1, "BrandNewProduct" + id);
      pstmt.setInt(2, 200989 + id + 10000);
      pstmt.setString(3, "Blue");
      pstmt.setDouble(4, 75.00);
      pstmt.setDouble(5, 89.99);
      pstmt.setTimestamp(6, new Timestamp(new Date().getTime()));
      return (1 == pstmt.executeUpdate());
   } catch (Exception e) {
      return false;
   }
}

private static boolean selectData(int id) {
   // Query the data previously inserted into the primary database from the geo replicated database
   String sql = "SELECT Name, Color, ListPrice FROM SalesLT.Product WHERE Name = ?";

   try (Connection connection = DriverManager.getConnection(READ_ONLY_URL);
           PreparedStatement pstmt = connection.prepareStatement(sql)) {
      pstmt.setString(1, "BrandNewProduct" + id);
      try (ResultSet resultSet = pstmt.executeQuery()) {
         return resultSet.next();
      }
   } catch (Exception e) {
      return false;
   }
}

private static int getHighWaterMarkId() {
   // Query the high water mark id stored in the table to be able to make unique inserts
   String sql = "SELECT MAX(ProductId) FROM SalesLT.Product";
   int result = 1;
   try (Connection connection = DriverManager.getConnection(READ_WRITE_URL);
           Statement stmt = connection.createStatement();
           ResultSet resultSet = stmt.executeQuery(sql)) {
      if (resultSet.next()) {
          result =  resultSet.getInt(1);
         }
      } catch (Exception e) {
       e.printStackTrace();
      }
      return result;
   }
}