<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Book" %>
<%@ page import="java.math.BigDecimal" %>

<%
    // Kiểm tra xem có sách để chỉnh sửa không
    Book book = (Book) request.getAttribute("book");
    boolean isEdit = (book != null);
%>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
        <title><%= isEdit ? "Chỉnh sửa sách" : "Thêm sách mới" %></title>
    </head>
    <body>
        <div class="container">
            <h2><%= isEdit ? "Chỉnh sửa sách" : "Thêm sách mới" %></h2>

            <form action="books" method="post">
                <% if (isEdit) { %>
                <input type="hidden" name="bookID" value="<%= book.getBookID() %>">
                <% } %>

                <label>Tiêu đề:</label>
                <input type="text" name="title" value="<%= isEdit ? book.getTitle() : "" %>" required><br>

                <label>Tác giả:</label>
                <input type="text" name="author" value="<%= isEdit ? book.getAuthor() : "" %>" required><br>

                <label>Ngày xuất bản:</label>
                <input type="date" name="publishDate" value="<%= isEdit ? book.getPublishDate() : "" %>" required><br>

                <label>Danh mục (ID):</label>
                <input type="number" name="categoryID" value="<%= isEdit ? book.getCategoryID() : "" %>" required><br>

                <label>Mô tả:</label>
                <textarea name="description" required><%= isEdit ? book.getDescription() : "" %></textarea><br>

                <label>Hình ảnh (URL):</label>
                <input type="text" name="image" value="<%= isEdit ? book.getImage() : "" %>"><br>

                <label>Giá:</label>
                <input type="number" step="0.01" name="price" value="<%= isEdit ? book.getPrice() : "" %>" required><br>

                <label>Số lượng:</label>
                <input type="number" name="quantity" value="<%= isEdit ? book.getQuantity() : "" %>" required><br>

                <button type="submit"><%= isEdit ? "Cập nhật" : "Thêm mới" %></button>
            </form>

            


            <br>
            <a href="books">Quay lại danh sách sách</a>
        </div>
    </body>
</html>
