package controller;

import DAO.BookDAO;
import model.Book;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/editBook")
public class EditBookServlet extends HttpServlet {

    private final BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookID = Integer.parseInt(request.getParameter("id"));
            Book book = bookDAO.getBookById(bookID);

            if (book == null) {
                response.sendRedirect(request.getContextPath() + "/admin/books?error=notfound");
                return;
            }

            request.setAttribute("book", book);
            request.getRequestDispatcher("/admin/book-edit.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/books?error=loadfailed");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int bookID = Integer.parseInt(request.getParameter("bookID"));
            Book existingBook = bookDAO.getBookById(bookID);

            if (existingBook == null) {
                response.sendRedirect(request.getContextPath() + "/admin/books?error=notfound");
                return;
            }

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

            Book updatedBook = new Book(bookID, title, author, translator, supplier, publisher, publishYear, 
                                        language, weight, dimensions, pageCount, format, sku, categoryID, 
                                        description, image, price, quantity, reviewCount, purchaseCount);

            bookDAO.updateBook(updatedBook);
            response.sendRedirect(request.getContextPath() + "/admin/books?success=updated");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/books?error=invalidinput");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/books?error=updatefailed");
        }
    }
}