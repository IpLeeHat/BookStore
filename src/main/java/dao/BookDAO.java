package DAO;

import context.DBContext;
import model.Book;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String query = "SELECT * FROM BOOK";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<Book> searchBooksByTitle(String title) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM BOOK WHERE title LIKE ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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
    public List<Book> searchBooks(String keyword) {
        List<Book> books = new ArrayList<>();
        String query = "SELECT * FROM BOOK WHERE title LIKE ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
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
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
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

        if (!sortBy.matches("title|price|publishYear|purchaseCount") || !order.matches("ASC|DESC")) {
            throw new IllegalArgumentException("Tham số sắp xếp không hợp lệ!");
        }

        String query = "SELECT * FROM BOOK ORDER BY " + sortBy + " " + order;

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<Book> getBooks(String keyword, Integer categoryID, Double minPrice, Double maxPrice, String sortBy, String order) {
        List<Book> books = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM BOOK WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND title LIKE ?");
        }
        if (categoryID != null) {
            query.append(" AND categoryID = ?");
        }
        if (minPrice != null && maxPrice != null) {
            query.append(" AND price BETWEEN ? AND ?");
        }
        if (sortBy != null && order != null) {
            query.append(" ORDER BY ").append(sortBy).append(" ").append(order);
        }

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword + "%");
            }
            if (categoryID != null) {
                ps.setInt(paramIndex++, categoryID);
            }
            if (minPrice != null && maxPrice != null) {
                ps.setDouble(paramIndex++, minPrice);
                ps.setDouble(paramIndex++, maxPrice);
            }

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

    public boolean updateBook(Book book) {
    if (book == null) {
        throw new IllegalArgumentException("Book không được null!");
    }

    String sql = "UPDATE BOOK SET title=?, author=?, publisher=?, publishYear=?, price=?, quantity=?, reviewCount=?, purchaseCount=?, image=?, description=? WHERE bookID=?";
    
    try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, book.getTitle());
        ps.setString(2, book.getAuthor());
        ps.setString(3, book.getPublisher());
        ps.setInt(4, book.getPublishYear());
        ps.setDouble(5, book.getPrice());
        ps.setInt(6, book.getQuantity());
        ps.setInt(7, book.getReviewCount());
        ps.setInt(8, book.getPurchaseCount());
        ps.setString(9, book.getImage());
        ps.setString(10, book.getDescription()); // THÊM NÀY!
        ps.setInt(11, book.getBookID());

        int rowsAffected = ps.executeUpdate();
        System.out.println("Rows affected: " + rowsAffected); // Debug
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}


    public boolean deleteBook(int bookID) {
        return executeUpdate("DELETE FROM BOOK WHERE bookID = ?", bookID);
    }

    public boolean addBook(Book book) {
    if (book == null) {
        throw new IllegalArgumentException("Book không được null!");
    }

    String sql = "INSERT INTO BOOK (title, author, translator, supplier, publisher, publishYear, language, weight, dimensions, pageCount, format, sku, categoryID, description, image, price, quantity, reviewCount, purchaseCount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, book.getTitle());
        ps.setString(2, book.getAuthor());
        ps.setString(3, book.getTranslator());
        ps.setString(4, book.getSupplier());
        ps.setString(5, book.getPublisher());
        ps.setInt(6, book.getPublishYear());
        ps.setString(7, book.getLanguage());
        ps.setInt(8, book.getWeight());
        ps.setString(9, book.getDimensions());
        ps.setInt(10, book.getPageCount());
        ps.setString(11, book.getFormat());
        ps.setString(12, book.getSku());
        ps.setInt(13, book.getCategoryID());
        ps.setString(14, book.getDescription());
        ps.setString(15, book.getImage());
        ps.setDouble(16, book.getPrice());
        ps.setInt(17, book.getQuantity());
        ps.setInt(18, book.getReviewCount());
        ps.setInt(19, book.getPurchaseCount());

        int rowsInserted = ps.executeUpdate();
        System.out.println("Rows inserted: " + rowsInserted); // Debug
        return rowsInserted > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}



    public Book getBookById(int bookID) {
        String sql = "SELECT * FROM BOOK WHERE bookID = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
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

    private boolean executeUpdate(String sql, Book book, Integer bookID) {
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            mapBookToPreparedStatement(book, ps);
            if (bookID != null) {
                ps.setInt(20, bookID);
            }
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private boolean executeUpdate(String sql, int bookID) {
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Book mapResultSetToBook(ResultSet rs) throws SQLException {
        return new Book(
                rs.getInt("bookID"), rs.getString("title"), rs.getString("author"), rs.getString("translator"),
                rs.getString("supplier"), rs.getString("publisher"), rs.getInt("publishYear"), rs.getString("language"),
                rs.getInt("weight"), rs.getString("dimensions"), rs.getInt("pageCount"), rs.getString("format"),
                rs.getString("sku"), rs.getInt("categoryID"), rs.getString("description"), rs.getString("image"),
                rs.getDouble("price"), rs.getInt("quantity"), rs.getInt("reviewCount"), rs.getInt("purchaseCount")
        );
    }

    private void mapBookToPreparedStatement(Book book, PreparedStatement ps) throws SQLException {
        ps.setString(1, book.getTitle());
        ps.setString(2, book.getAuthor());
        ps.setString(3, book.getTranslator());
        ps.setString(4, book.getSupplier());
        ps.setString(5, book.getPublisher());
        ps.setInt(6, book.getPublishYear());
        ps.setString(7, book.getLanguage());
        ps.setInt(8, book.getWeight());
        ps.setString(9, book.getDimensions());
        ps.setInt(10, book.getPageCount());
        ps.setString(11, book.getFormat());
        ps.setString(12, book.getSku());
        ps.setInt(13, book.getCategoryID());
        ps.setString(14, book.getDescription());
        ps.setString(15, book.getImage());
        ps.setDouble(16, book.getPrice());
        ps.setInt(17, book.getQuantity());
        ps.setInt(18, book.getReviewCount());
        ps.setInt(19, book.getPurchaseCount());
    }
}
