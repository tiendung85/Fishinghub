package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnect {
    // Kết nối instance (ít dùng, bạn chủ yếu dùng hàm static bên dưới)
    protected Connection connection;

    private String serverName = "localhost";
    private String dbName = "FishingHub1";
    private String portNumber = "1433";
    private String instance = "SQLEXPRESS";
    private String userID = "lam";
    private String password = "lamdz123";

    public DBConnect() {
        try {
            String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=FishingHub1;trustServerCertificate=true;";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, userID, password);
            System.out.println("✅ Kết nối thành công đến SQL Server");
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Kiểm tra kết nối instance
    public boolean isConnected() {
        return connection != null;
    }

    // === Phương thức static lấy Connection để dùng ở các DAO ===
    public static Connection getConnection() {
        try {
            String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=FishingHub1;trustServerCertificate=true;";
            String user = "lam";
            String pass = "lamdz123";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(url, user, pass);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
}
