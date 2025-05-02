package model;

import java.sql.Timestamp;

public class OrderHistory {
    private Timestamp orderDate;  // Sử dụng Timestamp thay vì String
    private Product product;
    private int quantity;
    private double price;
    private double amount;
    private String paymentMethod;

    // Constructor
    public OrderHistory(Timestamp orderDate, Product product, int quantity, double amount, String paymentMethod) {
        this.orderDate = orderDate;
        this.product = product;
        this.quantity = quantity;
        this.price = product.getPrice();  // Lấy giá sản phẩm từ đối tượng Product
        this.paymentMethod = paymentMethod;
        this.amount = calculateAmount();  // Tính toán số tiền ngay khi khởi tạo
    }

    // Hàm tính toán số tiền thanh toán
    private double calculateAmount() {
        return this.price * this.quantity;  // Số tiền = giá * số lượng
    }

    // Getters
    public Timestamp getOrderDate() { return orderDate; }
    public Product getProduct() { return product; }
    public int getQuantity() { return quantity; }
    public double getAmount() { return amount; }
    public String getPaymentMethod() { return paymentMethod; }

    // Setters
    public void setProduct(Product product) {
        this.product = product;
        this.amount = calculateAmount(); // Cập nhật amount khi set product mới
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.amount = calculateAmount(); // Cập nhật amount khi số lượng thay đổi
    }

    public void setAmount(double amount) {
        this.amount = amount; // Nếu bạn muốn set thủ công, nhưng nó sẽ không tự tính toán từ price và quantity
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
}
