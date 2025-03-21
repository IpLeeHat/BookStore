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
                background-color: #1e1e1e;
                color: #fff;
            }

            /* ✅ Thanh điều hướng */
            .nav-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #111;
                padding: 10px 5%;
            }

            .top-img img {
                width: 100%;
                height: 200px
            }

            .logo img {
                width: 150px;
            }

            .search-bar {
                display: flex;
                align-items: center;
                background: #333;
                padding: 5px;
                border-radius: 5px;
            }

            .search-bar input {
                padding: 10px;
                border: 1px solid #CDCFD0;
                ;
                outline: none;
                width: 400px;
                border-radius: 5px;
                background: #222;
                color: white;
            }

            .search-bar button {
                background-color: red;
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
                color: white;
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
                background: #222;
                border-radius: 5px;
                margin: 20px;
            }

            .filter-container select,
            .filter-container input {
                padding: 8px;
                border-radius: 5px;
                border: none;
                outline: none;
            }

            .filter-container button {
                padding: 8px 12px;
                border: none;
                background: red;
                color: white;
                border-radius: 5px;
                cursor: pointer;
            }

            /* ✅ Hiển thị sách theo dạng lưới */
            .book-container {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
                padding: 20px;
            }

            .book-card {
                background-color: #292929;
                padding: 15px;
                border-radius: 8px;
                text-align: center;
                transition: transform 0.3s ease-in-out;
            }

            .book-card:hover {
                transform: translateY(-5px);
                box-shadow: 0px 5px 15px rgba(255, 255, 255, 0.1);
            }

            .book-card img {
                width: 100%;
                height: 250px;
                object-fit: cover;
                border-radius: 5px;
            }

            .book-title {
                font-weight: bold;
                margin: 10px 0;
            }

            .book-price {
                color: #ff4c4c;
                font-weight: bold;
            }

            /* ✅ Dropdown menu */
            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropbtn {
                background: none;
                border: none;
                color: white;
                font-size: 16px;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #333;
                min-width: 150px;
                right: 0;
                box-shadow: 0px 5px 10px rgba(255, 255, 255, 0.1);
                border-radius: 5px;
                z-index: 1;
            }

            .dropdown-content a {
                color: white;
                padding: 10px;
                text-decoration: none;
                display: block;
                transition: background 0.3s;
            }

            .dropdown-content a:hover {
                background-color: red;
            }

            .dropdown:hover .dropdown-content {
                display: block;
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
            <img src="<%= book.getImage() %>" alt="Bìa sách">
            <p class="book-title"><%= book.getTitle() %></p>
            <p class="book-price"><%= book.getPrice() %> VNĐ</p>
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
</html>
