package model;

public class Product {
    private int productId;
    private int id;
    private String description;
    private double price;
    private String productLinks; // Trường mới

    // Constructor
    public Product(int productId,int id, String description, double price, String productLinks) {
        this.productId = productId;
        this.id = id; //category_id
        this.description = description;
        this.price = price;
        this.productLinks = productLinks; // Gán giá trị
    }
    // Constructor không có categoryId
    public Product(int productId,String description, double price, String productLinks) {
        this.productId = productId;
        this.description = description;
        this.price = price;
        this.productLinks = productLinks;
    }


    // Getters
    public int getProductId() {return productId;}
    public int getId() {
        return id;
    }
    public String getDescription() {
        return description;
    }
    public double getPrice() {
        return price;
    }
    public String getProductLinks() { // Getter mới
        return productLinks;
    }
}
