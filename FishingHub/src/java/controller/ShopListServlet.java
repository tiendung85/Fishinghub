// ShopListServlet.java
package controller;
import dal.ShopDAO;
import jakarta.servlet.*; import jakarta.servlet.http.*; import jakarta.servlet.annotation.*;
import model.Shop;
import java.io.IOException;
import java.util.List;

@WebServlet("/shop-list")
public class ShopListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Shop> shops = new ShopDAO().getAllShops();
        request.setAttribute("shops", shops);
        request.getRequestDispatcher("ShopList.jsp").forward(request, response);
    }
}

