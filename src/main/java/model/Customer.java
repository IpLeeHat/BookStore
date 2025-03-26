package model;

public class Customer {

    private int id; // Đổi từ String sang int
    private String name;
    private String phoneNumber;
    private String email;
    private String address;
    private String purchasedBook;
    private int quantity;
    private double totalPrice;
    private String role;

    // Constructor mặc định
    public Customer() {
    }

    // Constructor đầy đủ tham số

    public Customer(int id, String name, String phoneNumber, String email, String address, String purchasedBook, int quantity, double totalPrice, String role) {
        this.id = id;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.purchasedBook = purchasedBook;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.role = role;
    }
    

    // Getter và Setter
    public int getId() { // Đổi kiểu trả về từ String sang int
        return id;
    }

    public void setId(int id) { // Đổi kiểu tham số từ String sang int
        this.id = id;
    }

    public String getUsername() {
        return this.name;
    }

    public void setUsername(String username) {
        this.name = username;
    }

    public String getPhone() {
        return this.phoneNumber;
    }

    public void setPhone(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPurchasedBook() {
        return purchasedBook;
    }

    public void setPurchasedBook(String purchasedBook) {
        this.purchasedBook = purchasedBook;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    

    @Override
    public String toString() {
        return "Customer{"
                + "id=" + id // Không còn dấu nháy vì id giờ là int
                + ", name='" + name + '\''
                + ", phoneNumber='" + phoneNumber + '\''
                + ", email='" + email + '\''
                + ", address='" + address + '\''
                + ", purchasedBook='" + purchasedBook + '\''
                + ", quantity=" + quantity
                + ", totalPrice=" + totalPrice
                + '}';
    }
}
