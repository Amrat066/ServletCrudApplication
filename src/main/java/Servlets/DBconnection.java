package Servlets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {
     static final String URL ="jdbc:mysql://localhost:3306/ServlettJdbc";
     static final String USERNAME = "amrat";
     static final String PASSWORD = "root@123";
     
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
    	Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
