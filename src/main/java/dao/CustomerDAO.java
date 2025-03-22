package DAO;

import context.DBContext;
import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CustomerDAO {

    private static final Logger LOGGER = Logger.getLogger(CustomerDAO.class.getName());
    private Connection conn; // 🔥 THÊM DÒNG NÀY

    public CustomerDAO() {
        try {
            this.conn = DBContext.getConnection(); // 🔥 KẾT NỐI DATABASE
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối database!", e);
            throw new RuntimeException("Không thể kết nối database!", e);
        }
    }

    // Lấy danh sách tất cả khách hàng
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT userID, username, phone, email, address, purchasedBook, quantity, totalPrice, role FROM Users";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                byte roleByte = rs.getByte("role");
                String role = (roleByte == 1) ? "Admin" : "User"; // Chuyển đổi role

                customers.add(new Customer(
                        rs.getString("userID"),
                        rs.getString("username"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("address"),
                        rs.getString("purchasedBook"),
                        rs.getInt("quantity"),
                        rs.getDouble("totalPrice"),
                        role
                ));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi lấy danh sách khách hàng", e);
        }
        return customers;
    }

    // Xóa khách hàng theo username
    public boolean deleteCustomer(String username) {
        if (username == null || username.trim().isEmpty()) {
            LOGGER.warning("Attempt to delete customer with invalid username");
            return false;
        }

        String sql = "DELETE FROM Users WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi xóa khách hàng: " + username, e);
        }
        return false;
    }

    // Cập nhật mật khẩu của khách hàng theo email
    public boolean updatePassword(String email, String newPassword) {
        if (email == null || email.trim().isEmpty() || newPassword == null || newPassword.trim().isEmpty()) {
            LOGGER.warning("Invalid email or password for update");
            return false;
        }

        String query = "UPDATE Users SET Password = ? WHERE Email = ?";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi cập nhật mật khẩu cho email: " + email, e);
        }
        return false;
    }
}
