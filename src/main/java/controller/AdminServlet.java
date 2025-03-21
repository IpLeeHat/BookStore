package controller;

import DAO.BookDAO;
import DAO.CustomerDAO;
import java.io.IOException;
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
            if ("addBook".equals(action) || "updateBook".equals(action)) {
                // Lấy dữ liệu từ form
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

                // Tạo đối tượng Book
                Book book = new Book(
                        "updateBook".equals(action) ? Integer.parseInt(request.getParameter("id")) : 0,
                        title, author, translator, supplier, publisher, publishYear,
                        language, weight, dimensions, pageCount, format, sku, categoryID,
                        description, image, price, quantity, reviewCount, purchaseCount
                );

                if ("addBook".equals(action)) {
                    bookDAO.addBook(book);
                    request.setAttribute("message", "Book added successfully!");
                } else {
                    bookDAO.updateBook(book);
                    request.setAttribute("message", "Book updated successfully!");
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format! Please enter correct values.");
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred while processing your request.");
            e.printStackTrace();
        }

        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerDAO customerDAO = new CustomerDAO();
        BookDAO bookDAO = new BookDAO();

        try {
            if ("deleteCustomer".equals(action)) {
                String username = request.getParameter("username");
                customerDAO.deleteCustomer(username);
                response.sendRedirect("admin.jsp?message=Customer deleted successfully");
            } else if ("deleteBook".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                bookDAO.deleteBook(id);
                response.sendRedirect("admin.jsp?message=Book deleted successfully");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("admin.jsp?error=Invalid book ID format");
        } catch (Exception e) {
            response.sendRedirect("admin.jsp?error=An error occurred while processing your request");
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "AdminServlet for managing books and customers";
    }
}