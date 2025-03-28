package controller;

import DAO.BookDAO;
import DAO.CustomerDAO;
import java.io.IOException;
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
            else if ("updateCustomer".equals(action)) {
                handleUpdateCustomer(request, response);
            }
            else {
                response.sendRedirect("admin.jsp?error=Unknown action");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing POST request", e);
            response.sendRedirect("admin.jsp?error=An error occurred while processing your request: " + e.getMessage());
        }
    }

    private void handleUpdateCustomer(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Parse và validate customerId
            int customerId;
            try {
                customerId = Integer.parseInt(request.getParameter("customerId"));
                if (customerId <= 0) {
                    throw new NumberFormatException("Invalid customer ID");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect("admin.jsp?error=Invalid customer ID format");
                return;
            }

            // Lấy các tham số từ request
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String role = request.getParameter("role");

            // Validate các trường bắt buộc
            if (name == null || name.trim().isEmpty() || 
                email == null || email.trim().isEmpty()) {
                response.sendRedirect("admin.jsp?error=Name and email are required fields");
                return;
            }

            // Kiểm tra email trùng (trừ customer hiện tại)
            if (customerDAO.isEmailExists(email, customerId)) {
                response.sendRedirect("admin.jsp?error=Email already exists for another customer");
                return;
            }

            // Tạo và cập nhật đối tượng Customer
            Customer customer = new Customer();
            customer.setId(customerId);
            customer.setName(name.trim());
            customer.setPhoneNumber(phone != null ? phone.trim() : null);
            customer.setEmail(email.trim());
            customer.setAddress(address != null ? address.trim() : null);
            customer.setRole(role != null ? role.trim() : "0"); // Mặc định là User nếu không có role

            // Thực hiện update
            boolean success = customerDAO.updateCustomer(customer);
            
            if (success) {
                response.sendRedirect("admin.jsp?message=Customer updated successfully");
            } else {
                response.sendRedirect("admin.jsp?error=Failed to update customer. Please try again.");
            }
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error updating customer", e);
            response.sendRedirect("admin.jsp?error=An unexpected error occurred. Please try again.");
        }
    }

    private void handleBookAction(HttpServletRequest request, HttpServletResponse response, String action)
            throws ServletException, IOException {
        try {
            // Lấy các tham số từ request
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

            // Parse các giá trị số
            int publishYear = parseInt(request.getParameter("publishYear"));
            int weight = parseInt(request.getParameter("weight"));
            int pageCount = parseInt(request.getParameter("pageCount"));
            int categoryID = parseInt(request.getParameter("categoryID"));
            int quantity = parseInt(request.getParameter("quantity"));
            int reviewCount = parseInt(request.getParameter("reviewCount"));
            int purchaseCount = parseInt(request.getParameter("purchaseCount"));
            double price = parseDouble(request.getParameter("price"));

            // Xác định bookId cho thao tác update
            int bookId = "updateBook".equals(action) ? parseInt(request.getParameter("id")) : 0;
            
            // Tạo đối tượng Book
            Book book = new Book(bookId, title, author, translator, supplier, publisher, publishYear,
                               language, weight, dimensions, pageCount, format, sku, categoryID,
                               description, image, price, quantity, reviewCount, purchaseCount);

            // Thực hiện thao tác thêm hoặc cập nhật
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
                handleDeleteCustomer(request, response);
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

        boolean success = customerDAO.deleteCustomer(username.trim());
        if (success) {
            response.sendRedirect("admin.jsp?message=Customer deleted successfully");
        } else {
            response.sendRedirect("admin.jsp?error=Failed to delete customer. Customer may not exist.");
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
                response.sendRedirect("admin.jsp?error=Failed to delete book. Book may not exist.");
            }
        } catch (NumberFormatException e) {
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
        }
    }

    @Override
    public String getServletInfo() {
        return "AdminServlet for managing books and customers";
    }
}