package controller;

import context.DBContext;
import java.io.IOException;
import java.sql.*;
import java.util.logging.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        try (Connection conn = DBContext.getConnection()) {
            String sql = "SELECT userID, username, email, phone, address, role FROM USERS WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Tạo session
                HttpSession session = request.getSession();
                session.setAttribute("userId", rs.getInt("userID"));
                session.setAttribute("username", username);
                session.setAttribute("role", rs.getInt("role"));

                // Xử lý Remember Me
                if ("yes".equals(remember)) {
                    // Tạo cookie với path gốc của ứng dụng
                    String contextPath = request.getContextPath();
                    
                    Cookie userCookie = new Cookie("username", username);
                    userCookie.setPath(contextPath);
                    userCookie.setMaxAge(60 * 60 * 24 * 30); // 30 ngày
                    
                    Cookie passCookie = new Cookie("password", password);
                    passCookie.setPath(contextPath);
                    passCookie.setMaxAge(60 * 60 * 24 * 30);
                    
                    response.addCookie(userCookie);
                    response.addCookie(passCookie);
                } else {
                    // Xóa cookie nếu không chọn Remember Me
                    deleteCookie(response, "username", request.getContextPath());
                    deleteCookie(response, "password", request.getContextPath());
                }

                // Chuyển hướng sau khi đăng nhập
                response.sendRedirect(rs.getInt("role") == 1 ? "admin.jsp" : "books");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Login error", e);
            response.sendRedirect("error.jsp");
        }
    }

    private void deleteCookie(HttpServletResponse response, String name, String path) {
        Cookie cookie = new Cookie(name, "");
        cookie.setPath(path);
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }
}