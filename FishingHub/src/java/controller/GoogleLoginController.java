package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import google.GoogleUtils;
import google.GoogleUser;
import dal.UserDao;
import model.Users;

import java.io.IOException;

@WebServlet("/google-login")
public class GoogleLoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
           
            String authUrl = "https://accounts.google.com/o/oauth2/auth?"
                    + "scope=email%20profile"
                    + "&redirect_uri=" + GoogleUtils.GOOGLE_REDIRECT_URI
                    + "&response_type=code"
                    + "&client_id=" + GoogleUtils.GOOGLE_CLIENT_ID
                    + "&approval_prompt=force";
            response.sendRedirect(authUrl);
            return;
        }

   
        String accessToken = GoogleUtils.getToken(code);
        GoogleUser googleUser = GoogleUtils.getUserInfo(accessToken);

      
        UserDao userDao = new UserDao();
        Users user = userDao.getByEmail(googleUser.getEmail());
        if (user == null) {
      
            user = new Users();
            user.setFullName(googleUser.getName());
            user.setEmail(googleUser.getEmail());
            user.setPassword("");
            user.setRoleId(1);  
            userDao.insert(user);
        }

     
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        response.sendRedirect("Home.jsp"); 
    }
}