package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnect {
    protected Connection connection;
    
 
    private String userID = "sa";
    private String password = "1234567";

    public DBConnect() {
 try {
        String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=FishingHub1;trustServerCertificate=true;";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        connection = DriverManager.getConnection(url, userID, password);
        System.out.println("Kết nối thành công đến SQL Server");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // thêm phương thức test kết nối
    public boolean isConnected() {
        return connection != null;
    }

}