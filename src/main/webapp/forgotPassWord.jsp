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
                background: url('https://png.pngtree.com/thumb_back/fh260/background/20210908/pngtree-photographs-are-placed-on-the-lawn-of-notebooks-and-books-on-image_830204.jpg') no-repeat center center/cover;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                position: relative;
            }

            /* Lớp phủ làm mờ ảnh */
            body::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.3); 
                backdrop-filter: blur(8px); 
                z-index: 1;
            }

           
            .form-structor {
                background: rgba(255, 255, 255, 0.6);
                border-radius: 10px;
                padding: 50px;
                width: 25vw;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.7);
                text-align: center;
                position: relative;
                z-index: 2;
            }

            /* Tiêu đề */
            .form-title {
                font-size: 24px;
                font-weight: bold;
                color: #333;
                margin-bottom: 20px;
            }

            /* Ô nhập liệu */
            .input {
                width: 100%;
                padding: 10px 0px;
                margin: 10px 0;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 16px;
                transition: 0.3s ease-in-out;
                padding-right: 0px;
                /* margin-right: 31px; */
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
