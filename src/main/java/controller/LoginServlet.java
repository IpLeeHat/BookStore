package controller;

import context.DBContext;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
            // Truy vấn thông tin từ bảng USERS
            String sql = "SELECT userID, username, email, phone, address, role FROM USERS WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("userID"); // Đổi kiểu String -> int
                int role = rs.getInt("role");

                // Tạo đối tượng Customer từ dữ liệu database
                Customer customer = new Customer();
                customer.setId(userId); // Đổi setId(String) -> setId(int)
                customer.setName(rs.getString("username")); 
                customer.setEmail(rs.getString("email"));
                customer.setPhoneNumber(rs.getString("phone")); 
                customer.setAddress(rs.getString("address"));

                // Lưu vào session
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("username", username);
                session.setAttribute("role", role);
                session.setAttribute("user", customer); // Lưu Customer vào session

                // Nếu chọn "Ghi nhớ đăng nhập", lưu vào cookie
                if ("yes".equals(remember)) {
                    Cookie userCookie = new Cookie("username", username);
                    Cookie passCookie = new Cookie("password", password);
                    userCookie.setMaxAge(60 * 60 * 24 * 7);
                    passCookie.setMaxAge(60 * 60 * 24 * 7);
                    response.addCookie(userCookie);
                    response.addCookie(passCookie);
                }

                response.sendRedirect(role == 1 ? "admin.jsp" : "books");
            } else {
                request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Lỗi xử lý đăng nhập", e);
            response.sendRedirect("error.jsp");
        }
    }
}
