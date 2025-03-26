package controller;

import context.DBContext;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

        
        if (!phone.matches("^\\d{10}$")) {
            response.sendRedirect("register.jsp?error=Phone number must be 10 digits and contain only numbers.");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();

          
            String checkUsernameSQL = "SELECT username FROM users WHERE username = ?";
            pstmt = conn.prepareStatement(checkUsernameSQL);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                response.sendRedirect("register.jsp?error=Username already exists. Please choose another username.");
                return;
            }
            rs.close();
            pstmt.close();

         
            String checkEmailSQL = "SELECT email FROM users WHERE email = ?";
            pstmt = conn.prepareStatement(checkEmailSQL);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                response.sendRedirect("register.jsp?error=Email already registered. Please use another email.");
                return;
            }
            rs.close();
            pstmt.close();

           
            String checkPhoneSQL = "SELECT phone FROM users WHERE phone = ?";
            pstmt = conn.prepareStatement(checkPhoneSQL);
            pstmt.setString(1, phone);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                response.sendRedirect("register.jsp?error=Phone number already registered. Please use another phone number.");
                return;
            }
            rs.close();
            pstmt.close();

          
            String insertSQL = "INSERT INTO users (username, password, email, phone, address, role) VALUES (?, ?, ?, ?, ?, 0)";
            pstmt = conn.prepareStatement(insertSQL);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);
            pstmt.setString(5, address);

            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.setContentType("text/html");
                response.getWriter().println("<script>"
                        + "if (confirm('Registration successful! Do you want to log in now?')) {"
                        + "    window.location.href = 'login.jsp';"
                        + "} else {"
                        + "    window.location.href = 'books';"
                        + "}"
                        + "</script>");
            } else {
                response.sendRedirect("register.jsp?error=Registration failed. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=An error occurred. Please try again later.");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}