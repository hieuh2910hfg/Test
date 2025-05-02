package Admin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setSKU(rs.getString("SKU"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setProductLinks(rs.getString("product_links"));
                products.add(product);
            }
        }
        return products;
    }
    public int getNextProductId() throws SQLException {
        String query = "SELECT MAX(product_id) AS max_id FROM products";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("max_id") + 1; // Tăng giá trị lớn nhất lên 1
            } else {
                return 1; // Nếu bảng trống, bắt đầu từ 1
            }
        }
    }

    public void addProduct(Product product) throws SQLException {
        String query = "INSERT INTO products (product_id, SKU, description, price, category_id, product_links) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, product.getProductId()); // Gán giá trị product_id
            stmt.setString(2, product.getSKU());
            stmt.setString(3, product.getDescription());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getCategoryId());
            stmt.setString(6, product.getProductLinks());
            stmt.executeUpdate();
        }
    }


    public void updateProduct(Product product) throws SQLException {
        String query = "UPDATE products SET SKU = ?, description = ?, price = ?, category_id = ?, product_links = ? WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, product.getSKU());
            stmt.setString(2, product.getDescription());
            stmt.setDouble(3, product.getPrice());
            stmt.setInt(4, product.getCategoryId());
            stmt.setString(5, product.getProductLinks());
            stmt.setInt(6, product.getProductId());
            stmt.executeUpdate();
        }
    }

    public void deleteProduct(int productId) throws SQLException {
        String query = "DELETE FROM products WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, productId);
            stmt.executeUpdate();
        }
    }

    public Product getProductById(int productId) throws SQLException {
        String query = "SELECT * FROM products WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, productId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setSKU(rs.getString("SKU"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getDouble("price"));
                    product.setCategoryId(rs.getInt("category_id"));
                    product.setProductLinks(rs.getString("product_links"));
                    return product;
                }
            }
        }
        return null;
    }
}
