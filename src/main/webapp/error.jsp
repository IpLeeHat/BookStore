<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lỗi Hệ Thống</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            color: #721c24;
            text-align: center;
            padding: 50px;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }
        h2 {
            color: #d9534f;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Lỗi Hệ Thống</h2>
        <p><strong>Thông báo lỗi:</strong> <%= request.getAttribute("error") %></p>
        <a href="books.jsp">Quay lại trang chủ</a>
    </div>
</body>
</html>
