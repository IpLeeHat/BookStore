<%@ page import="java.util.List, java.util.ArrayList, model.Cart, model.Customer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sessionObj = request.getSession();
    List<Cart> cartItems = (List<Cart>) sessionObj.getAttribute("cartItems");
    if (cartItems == null) {
        cartItems = new ArrayList<>();
    }

    Customer customer = (Customer) sessionObj.getAttribute("user");
    if (customer == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    double totalAmount = 0;
    for (Cart item : cartItems) {
        totalAmount += item.getPrice().doubleValue() * item.getQuantity();
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h2, h3 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            margin-top: 10px;
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
        form {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 50%;
            margin: 20px auto;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
        }
        button:hover {
            background-color: #218838;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Xác nhận thanh toán</h2>

<h3>Thông tin giỏ hàng</h3>
<table>
    <tr>
        <th>Tên sách</th>
        <th>Số lượng</th>
        <th>Giá</th>
        <th>Tổng</th>
    </tr>
    <% for (Cart item : cartItems) { %>
    <tr>
        <td><%= item.getTitle() %></td>
        <td><%= item.getQuantity() %></td>
        <td><%= item.getPrice() %> VNĐ</td>
        <td><%= item.getPrice().doubleValue() * item.getQuantity() %> VNĐ</td>
    </tr>
    <% } %>
</table>

<h3>Tổng số tiền: <%= totalAmount %> VNĐ</h3>

<h3>Thông tin khách hàng</h3>
<form action="checkout" method="post">
    <label>Họ và tên:</label>
    <input type="text" name="name" value="<%= customer.getName() %>" required>

    <label>Email:</label>
    <input type="email" name="email" value="<%= customer.getEmail() %>" required>

    <label>Số điện thoại:</label>
    <input type="text" name="phone" value="<%= customer.getPhone() %>" required>

    <label>Địa chỉ giao hàng:</label>
    <input type="text" name="address" value="<%= customer.getAddress() %>" required>

    <input type="hidden" name="totalAmount" value="<%= totalAmount %>">

    <button type="submit">Xác nhận đơn hàng</button>
</form>

<a href="cart.jsp">Quay lại giỏ hàng</a>

</body>
</html>