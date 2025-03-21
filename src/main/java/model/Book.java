package model;

import java.math.BigDecimal;
import java.util.Date;

public class Book {
    private int bookID;
    private String title;
    private String author;
    private Date publishDate;
    private int categoryID;
    private String description;
    private String image;
    private double price;
    private int quantity;
    private int viewCount;
    private int purchaseCount;

    public Book(int bookID, String title, String author, Date publishDate, int categoryID, String description, String image, double price, int quantity, int viewCount, int purchaseCount) {
        this.bookID = bookID;
        this.title = title;
        this.author = author;
        this.publishDate = publishDate;
        this.categoryID = categoryID;
        this.description = description;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.viewCount = viewCount;
        this.purchaseCount = purchaseCount;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public int getPurchaseCount() {
        return purchaseCount;
    }

    public void setPurchaseCount(int purchaseCount) {
        this.purchaseCount = purchaseCount;
    }
}
