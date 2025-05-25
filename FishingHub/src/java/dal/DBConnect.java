package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public abstract class DBConnect<T> {

    protected Connection connection;

    private String serverName = "localhost";
    private String dbName = "FishingHub";
    private String portNumber = "1433";
    private String instance = "SQLEXPRESS"; // Leave empty if SQL is single instance
    private String userID = "lam";
    private String password = "lamdz123";

    public DBConnect() {
        try {
            String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName;
            if (instance == null || instance.trim().isEmpty()) {
                url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName;
            }
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, userID, password);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBConnect.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public static void main(String[] args) {
    DBConnect db = new DBConnect<Object>() {
        @Override
        public java.util.ArrayList<Object> list() { return null; }
        @Override
        public Object get(int id) { return null; }
        @Override
        public void insert(Object obj) { }
        @Override
        public void update(Object obj) { }
        @Override
        public void delete(Object obj) { }
    };

    if (db.connection != null) {
        System.out.println("✅ Kết nối thành công!");
    } else {
        System.out.println("❌ Kết nối thất bại!");
    }
}
    
    public abstract ArrayList<T> list();
    public abstract T get(int id);
    public abstract void insert(T obj);
    public abstract void update(T obj);
    public abstract void delete(T obj);
}
