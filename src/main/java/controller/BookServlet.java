package controller;


import DAO.BookDAO;
import model.Book;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/books")
public class BookServlet extends HttpServlet {

    private BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String keyword = request.getParameter("search");
            String categoryParam = request.getParameter("category");
            String priceRange = request.getParameter("priceRange");
            String sortBy = request.getParameter("sortBy");

            int categoryID = (categoryParam != null && !categoryParam.isEmpty()) ? Integer.parseInt(categoryParam) : -1;
            double minPrice = 0, maxPrice = Double.MAX_VALUE; // Mặc định lấy mọi mức giá

            // Xử lý khoảng giá (vd: "100000-500000")
            if (priceRange != null && priceRange.contains("-")) {
                String[] prices = priceRange.split("-");
                if (prices.length == 2) {
                    minPrice = Double.parseDouble(prices[0]);
                    maxPrice = Double.parseDouble(prices[1]);
                }
            }

            // Mặc định sắp xếp theo giá tăng dần
            String priceOrder = (sortBy != null && sortBy.equalsIgnoreCase("DESC")) ? "DESC" : "ASC";

            List<Book> books;
            if (categoryID != -1) {
                books = bookDAO.filterBooksByCategoryAndPrice(categoryID, minPrice, maxPrice, priceOrder);
            } else {
                books = bookDAO.getAllBooks(); // Nếu không chọn category thì lấy tất cả sách
            }

            request.setAttribute("books", books);
            request.getRequestDispatcher("/book.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách sách: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("bookID");
            int bookID = (idParam != null && !idParam.isEmpty()) ? Integer.parseInt(idParam) : 0;

            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String publishDateStr = request.getParameter("publishDate");
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Date publishDate = null;
            if (publishDateStr != null && !publishDateStr.isEmpty()) {
                try {
                    publishDate = Date.valueOf(publishDateStr);
                } catch (IllegalArgumentException e) {
                    throw new ServletException("Định dạng ngày không hợp lệ: " + publishDateStr);
                }
            }

            Book book = new Book(bookID, title, author, publishDate, categoryID, description, image, price, quantity, 0, 0);

            if (bookID == 0) {
                bookDAO.addBook(book);
            } else {
                bookDAO.updateBook(book);
            }

            response.sendRedirect("books");
        } catch (NumberFormatException e) {
            throw new ServletException("Lỗi: Dữ liệu không hợp lệ. Vui lòng kiểm tra lại!");
        } catch (Exception e) {
            throw new ServletException("Lỗi xử lý sách: " + e.getMessage());
        }
    }
}
