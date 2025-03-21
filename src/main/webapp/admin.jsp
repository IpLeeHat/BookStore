<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, model.Customer, model.Book, DAO.CustomerDAO, DAO.BookDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Management</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 20px;
            }
            h1, h2, h3 {
                text-align: center;
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                background: #fff;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            a {
                text-decoration: none;
                color: #007BFF;
            }
            a:hover {
                text-decoration: underline;
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
            }
            input, button {
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
        <h1>Admin Management</h1>

        <!-- Customer List -->
        <h2>Customer List</h2>
        <table>
            <tr>
                <th>Username</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Address</th>
                <th>Actions</th>
            </tr>
            <%
                CustomerDAO customerDAO = new CustomerDAO();
                List<Customer> customers = customerDAO.getAllCustomers();
                for (Customer c : customers) {
            %>
            <tr>
                <td><%= c.getUsername() %></td>
                <td><%= c.getEmail() %></td>
                <td><%= c.getPhone() %></td>
                <td><%= c.getAddress() %></td>
                <td>
                    <a href="AdminServlet?action=deleteCustomer&username=<%= c.getUsername() %>" 
                       onclick="return confirm('Are you sure you want to delete this customer?')">Delete</a>
                </td>
            </tr>
            <% } %>
        </table>

        <hr>

        <!-- Book List -->
        <h2>Book List</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Publish Date</th>
                <th>Category ID</th>
                <th>Description</th>
                <th>Image</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>View Count</th>
                <th>Purchase Count</th>
                <th>Actions</th>
            </tr>
            <%
                BookDAO bookDAO = new BookDAO();
                List<Book> books = bookDAO.getAllBooks();
                for (Book b : books) {
            %>
            <tr>
                <td><%= b.getBookID() %></td>
                <td><%= b.getTitle() %></td>
                <td><%= b.getAuthor() %></td>
                <td><%= b.getPublishDate() %></td>
                <td><%= b.getCategoryID() %></td>
                <td><%= b.getDescription() %></td>
                <td>
                    <img src="<%= b.getImage() %>" alt="Book Cover" width="50">
                </td>
                <td>$<%= b.getPrice() %></td>
                <td><%= b.getQuantity() %></td>
                <td><%= b.getViewCount() %></td>
                <td><%= b.getPurchaseCount() %></td>
                <td>
                    <a href="updateBook.jsp?id=<%= b.getBookID() %>">Update</a> | 
                    <a href="AdminServlet?action=deleteBook&id=<%= b.getBookID() %>" 
                       onclick="return confirm('Are you sure you want to delete this book?')">Delete</a>
                </td>
            </tr>
            <% } %>
        </table>

        <h3>Add New Book</h3>
        <form action="AdminServlet" method="post">
            <input type="hidden" name="action" value="addBook">
            <label>Title:</label> <input type="text" name="title" required><br>
            <label>Author:</label> <input type="text" name="author" required><br>
            <label>Publish Date:</label> <input type="date" name="publishDate" required><br>
            <label>Category ID:</label> <input type="number" name="categoryID" required><br>
            <label>Description:</label> <textarea name="description" required></textarea><br>
            <label>Image URL:</label> <input type="text" name="image" required><br>
            <label>Price:</label> <input type="number" step="0.01" name="price" required><br>
            <label>Quantity:</label> <input type="number" name="quantity" required><br>
            <label>View Count:</label> <input type="number" name="viewCount" required><br>
            <label>Purchase Count:</label> <input type="number" name="purchaseCount" required><br>
            <button type="submit">Add Book</button>
        </form>
    </body>
</html>
