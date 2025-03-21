
package model;

public class Customer {

    private String id;
    private String name;
    private String phoneNumber; // Đây là thuộc tính phoneNumber, không phải phone
    private String email;
    private String address;
    private String purchasedBook;
    private int quantity;
    private double totalPrice;

    // Constructor mặc định (giải quyết lỗi khởi tạo không có tham số)
    public Customer() {
    }

    public Customer(String id, String name, String phoneNumber, String email, String address, String purchasedBook, int quantity, double totalPrice) {
        this.id = id;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.purchasedBook = purchasedBook;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
    }

    // Thêm phương thức getUsername() và setUsername()
    public String getUsername() {
        return this.name; // Giả sử username là name
    }

    public void setUsername(String username) {
        this.name = username;
    }

    // Thêm phương thức getPhone() (Vì biến là phoneNumber, không phải phone)
    public String getPhone() {
        return this.phoneNumber;
    }

    public void setPhone(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    @Override
    public String toString() {
        return "Customer{"
                + "id='" + id + '\''
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

