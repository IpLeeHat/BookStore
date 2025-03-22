package controller;

import DAO.BookDAO;
import model.Book;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("AddBookServlet is running!"); // DEBUG

        try {
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

            Book newBook = new Book(0, title, author, translator, supplier, publisher, publishYear, language, weight, dimensions, pageCount, format, sku, categoryID, description, image, price, quantity, reviewCount, purchaseCount);

            BookDAO bookDAO = new BookDAO();
            boolean isAdded = bookDAO.addBook(newBook);

            System.out.println("Add success: " + isAdded); // Debug

            if (isAdded) {
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

