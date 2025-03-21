<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Cart" %>
<jsp:useBean id="cartDAO" class="DAO.CartDAO" scope="page"/>

<html>
<head>
    <title>Giỏ hàng</title>
</head>
<body>
    <h2>Giỏ hàng của bạn</h2>
    <table border="1">
        <tr>
            <th>Tên sách</th>
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Tổng tiền</th>
            <th>Hành động</th>
        </tr>

        <%
            List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
            if (cartItems != null && !cartItems.isEmpty()) {
                for (Cart item : cartItems) {
        %>
            <tr>
                <td><%= item.getTitle() %></td>
                <td><%= item.getQuantity() %></td>
                <td><%= item.getPrice() %> VNĐ</td>
                <td><%= item.getPrice().multiply(new java.math.BigDecimal(item.getQuantity())) %> VNĐ</td>
                <td>
                    <form action="removeFromCart" method="post">
                        <input type="hidden" name="cartID" value="<%= item.getCartID() %>">
                        <input type="submit" value="Xóa">
                    </form>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="5">Giỏ hàng trống</td>
            </tr>
        <%
            }
        %>
    </table>
    <a href="book.jsp">Quay lại mua sắm</a>
</body>
</html>
