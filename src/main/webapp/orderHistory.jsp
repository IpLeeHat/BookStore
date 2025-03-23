<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderDetail" %>

<h2>Lịch sử mua hàng của bạn</h2>

<% List<Order> orderList = (List<Order>) request.getAttribute("orderList"); %>

<table border="1">
    <tr>
        <th>Hình ảnh</th>
        <th>Tên sách</th>
        <th>Số lượng</th>
        <th>Giá</th>
        <th>Thành tiền</th>
        <th>Trạng thái</th>
    </tr>
    <% for (Order order : orderList) { %>
        <% for (OrderDetail detail : order.getOrderDetails()) { %>
        <tr>
            <td><img src="<%= detail.getImage() %>" width="50"></td>
            <td><%= detail.getTitle() %></td>
            <td><%= detail.getQuantity() %></td>
            <td><%= detail.getPrice() %></td>
            <td><%= detail.getTotalPrice() %></td>
            <td><%= order.getStatus() %></td>
        </tr>
        <% } %>
    <% } %>
</table>
