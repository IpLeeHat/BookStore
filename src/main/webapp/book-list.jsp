<%@ page import="java.util.List, model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
        <title>Quản lý Sách</title>
    </head>
    <body>
        <h2>Danh sách sách</h2>

        <%-- Kiểm tra nếu có thông báo lỗi --%>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <p style="color: red;"><%= error %></p>
        <% } %>

        <%-- Nút Thêm Sách --%>
        <a href="${pageContext.request.contextPath}/admin/addBook">
            <button>Thêm Sách</button>
        </a>


        <table border="1">
            <tr>
                <th>ID</th>
                <th>Tiêu đề</th>
                <th>Tác giả</th>
                <th>Giá</th>
                <th>Hành động</th>
            </tr>
            <%
                List<Book> books = (List<Book>) request.getAttribute("books");
                if (books != null && !books.isEmpty()) {
                    for (Book book : books) {
            %>
            <tr>
                <td><%= book.getBookID() %></td>
                <td><%= book.getTitle() %></td>
                <td><%= book.getAuthor() %></td>
                <td><%= book.getPrice() %> VNĐ</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/editBook?id=<%= book.getBookID() %>">Sửa</a> | 
                    <a href="/BookShop/admin/deleteBook?id=<%= book.getBookID() %>"
                       onclick="return confirm('Bạn có chắc muốn xóa sách này không?')">Xóa</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="5" style="text-align: center; color: gray;">Không có sách nào!</td>
            </tr>
            <% } %>
        </table>
    </body>
</html>
