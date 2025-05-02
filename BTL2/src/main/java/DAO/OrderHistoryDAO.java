package DAO;

import model.OrderHistory;
import model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderHistoryDAO {

    public List<OrderHistory> getOrderHistoryByCustomerId(int customerId, Connection conn) throws SQLException {
        List<OrderHistory> orderHistories = new ArrayList<>();

        // Truy vấn dữ liệu từ các bảng orders, order_items và payments
        String query = "SELECT o.order_id, o.customer_id, o.order_date, o.total_price, "
                + "oi.product_id, oi.quantity, oi.price, "
                + "p.payment_method, p.payment_date, p.amount "
                + "FROM orders o "
                + "JOIN order_items oi ON o.order_id = oi.order_id "
                + "JOIN payments p ON o.payment_id = p.payment_id "
                + "WHERE o.customer_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, customerId);  // Set customerId vào câu truy vấn
            ResultSet rs = stmt.executeQuery();  // Thực thi truy vấn

            while (rs.next()) {
                // Lấy thông tin từ ResultSet và tạo đối tượng OrderHistory
                Product product = getProductById(rs.getInt("product_id"), conn);

                // Tạo OrderHistory mới và sử dụng constructor để gán giá trị
                OrderHistory order = new OrderHistory(
                        rs.getTimestamp("order_date"),
                        product,
                        rs.getInt("quantity"),
                        rs.getDouble("amount"),
                        rs.getString("payment_method")
                );

                // Thêm đối tượng OrderHistory vào danh sách
                orderHistories.add(order);
            }
        }

        return orderHistories;
    }

    // Phương thức lấy thông tin sản phẩm từ product_id
    private Product getProductById(int productId, Connection conn) throws SQLException {
        Product product = null;
        String query = "SELECT p.product_id, p.description, p.price, p.product_links "
                + "FROM products p WHERE p.product_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, productId);  // Set productId vào câu truy vấn
            ResultSet rs = stmt.executeQuery();  // Thực thi truy vấn

            if (rs.next()) {
                // Tạo đối tượng Product từ dữ liệu truy vấn
                product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("product_links") // Thêm đường dẫn sản phẩm (nếu có)
                );
            }
        }

        return product;
    }
}
