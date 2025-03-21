<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Cookie[] cookies = request.getCookies();
    String savedUsername = "";
    String savedPassword = "";
    boolean rememberMeChecked = false;

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("username".equals(cookie.getName())) {
                savedUsername = cookie.getValue();
                rememberMeChecked = true;
            } else if ("password".equals(cookie.getName())) {
                savedPassword = cookie.getValue();
            }
        }
    }
%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Bookstore</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background: url('https://i.pinimg.com/736x/1c/76/2e/1c762e126d2d10dea41c171f805c87b0.jpg') no-repeat center center/cover;
                position: relative;
            }
            body::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255, 255, 255, 0.5);
                z-index: 0;
            }
            .container {
                background: rgba(255, 255, 255, 0.8);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                text-align: center;
                width: 300px;
                position: relative;
                z-index: 1;
            }
            .container h2 {
                margin-bottom: 20px;
            }
            .container input {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            .container button {
                width: 100%;
                padding: 10px;
                background: #333;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .container button:hover {
                background: #555;
            }
            .toggle-link {
                margin-top: 10px;
                display: block;
                cursor: pointer;
                color: blue;
            }
            .remember-me {
                display: flex;
                align-items: center;
                justify-content: flex-start;
                font-size: 14px;
                margin-bottom: 10px;
            }
            .remember-me input {
                /* margin-right: 5px; */
                width: 6vw;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Login</h2>
            <form action="LoginServlet" method="post">
                <input type="text" name="username" placeholder="Username" value="<%= savedUsername %>" required>
                <input type="password" name="password" placeholder="Password" required>

                <div class="remember-me">
                    <input type="checkbox" name="remember" value="yes" <%= rememberMeChecked ? "checked" : "" %>> 
                    <label for="remember">Remember me</label>
                </div>

                <button type="submit">Login</button>
            </form>

            <a href="forgotPassWord.jsp" class="toggle-link">Forgot Password?</a>
            <a href="register.jsp" class="toggle-link">Don't have an account? Register</a>
        </div>
    </body>
</html>
