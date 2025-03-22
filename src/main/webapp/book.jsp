<%@ page import="java.util.List, model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>BookStore</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            /* ✅ Giao diện chung */
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #F0F0F0;
                color: #333;
            }

            /* ✅ Thanh điều hướng */
            .nav-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #ffffff;
                padding: 10px 5%;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            }

            .top-img img {
                width: 100%;
                height: 250px;
            }

            .logo img {
                padding-left: 100px;
                width: 200px;
            }

            .search-bar {
                display: flex;
                align-items: center;
                background: #fff;
                padding: 5px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            .search-bar input {
                padding: 10px;
                border: none;
                outline: none;
                width: 400px;
                border-radius: 5px;
                background: #f1f1f1;
                color: #333;
            }

            .search-bar button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px;
                cursor: pointer;
                border-radius: 5px;
                margin-left: 5px;
            }

            .icons {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .icons a {
                color: #333;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .icons i {
                font-size: 20px;
            }

            /* ✅ Bộ lọc */
            .filter-container {
                display: flex;
                justify-content: center;
                gap: 10px;
                padding: 15px;
                background: #ffffff;
                border-radius: 5px;
                margin: 20px;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            }

            .filter-container select,
            .filter-container input {
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #ccc;
                outline: none;
                background: #f8f9fa;
            }

            .filter-container button {
                padding: 8px 12px;
                border: none;
                background: #007bff;
                color: white;
                border-radius: 5px;
                cursor: pointer;
            }

            /* ✅ Hiển thị sách theo dạng lưới */
            .book-container {
                display: grid;
                grid-template-columns: repeat(5, 1fr);
                gap: 15px;
                padding: 5% 10% 10% 10%;
            }

            .book-card {
                background-color: #ffffff;
                padding: 10px;
                border-radius: 8px;
                text-align: center;
                transition: transform 0.3s ease-in-out;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            }

            .book-card:hover {
                transform: translateY(-5px);
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            }

            .book-card img {
                width: 60%;
                aspect-ratio: 5 / 7;
                object-fit: cover;
                border-radius: 5px;
            }

            .book-title {
                font-weight: bold;
                margin: 10px 0;
                font-size: 15px;
            }

            .book-price {
                color: #dc3545;
                font-weight: bold;
                font-size: 13px;
            }

            /* ✅ Dropdown menu */
            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropbtn {
                background: none;
                border: none;
                color: #333;
                font-size: 16px;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #ffffff;
                min-width: 150px;
                right: 0;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
                z-index: 1;
            }

            .dropdown-content a {
                color: #333;
                padding: 10px;
                text-decoration: none;
                display: block;
                transition: background 0.3s;
            }

            .dropdown-content a:hover {
                background-color: #007bff;
                color: white;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

            /*            footer*/
            footer {
                background: #f5f5f5;
                padding: 20px;
                font-family: Arial, sans-serif;
            }
            .footer-container {
                display: flex;
                justify-content: space-between;
                max-width: 1200px;
                margin: auto;
                flex-wrap: wrap;
            }

            .footer-left, .footer-middle, .footer-right  {
                flex: 1;
                margin: 10px;
            }
            .footer-left h2 {
                color: red;
            }
            .footer-middle ul {
                list-style: none;
                padding: 0;
            }
            .footer-middle ul li {
                margin: 5px 0;
            }
            .social-icons i {
                font-size: 20px;
                margin-right: 10px;
            }
            @media (max-width: 768px) {
                .footer-container {
                    flex-direction: column;
                    text-align: center;
                }
                .social-icons {
                    justify-content: center;
                }
            }

        </style>
    </head>
    <body>

        <!-- ✅ Thanh điều hướng -->
        <header>
            <div class="top-img">
                <img src="<%= request.getContextPath() %>/images/header.png" alt="Header">
            </div>
            <div class="nav-bar">
                <!-- Logo -->
                <div class="logo">
                    <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo">
                </div>

                <!-- Thanh tìm kiếm -->
                <div class="search-bar">
                    <form action="books" method="get">
                        <input type="text" name="search" placeholder="🔍 Nhập tên sách..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                        <button type="submit"><i class="fas fa-search"></i></button>
                    </form>
                </div>

                <!-- Icon thông báo, giỏ hàng, tài khoản -->
                <div class="icons">
                    <a href="#"><i class="fas fa-bell"></i> Thông báo</a>
                    <a href="#"><i class="fas fa-shopping-cart"></i> Giỏ hàng</a>

                    <div class="dropdown">
                        <button class="dropbtn">
                            <i class="fas fa-user"></i>
                            <span>Tài Khoản</span>
                        </button>
                        <div class="dropdown-content">
                            <%
                                String username = (String) session.getAttribute("username");
                                if (username != null) {
                            %>
                            <a href="updateUser.jsp"><i class="fas fa-user-edit"></i> Chỉnh sửa trang cá nhân</a>
                            <a href="LogoutServlet" class="login-btn"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                            <%
                                } else {
                            %>
                            <a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Đăng nhập</a>
                            <a href="register.jsp"><i class="fas fa-user-plus"></i> Đăng ký</a>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <!-- ✅ Bộ lọc -->
        <div class="filter-container">
            <form action="books" method="get">


                <select name="category">
                    <option value="">-- Chọn thể loại --</option>
                    <option value="1">Khoa học</option>
                    <option value="2">Văn học</option>
                    <option value="3">Lịch sử</option>
                    <option value="4">Kinh tế</option>
                </select>

                <select name="priceRange">
                    <option value="">-- Chọn giá --</option>
                    <option value="0-100000">Dưới 100k</option>
                    <option value="100000-300000">100k - 300k</option>
                    <option value="300000-500000">300k - 500k</option>
                    <option value="500000-1000000">500k - 1 triệu</option>
                    <option value="1000000-">Trên 1 triệu</option>
                </select>

                <select name="sortBy">
                    <option value="">-- Sắp xếp theo giá --</option>
                    <option value="asc">Giá thấp đến cao</option>
                    <option value="desc">Giá cao đến thấp</option>
                </select>

                <button type="submit">Lọc</button>
            </form>
        </div>

        <!-- ✅ Danh sách sách theo dạng lưới -->
        <div class="book-container">
            <%
                List<Book> books = (List<Book>) request.getAttribute("books");
                if (books != null && !books.isEmpty()) {
                    for (Book book : books) {
            %>
            <div class="book-card">
                <a href="bookDetails?id=<%= book.getBookID() %>">
                    <img src="<%= book.getImage() %>" alt="Bìa sách">
                    <p class="book-title"><%= book.getTitle() %></p>
                    <p class="book-price"><%= book.getFormattedPrice() %> VNĐ</p>
                    <p class="book-sold">Sold: <%= book.getPurchaseCount() %></p>
                </a>
            </div>
            <%
                    }
                } else {
            %>
            <p style="text-align: center; width: 100%;">Không có sách nào.</p>
            <%
                }
            %>
        </div>


    </body>
    <footer>
        <div class="footer-container">
            <div class="footer-left">
                <div class="footer-img">
                    <img src="<%= request.getContextPath() %>/images/logo.png" alt="logo">
                </div>
                <p>FPT University</p>
                <p>Hòa Hải - NHS - Đà Nẵng</p>
                <div class="social-icons">
                    <i class="fab fa-facebook"></i>
                    <i class="fab fa-instagram"></i>
                    <i class="fab fa-twitter"></i>
                    <i class="fab fa-youtube"></i>
                </div>
            </div>
            <div class="footer-middle">
                <h3>DỊCH VỤ</h3>
                <ul>
                    <li>Điều khoản sử dụng</li>
                    <li>Chính sách bảo mật thông tin cá nhân</li>
                    <li>Chính sách bảo mật thanh toán</li>
                    <li>Giới thiệu Fahasa</li>
                    <li>Hệ thống trung tâm - nhà sách</li>
                </ul>
            </div>
            <div class="footer-middle">
                <h3>HỖ TRỢ</h3>
                <ul>
                    <li>Chính sách đổi - trả - hoàn tiền</li>
                    <li>Chính sách bảo hành - bồi hoàn</li>
                    <li>Chính sách vận chuyển</li>
                    <li>Chính sách khách sĩ</li>
                </ul>
            </div>
            <div class="footer-right">
                <h3>LIÊN HỆ</h3>
                <p>📍 Thành phố Kon Tum, tỉnh Kon Tum</p>
                <p>📧 khanhhoa@gmail.com</p>
                <p>📞 113 113 113</p>
            </div>
        </div>
    </footer>
</html>
