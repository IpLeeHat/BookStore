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
                text-align: center;
            }
            h1 {
                color: #333;
            }
            .menu-btn {
                padding: 15px;
                font-size: 18px;
                margin: 10px;
                cursor: pointer;
                border: none;
                border-radius: 5px;
                background-color: #007BFF;
                color: white;
            }
            .menu-btn:hover {
                background-color: #0056b3;
            }
            .back-btn {
                background-color: #6c757d;
            }
            .back-btn:hover {
                background-color: #5a6268;
            }
            .hidden {
                display: none;
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
            .container {
                max-width: 90%;
                margin: auto;
            }
        </style>
        <script>
            function showSection(section) {
                document.getElementById('customerSection').classList.add('hidden');
                document.getElementById('bookSection').classList.add('hidden');
                document.getElementById('menu').classList.add('hidden');
                document.getElementById('goBack').classList.remove('hidden');
                document.getElementById(section).classList.remove('hidden');
            }
            function goBack() {
                document.getElementById('customerSection').classList.add('hidden');
                document.getElementById('bookSection').classList.add('hidden');
                document.getElementById('menu').classList.remove('hidden');
                document.getElementById('goBack').classList.add('hidden');
            }
        </script>
    </head>
    <body>
        <h1>Admin Management</h1>

        <div id="menu">
            <button class="menu-btn" onclick="showSection('customerSection')">👤 View Customers</button>
            <button class="menu-btn" onclick="showSection('bookSection')">📚 View Books</button>
        </div>

        <button id="goBack" class="menu-btn back-btn hidden" onclick="goBack()">🔙 Go Back</button>

        <!-- Customer Section -->
        <div id="customerSection" class="hidden">
            <h2>Customer List</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Phone Number</th>
                    <th>Email</th>
                    <th>Address</th>
                    <th>Purchased Book</th>
                    <th>Quantity</th>
                    <th>Total Price ($)</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
                <%
                    CustomerDAO customerDAO = new CustomerDAO();
                    List<Customer> customers = customerDAO.getAllCustomers();
                    for (Customer c : customers) {
                %>
                <tr>
                    <td><%= c.getId() %></td>
                    <td><%= c.getName() %></td>
                    <td><%= c.getPhoneNumber() %></td>
                    <td><%= c.getEmail() %></td>
                    <td><%= c.getAddress() %></td>
                    <td><%= c.getPurchasedBook() != null ? c.getPurchasedBook() : "N/A" %></td>
                    <td><%= c.getQuantity() > 0 ? c.getQuantity() : "N/A" %></td>
                    <td><%= c.getTotalPrice() > 0 ? "$" + c.getTotalPrice() : "N/A" %></td>
                    <td><%= c.getRole() %></td> <!-- Hiển thị Role -->
                    <td>
                        <a href="AdminServlet?action=deleteCustomer&username=<%= c.getName() %>" 
                           onclick="return confirm('Are you sure you want to delete this customer?')">Delete</a>
                    </td>
                </tr>
                <% } %>

            </table>
        </div>


        <!-- Book Section -->
        <div id="bookSection" class="hidden">
            <h2>Book List</h2>
            <a href="addBook.jsp">
                <button style="margin-bottom: 10px; padding: 10px; font-size: 16px;">➕ Add Book</button>
            </a>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Translator</th>
                    <th>Supplier</th>
                    <th>Publisher</th>
                    <th>Publish Year</th>
                    <th>Language</th>
                    <th>Weight (g)</th>
                    <th>Dimensions</th>
                    <th>Page Count</th>
                    <th>Format</th>
                    <th>SKU</th>
                    <th>Category ID</th>
                    <th>Description</th>
                    <th>Image</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Review Count</th>
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
                    <td><%= b.getTranslator() != null ? b.getTranslator() : "N/A" %></td>
                    <td><%= b.getSupplier() != null ? b.getSupplier() : "N/A" %></td>
                    <td><%= b.getPublisher() != null ? b.getPublisher() : "N/A" %></td>
                    <td><%= b.getPublishYear() %></td>
                    <td><%= b.getLanguage() %></td>
                    <td><%= b.getWeight() > 0 ? b.getWeight() + " g" : "N/A" %></td>
                    <td><%= b.getDimensions() != null ? b.getDimensions() : "N/A" %></td>
                    <td><%= b.getPageCount() %></td>
                    <td><%= b.getFormat() != null ? b.getFormat() : "N/A" %></td>
                    <td><%= b.getSku() != null ? b.getSku() : "N/A" %></td>
                    <td><%= b.getCategoryID() %></td>
                    <td><%= b.getDescription() %></td>
                    <td>
                        <img src="<%= b.getImage() %>" alt="Book Cover" width="50">
                    </td>
                    <td>$<%= b.getPrice() %></td>
                    <td><%= b.getQuantity() %></td>
                    <td><%= b.getReviewCount() %></td>
                    <td><%= b.getPurchaseCount() %></td>
                    <td>
                        <a href="updateBook.jsp?id=<%= b.getBookID() %>">Update</a> | 
                        <a href="AdminServlet?action=deleteBook&id=<%= b.getBookID() %>" 
                           onclick="return confirm('Are you sure you want to delete this book?')">Delete</a>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>
    </body>
</html>
