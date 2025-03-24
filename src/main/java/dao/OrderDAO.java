package DAO;

import context.DBContext;
import model.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.OrderDetail;

public class OrderDAO {
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT * FROM ORDERS WHERE userID = ? ORDER BY orderDate DESC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                    rs.getInt("orderID"),
                    rs.getInt("userID"),
                    rs.getDate("orderDate"),
                    rs.getDouble("totalPrice"),
                    rs.getString("status")
                );
                orderList.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderList;
    }
    
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) { // ✅ orderId là int
    List<OrderDetail> orderDetails = new ArrayList<>();
    String sql = "SELECT od.orderDetailID, od.orderID, od.bookID, b.title, b.image, od.quantity, od.price, od.totalPrice " +
                 "FROM ORDER_DETAILS od JOIN BOOKS b ON od.bookID = b.bookID " +
                 "WHERE od.orderID = ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
         
        stmt.setInt(1, orderId); // ✅ Sửa setString → setInt
        ResultSet rs = stmt.executeQuery();
        
        while (rs.next()) {
            OrderDetail detail = new OrderDetail(
                rs.getInt("orderDetailID"), // ✅ Sửa getString → getInt
                rs.getInt("orderID"),      // ✅ Sửa getString → getInt
                rs.getInt("bookID"),       // ✅ Sửa getString → getInt
                rs.getString("title"),
                rs.getString("image"),
                rs.getInt("quantity"),
                rs.getDouble("price"),
                rs.getDouble("totalPrice")
            );
            orderDetails.add(detail);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return orderDetails;
}
    
    public void placeOrder(int userID, List<Cart> cartItems) {
    String insertOrderQuery = "INSERT INTO Orders (userID, orderDate, totalPrice, status) VALUES (?, GETDATE(), ?, 1)";
    String insertOrderDetailQuery = "INSERT INTO Order_Details (orderID, bookID, quantity, price) VALUES (?, ?, ?, ?)";

    Connection conn = null;
    PreparedStatement orderStmt = null;
    PreparedStatement detailStmt = null;
    ResultSet generatedKeys = null;

    try {
        conn = DBContext.getConnection();
        conn.setAutoCommit(false); // Bắt đầu transaction

        // 1️⃣ Tính tổng giá trị đơn hàng
        double totalPrice = 0;
        for (Cart item : cartItems) {
            totalPrice += item.getQuantity() * item.getPrice();
        }

        // 2️⃣ Thêm vào bảng ORDERS
        orderStmt = conn.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS);
        orderStmt.setInt(1, userID);
        orderStmt.setDouble(2, totalPrice);
        orderStmt.executeUpdate();

        // 3️⃣ Lấy orderID vừa tạo
        generatedKeys = orderStmt.getGeneratedKeys();
        int orderID = -1;
        if (generatedKeys.next()) {
            orderID = generatedKeys.getInt(1);
        }

        // 4️⃣ Thêm từng sách vào bảng ORDER_DETAILS
        detailStmt = conn.prepareStatement(insertOrderDetailQuery);
        for (Cart item : cartItems) {
            detailStmt.setInt(1, orderID);
            detailStmt.setInt(2, item.getBookID());
            detailStmt.setInt(3, item.getQuantity());
            detailStmt.setDouble(4, item.getPrice());
            detailStmt.addBatch(); // Thêm vào batch để chạy nhanh hơn
        }
        detailStmt.executeBatch(); // Thực thi batch

        conn.commit(); // Xác nhận giao dịch
    } catch (SQLException e) {
        if (conn != null) {
            try {
                conn.rollback(); // Rollback nếu có lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        e.printStackTrace();
    } finally {
        try {
            if (generatedKeys != null) generatedKeys.close();
            if (orderStmt != null) orderStmt.close();
            if (detailStmt != null) detailStmt.close();
            if (conn != null) conn.setAutoCommit(true); // Reset chế độ tự động commit
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


}


