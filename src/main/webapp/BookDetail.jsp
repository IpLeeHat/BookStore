<%@ page import="model.Book, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <title>Chi tiết sách</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #F0F0F0;
                color: #333;
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
            .detail-info {
                background-color: #FFF;
                padding: 15px;
                border-radius: 8px;
                margin-top: 20px;
            }
            .detail-info h3 {
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .detail-info table {
                width: 100%;
                border-collapse: collapse;
            }
            .detail-info table tr td {
                padding: 8px;
                border-bottom: 1px solid #DDD;
            }
            .small-text td {
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
            .summary {
                padding: 10px;
                border: 1px solid #DDD;
                border-radius: 8px;
                margin-bottom: 20px;
            }
            .summary h2 {
                font-size: 20px;
                margin-bottom: 10px;
            }
            .summary-info {
                display: flex;
                justify-content: space-between;
                font-size: 14px;
                margin-bottom: 8px;
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
            .detail-info p {
                font-size: 13px;
            }
            .policy{
                font-size: 13px;
            }
        </style>
    </head>
    <body>
        <% Book book = (Book) request.getAttribute("book"); %>
        <div class="main-wrapper">
            <div class="container">
                <div class="book-image">
                    <img src="<%= book.getImage() %>" alt="Bìa sách">
                    <div class="actions">
                        <button class="add-to-cart"><i class="fas fa-cart-plus"></i> Add to Cart</button>
                        <button class="buy-now">Buy now</button>
                    </div>
                    <div class="promotions">
                        <h4>Fahasa Promotional Policies</h4>
                        <div class="policy"><i class="fas fa-truck"></i> <strong>Thời gian giao hàng:</strong> Giao nhanh và uy tín</div>
                        <div class="policy"><i class="fas fa-undo"></i> <strong>Chính sách đổi trả:</strong> Đổi trả miễn phí toàn quốc</div>
                        <div class="policy"><i class="fas fa-users"></i> <strong>Chính sách khách sỉ:</strong> Ưu đãi khi mua số lượng lớn</div>
                    </div>
                </div>

                <!-- DI CHUYỂN PHẦN .book-info RA NGOÀI .book-image -->
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
                        <table class="small-text">
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
                    <div class="detail-info" style="margin-top: 20px;">
                        <h3>Mô tả sản phẩm</h3>
                        <p><%= book.getDescription() %></p>
                        <p> Cuốn sách này là một tác phẩm hiện đại đặc sắc, được yêu thích nhờ nội dung phong phú và cách trình bày dễ hiểu. Những thông điệp sâu sắc được truyền tải qua từng trang sách, mang đến trải nghiệm đọc đầy cảm hứng và ý nghĩa.</p>
                            <p>Bằng ngôn ngữ giản dị nhưng lôi cuốn, tác phẩm này không chỉ thu hút người đọc bởi cốt truyện độc đáo mà còn khơi gợi nhiều cảm xúc và giá trị tinh thần đáng suy ngẫm.</p>
                            <p>Sự kết hợp giữa lối viết sáng tạo và nội dung giàu tính nhân văn giúp cuốn sách trở thành một trong những tác phẩm đáng đọc nhất hiện nay. Đây là lựa chọn hoàn hảo cho những ai yêu thích thể loại văn học hiện đại.</p>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
