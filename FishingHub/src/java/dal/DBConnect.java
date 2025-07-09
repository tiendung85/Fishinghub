package dal;

import java.sql.Connection;
import java.sql.DriverManager;
<<<<<<< HEAD
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnect {
    protected Connection connection;
    
 
    private String userID = "sa";
    private String password = "123";

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

=======


public class DBConnect {

    public Connection connection;

    public DBConnect() {
        openConnection();
    }

    private void openConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                String url = "jdbc:sqlserver://localhost:1433;databaseName=FishingHub;encrypt=true;trustServerCertificate=true;characterEncoding=UTF-8;sendStringParametersAsUnicode=true";
                String username = "sa";
                String pass = "123";
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(url, username, pass);
                System.out.println("Database connection established successfully.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Connection closed successfully.");
            }
        } catch (Exception e) {
            System.out.println("Error closing connection: " + e.getMessage());
        }
    }
>>>>>>> origin/NgocDung
}