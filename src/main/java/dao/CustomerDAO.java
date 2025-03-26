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
    private Connection conn;

    public CustomerDAO() {
        try {
            this.conn = DBContext.getConnection();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối database!", e);
            throw new RuntimeException("Không thể kết nối database!", e);
        }
    }

    // Lấy danh sách tất cả khách hàng
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT userID, username, phone, email, address, purchasedBook, quantity, totalPrice, role FROM Users";

        try (PreparedStatement ps = conn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                customers.add(new Customer(
                        rs.getInt("userID"), // Sửa thành getInt cho ID
                        rs.getString("username"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("address"),
                        rs.getString("purchasedBook"),
                        rs.getInt("quantity"),
                        rs.getDouble("totalPrice"),
                        rs.getString("role")
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

    // Phương thức cập nhật thông tin customer
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE Users SET username=?, phone=?, email=?, address=?, role=? WHERE userID=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getPhoneNumber());
            ps.setString(3, customer.getEmail());
            ps.setString(4, customer.getAddress());
            ps.setString(5, customer.getRole());
            ps.setInt(6, customer.getId()); // Sửa thành setInt cho ID

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi cập nhật khách hàng: " + customer.getId(), e);
        }
        return false;
    }

    // Phương thức kiểm tra email đã tồn tại chưa (khi update)
    public boolean isEmailExists(String email, int excludeUserId) { // Đổi thành int cho userId
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ? AND userID != ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setInt(2, excludeUserId); // Sửa thành setInt
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi kiểm tra email tồn tại: " + email, e);
        }
        return false;
    }

    // Thêm phương thức lấy customer bằng ID
    public Customer getCustomerById(int id) {
        String sql = "SELECT userID, username, phone, email, address, purchasedBook, quantity, totalPrice, role FROM Users WHERE userID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Customer(
                            rs.getInt("userID"),
                            rs.getString("username"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            rs.getString("address"),
                            rs.getString("purchasedBook"),
                            rs.getInt("quantity"),
                            rs.getDouble("totalPrice"),
                            rs.getString("role")
                    );
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi lấy thông tin khách hàng theo ID: " + id, e);
        }
        return null;
    }

    // Đóng kết nối
    public void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi đóng kết nối", e);
        }
    }
}