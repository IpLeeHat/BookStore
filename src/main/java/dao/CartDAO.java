package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import java.math.BigDecimal;
import context.DBContext;

public class CartDAO {
    public List<Cart> getUserCart(int userId) {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT c.cartID, c.userID, c.bookID, c.quantity, b.title, b.price " +
                     "FROM Cart c JOIN Book b ON c.bookID = b.bookID " +
                     "WHERE c.userID = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                cartItems.add(new Cart(
                    rs.getInt("cartID"),
                    rs.getInt("userID"),
                    rs.getInt("bookID"),
                    rs.getInt("quantity"),
                    rs.getString("title"),
                    rs.getBigDecimal("price")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public void addToCart(int userId, int bookId, int quantity) {
        String sql = "INSERT INTO Cart (userID, bookID, quantity) VALUES (?, ?, ?)";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, bookId);
            stmt.setInt(3, quantity);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void removeFromCart(int cartID) {
        String sql = "DELETE FROM Cart WHERE cartID = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cartID);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
