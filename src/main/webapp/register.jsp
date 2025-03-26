<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đăng ký tài khoản</title>
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background: url('https://images.pexels.com/photos/159711/books-bookstore-book-reading-159711.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2') no-repeat center center/cover;
            }

            .register-container {
                width: 350px;
                padding: 7vw;
                border: 1px solid rgba(255, 255, 255, 0.3);
                border-radius: 10px;
                background: rgba(255, 255, 255, 0.2);
                box-shadow: 0px 0px 8px rgba(0, 0, 0, 0.1);
                text-align: center;
                backdrop-filter: blur(15px);
            }

            .register-container h2 {
                margin-bottom: 15px;
                color: black;
            }
            .form-group label {
                font-weight: bold;
                color: #f8f9fa;
            }

            .register-container input {
                color: #333; /* Màu chữ trong ô input để dễ đọc */
                background: rgba(255, 255, 255, 0.7); /* Làm nền input hơi trong suốt */
                border: 1px solid rgba(255, 255, 255, 0.5);
            }

            .register-container input::placeholder {
                color: rgba(51, 51, 51, 0.7); /* Màu placeholder nhẹ để dễ nhìn */
            }

            .register-container button {
                background-color: #28a745;
                color: white;
                font-weight: bold;
                margin-left: 10px;
            }
            p {
                color: #000000;
                /* size: a3; */
                font-size: 20px;
            }

            .register-container button:hover {
                background-color: #218838;
            }
            .form-group {
                text-align: left;
                margin-bottom: 10px;
            }
            .form-group label {
                font-weight: bold;
            }
            input {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
                transition: 0.3s;
            }
            input:focus {
                border-color: #28a745;
                outline: none;
            }
            button {
                width: 100%;
                padding: 12px;
                border: none;
                border-radius: 5px;
                background-color: #28a745;
                color: white;
                cursor: pointer;
                font-size: 16px;
                transition: 0.3s;
            }
            button:hover {
                background-color: #218838;
            }
            .error-message {
                color: red;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <div class="register-container">
            <h2>Đăng ký</h2>


            <% if (request.getParameter("error") != null) { %>
            <div style="color: red; text-align: center; margin: 10px 0;">
                <%= request.getParameter("error") %>
            </div>
            <% } %>

            <form action="RegisterServlet" method="post">
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="phone">Số điện thoại</label>
                    <input type="text" id="phone" name="phone" required>
                </div>
                <div class="form-group">
                    <label for="address">Địa chỉ</label>
                    <input type="text" id="address" name="address" required>
                </div>
                <button type="submit">Đăng ký</button>
            </form>

            <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a></p>
        </div>
    </body>
</html>
