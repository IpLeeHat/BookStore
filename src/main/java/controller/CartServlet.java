package controller;

import DAO.BookDAO;
import DAO.CartDAO;
import model.Book;
import model.Cart;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Cart> cartItems = cartDAO.getCartByUserID(userId);
        BigDecimal totalAmount = cartItems.stream()
                .map(Cart::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                Book book = bookDAO.getBookByID(bookId);
                if (book == null) {
                    request.setAttribute("message", "Sách không tồn tại.");
                } else if (quantity <= 0 || quantity > book.getQuantity()) {
                    request.setAttribute("message", "Số lượng không hợp lệ.");
                } else {
                    cartDAO.addToCart(userId, book, quantity);
                    request.setAttribute("message", "Sản phẩm đã được thêm vào giỏ hàng.");
                }
            } else if ("update".equals(action)) {
                int cartId = Integer.parseInt(request.getParameter("cartId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                if (quantity > 0) {
                    cartDAO.updateCartQuantity(cartId, quantity);
                } else {
                    cartDAO.removeFromCart(cartId);
                }
            } else if ("remove".equals(action)) {
                String cartIdParam = request.getParameter("cartId");

                if (cartIdParam != null) {
                    try {
                        int cartId = Integer.parseInt(cartIdParam);
                        boolean isRemoved = cartDAO.removeFromCart(cartId);

                        if (isRemoved) {
                            session.setAttribute("cartMessage", "Sản phẩm đã được xóa khỏi giỏ hàng.");
                        } else {
                            session.setAttribute("cartMessage", "Không tìm thấy sản phẩm trong giỏ hàng.");
                        }
                    } catch (NumberFormatException e) {
                        session.setAttribute("cartMessage", "Lỗi dữ liệu: ID không hợp lệ.");
                    }
                } else {
                    session.setAttribute("cartMessage", "Lỗi: Không tìm thấy sản phẩm để xóa.");
                }
            }

        } catch (NumberFormatException e) {
            request.setAttribute("message", "Dữ liệu nhập không hợp lệ.");
        }
        response.sendRedirect("cart");
        List<Cart> updatedCartItems = cartDAO.getCartByUserID(userId);
        session.setAttribute("cartItems", updatedCartItems);

    }
}
