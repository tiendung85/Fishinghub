package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Category;

public class CategoryDAO extends DBConnect {

    public List<Category> getAllCategories() {
        List<Category> categoryList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Category";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryId"));
                category.setName(rs.getString("Name"));
                categoryList.add(category);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return categoryList;
    }

    public Category getCategoryById(int id) {
        Category category = null;
        try {
            String sql = "SELECT * FROM Category WHERE CategoryId = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                category = new Category();
                category.setCategoryId(rs.getInt("CategoryId"));
                category.setName(rs.getString("Name"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return category;
    }

    public boolean addCategory(Category category) {
        try {
            String sql = "INSERT INTO Category (Name) VALUES (?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, category.getName());
            int rows = statement.executeUpdate();
            return rows > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean updateCategory(Category category) {
        try {
            String sql = "UPDATE Category SET Name = ? WHERE CategoryId = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, category.getName());
            statement.setInt(2, category.getCategoryId());
            int rows = statement.executeUpdate();
            return rows > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean deleteCategory(int id) {
        try {
            String sql = "DELETE FROM Category WHERE CategoryId = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            int rows = statement.executeUpdate();
            return rows > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public List<Category> searchCategories(String keyword) {
        List<Category> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Category WHERE Name LIKE ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + keyword + "%");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryId"));
                category.setName(rs.getString("Name"));
                list.add(category);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Legacy method for compatibility
    public List<Category> getAllCategory() {
        return getAllCategories();
    }
}