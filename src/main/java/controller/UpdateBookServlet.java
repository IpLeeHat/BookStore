package controller;

import DAO.BookDAO;
import model.Book;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateBookServlet", urlPatterns = {"/updateBook"})
public class UpdateBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    System.out.println("UpdateBookServlet is running!"); // DEBUG

    try {
        int bookID = Integer.parseInt(request.getParameter("bookID"));
        System.out.println("Updating book with ID: " + bookID); // Debug

        BookDAO bookDAO = new BookDAO();
        Book existingBook = bookDAO.getBookById(bookID);

        if (existingBook == null) {
            System.out.println("Book not found!");
            response.sendRedirect("error.jsp");
            return;
        }

        // Debug: Log request parameters
        System.out.println("Title: " + request.getParameter("title"));
        System.out.println("Author: " + request.getParameter("author"));
        System.out.println("Image: " + request.getParameter("image"));
        System.out.println("Quantity: " + request.getParameter("quantity"));
        System.out.println("Review Count: " + request.getParameter("reviewCount"));
        System.out.println("Purchase Count: " + request.getParameter("purchaseCount"));
        System.out.println("Description: " + request.getParameter("description"));

        String title = getOrDefault(request.getParameter("title"), existingBook.getTitle());
        String author = getOrDefault(request.getParameter("author"), existingBook.getAuthor());
        String publisher = getOrDefault(request.getParameter("publisher"), existingBook.getPublisher());
        int publishYear = parseOrDefault(request.getParameter("publishYear"), existingBook.getPublishYear());
        double price = parseOrDefault(request.getParameter("price"), existingBook.getPrice());
        int quantity = parseOrDefault(request.getParameter("quantity"), existingBook.getQuantity());
        int reviewCount = parseOrDefault(request.getParameter("reviewCount"), existingBook.getReviewCount());
        int purchaseCount = parseOrDefault(request.getParameter("purchaseCount"), existingBook.getPurchaseCount());
        String image = getOrDefault(request.getParameter("image"), existingBook.getImage());
        String description = getOrDefault(request.getParameter("description"), existingBook.getDescription()); // THÊM MỤC NÀY!

        existingBook.setTitle(title);
        existingBook.setAuthor(author);
        existingBook.setPublisher(publisher);
        existingBook.setPublishYear(publishYear);
        existingBook.setPrice(price);
        existingBook.setQuantity(quantity);
        existingBook.setReviewCount(reviewCount);
        existingBook.setPurchaseCount(purchaseCount);
        existingBook.setImage(image);
        existingBook.setDescription(description); // CẬP NHẬT!

        boolean isUpdated = bookDAO.updateBook(existingBook);

        System.out.println("Update success: " + isUpdated); // Debug

        if (isUpdated) {
            response.sendRedirect("admin.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    }
}




    private String getOrDefault(String input, String defaultValue) {
        return (input == null || input.trim().isEmpty()) ? defaultValue : input;
    }

    private int parseOrDefault(String input, int defaultValue) {
        try {
            return Integer.parseInt(input);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private double parseOrDefault(String input, double defaultValue) {
        try {
            return Double.parseDouble(input);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}
