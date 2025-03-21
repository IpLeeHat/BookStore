package controller;

import DAO.BookDAO;
import model.Book;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/addBook")
public class AddBookServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/admin/book-add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ request
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String translator = request.getParameter("translator");
            String supplier = request.getParameter("supplier");
            String publisher = request.getParameter("publisher");
            int publishYear = Integer.parseInt(request.getParameter("publishYear"));
            String language = request.getParameter("language");
            int weight = Integer.parseInt(request.getParameter("weight"));
            String dimensions = request.getParameter("dimensions");
            int pageCount = Integer.parseInt(request.getParameter("pageCount"));
            String format = request.getParameter("format");
            String sku = request.getParameter("sku");
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int reviewCount = Integer.parseInt(request.getParameter("reviewCount"));
            int purchaseCount = Integer.parseInt(request.getParameter("purchaseCount"));

            // Tạo đối tượng sách
            Book book = new Book(0, title, author, translator, supplier, publisher, publishYear, language, weight, 
                                 dimensions, pageCount, format, sku, categoryID, description, image, price, quantity, reviewCount, purchaseCount);

            // Thêm sách vào database
            bookDAO.addBook(book);
            response.sendRedirect(request.getContextPath() + "/admin/books");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Lỗi: Dữ liệu số không hợp lệ.");
            request.getRequestDispatcher("/admin/book-add.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi thêm sách: " + e.getMessage());
            request.getRequestDispatcher("/admin/book-add.jsp").forward(request, response);
        }
    }
}