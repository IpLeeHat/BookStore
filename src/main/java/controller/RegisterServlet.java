package controller;

import context.DBContext; // Import DBContext
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        int role = 0; // Default role = 0 (user)

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Use DBContext to connect
            conn = DBContext.getConnection();

            // SQL query to insert user
            String sql = "INSERT INTO users (username, password, email, phone, address, role) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);
            pstmt.setString(5, address);
            pstmt.setInt(6, role);

            int row = pstmt.executeUpdate();
            if (row > 0) {
                // Show JavaScript alert with options
                response.setContentType("text/html");
                response.getWriter().println("<script>"
                        + "if (confirm('Registration successful! Do you want to log in now?')) {"
                        + "    window.location.href = 'book.jsp';"
                        + "} else {"
                        + "    window.location.href = 'login.jsp';"
                        + "}"
                        + "</script>");
            } else {
                response.sendRedirect("register.jsp?error=Registration failed!");
            }
        } catch (Exception e) {
            response.sendRedirect("register.jsp?error=" + e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
