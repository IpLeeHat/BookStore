<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đơn hàng đã xác nhận</title>
    <style>
        /* Reset cơ bản */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        /* Tiêu đề */
        h2 {
            color: #28a745;
            font-size: 24px;
            margin-bottom: 20px;
        }

        /* Thông tin người nhận */
        h3 {
            color: #007bff;
            font-size: 20px;
            margin-top: 20px;
        }

        p {
            background: white;
            padding: 10px;
            max-width: 400px;
            margin: 10px auto;
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }

        /* Tổng tiền */
        h3:last-of-type {
            color: #dc3545;
        }

        /* Link tiếp tục mua sắm */
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
        }

        a:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

<%@ page import="model.Customer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sessionObj = request.getSession();
    Customer checkoutCustomer = (Customer) sessionObj.getAttribute("checkoutCustomer");

    if (checkoutCustomer == null) {
        response.sendRedirect("checkout.jsp");
        return;
    }
%>

<h2>Đơn hàng của bạn đã được xác nhận!</h2>

<h3>Thông tin người nhận</h3>
<p><strong>Họ và tên:</strong> <%= checkoutCustomer.getName() %></p>
<p><strong>Email:</strong> <%= checkoutCustomer.getEmail() %></p>
<p><strong>Số điện thoại:</strong> <%= checkoutCustomer.getPhone() %></p>
<p><strong>Địa chỉ:</strong> <%= checkoutCustomer.getAddress() %></p>

<h3>Tổng số tiền: <%= checkoutCustomer.getTotalPrice() %> VNĐ</h3>

<p>Cảm ơn bạn đã mua sắm! Chúng tôi sẽ liên hệ sớm để giao hàng.</p>

<a href="books">Tiếp tục mua sắm</a>

</body>
</html>