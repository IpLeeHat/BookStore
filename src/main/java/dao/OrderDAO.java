package DAO;

import context.DBContext;
import model.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
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

}


