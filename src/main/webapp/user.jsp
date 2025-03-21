<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Customer" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            color: white;
        }

        /* Background image with blur effect */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://i.pinimg.com/736x/43/2d/57/432d5796bf199702cc393336c77328a6.jpg') no-repeat center center fixed;
            background-size: cover;
            filter: blur(8px); /* Blurred effect */
            z-index: -1;
        }

        .card {
            background: rgba(0, 0, 0, 0.6);
            color: white;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }

        .btn-custom {
            width: 160px;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="col-md-6">
            <div class="card">
                <h3>Welcome, <%= username %>! 👋</h3>
                <hr>
                <div class="mt-3">
                    <a href="updateUser.jsp" class="btn btn-warning btn-custom">Update Profile</a>
                    <a href="book.jsp" class="btn btn-danger btn-custom">View Book</a>
                    <a href="LogoutServlet" class="btn btn-danger btn-custom">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
