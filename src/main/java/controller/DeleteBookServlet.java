package controller;


import DAO.BookDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin/deleteBook")
public class DeleteBookServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        System.out.println("DeleteBookServlet received request with id: " + idParam); // Debug

        if (idParam == null || idParam.isEmpty()) {
            System.out.println("Error: ID không hợp lệ!");
            response.sendRedirect(request.getContextPath() + "/admin/books");
            return;
        }

        int bookID = Integer.parseInt(idParam);
        
        boolean success = bookDAO.deleteBook(bookID);
        if (!success) {
            System.out.println("Không thể xóa sách có ID: " + bookID);
        } else {
            System.out.println("Xóa sách thành công: " + bookID);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/books");
    }
}



