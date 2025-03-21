package controller;

import DAO.BookDAO;
import model.Book;
import java.io.IOException;
import java.sql.Date;
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
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            Date publishDate = Date.valueOf(request.getParameter("publishDate"));
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String description = request.getParameter("description");
            String image = request.getParameter("image");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Book book = new Book(0, title, author, publishDate, categoryID, description, image, price, quantity, 0, 0);

            bookDAO.addBook(book);
            response.sendRedirect(request.getContextPath() + "/admin/books");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi thêm sách: " + e.getMessage());
            request.getRequestDispatcher("/admin/book-add.jsp").forward(request, response);
        }
    }
}
