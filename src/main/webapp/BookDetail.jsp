<%@ page import="model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
    <head>
        <title>Chi tiết sách</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #F0F0F0;
                color: #333;
                margin: 0;
                padding: 0;
            }
            .main-wrapper {
                display: flex;
                justify-content: center;
                padding: 20px;
            }
            .container {
                width: 60%;
                display: flex;
                gap: 20px;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            }

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
            .book-image {
                width: 320px;
                flex-shrink: 0;
                position: sticky;
                top: 20px;
                height: fit-content;
            }
            .book-image img {
                width: 100%;
                border-radius: 5px;
            }
            .book-info {
                flex: 1;
            }
            .detail-info, .summary {
                background-color: #FFF;
                padding: 15px;
                border-radius: 8px;
                margin-top: 20px;
            }
            .detail-info h3, .summary h2 {
                font-size: 18px;
                font-weight: bold;
            }
            .detail-info table {
                width: 100%;
                border-collapse: collapse;
            }
            .detail-info td {
                padding: 8px;
                border-bottom: 1px solid #DDD;
                font-size: 13px;
            }
            .actions {
                margin-top: 20px;
                display: flex;
                gap: 10px;
            }
            .add-to-cart, .buy-now {
                padding: 8px 12px;
                font-size: 14px;
                border-radius: 5px;
                cursor: pointer;
            }
            .add-to-cart {
                background: white;
                color: red;
                border: 1px solid red;
            }
            .add-to-cart:hover {
                background: red;
                color: white;
            }
            .buy-now {
                background: red;
                color: white;
                border: none;
            }
            .buy-now:hover {
                background: darkred;
            }
            .price {
                color: red;
                font-size: 24px;
                margin-top: 5px;
            }
            .discount {
                background-color: red;
                color: white;
                padding: 2px 6px;
                margin-left: 10px;
                border-radius: 4px;
            }
            .policy {
                font-size: 13px;
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
            .detail-info p{
                font-size: 13px
            }
        </style>
    </head>
    <body>
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

        <% Book book = (Book) request.getAttribute("book"); %>
        <div class="main-wrapper">
            <div class="container">
                <div class="book-image">
                    <img src="<%= book.getImage() %>" alt="Bìa sách">
                    <div class="actions">
                        <form action="${pageContext.request.contextPath}/addToCart" method="post">
                            <input type="hidden" name="id" value="<%= book.getBookID() %>">
                            <button type="submit" class="add-to-cart"><i class="fas fa-cart-plus"></i> Add to Cart</button>
                        </form>
                        <form action="checkout.jsp" method="post">
                            <input type="hidden" name="id" value="<%= book.getBookID() %>">
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="buy-now">Buy now</button>
                        </form>

                    </div>

                    <% String added = request.getParameter("added"); %>
                    <% if ("true".equals(added)) { %>
                    <script>
                        alert("Sách đã được thêm vào giỏ hàng!");
                    </script>
                    <% } %>

                    <div class="promotions">
                        <h4>Fahasa Promotional Policies</h4>
                        <div class="policy"><i class="fas fa-truck"></i> <strong>Thời gian giao hàng:</strong> Giao nhanh và uy tín</div>
                        <div class="policy"><i class="fas fa-undo"></i> <strong>Chính sách đổi trả:</strong> Đổi trả miễn phí toàn quốc</div>
                        <div class="policy"><i class="fas fa-users"></i> <strong>Chính sách khách sỉ:</strong> Ưu đãi khi mua số lượng lớn</div>
                    </div>
                </div>
                <div class="book-info">
                    <div class="summary">
                        <h2><%= book.getTitle() %></h2>
                        <div class="summary-info">
                            <div>Supplier: <%= book.getSupplier() %></div>
                            <div>Author: <%= book.getAuthor() %></div>
                            <div>Book layout: <%= book.getFormat() %></div>
                        </div>
                        <div class="price">
                            <%= book.getFormattedPrice() %> VNĐ <span class="discount">-10%</span>
                        </div>
                    </div>
                    <div class="detail-info">
                        <h3>Thông tin chi tiết</h3>
                        <table>
                            <tr><td>Product Code:</td><td><%= book.getSku() %></td></tr>
                            <tr><td>Author:</td><td><%= book.getAuthor() %></td></tr>
                            <tr><td>Translator:</td><td><%= book.getTranslator() %></td></tr>
                            <tr><td>Supplier:</td><td><%= book.getSupplier() %></td></tr>
                            <tr><td>Publisher:</td><td><%= book.getPublisher() %></td></tr>
                            <tr><td>Publish Year:</td><td><%= book.getPublishYear() %></td></tr>
                            <tr><td>Language:</td><td><%= book.getLanguage() %></td></tr>
                            <tr><td>Weight:</td><td><%= book.getWeight() %> g</td></tr>
                            <tr><td>Size:</td><td><%= book.getDimensions() %></td></tr>
                            <tr><td>Pages:</td><td><%= book.getPageCount() %></td></tr>
                            <tr><td>Format:</td><td><%= book.getFormat() %></td></tr>
                            <tr><td>Price:</td><td><%= book.getFormattedPrice() %> VNĐ</td></tr>
                        </table>
                    </div>
                    <div class="detail-info">
                        <h3>Mô tả sản phẩm</h3>
                        <p><%= book.getDescription() %></p>
                        <p>Cuốn sách này mang đến cho độc giả một góc nhìn mới mẻ và sâu sắc về [chủ đề của sách]. Với lối hành văn cuốn hút, tác giả đã khéo léo dẫn dắt người đọc vào một hành trình khám phá đầy thú vị, mở ra nhiều suy ngẫm ý nghĩa.</p>
                        <p>Tác phẩm được chia thành nhiều chương, mỗi chương đều cung cấp những thông tin bổ ích và những câu chuyện hấp dẫn. Thông qua từng trang sách, độc giả sẽ tìm thấy không chỉ kiến thức mà còn là cảm hứng và động lực để thay đổi bản thân.</p>
                        <p>Đây không chỉ là một cuốn sách đơn thuần, mà còn là một người bạn đồng hành giúp người đọc nhìn nhận vấn đề theo cách mới. Nó phù hợp với nhiều đối tượng, từ những ai đang tìm kiếm kiến thức đến những người muốn thư giãn với một câu chuyện ý nghĩa.</p>
                        <p>Nếu bạn đang tìm một cuốn sách có thể giúp bạn mở rộng tầm nhìn và phát triển bản thân, đây chắc chắn là một lựa chọn không thể bỏ qua. Nội dung dễ hiểu, cách diễn đạt sinh động và những thông điệp sâu sắc khiến cuốn sách này trở thành một trong những tác phẩm đáng đọc nhất.</p>

                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
