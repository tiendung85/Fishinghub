/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author pc
 */
   public class TestDBConnect {
    public static void main(String[] args) {
        DBConnect db = new DBConnect();
        if (db.isConnected()) {
            System.out.println("✅ Kết nối thành công!");
        } else {
            System.out.println("❌ Kết nối thất bại.");
        }
    }
}