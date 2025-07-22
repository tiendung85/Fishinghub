package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import model.Product;

public class ProductDAO extends DBConnect {

    public Product getProductById(int id) {
        Product product = new Product();
        try {
            String sql = "select * from Product where ProductId = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                product.setProductId(rs.getInt("ProductId"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setStockQuantity(rs.getInt("StockQuantity"));
                product.setSoldQuantity(rs.getInt("SoldQuantity"));
                product.setCategoryId(rs.getInt("CategoryId"));
            }
        } catch (Exception ex) {
            System.out.println("Error at ProductDAO: " + ex.getMessage());
        }
        return product;
    }

    public boolean addProduct(Product p) {
        Product product = new Product();
        try {
            String sql = "insert into Product(Name, Price, StockQuantity, SoldQuantity, CategoryId) "
                    + "VALUES ( ?, ?, ?, 0, ? )";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, p.getName());
            statement.setDouble(2, p.getPrice());
            statement.setInt(3, p.getStockQuantity());
            statement.setInt(4, p.getCategoryId());
            int rs = statement.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception ex) {
            System.out.println("Error at ProductDAO: " + ex.getMessage());
        }
        return false;
    }

    public boolean updateProduct(Product p) {
        Product product = new Product();
        try {
            String sql = "Update Product "
                    + "set Name = ?, Price = ?, StockQuantity = ?, SoldQuantity = ?, CategoryId = ? "
                    + "where ProductId = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, p.getName());
            statement.setDouble(2, p.getPrice());
            statement.setInt(3, p.getStockQuantity());
            statement.setInt(4, p.getSoldQuantity());
            statement.setInt(5, p.getCategoryId());
            statement.setInt(6, p.getProductId());
            int rs = statement.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception ex) {
            System.out.println("Error at ProductDAO: " + ex.getMessage());
        }
        return false;
    }

    public boolean deleteProduct(int p) {
        try {
            String sql = "Delete From Product "
                    + "where ProductId = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, p);
            int rs = statement.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception ex) {
            System.out.println("Error at ProductDAO: " + ex.getMessage());
        }
        return false;
    }

    public List<Product> getAllProduct() {
        List<Product> productList = new ArrayList<>();
        try {
            String sql = "select * from Product";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductId"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setStockQuantity(rs.getInt("StockQuantity"));
                product.setSoldQuantity(rs.getInt("SoldQuantity"));
                product.setCategoryId(rs.getInt("CategoryId"));
                productList.add(product);
            }
        } catch (Exception ex) {
            System.out.println("Error at ProductDAO: " + ex.getMessage());
        }
        return productList;
    }

    public int getTotalProductCount() {
        String sql = "SELECT COUNT(*) FROM Product";
        try (
                PreparedStatement statement = connection.prepareStatement(sql); ResultSet rs = statement.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int getTotalProductCountBySearch(String keyword) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM Product WHERE Name LIKE ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + keyword + "%");
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception ex) {
            System.out.println("Error in getTotalProductCountBySearch: " + ex.getMessage());
        }
        return count;
    }

    public List<Product> getProductsByCategoryIdsAndPage(List<Integer> ids, int page, int pageSize) {
        List<Product> productList = new ArrayList<>();
        if (ids == null || ids.isEmpty()) {
            return productList;
        }

        try {
            String placeholders = ids.stream().map(id -> "?").collect(Collectors.joining(","));
            String sql = "SELECT * FROM Product WHERE CategoryId IN (" + placeholders
                    + ") ORDER BY ProductId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement statement = connection.prepareStatement(sql);

            int i = 1;
            for (Integer id : ids) {
                statement.setInt(i++, id);
            }

            int offset = (page - 1) * pageSize;
            statement.setInt(i++, offset);
            statement.setInt(i, pageSize);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductId"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setStockQuantity(rs.getInt("StockQuantity"));
                product.setSoldQuantity(rs.getInt("SoldQuantity"));
                product.setCategoryId(rs.getInt("CategoryId"));
                productList.add(product);
            }
        } catch (Exception ex) {
            System.out.println("Error in getProductsByCategoryIdsAndPage: " + ex.getMessage());
        }

        return productList;
    }

    public List<Product> searchProductByPage(String keyword, int page, int pageSize) {
        List<Product> productList = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Product WHERE Name LIKE ? ORDER BY ProductId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + keyword + "%");
            statement.setInt(2, (page - 1) * pageSize); // OFFSET
            statement.setInt(3, pageSize); // FETCH NEXT

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductId"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setStockQuantity(rs.getInt("StockQuantity"));
                product.setSoldQuantity(rs.getInt("SoldQuantity"));
                product.setCategoryId(rs.getInt("CategoryId"));
                productList.add(product);
            }
        } catch (Exception ex) {
            System.out.println("Error in searchProductByPage: " + ex.getMessage());
        }

        return productList;
    }

    public int getTotalProductCountByCategories(List<Integer> ids) {
        int count = 0;
        if (ids == null || ids.isEmpty()) {
            return count;
        }

        try {
            String placeholders = ids.stream().map(id -> "?").collect(Collectors.joining(","));
            String sql = "SELECT COUNT(*) FROM Product WHERE CategoryId IN (" + placeholders + ")";
            PreparedStatement statement = connection.prepareStatement(sql);

            int i = 1;
            for (Integer id : ids) {
                statement.setInt(i++, id);
            }

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception ex) {
            System.out.println("Error in getTotalProductCountByCategories: " + ex.getMessage());
        }

        return count;
    }

    public List<Product> getProductsByPage(int page, int pageSize) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Product ORDER BY ProductId OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (
                PreparedStatement statement = connection.prepareStatement(sql)) {
            int offset = (page - 1) * pageSize;
            statement.setInt(1, offset);
            statement.setInt(2, pageSize);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductId"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setStockQuantity(rs.getInt("StockQuantity"));
                product.setSoldQuantity(rs.getInt("SoldQuantity"));
                product.setCategoryId(rs.getInt("CategoryId"));
                productList.add(product);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return productList;
    }

    public List<Product> searchProduct(String searchValue) {
        List<Product> productList = new ArrayList<>();
        try {
            String sql = "select * from Product where Name like ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + searchValue + "%");
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductId"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setStockQuantity(rs.getInt("StockQuantity"));
                product.setSoldQuantity(rs.getInt("SoldQuantity"));
                product.setCategoryId(rs.getInt("CategoryId"));
                productList.add(product);
            }
        } catch (Exception ex) {
            System.out.println("Error at ProductDAO: " + ex.getMessage());
        }
        return productList;
    }

    public List<Product> getProductsByCategoryIds(List<Integer> categoryIds) {
        List<Product> productList = new ArrayList<>();
        if (categoryIds == null || categoryIds.isEmpty()) {
            return productList;
        }

        String placeholders = categoryIds.stream().map(id -> "?").collect(Collectors.joining(","));
        String sql = "SELECT * FROM Product WHERE categoryId IN (" + placeholders + ")";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            for (int i = 0; i < categoryIds.size(); i++) {
                ps.setInt(i + 1, categoryIds.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductId"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setStockQuantity(rs.getInt("StockQuantity"));
                product.setSoldQuantity(rs.getInt("SoldQuantity"));
                product.setCategoryId(rs.getInt("CategoryId"));
                productList.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return productList;
    }

    // ProductDAO.java bổ sung
    public List<Product> getProductsByShop(int shopId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE ShopId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, shopId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductId"));
                p.setName(rs.getString("Name"));
                p.setPrice(rs.getDouble("Price"));
                p.setImage(rs.getString("Image"));
                p.setStockQuantity(rs.getInt("StockQuantity"));
                p.setSoldQuantity(rs.getInt("SoldQuantity"));
                p.setShopId(rs.getInt("ShopId"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
