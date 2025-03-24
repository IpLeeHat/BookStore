package DAO;

import model.Cart;
import model.Book;
import context.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    
    public void addToCart(int userID, Book book, int quantity) {
        String checkQuery = "SELECT quantity FROM Cart WHERE userID = ? AND bookID = ?";
        String insertQuery = "INSERT INTO Cart (userID, bookID, quantity, title, price, image) VALUES (?, ?, ?, ?, ?, ?)";
        String updateQuery = "UPDATE Cart SET quantity = quantity + ? WHERE userID = ? AND bookID = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {

            checkStmt.setInt(1, userID);
            checkStmt.setInt(2, book.getBookID());
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                    updateStmt.setInt(1, quantity);
                    updateStmt.setInt(2, userID);
                    updateStmt.setInt(3, book.getBookID());
                    updateStmt.executeUpdate();
                }
            } else {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                    insertStmt.setInt(1, userID);
                    insertStmt.setInt(2, book.getBookID());
                    insertStmt.setInt(3, quantity);
                    insertStmt.setString(4, book.getTitle());
                    insertStmt.setDouble(5, book.getPrice());
                    insertStmt.setString(6, book.getImage()); 
                    insertStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Cart> getCartByUserID(int userID) {
        List<Cart> cartList = new ArrayList<>();
        String query = "SELECT cartID, userID, bookID, quantity, title, price, image FROM Cart WHERE userID = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                cartList.add(new Cart(
                        rs.getInt("cartID"),
                        rs.getInt("userID"),
                        rs.getInt("bookID"),
                        rs.getInt("quantity"),
                        rs.getString("title"),
                        rs.getDouble("price"), // Sửa lại từ getBigDecimal thành getDouble
                        rs.getString("image")  // Lấy ảnh
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartList;
    }

    public boolean removeFromCart(int cartID) {
        String query = "DELETE FROM Cart WHERE cartID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, cartID);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void clearCart(int userID) {
        String query = "DELETE FROM Cart WHERE userID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCartQuantity(int userID, int bookID, int quantity) {
        String query = "UPDATE Cart SET quantity = ? WHERE userID = ? AND bookID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, userID);
            stmt.setInt(3, bookID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addCartItem(Cart cartItem) {
        String query = "INSERT INTO Cart (userID, bookID, quantity, title, price, image) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, cartItem.getUserID());
            stmt.setInt(2, cartItem.getBookID());
            stmt.setInt(3, cartItem.getQuantity());
            stmt.setString(4, cartItem.getTitle());
            stmt.setDouble(5, cartItem.getPrice());
            stmt.setString(6, cartItem.getImage());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
}
