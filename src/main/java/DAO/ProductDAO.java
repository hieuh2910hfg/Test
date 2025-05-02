package DAO;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();
        String query;

        // Kiểm tra nếu categoryId là 0 thì lấy tất cả sản phẩm
        if (categoryId == 0) {
            query = "SELECT product_id,description, price, product_links, category_id FROM products";
        } else {
            query = "SELECT product_id,description, price, product_links, category_id FROM products WHERE category_id = ?";
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            if (categoryId != 0) {
                stmt.setInt(1, categoryId);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int productId = rs.getInt("product_id");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                String productLinks = rs.getString("product_links");
                int category = rs.getInt("category_id");

                Product product = new Product(productId,category,description, price, productLinks);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductById(int id) {
        Product product = null;
        String query = "SELECT product_id, description, price, product_links FROM products WHERE product_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);

            System.out.println("Truy vấn sản phẩm với ID: " + id);

            ResultSet rs = stmt.executeQuery();
            System.out.println(rs);
            if (rs.next()) {
                int productId = rs.getInt("product_id");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                String productLinks = rs.getString("product_links");

                product = new Product(productId, description, price, productLinks);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }
    public Product getProductByName(String name) {
        Product product = null;
        String query = "SELECT product_id, description, price, product_links FROM products WHERE description = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, name);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int productId = rs.getInt("product_id");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                String productLinks = rs.getString("product_links");

                product = new Product(productId, description, price, productLinks);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }


}
