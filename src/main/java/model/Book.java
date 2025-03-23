package model;

import java.text.NumberFormat;
import java.util.Date;
import java.util.Locale;

public class Book {

    private int bookID;
    private String title;
    private String author;
    private String translator;
    private String supplier;
    private String publisher;
    private int publishYear;
    private String language;
    private int weight;
    private String dimensions;
    private int pageCount;
    private String format;
    private String sku;
    private int categoryID;
    private String description;
    private String image;
    private double price;
    private int quantity;
    private int reviewCount;
    private int purchaseCount;

    public Book(int bookID, String title, String author, String translator, String supplier, String publisher,
            int publishYear, String language, int weight, String dimensions, int pageCount,
            String format, String sku, int categoryID, String description, String image,
            double price, int quantity, int reviewCount, int purchaseCount) { // ✅ Thêm hai tham số
        this.bookID = bookID;
        this.title = title;
        this.author = author;
        this.translator = translator;
        this.supplier = supplier;
        this.publisher = publisher;
        this.publishYear = publishYear;
        this.language = language;
        this.weight = weight;
        this.dimensions = dimensions;
        this.pageCount = pageCount;
        this.format = format;
        this.sku = sku;
        this.categoryID = categoryID;
        this.description = description;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
        this.reviewCount = reviewCount;
        this.purchaseCount = purchaseCount;
    }

    // Getters và Setters
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

    public String getTranslator() {
        return translator;
    }

    public void setTranslator(String translator) {
        this.translator = translator;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public int getPublishYear() {
        return publishYear;
    }

    public void setPublishYear(int publishYear) {
        this.publishYear = publishYear;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public String getDimensions() {
        return dimensions;
    }

    public void setDimensions(String dimensions) {
        this.dimensions = dimensions;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
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

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getReviewCount() {
        return reviewCount;
    }

    public void setReviewCount(int reviewCount) {
        this.reviewCount = reviewCount;
    }

    public int getPurchaseCount() {
        return purchaseCount;
    }

    public void setPurchaseCount(int purchaseCount) {
        this.purchaseCount = purchaseCount;
    }

    public String getFormattedPrice() {
        NumberFormat formatter = NumberFormat.getNumberInstance(Locale.US);
        return formatter.format(price);
    }
}
