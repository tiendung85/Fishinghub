/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryDAO extends DBConnect {

    public List<Category> getAllCategory() {
        List<Category> categoryList = new ArrayList<>();
        try {
            String sql = "select * from Category";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryId"));
                category.setName(rs.getString("Name"));
                categoryList.add(category);
            }
        } catch (Exception ex) {
            System.out.println("Error at CategoryDAO: " + ex.getMessage());
        }
        return categoryList;
    }
}