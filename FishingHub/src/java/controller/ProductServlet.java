/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Product;

public class ProductServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String btAction = "";
        String url = "Product.jsp";
        int page = 1;
        int pageSize = 8;

        try {
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Category> categoryList = categoryDAO.getAllCategory();
            request.setAttribute("categoryList", categoryList);

            ProductDAO productDAO = new ProductDAO();
            List<Product> productList = new ArrayList<>();

            // Lấy tham số trang nếu có
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            btAction = request.getParameter("btAction") != null ? request.getParameter("btAction") : "";

            int totalProducts = 0;
            request.setAttribute("btAction", btAction);
            if (btAction.equals("search")) {
                String searchValue = request.getParameter("searchValue");
                if (searchValue == null || searchValue.isBlank()) {
                    totalProducts = productDAO.getTotalProductCount();
                    productList = productDAO.getProductsByPage(page, pageSize);
                } else {
                    totalProducts = productDAO.getTotalProductCountBySearch(searchValue);
                    productList = productDAO.searchProductByPage(searchValue, page, pageSize);
                }
                request.setAttribute("searchValue", searchValue);
            } else if (btAction.equals("filterBrand")) {
                String[] brandIds = request.getParameterValues("brand");
                if (brandIds != null && brandIds.length > 0) {
                    List<Integer> categoryIdList = new ArrayList<>();
                    for (String id : brandIds) {
                        categoryIdList.add(Integer.parseInt(id));
                    }
                    totalProducts = productDAO.getTotalProductCountByCategories(categoryIdList);
                    productList = productDAO.getProductsByCategoryIdsAndPage(categoryIdList, page, pageSize);
                    request.setAttribute("selectedBrands", categoryIdList);
                } else {
                    totalProducts = productDAO.getTotalProductCount();
                    productList = productDAO.getProductsByPage(page, pageSize);
                    request.setAttribute("selectedBrands", new ArrayList<>());
                }
            } else {
                // Default: lấy tất cả sản phẩm
                totalProducts = productDAO.getTotalProductCount();
                productList = productDAO.getProductsByPage(page, pageSize);
            }

            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            request.setAttribute("productList", productList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}