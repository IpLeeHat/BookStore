package controller;

import DAO.BookDAO;
import DAO.CustomerDAO;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Book;
import model.Customer;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AdminServlet.class.getName());
    private BookDAO bookDAO = new BookDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendRedirect("admin.jsp?error=Invalid action");
            return;
        }

        try {
            if ("addBook".equals(action) || "updateBook".equals(action)) {
                handleBookAction(request, response, action);
            } 
            // THÊM XỬ LÝ UPDATE CUSTOMER
            else if ("updateCustomer".equals(action)) {
                handleUpdateCustomer(request, response);
            }
            else {
                response.sendRedirect("admin.jsp?error=Unknown action");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing POST request", e);
            response.sendRedirect("admin.jsp?error=An error occurred while processing your request");
        }
    }

    // THÊM PHƯƠNG THỨC XỬ LÝ UPDATE CUSTOMER
    private void handleUpdateCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String customerId = request.getParameter("customerId");
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String role = request.getParameter("role");

            // Validate input
            if (customerId == null || customerId.trim().isEmpty() || 
                name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
                response.sendRedirect("admin.jsp?error=Required fields are missing");
                return;
            }

            // Kiểm tra email đã tồn tại chưa (trừ customer hiện tại)
            if (customerDAO.isEmailExists(email, customerId)) {
                response.sendRedirect("admin.jsp?error=Email already exists for another customer");
                return;
            }

            // Tạo đối tượng Customer với thông tin mới
            Customer customer = new Customer();
            customer.setId(customerId);
            customer.setName(name);
            customer.setPhoneNumber(phone);
            customer.setEmail(email);
            customer.setAddress(address);
            customer.setRole(role);

            // Thực hiện update
            boolean success = customerDAO.updateCustomer(customer);
            
            if (success) {
                response.sendRedirect("admin.jsp?message=Customer updated successfully");
            } else {
                response.sendRedirect("admin.jsp?error=Failed to update customer");
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating customer", e);
            response.sendRedirect("admin.jsp?error=An error occurred while updating customer");
        }
    }

    private void handleBookAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String translator = request.getParameter("translator");
            String supplier = request.getParameter("supplier");
            String publisher = request.getParameter("publisher");
            String language = request.getParameter("language");
            String dimensions = request.getParameter("dimensions");
            String format = request.getParameter("format");
            String sku = request.getParameter("sku");
            String description = request.getParameter("description");
            String image = request.getParameter("image");

            int publishYear = parseInt(request.getParameter("publishYear"));
            int weight = parseInt(request.getParameter("weight"));
            int pageCount = parseInt(request.getParameter("pageCount"));
            int categoryID = parseInt(request.getParameter("categoryID"));
            int quantity = parseInt(request.getParameter("quantity"));
            int reviewCount = parseInt(request.getParameter("reviewCount"));
            int purchaseCount = parseInt(request.getParameter("purchaseCount"));
            double price = parseDouble(request.getParameter("price"));

            int bookId = "updateBook".equals(action) ? parseInt(request.getParameter("id")) : 0;
            
            Book book = new Book(bookId, title, author, translator, supplier, publisher, publishYear,
                                 language, weight, dimensions, pageCount, format, sku, categoryID,
                                 description, image, price, quantity, reviewCount, purchaseCount);

            if ("addBook".equals(action)) {
                bookDAO.addBook(book);
                request.setAttribute("message", "Book added successfully!");
            } else {
                bookDAO.updateBook(book);
                request.setAttribute("message", "Book updated successfully!");
            }
            
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid number format in book data", e);
            response.sendRedirect("admin.jsp?error=Invalid number format! Please enter correct values.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("admin.jsp?error=Invalid action");
            return;
        }

        try {
            if ("deleteCustomer".equals(action)) {
<<<<<<< HEAD
                int customerId = Integer.parseInt(request.getParameter("id")); // Đổi String -> int
                customerDAO.deleteCustomer(customerId); // Gọi phương thức với int id
                response.sendRedirect("admin.jsp?message=Customer deleted successfully");
=======
                handleDeleteCustomer(request, response);
>>>>>>> fca60eca8b1241d9084828933b5793f8a53b5579
            } else if ("deleteBook".equals(action)) {
                handleDeleteBook(request, response);
            } else {
                response.sendRedirect("admin.jsp?error=Unknown action");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing GET request", e);
            response.sendRedirect("admin.jsp?error=An error occurred while processing your request");
        }
    }

    private void handleDeleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String username = request.getParameter("username");
        
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("admin.jsp?error=Invalid username");
            return;
        }

        boolean success = customerDAO.deleteCustomer(username);
        if (success) {
            response.sendRedirect("admin.jsp?message=Customer deleted successfully");
        } else {
            response.sendRedirect("admin.jsp?error=Failed to delete customer");
        }
    }

    private void handleDeleteBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = parseInt(request.getParameter("id"));
            boolean success = bookDAO.deleteBook(id);

            if (success) {
                response.sendRedirect("admin.jsp?message=Book deleted successfully");
            } else {
                response.sendRedirect("admin.jsp?error=Failed to delete book");
            }
        } catch (NumberFormatException e) {
<<<<<<< HEAD
            response.sendRedirect("admin.jsp?error=Invalid ID format");
        } catch (Exception e) {
            response.sendRedirect("admin.jsp?error=An error occurred while processing your request");
            e.printStackTrace();
=======
            LOGGER.log(Level.WARNING, "Invalid book ID format", e);
            response.sendRedirect("admin.jsp?error=Invalid book ID format");
        }
    }

    private int parseInt(String value) {
        try {
            return (value != null && !value.isEmpty()) ? Integer.parseInt(value) : 0;
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Failed to parse int: " + value, e);
            throw e;
        }
    }

    private double parseDouble(String value) {
        try {
            return (value != null && !value.isEmpty()) ? Double.parseDouble(value) : 0.0;
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Failed to parse double: " + value, e);
            throw e;
>>>>>>> fca60eca8b1241d9084828933b5793f8a53b5579
        }
    }

    @Override
    public String getServletInfo() {
        return "AdminServlet for managing books and customers";
    }
}
