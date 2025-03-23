package controller;
import context.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Customer;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("CheckoutServlet called"); // Debug log

        // Lấy session
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        // Cập nhật thông tin khách hàng
        customer.setName(name);
        customer.setEmail(email);
        customer.setPhoneNumber(phone);
        customer.setAddress(address);
        customer.setTotalPrice(totalAmount);

        // Lưu vào database
        try (Connection conn = DBContext.getConnection()) {
            String sql = "INSERT INTO ORDERS (userID, orderDate, totalPrice, status) VALUES (?, GETDATE(), ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setInt(1, customer.getId());  // Không còn lỗi ép kiểu!
            stmt.setDouble(2, totalAmount);
            stmt.setInt(3, 1); // Status: 1 (Completed)

            int rowsInserted = stmt.executeUpdate();
            stmt.close();

            if (rowsInserted > 0) {
                System.out.println("✅ Order saved successfully!");
            } else {
                System.out.println("❌ Failed to save order.");
                response.sendRedirect("checkoutError.jsp");
                return;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("checkoutError.jsp");
            return;
        }

        // Lưu vào session để hiển thị trên trang xác nhận đơn hàng
        session.setAttribute("checkoutCustomer", customer);

        // Chuyển hướng đến trang xác nhận đơn hàng
        response.sendRedirect("orderConfirmation.jsp");
    }
}
