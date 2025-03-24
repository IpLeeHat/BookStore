package controller;

import context.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.List;
import model.Cart;
import model.Customer;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("CheckoutServlet called");

        // Lấy session
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");
        List<Cart> cartItems = (List<Cart>) session.getAttribute("cartItems");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (cartItems == null || cartItems.isEmpty()) {
            request.setAttribute("message", "Giỏ hàng trống, không thể thanh toán!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
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

        Connection conn = null;
        PreparedStatement orderStmt = null;
        PreparedStatement orderDetailStmt = null;
        ResultSet generatedKeys = null;

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // 1️⃣ Thêm đơn hàng vào bảng ORDERS
            String insertOrderQuery = "INSERT INTO ORDERS (userID, orderDate, totalPrice, status) VALUES (?, GETDATE(), ?, ?)";
            orderStmt = conn.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, customer.getId());
            orderStmt.setDouble(2, totalAmount);
            orderStmt.setInt(3, 1); // Status: 1 (Completed)
            orderStmt.executeUpdate();

            // 2️⃣ Lấy orderID vừa tạo
            generatedKeys = orderStmt.getGeneratedKeys();
            int orderID = -1;
            if (generatedKeys.next()) {
                orderID = generatedKeys.getInt(1);
            }

            // 3️⃣ Thêm từng sách vào ORDER_DETAILS
            String insertOrderDetailQuery = "INSERT INTO ORDER_DETAILS (orderID, bookID, quantity, price) VALUES (?, ?, ?, ?)";
            orderDetailStmt = conn.prepareStatement(insertOrderDetailQuery);
            for (Cart item : cartItems) {
                orderDetailStmt.setInt(1, orderID);
                orderDetailStmt.setInt(2, item.getBookID());
                orderDetailStmt.setInt(3, item.getQuantity());
                orderDetailStmt.setDouble(4, item.getPrice());
                orderDetailStmt.addBatch(); // Sử dụng batch để tối ưu hóa
            }
            orderDetailStmt.executeBatch(); // Thực thi batch

            // 4️⃣ Xóa giỏ hàng sau khi đặt hàng thành công
            String deleteCartQuery = "DELETE FROM CART WHERE userID = ?";
            try (PreparedStatement stmtClearCart = conn.prepareStatement(deleteCartQuery)) {
                stmtClearCart.setInt(1, customer.getId());
                stmtClearCart.executeUpdate();
            }

            conn.commit(); // Xác nhận giao dịch

            // Xóa giỏ hàng trong session
            session.removeAttribute("cartItems");

            // Lưu vào session để hiển thị trên trang xác nhận đơn hàng
            session.setAttribute("checkoutCustomer", customer);

            // Chuyển hướng đến trang xác nhận đơn hàng
            response.sendRedirect("orderConfirmation.jsp");

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            response.sendRedirect("checkoutError.jsp");
        } finally {
            try {
                if (generatedKeys != null) generatedKeys.close();
                if (orderStmt != null) orderStmt.close();
                if (orderDetailStmt != null) orderDetailStmt.close();
                if (conn != null) conn.setAutoCommit(true); // Reset chế độ tự động commit
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
