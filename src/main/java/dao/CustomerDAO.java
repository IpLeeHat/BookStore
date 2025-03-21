package DAO;

import model.Customer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import context.DBContext;

public class CustomerDAO {

    // Lấy thông tin khách hàng theo ID
    public Customer getCustomerById(String id) {
        String query = "SELECT * FROM CUSTOMERS WHERE id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToCustomer(rs);
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
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
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
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            mapCustomerToPreparedStatement(customer, ps);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin khách hàng
    public boolean updateCustomer(Customer customer) {
        String query = "UPDATE CUSTOMERS SET name=?, phoneNumber=?, email=?, address=?, purchasedBook=?, quantity=?, totalPrice=? WHERE id=?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            mapCustomerToPreparedStatement(customer, ps);
            ps.setString(8, customer.getId());  // id là tham số cuối cùng
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa khách hàng
    public boolean deleteCustomer(String id) {
        String query = "DELETE FROM CUSTOMERS WHERE id=?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, id);
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
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Ánh xạ ResultSet thành đối tượng Customer
    private Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        return new Customer(
                rs.getString("id"),
                rs.getString("name"),
                rs.getString("phoneNumber"),
                rs.getString("email"),
                rs.getString("address"),
                rs.getString("purchasedBook"),
                rs.getInt("quantity"),
                rs.getDouble("totalPrice")
        );
    }

    // Ánh xạ đối tượng Customer vào PreparedStatement
    private void mapCustomerToPreparedStatement(Customer customer, PreparedStatement ps) throws SQLException {
        ps.setString(1, customer.getId());
        ps.setString(2, customer.getName());
        ps.setString(3, customer.getPhoneNumber());
        ps.setString(4, customer.getEmail());
        ps.setString(5, customer.getAddress());
        ps.setString(6, customer.getPurchasedBook());
        ps.setInt(7, customer.getQuantity());
        ps.setDouble(8, customer.getTotalPrice());
    }

    public boolean checkEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM Users WHERE Email = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(String email, String newPassword) {
        String query = "UPDATE Users SET Password = ? WHERE Email = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
