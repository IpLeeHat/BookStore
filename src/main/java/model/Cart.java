package model;

public class Cart {
    private int cartID;
    private int userID;
    private int bookID;
    private int quantity;
    private String title;  // ✅ Thêm tiêu đề sách
    private double price;  // ✅ Thêm giá sách
    private String image;  // ✅ Thêm ảnh sách

    public Cart() {}

    public Cart(int cartID, int userID, int bookID, int quantity, String title, double price, String image) {
        this.cartID = cartID;
        this.userID = userID;
        this.bookID = bookID;
        this.quantity = quantity;
        this.title = title;
        this.price = price;
        this.image = image;
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    
    public double getTotalPrice() {
    return price * quantity;
}

}
