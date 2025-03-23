package DAO;

import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import context.DBContext;

public class CustomerDAO {

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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy danh sách tất cả khách hàng
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM CUSTOMERS";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

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

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
