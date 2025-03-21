package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;
import context.DBContext;
import utils.EmailSender;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/ForgotPasswordServlet"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        // Kiểm tra nếu email bị null hoặc rỗng
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("message", "❌ Vui lòng nhập email!");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT email FROM Users WHERE email = ?")) {

            stmt.setString(1, email.trim());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Tạo mã OTP 6 chữ số
                    String otp = String.format("%06d", new Random().nextInt(999999));

                    // Lưu OTP vào session (bảo mật tốt hơn nếu lưu vào DB)
                    HttpSession session = request.getSession();
                    session.setAttribute("otp", otp);
                    session.setAttribute("email", email);
                    session.setAttribute("otpExpireTime", System.currentTimeMillis() + 5 * 60 * 1000); // Hết hạn sau 5 phút

                    // Gửi OTP qua email
                    boolean emailSent = EmailSender.sendOTP(email, "Reset Password OTP", "Mã OTP của bạn là: " + otp);
                    
                    if (emailSent) {
                        response.sendRedirect("verifyOtp.jsp"); // Chuyển hướng đến trang nhập OTP
                    } else {
                        request.setAttribute("message", "❌ Không thể gửi email. Vui lòng thử lại!");
                        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("message", "❌ Email không tồn tại trong hệ thống!");
                    request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "❌ Lỗi hệ thống! Vui lòng thử lại sau.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
    }
}
