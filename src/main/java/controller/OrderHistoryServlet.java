package controller;

import DAO.OrderDAO;
import model.Order;
import model.OrderDetail;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "OrderHistoryServlet", urlPatterns = {"/order-history"})
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // 🔥 Kiểm tra userId trong session có phải Integer không
        Object userIdObj = session.getAttribute("userId");
        
        // ⚠️ Nếu userId null hoặc không phải Integer → Chuyển hướng về login
        if (userIdObj == null || !(userIdObj instanceof Integer)) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) userIdObj; // ✅ Ép kiểu an toàn sang int
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orderList = orderDAO.getOrdersByUserId(userId); // ✅ truyền int

        for (Order order : orderList) {
            List<OrderDetail> orderDetails = orderDAO.getOrderDetailsByOrderId(order.getOrderId()); // ✅ Truyền int
            order.setOrderDetails(orderDetails);
        }

        request.setAttribute("orderList", orderList);
        request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
        
        
    }
}
