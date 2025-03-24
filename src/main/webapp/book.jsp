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

header {
    position: relative;
}

/* ✅ Thanh điều hướng */
.nav-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #ffffff;
    padding: 8px 5%;
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
    height: 65px;
}

/* Thêm class sticky cho nav-bar khi cuộn */
.nav-bar.sticky {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
    animation: slideDown 0.3s ease-out;
    padding: 5px 5%;
    box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.15);
    height: 55px;
}

@keyframes slideDown {
    from {
        transform: translateY(-100%);
    }
    to {
        transform: translateY(0);
    }
}

.top-img img {
    width: 100%;
    height: 250px;
    display: block;
    object-fit: cover;
}

.logo img {
    padding-left: 40px;
    width: 160px;
    height: auto;
    transition: all 0.3s ease;
}

.nav-bar.sticky .logo img {
    width: 140px;
    padding-left: 20px;
}

/* ✅ Thanh tìm kiếm đã chỉnh sửa */
.search-bar {
    display: flex;
    align-items: center; /* Đảm bảo các phần tử con cùng hàng */
    background: #f1f1f1;
    border-radius: 25px;
    border: 1px solid #ddd;
    height: 42px;
    margin: 0 25px;
    flex: 1;
    max-width: 550px;
    overflow: hidden;
}

.search-bar form {
    display: flex;
    width: 100%;
    height: 100%;
}

.search-bar:hover {
    box-shadow: 0 0 8px rgba(0, 123, 255, 0.2);
}

.search-bar input {
    flex: 1;
    padding: 15px 20px 0px 20px;
    border: none;
    outline: none;
    background: transparent;
    color: #333;
    font-size: 15px;
    height: 100%;
    line-height: 42px; /* Căn giữa theo chiều dọc */
}


.search-bar input::placeholder {
    color: #888;
    font-size: 14px;
}

.search-bar button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 0 20px;
    cursor: pointer;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.3s;
    margin-top: 8px;
}

.search-bar button:hover {
    background-color: #0069d9;
}

.search-bar button i {
    font-size: 16px;
}

.nav-bar.sticky .search-bar {
    height: 38px;
}

.icons {
    display: flex;
    align-items: center;
    gap: 18px;
}

.icons a {
    color: #333;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 14px;
    transition: color 0.3s;
    padding: 5px 0;
}

.icons a:hover {
    color: #007bff;
}

.icons i {
    font-size: 18px;
}

/* ✅ Bộ lọc */
.filter-container {
    display: flex;
    justify-content: center;
    gap: 12px;
    padding: 16px;
    background: #ffffff;
    border-radius: 6px;
    margin: 22px;
    box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.1);
}

.filter-container select,
.filter-container input {
    padding: 9px;
    border-radius: 5px;
    border: 1px solid #ccc;
    outline: none;
    background: #f8f9fa;
    font-size: 14px;
}

.filter-container button {
    padding: 9px 14px;
    border: none;
    background: #007bff;
    color: white;
    border-radius: 5px;
    cursor: pointer;
    transition: background 0.3s;
}

.filter-container button:hover {
    background: #0069d9;
}

/* ✅ Hiển thị sách theo dạng lưới */
.book-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 18px;
    padding: 30px 8%;
    margin-top: 15px;
}

.book-card {
    background-color: #ffffff;
    padding: 15px;
    border-radius: 8px;
    text-align: center;
    transition: all 0.3s ease;
    box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.1);
}

.book-card a {
    text-decoration: none;
    color: inherit;
    display: block;
}

.book-card:hover {
    transform: translateY(-5px);
    box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.15);
}

.book-card img {
    width: 65%;
    aspect-ratio: 5 / 7;
    object-fit: cover;
    border-radius: 5px;
    margin-bottom: 12px;
}

.book-title {
    font-weight: bold;
    margin: 12px 0;
    font-size: 15px;
    height: 42px;
    display: flex;
    align-items: center;
    justify-content: center;
    line-height: 1.3;
}

.book-price {
    color: #dc3545;
    font-weight: bold;
    font-size: 16px;
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
    font-size: 14px;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 6px 0;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #ffffff;
    min-width: 170px;
    right: 0;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.12);
    border-radius: 6px;
    z-index: 1;
}

.dropdown-content a {
    color: #333;
    padding: 10px 16px;
    text-decoration: none;
    display: block;
    transition: all 0.3s;
    font-size: 14px;
}

.dropdown-content a:hover {
    background-color: #007bff;
    color: white;
}

.dropdown:hover .dropdown-content {
    display: block;
}

/* Footer */
footer {
    background: #f5f5f5;
    padding: 30px 0;
    font-family: Arial, sans-serif;
    margin-top: 40px;
}

.footer-container {
    display: flex;
    justify-content: space-between;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 25px;
    flex-wrap: wrap;
}

.footer-left, .footer-middle, .footer-right {
    flex: 1;
    min-width: 250px;
    margin: 12px 0;
    padding: 0 15px;
}

.footer-left h2 {
    color: red;
    margin-bottom: 18px;
}

.footer-middle ul {
    list-style: none;
    padding: 0;
}

.footer-middle ul li {
    margin: 8px 0;
}

.footer-middle ul li a {
    text-decoration: none;
    color: #333;
    transition: color 0.3s;
}

.footer-middle ul li a:hover {
    color: #007bff;
}

.social-icons {
    display: flex;
    margin-top: 18px;
}

.social-icons a {
    color: #333;
    margin-right: 15px;
    font-size: 20px;
    transition: color 0.3s;
}

.social-icons a:hover {
    color: #007bff;
}

/* Responsive */
@media (max-width: 992px) {
    .search-bar {
        max-width: 450px;
        margin: 0 15px;
    }
    
    .logo img {
        padding-left: 30px;
        width: 140px;
    }
    
    .nav-bar.sticky .logo img {
        width: 120px;
    }
}

@media (max-width: 768px) {
    .nav-bar {
        flex-wrap: wrap;
        height: auto;
        padding: 10px 5%;
    }
    
    .nav-bar.sticky {
        padding: 8px 5%;
    }
    
    .search-bar {
        order: 1;
        width: 100%;
        max-width: none;
        margin: 12px 0;
    }
    
    .logo {
        order: 0;
    }
    
    .icons {
        order: 2;
        margin-left: auto;
    }
    
    .book-container {
        grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
        padding: 20px 5%;
    }
    
    .footer-container {
        flex-direction: column;
        text-align: center;
    }
    
    .social-icons {
        justify-content: center;
    }
}

@media (max-width: 480px) {
    .logo img {
        padding-left: 15px;
        width: 120px;
    }
    
    .nav-bar.sticky .logo img {
        width: 100px;
    }
    
    .icons {
        gap: 12px;
    }
    
    .icons a span {
        display: none;
    }
    
    .book-container {
        grid-template-columns: repeat(2, 1fr);
    }
}

        </style>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const topImg = document.querySelector('.top-img');
                const navBar = document.querySelector('.nav-bar');

                // Lấy chiều cao của ảnh header
                const headerImgHeight = topImg.offsetHeight;

                window.addEventListener('scroll', function () {
                    // Kiểm tra nếu cuộn xuống qua ảnh header
                    if (window.scrollY > headerImgHeight) {
                        navBar.classList.add('sticky');
                    } else {
                        navBar.classList.remove('sticky');
                    }
                });
            });
        </script>
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
                    <a href="cart"><i class="fas fa-shopping-cart"></i> Giỏ hàng</a>

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
                    <option value="1">Khoa học viễn tưởng</option>
                    <option value="2">Văn học</option>
                    <option value="3">Lịch sử</option>
                    <option value="4">Công nghệ thông tin</option>
                    <option value="5">Thiếu nhi</option>
                    <option value="6">Kinh tế</option>
                    <option value="7">Tâm lí học</option>
                    <option value="8">Truyện tranh</option>
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
