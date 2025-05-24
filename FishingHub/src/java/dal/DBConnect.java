/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnect {

    private String serverName = "localhost";
    private String dbName = "FishingHub";
    private String portNumber = "1433";
    private String instance = "";//LEAVE THIS ONE EMPTY IF YOUR SQL IS A SINGLE INSTANCE
    private String userID = "sa";
    private String password = "123";

    protected Connection connection;

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

    public void testSelectFishSpecies() {
    String query = "SELECT TOP 5 * FROM FishSpecies"; // Giới hạn kết quả để dễ test
    try {
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {
            int id = rs.getInt("Id");
            String commonName = rs.getString("CommonName");
            String scientificName = rs.getString("ScientificName");
            String bestSeason = rs.getString("BestSeason");
            double avgWeight = rs.getDouble("AverageWeightKg");

            System.out.println("ID: " + id);
            System.out.println("Common Name: " + commonName);
            System.out.println("Scientific Name: " + scientificName);
            System.out.println("Best Season: " + bestSeason);
            System.out.println("Average Weight (kg): " + avgWeight);
            System.out.println("-----------------------------");
        }

        rs.close();
        stmt.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}


    public static void main(String[] args) {
        DBConnect db = new DBConnect();
        if (db.connection != null) {
            System.out.println("✅ Kết nối thành công!");
            db.testSelectFishSpecies();
        } else {
            System.out.println("❌ Kết nối thất bại!");
        }
    }

}
