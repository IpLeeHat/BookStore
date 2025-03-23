package DAO;

import model.Cart;
import model.Book;
import context.DBContext;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public void addToCart(int userID, Book book, int quantity) {
        String checkQuery = "SELECT quantity FROM Cart WHERE userID = ? AND bookID = ?";
        String insertQuery = "INSERT INTO Cart (userID, bookID, quantity, title, price) VALUES (?, ?, ?, ?, ?)";
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
                    insertStmt.setBigDecimal(5, BigDecimal.valueOf(book.getPrice()));
                    insertStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Cart> getCartByUserID(int userID) {
    List<Cart> cartList = new ArrayList<>();
    String query = "SELECT cartID, userID, bookID, quantity, title, price, imageUrl FROM Cart WHERE userID = ?";

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
                    rs.getBigDecimal("price"),
                    rs.getString("imageUrl")  // Lấy thêm ảnh
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
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;
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

    public void updateCartQuantity(int cartID, int quantity) {
        String query = "UPDATE Cart SET quantity = ? WHERE cartID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
