package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Book;
import DAO.BookDAO;
import model.Cart;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    private final BookDAO bookDAO = new BookDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");

        if (idStr != null) {
            try {
                int bookId = Integer.parseInt(idStr);
                Book book = bookDAO.getBookByID(bookId);

                if (book != null) {
                    HttpSession session = request.getSession();
                    int userId = (session.getAttribute("userID") != null) ? (int) session.getAttribute("userID") : 0;

                    List<Cart> cartItems = (List<Cart>) session.getAttribute("cartItems");
                    if (cartItems == null) {
                        cartItems = new ArrayList<>();
                    }

                    boolean found = false;
                    for (Cart item : cartItems) {
                        if (item.getBookID() == bookId) {
                            if (item.getQuantity() < book.getQuantity()) {
                                item.setQuantity(item.getQuantity() + 1);
                            } else {
                                session.setAttribute("cartMessage", "Số lượng sách trong kho không đủ!");
                            }
                            found = true;
                            break;
                        }
                    }

                    if (!found) {
                        if (book.getQuantity() > 0) {
                            Cart newCartItem = new Cart(
                                    0, // cartID sẽ do DB tự tạo
                                    userId, 
                                    book.getBookID(), 
                                    1, 
                                    book.getTitle(), 
                                    book.getPrice(), 
                                    book.getImage()
                            );
                            cartItems.add(newCartItem);
                        } else {
                            session.setAttribute("cartMessage", "Sách này đã hết hàng!");
                        }
                    }

                    session.setAttribute("cartItems", cartItems);
                    response.sendRedirect("bookDetails?id=" + bookId + "&added=true");
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("books");
    }
}
