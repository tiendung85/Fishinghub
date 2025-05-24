/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author pc
 */
public class DBConnect {

    private static DBConnect instance = new DBConnect();
    Connection connection;

    public static DBConnect getInstance() {
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }

    private DBConnect() {
        try {
            if (connection == null || connection.isClosed()) {
                String user = "sa";
                String password = "123";
                String url = "jdbc:sqlserver://localhost:1433;databaseName=FishingHub";
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(url, user, password);

                // In ra thông báo kết nối thành công
                System.out.println("Database connected successfully!");
            }
        } catch (Exception e) {
            connection = null;

            // In ra thông tin lỗi nếu kết nối thất bại
            System.out.println("Database connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
