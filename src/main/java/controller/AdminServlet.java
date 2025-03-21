package controller;

import DAO.BookDAO;
import DAO.CustomerDAO;
import DAO.CustomerDAO;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        BookDAO bookDAO = new BookDAO();

        try {
            if ("addBook".equals(action)) {
                // Retrieve data from the form
                String title = request.getParameter("title");
                String author = request.getParameter("author");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String genre = request.getParameter("genre");
                String language = request.getParameter("language");
                double price = Double.parseDouble(request.getParameter("price"));
                int pages = Integer.parseInt(request.getParameter("pages"));
                int rating = Integer.parseInt(request.getParameter("rating"));
                int stock = Integer.parseInt(request.getParameter("stock"));

                // Convert publish date
                String dateStr = request.getParameter("publishDate");
                Date publishDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
                java.sql.Date sqlPublishDate = new java.sql.Date(publishDate.getTime());

                // Create a Book object and add to DB
                Book book = new Book(0, title, author, sqlPublishDate, quantity, genre, language, price, pages, rating, stock);
                bookDAO.addBook(book);

                request.setAttribute("message", "Book added successfully!");
            } else if ("updateBook".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String author = request.getParameter("author");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String genre = request.getParameter("genre");
                String language = request.getParameter("language");
                double price = Double.parseDouble(request.getParameter("price"));
                int pages = Integer.parseInt(request.getParameter("pages"));
                int rating = Integer.parseInt(request.getParameter("rating"));
                int stock = Integer.parseInt(request.getParameter("stock"));

                // Convert publish date
                String dateStr = request.getParameter("publishDate");
                Date publishDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
                java.sql.Date sqlPublishDate = new java.sql.Date(publishDate.getTime());

                // Update book in DB
                Book book = new Book(id, title, author, sqlPublishDate, quantity, genre, language, price, pages, rating, stock);
                bookDAO.updateBook(book);

                request.setAttribute("message", "Book updated successfully!");
            }
        } catch (NumberFormatException | ParseException e) {
            request.setAttribute("error", "Error: Please enter data in the correct format!");
        }

        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerDAO customerDAO = new CustomerDAO();
        BookDAO bookDAO = new BookDAO();

        if ("deleteCustomer".equals(action)) {
            String username = request.getParameter("username");
            customerDAO.deleteCustomer(username);
            response.sendRedirect("admin.jsp");
        } else if ("deleteBook".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            bookDAO.deleteBook(id);
            response.sendRedirect("admin.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "AdminServlet for managing books and customers";
    }
}
