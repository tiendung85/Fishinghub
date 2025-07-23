package controller;

import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ShopDetailServlet", urlPatterns = {"/shop-detail"})
public class ShopDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String shopIdParam = request.getParameter("shopId");
        if (shopIdParam == null) {
            response.sendRedirect("shop-list");
            return;
        }

        try {
            int shopId = Integer.parseInt(shopIdParam);
            ProductDAO dao = new ProductDAO();
            List<Product> products = dao.getProductsByShop(shopId);

            request.setAttribute("productList", products);
            request.getRequestDispatcher("ShopDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("shop-list");
        }
    }
}
