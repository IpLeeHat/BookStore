package model;

import java.math.BigDecimal;

public class Cart {
    private int cartID;
    private int userID;
    private int bookID;
    private int quantity;
    private String title;
    private BigDecimal price;
    private String imageUrl; // 🆕 Thêm ảnh sản phẩm

    public Cart() {
    }

    public Cart(int cartID, int userID, int bookID, int quantity, String title, BigDecimal price, String imageUrl) {
        this.cartID = cartID;
        this.userID = userID;
        this.bookID = bookID;
        this.quantity = quantity;
        this.title = title;
        this.price = price;
        this.imageUrl = imageUrl;
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getTotalPrice() {
        return price.multiply(BigDecimal.valueOf(quantity));
    }

    // 🆕 Thêm getter & setter cho imageUrl
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
