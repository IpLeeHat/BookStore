<%@ page import="model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <title>Chỉnh sửa sách</title>
</head>
<body>
    <h2>Chỉnh sửa Sách</h2>
    
    <%
        Book book = (Book) request.getAttribute("book");
        if (book == null) {
    %>
        <p style="color: red;">Sách không tồn tại.</p>
        <a href="books">Quay lại danh sách</a>
    <%
        } else {
    %>
        <form action="${pageContext.request.contextPath}/admin/editBook" method="post">
            <input type="hidden" name="bookID" value="<%= book.getBookID() %>">
            <label>Tiêu đề:</label> <input type="text" name="title" value="<%= book.getTitle() %>" required><br>
            <label>Tác giả:</label> <input type="text" name="author" value="<%= book.getAuthor() %>" required><br>
            <label>Ngày xuất bản:</label> <input type="date" name="publishDate" value="<%= book.getPublishDate() %>" required><br>
            <label>Thể loại:</label> <input type="number" name="categoryID" value="<%= book.getCategoryID() %>" required><br>
            <label>Mô tả:</label> <textarea name="description"><%= book.getDescription() %></textarea><br>
            <label>Hình ảnh:</label> <input type="text" name="image" value="<%= book.getImage() %>"><br>
            <label>Giá:</label> <input type="text" name="price" value="<%= book.getPrice() %>" required><br>
            <label>Số lượng:</label> <input type="number" name="quantity" value="<%= book.getQuantity() %>" required><br>
            <button type="submit">Cập nhật</button>
        </form>
    <%
        }
    %>
    
    <a href="${pageContext.request.contextPath}/admin/books">Quay lại danh sách</a>
</body>
</html>
