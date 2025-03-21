<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Customer" %>
<%
    Customer user = (Customer) session.getAttribute("user");

    if (user == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username")) {
                    String username = cookie.getValue();
                    user = new Customer();
                    user.setUsername(username);
                    session.setAttribute("user", user);
                    break;
                }
            }
        }
    }

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Profile</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: url('https://i.pinimg.com/474x/b5/17/cc/b517cc9fb3ec7912b87c1f4f93492b7a.jpg') no-repeat center center;
                background-size: auto;
                background-attachment: fixed;
                display: flex
                    ;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                backdrop-filter: blur(1.5px);
            }


            .container {
                /*background: white;*/
                /*padding: 20px;*/
                /*border-radius: 10px;*/
                /*box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);*/
                width: 400px;
            }
            h2 {
                text-align: center;
                color: #53c4e4;
            }
            label {
                color: #53c4e4;
            }
            input[type="text"], input[type="password"], input[type="submit"] {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border-radius: 5px;
                border: 1px solid #ccc;
            }
            input[type="submit"] {
                background: #007bff;
                color: white;
                font-size: 16px;
                cursor: pointer;
                /* padding-left: 0px; */
                margin-left: 10px;
            }
            input[type="submit"]:hover {
                background: #0056b3;
            }
            .message {
                text-align: center;
                color: green;
                font-weight: bold;
            }
            .error {
                text-align: center;
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Update Your Information</h2>

            <% if (request.getParameter("success") != null) { %>
            <p class="message">Update successful! Redirecting to login...</p>
            <script>
                setTimeout(function () {
                    window.location.href = "login.jsp";
                }, 2000);
            </script>
            <% } %>

            <% if (request.getParameter("error") != null) { %>
            <p class="error">Error: <%= request.getParameter("error") %></p>
            <% } %>

            <form action="UpdateServlet" method="post">
                <label>Username:</label>
                <input type="text" name="username" value="<%= user.getUsername() %>" required><br>

                <label>Email:</label>
                <input type="text" name="email" value="<%= user.getEmail() %>" required><br>

                <label>Phone:</label>
                <input type="text" name="phone" value="<%= user.getPhone() %>" required><br>

                <label>Address:</label>
                <input type="text" name="address" value="<%= user.getAddress() %>" required><br>

                <label>New Password:</label>
                <input type="password" name="newPassword"><br>

                <label>Confirm Password:</label>
                <input type="password" name="confirmPassword"><br>

                <input type="submit" value="Update">
            </form>
        </div>
    </body>
</html>
