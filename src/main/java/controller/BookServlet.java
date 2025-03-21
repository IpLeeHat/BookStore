package controller;

import DAO.BookDAO;
import model.Book;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private final BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String keyword = request.getParameter("search");
            String categoryParam = request.getParameter("category");
            String priceRange = request.getParameter("priceRange");
            String sortBy = request.getParameter("sortBy");
            
            Integer categoryID = (categoryParam != null && !categoryParam.isEmpty()) ? Integer.parseInt(categoryParam) : null;
            Double minPrice = null, maxPrice = null;
            
            if (priceRange != null && priceRange.contains("-")) {
                String[] prices = priceRange.split("-");
                minPrice = Double.parseDouble(prices[0]);
                maxPrice = Double.parseDouble(prices[1]);
            }

            String order = (sortBy != null && sortBy.equalsIgnoreCase("DESC")) ? "DESC" : "ASC";
            List<Book> books = bookDAO.getBooks(keyword, categoryID, minPrice, maxPrice, "price", order);
            
            request.setAttribute("books", books);
            request.getRequestDispatcher("/book.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi tải danh sách sách: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookID = parseInt(request.getParameter("bookID"), 0);
            Book book = new Book(
                bookID,
                request.getParameter("title"),
                request.getParameter("author"),
                request.getParameter("translator"),
                request.getParameter("supplier"),
                request.getParameter("publisher"),
                parseInt(request.getParameter("publishYear"), 0),
                request.getParameter("language"),
                parseInt(request.getParameter("weight"), 0),
                request.getParameter("dimensions"),
                parseInt(request.getParameter("pageCount"), 0),
                request.getParameter("format"),
                request.getParameter("sku"),
                parseInt(request.getParameter("categoryID"), 0),
                request.getParameter("description"),
                request.getParameter("image"),
                parseDouble(request.getParameter("price"), 0.0),
                parseInt(request.getParameter("quantity"), 0),
                parseInt(request.getParameter("reviewCount"), 0),
                parseInt(request.getParameter("purchaseCount"), 0)
            );
            
            if (bookID == 0) bookDAO.addBook(book);
            else bookDAO.updateBook(book);
            
            response.sendRedirect("books");
        } catch (Exception e) {
            throw new ServletException("Lỗi xử lý sách: " + e.getMessage());
        }
    }

    private int parseInt(String param, int defaultValue) {
        try { return (param != null) ? Integer.parseInt(param) : defaultValue; }
        catch (NumberFormatException e) { return defaultValue; }
    }

    private double parseDouble(String param, double defaultValue) {
        try { return (param != null) ? Double.parseDouble(param) : defaultValue; }
        catch (NumberFormatException e) { return defaultValue; }
    }
}