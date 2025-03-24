package DAO;

import context.DBContext;
import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CustomerDAO {

<<<<<<< HEAD
    // Lấy thông tin khách hàng theo ID
    public Customer getCustomerById(int id) { // Đổi String -> int
        String query = "SELECT * FROM CUSTOMERS WHERE id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id); // Đổi setString -> setInt
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCustomer(rs);
                }
            }
=======
    private static final Logger LOGGER = Logger.getLogger(CustomerDAO.class.getName());
    private Connection conn; // 🔥 THÊM DÒNG NÀY

    public CustomerDAO() {
        try {
            this.conn = DBContext.getConnection(); // 🔥 KẾT NỐI DATABASE
>>>>>>> fca60eca8b1241d9084828933b5793f8a53b5579
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi kết nối database!", e);
            throw new RuntimeException("Không thể kết nối database!", e);
        }
    }

    // Lấy danh sách tất cả khách hàng
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
<<<<<<< HEAD
        String query = "SELECT * FROM CUSTOMERS";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
=======
        String sql = "SELECT userID, username, phone, email, address, purchasedBook, quantity, totalPrice, role FROM Users";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

>>>>>>> fca60eca8b1241d9084828933b5793f8a53b5579
            while (rs.next()) {
                // Sửa lại phần này để lấy đúng giá trị role từ database
                String role = rs.getString("role"); // Giữ nguyên giá trị 0 hoặc 1

                customers.add(new Customer(
                        rs.getString("userID"),
                        rs.getString("username"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        rs.getString("address"),
                        rs.getString("purchasedBook"),
                        rs.getInt("quantity"),
                        rs.getDouble("totalPrice"),
                        role // Truyền thẳng giá trị role từ database
                ));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi lấy danh sách khách hàng", e);
        }
        return customers;
    }

<<<<<<< HEAD
    // Thêm khách hàng mới
    public boolean addCustomer(Customer customer) {
        String query = "INSERT INTO CUSTOMERS (id, name, phoneNumber, email, address, purchasedBook, quantity, totalPrice) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        return executeUpdate(customer, query);
    }

    // Cập nhật thông tin khách hàng
    public boolean updateCustomer(Customer customer) {
        String query = "UPDATE CUSTOMERS SET name=?, phoneNumber=?, email=?, address=?, purchasedBook=?, quantity=?, totalPrice=? WHERE id=?";
        return executeUpdate(customer, query);
    }

    // Xóa khách hàng
    public boolean deleteCustomer(int id) { // Đổi String -> int
        String query = "DELETE FROM CUSTOMERS WHERE id=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id); // Đổi setString -> setInt
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Tìm kiếm khách hàng theo tên
    public List<Customer> searchCustomersByName(String name) {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM CUSTOMERS WHERE name LIKE ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    customers.add(mapResultSetToCustomer(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Kiểm tra email đã tồn tại chưa
    public boolean checkEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM CUSTOMERS WHERE email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật mật khẩu cho khách hàng
    public boolean updatePassword(String email, String newPassword) {
        String query = "UPDATE CUSTOMERS SET password = ? WHERE email = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✨ [Hàm hỗ trợ] Ánh xạ ResultSet thành đối tượng Customer
    private Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        return new Customer(
                rs.getInt("id"), // Đổi getString -> getInt
                rs.getString("name"),
                rs.getString("phoneNumber"),
                rs.getString("email"),
                rs.getString("address"),
                rs.getString("purchasedBook"),
                rs.getInt("quantity"),
                rs.getDouble("totalPrice")
        );
    }

    // ✨ [Hàm hỗ trợ] Thực thi câu lệnh INSERT/UPDATE với Customer
    private boolean executeUpdate(Customer customer, String query) {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, customer.getId()); // Đổi setString -> setInt
            ps.setString(2, customer.getName());
            ps.setString(3, customer.getPhoneNumber());
            ps.setString(4, customer.getEmail());
            ps.setString(5, customer.getAddress());
            ps.setString(6, customer.getPurchasedBook());
            ps.setInt(7, customer.getQuantity());
            ps.setDouble(8, customer.getTotalPrice());

            if (query.startsWith("UPDATE")) {
                ps.setInt(8, customer.getId()); // id sẽ là tham số cuối cùng khi UPDATE
            }

=======
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
>>>>>>> fca60eca8b1241d9084828933b5793f8a53b5579
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi cập nhật mật khẩu cho email: " + email, e);
        }
        return false;
    }

    // 2. Phương thức cập nhật thông tin customer (QUAN TRỌNG)
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE Users SET username=?, phone=?, email=?, address=?, role=? WHERE userID=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getPhoneNumber());
            ps.setString(3, customer.getEmail());
            ps.setString(4, customer.getAddress());
            ps.setString(5, customer.getRole());
            ps.setString(6, customer.getId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Lỗi cập nhật khách hàng: " + customer.getId(), e);
        }
        return false;
    }

    // 3. Phương thức kiểm tra email đã tồn tại chưa (khi update)
    public boolean isEmailExists(String email, String excludeUserId) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ? AND userID != ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, excludeUserId);
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
}
