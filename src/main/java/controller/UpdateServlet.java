package controller;

import context.DBContext;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;



@WebServlet(name = "UpdateServlet", urlPatterns = {"/UpdateServlet"})
public class UpdateServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");

        // Kiểm tra người dùng đã đăng nhập chưa
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldUsername = user.getName(); // Username hiện tại
        String newUsername = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra mật khẩu mới có khớp không
        if (newPassword != null && !newPassword.isEmpty() && !newPassword.equals(confirmPassword)) {
            response.sendRedirect("updateUser.jsp?error=Passwords do not match");
            return;
        }

        try (Connection conn = DBContext.getConnection()) {
            String sql;
            PreparedStatement stmt;

            // Nếu có mật khẩu mới
            if (newPassword != null && !newPassword.isEmpty()) {
                sql = "UPDATE USERS SET username=?, email=?, phone=?, address=?, password=? WHERE username=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, newUsername);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, address);
                stmt.setString(5, hashPassword(newPassword)); // Hash mật khẩu
                stmt.setString(6, oldUsername);
            } else { // Nếu không đổi mật khẩu
                sql = "UPDATE USERS SET username=?, email=?, phone=?, address=? WHERE username=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, newUsername);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, address);
                stmt.setString(5, oldUsername);
            }

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                // Cập nhật lại session user
                user.setName(newUsername);
                user.setEmail(email);
                user.setPhoneNumber(phone);
                user.setAddress(address);
                session.setAttribute("user", user);

                // Cập nhật cookie
                Cookie usernameCookie = new Cookie("username", newUsername);
                usernameCookie.setMaxAge(60 * 60 * 24 * 7); // 7 ngày
                response.addCookie(usernameCookie);

                response.sendRedirect("updateUser.jsp?success=1");
            } else {
                response.sendRedirect("updateUser.jsp?error=Update Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("updateUser.jsp?error=Database Error");
        }
    }

    /**
     * Hàm hash mật khẩu bằng SHA-256
     */
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
