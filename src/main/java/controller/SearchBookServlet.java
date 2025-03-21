package controller;

import DAO.BookDAO;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;

@WebServlet("/search-books")
public class SearchBookServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        BookDAO bookDAO = new BookDAO();
        List<Book> books;

        // Lấy tham số từ request
        String keyword = request.getParameter("keyword");
        String sortBy = request.getParameter("sortBy"); 
        String order = request.getParameter("order"); 

        if (keyword != null && !keyword.isEmpty()) {
            books = bookDAO.searchBooks(keyword);
        } else if (sortBy != null && order != null) {
            books = bookDAO.sortBooks(sortBy, order);
        } else {
            books = bookDAO.getAllBooks();
        }

      
    }
}
