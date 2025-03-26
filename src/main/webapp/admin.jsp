<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, model.Customer, model.Book, DAO.CustomerDAO, DAO.BookDAO" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Management</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                background: url('https://source.unsplash.com/1600x900/?library,books') no-repeat center center/cover;
                display: flex;
                flex-direction: column;
                align-items: center;
                min-height: 100vh;
            }

            /* HEADER */
            .header {
                width: 100%;
                background: rgba(0, 0, 0, 0.8);
                color: white;
                padding: 15px;
                text-align: center;
                font-size: 24px;
                position: fixed;
                top: 0;
                left: 0;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 50px;
            }

            .header .logo {
                font-weight: bold;
                font-size: 26px;
            }

            .logout-btn {
                background: red;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            .logout-btn:hover {
                background: darkred;
            }

            /* CONTAINER */
            .container {
                margin-top: 80px;
                text-align: center;
                background: rgba(255, 255, 255, 0.9);
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
                width: 90%;
                max-width: 1200px;
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
                background: white;
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

            /* Search styles */
            .search-container {
                margin: 20px 0;
                display: flex;
                justify-content: center;
            }

            .search-input {
                padding: 10px;
                width: 300px;
                border: 1px solid #ddd;
                border-radius: 5px 0 0 5px;
                font-size: 16px;
            }

            .search-btn {
                padding: 10px 15px;
                background-color: #4CAF50;
                color: white;
                border: none;
                border-radius: 0 5px 5px 0;
                cursor: pointer;
                font-size: 16px;
            }

            .search-btn:hover {
                background-color: #45a049;
            }

            /* Update form styles */
            .update-form {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 20px rgba(0,0,0,0.3);
                z-index: 1001;
                width: 400px;
                max-width: 90%;
            }

            .update-form h3 {
                margin-bottom: 20px;
                color: #333;
            }

            .form-group {
                margin-bottom: 15px;
                text-align: left;
            }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .form-group input, .form-group select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .form-actions {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                margin-top: 20px;
            }

            .form-actions button {
                padding: 8px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .save-btn {
                background-color: #4CAF50;
                color: white;
            }

            .save-btn:hover {
                background-color: #45a049;
            }

            .cancel-btn {
                background-color: #f44336;
                color: white;
            }

            .cancel-btn:hover {
                background-color: #d32f2f;
            }

            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                z-index: 1000;
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

            function searchCustomers() {
                const input = document.getElementById('customerSearch');
                const filter = input.value.toUpperCase();
                const table = document.getElementById('customerTable');
                const tr = table.getElementsByTagName('tr');

                for (let i = 1; i < tr.length; i++) {
                    let found = false;
                    const tdArray = tr[i].getElementsByTagName('td');

                    for (let j = 0; j < tdArray.length; j++) {
                        const td = tdArray[j];
                        if (td) {
                            const txtValue = td.textContent || td.innerText;
                            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                                found = true;
                                break;
                            }
                        }
                    }

                    tr[i].style.display = found ? '' : 'none';
                }
            }

            function searchBooks() {
                const input = document.getElementById('bookSearch');
                const filter = input.value.toUpperCase();
                const bookCards = document.getElementsByClassName('book-card');

                for (let i = 0; i < bookCards.length; i++) {
                    const card = bookCards[i];
                    const title = card.querySelector('h3').textContent.toUpperCase();
                    const author = card.querySelector('p:nth-of-type(1)').textContent.toUpperCase();

                    if (title.indexOf(filter) > -1 || author.indexOf(filter) > -1) {
                        card.style.display = '';
                    } else {
                        card.style.display = 'none';
                    }
                }
            }

            // Function to show update form
            function showUpdateForm(customerId, name, phone, email, address, role) {
                document.getElementById('updateCustomerId').value = customerId;
                document.getElementById('updateName').value = name;
                document.getElementById('updatePhone').value = phone;
                document.getElementById('updateEmail').value = email;
                document.getElementById('updateAddress').value = address;
                document.getElementById('updateRole').value = role;

                document.getElementById('updateForm').style.display = 'block';
                document.getElementById('overlay').style.display = 'block';
            }

            // Function to close update form
            function closeUpdateForm() {
                document.getElementById('updateForm').style.display = 'none';
                document.getElementById('overlay').style.display = 'none';
            }

            // Function to submit update form
            function submitUpdateForm() {
                document.getElementById('updateCustomerForm').submit();
            }
        </script>
    </head>
    <body>

        <!-- HEADER -->
        <div class="header" style="position: fixed; top: 0; left: 0; width: 100%; z-index: 1000;">
            <div class="logo">📊 Admin Management</div>
            <a href="LogoutServlet" >
                <button class="logout-btn">🚪 Logout</button>
            </a>
        </div>


        <div class="container">

            <div id="menu">
                <button class="menu-btn" onclick="showSection('customerSection')">👤 View Customers</button>
                <button class="menu-btn" onclick="showSection('bookSection')">📚 View Books</button>
            </div>

            <button id="goBack" class="menu-btn back-btn hidden" onclick="goBack()">🔙 Go Back</button>

            <!-- Customer Section -->
            <div id="customerSection" class="hidden">
                <h2>Customer List</h2>

                <!-- Customer Search -->
                <div class="search-container">
                    <input type="text" id="customerSearch" class="search-input" placeholder="Search customers..." onkeyup="searchCustomers()">
                    <button class="search-btn">🔍 Search</button>
                </div>

                <table id="customerTable">
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
                            String roleDisplay = "0".equals(c.getRole()) ? "User" : "Admin";
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
                        <td><%= roleDisplay %></td>
                        <td>
                            <a href="#" onclick="showUpdateForm('<%= c.getId() %>', '<%= c.getName() %>', '<%= c.getPhoneNumber() %>', '<%= c.getEmail() %>', '<%= c.getAddress() %>', '<%= c.getRole() %>')">Update</a> | 
                            <a href="AdminServlet?action=deleteCustomer&username=<%= c.getName() %>" 
                               onclick="return confirm('Are you sure you want to delete this customer?')">Delete</a>
                        </td>
                    </tr>
                    <% } %>
                </table>
            </div>

            <!-- Book Section -->
            <div id="bookSection" class="hidden">
                <h2 style="margin-bottom: 20px;">Book List</h2>

                <a href="addBook.jsp">
                    <button id="addBook" class="menu-btn" style="margin-bottom: 10px; padding: 10px; font-size: 16px;">➕ Add Book</button>
                </a>

                <!-- Book Search -->
                <div class="search-container">
                    <input type="text" id="bookSearch" class="search-input" placeholder="Search books by title or author..." onkeyup="searchBooks()">
                    <button class="search-btn">🔍 Search</button>
                </div>

                <div class="book-container">
                    <%
                        BookDAO bookDAO = new BookDAO();
                        List<Book> books = bookDAO.getAllBooks();
                        for (Book b : books) {
                    %>
                    <div class="book-card">
                        <img src="<%= b.getImage() %>" alt="Book Cover" class="book-image">
                        <div class="book-info">
                            <h3><%= b.getTitle() %></h3>
                            <p><strong>Author:</strong> <%= b.getAuthor() %></p>
                            <p><strong>Price:</strong> $<%= b.getPrice() %></p>
                            <p><strong>Quantity:</strong> <%= b.getQuantity() %></p>
                            <div class="book-hover-details">
                                <p><strong>Publisher:</strong> <%= b.getPublisher() %></p>
                                <p><strong>Year:</strong> <%= b.getPublishYear() %></p>
                                <p><strong>Language:</strong> <%= b.getLanguage() %></p>
                                <p><strong>Pages:</strong> <%= b.getPageCount() %></p>
                                <p><strong>Format:</strong> <%= b.getFormat() %></p>
                                <p><strong>SKU:</strong> <%= b.getSku() %></p>
                                <p><strong>Category:</strong> <%= b.getCategoryID() %></p>
                                <p><strong>Rating:</strong> <%= b.getReviewCount() %> ⭐</p>
                                <p><strong>Purchases:</strong> <%= b.getPurchaseCount() %></p>
                                <p><strong>Description:</strong> <%= b.getDescription() %></p>
                            </div>
                            <div class="book-actions">
                                <a href="updateBook.jsp?id=<%= b.getBookID() %>">Update</a>
                                <a href="AdminServlet?action=deleteBook&id=<%= b.getBookID() %>" 
                                   onclick="return confirm('Are you sure you want to delete this book?')">Delete</a>
                            </div>
                        </div>
                    </div>

                    <% } %>
                </div>
            </div>

            <!-- Update Customer Form -->
            <div id="updateForm" class="update-form">
                <h3>Update Customer</h3>
                <form id="updateCustomerForm" action="AdminServlet" method="post">
                    <input type="hidden" name="action" value="updateCustomer">
                    <input type="hidden" id="updateCustomerId" name="customerId">

                    <div class="form-group">
                        <label for="updateName">Name:</label>
                        <input type="text" id="updateName" name="name" required>
                    </div>

                    <div class="form-group">
                        <label for="updatePhone">Phone Number:</label>
                        <input type="text" id="updatePhone" name="phone" required>
                    </div>

                    <div class="form-group">
                        <label for="updateEmail">Email:</label>
                        <input type="email" id="updateEmail" name="email" required>
                    </div>

                    <div class="form-group">
                        <label for="updateAddress">Address:</label>
                        <input type="text" id="updateAddress" name="address" required>
                    </div>

                    <div class="form-group">
                        <label for="updateRole">Role:</label>
                        <select id="updateRole" name="role" required>
                            <option value="0">User</option>
                            <option value="1">Admin</option>
                        </select>
                    </div>

                    <div class="form-actions">
                        <button type="button" class="cancel-btn" onclick="closeUpdateForm()">Cancel</button>
                        <button type="submit" class="save-btn">Save</button>
                    </div>
                </form>
            </div>

            <!-- Overlay for modal -->
            <div id="overlay" class="overlay" onclick="closeUpdateForm()"></div>

            <style>
                .book-container {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 20px;
                    justify-content: center;
                }
                .book-card {
                    width: 250px;
                    background: white;
                    padding: 15px;
                    border-radius: 10px;
                    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                    text-align: center;
                    position: relative;
                    transition: transform 0.3s ease-in-out;
                }
                .book-card:hover {
                    transform: scale(1.05);
                }
                .book-image {
                    width: 100%;
                    height: auto;
                    border-radius: 5px;
                }
                .book-info {
                    margin-top: 10px;
                }
                .book-hover-details {
                    display: none;
                    background: rgba(0, 0, 0, 0.8);
                    color: white;
                    padding: 10px;
                    border-radius: 5px;
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    width: 90%;
                    text-align: left;
                }
                .book-card:hover .book-hover-details {
                    display: block;
                }
                .book-actions a {
                    display: inline-block;
                    margin: 5px;
                    padding: 8px;
                    background: #007BFF;
                    color: white;
                    text-decoration: none;
                    border-radius: 5px;
                }
                .book-actions a:hover {
                    background: #0056b3;
                }

                #goBack {
                    position: fixed;
                    top: 80px;
                    left: 10px;
                    z-index: 1000;
                }

                #addBook {
                    position: fixed;
                    top: 80px;
                    right: 10px;
                    z-index: 1000;
                }

            </style>

        </div>
    </body>
</html>