package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Category;
import model.Product;
import model.Users;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CategoryManageServlet", urlPatterns = { "/CategoryManage" })
public class CategoryManageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null || user.getRoleId() != 2) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String search = request.getParameter("search");
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductDAO productDAO = new ProductDAO();
        List<Category> categoryList;
        if (search != null && !search.trim().isEmpty()) {
            categoryList = categoryDAO.searchCategories(search);
        } else {
            categoryList = categoryDAO.getAllCategories();
        }

        // Lấy danh sách sản phẩm cho mỗi danh mục
        Map<Integer, List<Product>> categoryProducts = new HashMap<>();
        for (Category category : categoryList) {
            List<Product> products = productDAO.getProductsByCategoryIds(List.of(category.getCategoryId()));
            categoryProducts.put(category.getCategoryId(), products);
        }

        int page = 1;
        int pageSize = 5;
        try {
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        int totalCategories = categoryList.size();
        int totalPages = (int) Math.ceil((double) totalCategories / pageSize);
        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, totalCategories);
        List<Category> paginatedList = categoryList.subList(start, end);

        request.setAttribute("categoryList", paginatedList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("categoryProducts", categoryProducts);
        request.getRequestDispatcher("/dashboard_owner/CategoryManage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        if (user == null || user.getRoleId() != 2) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String action = request.getParameter("action");
        CategoryDAO categoryDAO = new CategoryDAO();
        ProductDAO productDAO = new ProductDAO();

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            if (name != null && !name.trim().isEmpty()) {
                Category category = new Category();
                category.setName(name.trim());
                boolean success = categoryDAO.addCategory(category);
                session.setAttribute("message", success ? "Thêm danh mục thành công" : "Thêm danh mục thất bại");
            } else {
                session.setAttribute("message", "Tên danh mục không được để trống");
            }
            response.sendRedirect("CategoryManage");
        } else if ("edit".equals(action)) {
            String idStr = request.getParameter("id");
            String newName = request.getParameter("newName");
            try {
                int id = Integer.parseInt(idStr);
                if (newName == null) {
                    // Display edit modal
                    Category category = categoryDAO.getCategoryById(id);
                    if (category != null) {
                        request.setAttribute("editCategory", category);
                        doGet(request, response); // Re-render the page with the edit modal
                    } else {
                        session.setAttribute("message", "Danh mục không tồn tại");
                        response.sendRedirect("CategoryManage");
                    }
                } else if (newName != null && !newName.trim().isEmpty()) {
                    // Update category
                    Category category = new Category();
                    category.setCategoryId(id);
                    category.setName(newName.trim());
                    boolean success = categoryDAO.updateCategory(category);
                    session.setAttribute("message",
                            success ? "Cập nhật danh mục thành công" : "Cập nhật danh mục thất bại");
                    response.sendRedirect("CategoryManage");
                } else {
                    session.setAttribute("message", "Tên danh mục không được để trống");
                    request.setAttribute("editCategory", categoryDAO.getCategoryById(id));
                    doGet(request, response); // Re-render with error
                }
            } catch (NumberFormatException e) {
                session.setAttribute("message", "ID danh mục không hợp lệ");
                response.sendRedirect("CategoryManage");
            }
        } else if ("delete".equals(action)) {
            String idStr = request.getParameter("id");
            try {
                int id = Integer.parseInt(idStr);
                if (productDAO.hasProductsInCategory(id)) {
                    session.setAttribute("message", "Không thể xóa danh mục có sản phẩm");
                } else {
                    boolean success = categoryDAO.deleteCategory(id);
                    session.setAttribute("message", success ? "Xóa danh mục thành công" : "Xóa danh mục thất bại");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("message", "ID danh mục không hợp lệ");
            }
            response.sendRedirect("CategoryManage");
        }
    }
}