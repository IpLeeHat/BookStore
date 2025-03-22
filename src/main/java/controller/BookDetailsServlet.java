package controller;

import DAO.BookDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;
import java.io.IOException;

@WebServlet("/bookDetails")
public class BookDetailsServlet extends HttpServlet {
    private final BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int bookId = Integer.parseInt(idStr);
                Book book = bookDAO.getBookByID(bookId);
                
                if (book != null) {
                    request.setAttribute("book", book);
                    request.getRequestDispatcher("BookDetail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect("books"); // Chuyển hướng về danh sách sách
    }
}
