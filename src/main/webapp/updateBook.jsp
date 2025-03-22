<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Book, DAO.BookDAO" %>
<%
    int bookID = Integer.parseInt(request.getParameter("id"));
    BookDAO bookDAO = new BookDAO();
    Book book = bookDAO.getBookById(bookID);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        form {
            width: 50%;
            margin: auto;
            background: #fff;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }
        input, textarea, button {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #28a745;
            color: white;
            cursor: pointer;
        }
        button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <h1 style="text-align: center;">Update Book</h1>
    <form action="<%= request.getContextPath() %>/updateBook" method="post">

        <input type="hidden" name="bookID" value="<%= book.getBookID() %>">

        <label>Title:</label>
        <input type="text" name="title" value="<%= book.getTitle() %>">

        <label>Author:</label>
        <input type="text" name="author" value="<%= book.getAuthor() %>">

        <label>Publish Year:</label>
        <input type="number" name="publishYear" value="<%= book.getPublishYear() %>">

        <label>Category ID:</label>
        <input type="number" name="categoryID" value="<%= book.getCategoryID() %>">

        <label>Description:</label>
        <textarea name="description"><%= book.getDescription() %></textarea>

        <label>Image URL:</label>
        <input type="text" name="image" value="<%= book.getImage() %>">

        <label>Price:</label>
        <input type="number" step="0.01" name="price" value="<%= book.getPrice() %>">

        <label>Quantity:</label>
        <input type="number" name="quantity" value="<%= book.getQuantity() %>">

        <label>Review Count:</label>
        <input type="number" name="reviewCount" value="<%= book.getReviewCount() %>">

        <label>Purchase Count:</label>
        <input type="number" name="purchaseCount" value="<%= book.getPurchaseCount() %>">

        <button type="submit">Update Book</button>
    </form>
</body>
</html>
