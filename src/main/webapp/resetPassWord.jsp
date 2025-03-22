<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reset Password</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background: url('https://img1.kienthucvui.vn/uploads/2022/01/03/anh-quyen-sach-dep_093709196.jpg') no-repeat center center/cover;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .form-container {
                background: rgba(255, 255, 255, 0.6);
                border-radius: 10px;
                padding: 30px;
                width: 400px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                text-align: center;
                animation: fadeIn 0.5s ease-in-out;
            }

            h2 {
                font-size: 24px;
                color: #333;
                margin-bottom: 20px;
            }

            .input {
                width: 35vh;
                padding: 12px;
                margin: 10px 0;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
                transition: 0.3s;
            }

            .input:focus {
                border-color: #ff758c;
                box-shadow: 0 0 8px rgba(255, 117, 140, 0.2);
                outline: none;
            }

            .btn {
                background: #ff758c;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 5px;
                font-size: 18px;
                cursor: pointer;
                transition: 0.3s;
            }

            .btn:hover {
                background: #e84560;
            }

            .error-message {
                color: red;
                font-size: 14px;
                margin-top: 10px;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Reset Password</h2>
            <form action="ResetPasswordServlet" method="post">
                <input type="password" class="input" placeholder="New Password" name="newPassword" required>
                <input type="password" class="input" placeholder="Confirm Password" name="confirmPassword" required> <br>
                    <button type="submit" class="btn">Update</button>
            </form>
            <p class="error-message">${message}</p> <!-- Hiển thị thông báo lỗi nếu có -->
        </div>
    </body>
</html>
