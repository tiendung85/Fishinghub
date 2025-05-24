package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;

public abstract class DBContext<T> {

    protected Connection connection;

    public DBContext() {
        try {

            String url = "jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=FishingHub;encrypt=true;trustServerCertificate=true;";
            String username = "lam";        
            String password = "lamdz123";  
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException ex) {
            System.out.println("SQL Server JDBC Driver not found.");
            ex.printStackTrace();
        } catch (SQLException ex) {
            System.out.println("Failed to connect to database.");
            ex.printStackTrace();
        }
    }
    public abstract ArrayList<T> list();

    public abstract T get(int id);

    public abstract void insert(T model);

    public abstract void update(T model);

    public abstract void delete(T model);
}
