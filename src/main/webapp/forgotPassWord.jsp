<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password</title>
        <style>
            /* Định dạng toàn trang */
            body {
                font-family: 'Arial', sans-serif;
                background: linear-gradient(135deg, #00c6ff, #0072ff);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            /* Container chính */
            .form-structor {
                background: #fff;
                border-radius: 10px;
                padding: 30px;
                width: 400px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                text-align: center;
                animation: fadeIn 0.5s ease-in-out;
            }

            /* Tiêu đề form */
            .form-title {
                font-size: 24px;
                font-weight: bold;
                color: #333;
                margin-bottom: 20px;
            }

            /* Ô nhập liệu */
            .input {
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
                transition: 0.3s ease-in-out;
            }

            /* Hiệu ứng khi nhập vào ô input */
            .input:focus {
                border-color: #0072ff;
                box-shadow: 0 0 8px rgba(0, 114, 255, 0.2);
                outline: none;
            }

            /* Nút Submit */
            .submit-btn {
                background: #0072ff;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 5px;
                width: 100%;
                font-size: 18px;
                cursor: pointer;
                transition: 0.3s;
            }

            .submit-btn:hover {
                background: #0056d2;
            }

            /* Thông báo lỗi */
            .text-danger {
                color: red;
                font-size: 14px;
            }

            /* Responsive cho điện thoại */
            @media (max-width: 480px) {
                .form-structor {
                    width: 90%;
                    padding: 20px;
                }

                .input {
                    font-size: 14px;
                }

                .submit-btn {
                    font-size: 16px;
                }
            }

            /* Hiệu ứng xuất hiện */
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
        <div class="form-structor">
            <h2 class="form-title">Forgot Password</h2>
            <form action="ForgotPasswordServlet" method="post">
                <div class="form-holder">
                    <input type="email" class="input" placeholder="Enter email" id="email" name="email" required>
                </div>
                <button type="submit" class="submit-btn">Next</button>
            </form>
            <p class="text-danger">${message}</p> <!-- Hiển thị thông báo lỗi nếu có -->
        </div>
    </body>
</html>
