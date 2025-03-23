<%@ page import="java.util.ArrayList, java.util.List, model.Cart" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sessionObj = request.getSession();
    List<Cart> cartItems = (List<Cart>) sessionObj.getAttribute("cartItems");
    if (cartItems == null) {
        cartItems = new ArrayList<>();
    }

    String cartMessage = (String) sessionObj.getAttribute("cartMessage");
    sessionObj.removeAttribute("cartMessage"); // Xóa thông báo sau khi hiển thị
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Giỏ hàng</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f8f8f8;
                text-align: center;
            }
            h2 {
                color: #333;
            }
            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background: #fff;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #007bff;
                color: white;
            }
            img {
                border-radius: 5px;
            }
            .btn {
                display: inline-block;
                margin: 10px;
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }
            .btn-checkout {
                background-color: #28a745;
            }
            .btn:hover {
                opacity: 0.8;
            }
            p {
                font-size: 18px;
                color: red;
            }
        </style>
    </head>
    <body>
        <h2>Giỏ hàng của bạn</h2>
        <% if (cartMessage != null) { %>
        <p><%= cartMessage %></p>
        <% } %>
        <% if (cartItems.isEmpty()) { %>
        <p>Giỏ hàng của bạn đang trống.</p>
        <% } else { %>
        <table>
            <tr>
                <th>Ảnh</th>
                <th>Tên sách</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Tổng</th>
                <th>Hành động</th>
            </tr>
            <% for (Cart item : cartItems) { %>
            <tr>
                <td><img src="<%= item.getImageUrl() %>" alt="Ảnh sách" width="80"></td>
                <td><%= item.getTitle() %></td>
                <td><%= item.getPrice() %> VNĐ</td>
                <td>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="bookID" value="<%= item.getBookID() %>">
                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1">
                        <button type="submit">Cập nhật</button>
                    </form>
                </td>
                <td><%= item.getTotalPrice() %> VNĐ</td>
                <td>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="cartId" value="<%= item.getCartID() %>">
                        <button type="submit">Xóa</button>
                    </form>

                </td>
            </tr>
            <% } %>
        </table>
        <% } %>

        <a href="book.jsp" class="btn">Tiếp tục mua sắm</a>
        <a href="checkout.jsp" class="btn btn-checkout">Thanh toán</a>
        <a href="order-history" class="btn">Lịch sử mua hàng</a>
    </body>
</html>

