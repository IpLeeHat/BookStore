package DAO;

import context.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Book;

public class BookDAO {

    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String query = "SELECT * FROM BOOK";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // Tìm kiếm sách theo tiêu đề
    public List<Book> searchBooksByTitle(String title) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM BOOK WHERE title LIKE ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + title + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    books.add(mapResultSetToBook(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // Cập nhật sách
    public boolean updateBook(Book book) {
        String sql = "UPDATE BOOK SET title=?, author=?, publishDate=?, categoryID=?, description=?, image=?, price=?, quantity=?, viewCount=?, purchaseCount=? WHERE bookID=?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            mapBookToPreparedStatement(book, ps);
            ps.setInt(11, book.getBookID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBook(int bookID) {
        String sql = "DELETE FROM BOOK WHERE bookID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void addBook(Book book) {
        String sql = "INSERT INTO BOOK (bookID, title, author, publishDate, categoryID, description, image, price, quantity, viewCount, purchaseCount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, book.getBookID());
            stmt.setString(2, book.getTitle());
            stmt.setString(3, book.getAuthor());
            stmt.setDate(4, new java.sql.Date(book.getPublishDate().getTime()));
            stmt.setInt(5, book.getCategoryID());
            stmt.setString(6, book.getDescription());
            stmt.setString(7, book.getImage());
            stmt.setDouble(8, book.getPrice()); // Giá sách dạng double
            stmt.setInt(9, book.getQuantity());
            stmt.setInt(10, book.getViewCount());
            stmt.setInt(11, book.getPurchaseCount());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Book> searchBooks(String keyword) {
        List<Book> books = new ArrayList<>();
        String query = "SELECT * FROM BOOK WHERE title LIKE ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    books.add(mapResultSetToBook(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<Book> filterByCategory(int categoryID) {
        List<Book> books = new ArrayList<>();
        String query = "SELECT * FROM BOOK WHERE categoryID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, categoryID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    books.add(mapResultSetToBook(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<Book> sortBooks(String sortBy, String order) {
        List<Book> books = new ArrayList<>();

        // Đảm bảo tham số hợp lệ để tránh SQL Injection
        if (!sortBy.matches("title|price|publishDate|purchaseCount") || !order.matches("ASC|DESC")) {
            throw new IllegalArgumentException("Tham số sắp xếp không hợp lệ!");
        }

        String query = "SELECT * FROM BOOK ORDER BY " + sortBy + " " + order;

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // Lấy sách theo ID
    public Book getBookById(int bookID) {
        String sql = "SELECT * FROM BOOK WHERE bookID = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBook(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Phương thức ánh xạ từ ResultSet sang Book
    private Book mapResultSetToBook(ResultSet rs) throws SQLException {
        return new Book(
                rs.getInt("bookID"),
                rs.getString("title"),
                rs.getString("author"),
                rs.getDate("publishDate"),
                rs.getInt("categoryID"),
                rs.getString("description"),
                rs.getString("image"),
                rs.getDouble("price"), // Giá sách dạng double
                rs.getInt("quantity"),
                rs.getInt("viewCount"),
                rs.getInt("purchaseCount")
        );
    }

    // Phương thức ánh xạ từ Book sang PreparedStatement
    private void mapBookToPreparedStatement(Book book, PreparedStatement ps) throws SQLException {
        ps.setString(1, book.getTitle());
        ps.setString(2, book.getAuthor());
        ps.setDate(3, new java.sql.Date(book.getPublishDate().getTime()));
        ps.setInt(4, book.getCategoryID());
        ps.setString(5, book.getDescription());
        ps.setString(6, book.getImage());
        ps.setDouble(7, book.getPrice()); // Giá sách dạng double
        ps.setInt(8, book.getQuantity());
        ps.setInt(9, book.getViewCount());
        ps.setInt(10, book.getPurchaseCount());
    }

    public List<Book> filterBooksByCategoryAndPrice(int categoryID, double minPrice, double maxPrice, String priceOrder) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
