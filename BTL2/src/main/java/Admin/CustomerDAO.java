package Admin;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    // Lấy tất cả khách hàng
    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM customers";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setFirstName(rs.getString("first_name"));
                customer.setLastName(rs.getString("last_name"));
                customer.setUsername(rs.getString("username"));
                customer.setPasswordHash(rs.getString("passwordHash"));
                customer.setEmail(rs.getString("email"));
                customer.setPhoneNumber(rs.getString("phone_number"));
                customers.add(customer);
            }
        }
        return customers;
    }

    // Lấy khách hàng theo ID
    public Customer getCustomerById(int customerId) throws SQLException {
        String query = "SELECT * FROM customers WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setFirstName(rs.getString("first_name"));
                    customer.setLastName(rs.getString("last_name"));
                    customer.setUsername(rs.getString("username"));
                    customer.setPasswordHash(rs.getString("passwordHash"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhoneNumber(rs.getString("phone_number"));
                    return customer;
                }
            }
        }
        return null;
    }

    // Thêm khách hàng mới
    public void addCustomer(Customer customer) throws SQLException {
        String query = "INSERT INTO customers (first_name, last_name, username, passwordHash, email, phone_number) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, customer.getFirstName());
            stmt.setString(2, customer.getLastName());
            stmt.setString(3, customer.getUsername());
            stmt.setString(4, customer.getPasswordHash());
            stmt.setString(5, customer.getEmail());
            stmt.setString(6, customer.getPhoneNumber());
            stmt.executeUpdate();
        }
    }

    // Cập nhật thông tin khách hàng
    public void updateCustomer(Customer customer) throws SQLException {
        String query = "UPDATE customers SET first_name = ?, last_name = ?, username = ?, passwordHash = ?, email = ?, phone_number = ? WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, customer.getFirstName());
            stmt.setString(2, customer.getLastName());
            stmt.setString(3, customer.getUsername());
            stmt.setString(4, customer.getPasswordHash());
            stmt.setString(5, customer.getEmail());
            stmt.setString(6, customer.getPhoneNumber());
            stmt.setInt(7, customer.getCustomerId());
            stmt.executeUpdate();
        }
    }

    // Xóa khách hàng theo ID
    public void deleteCustomer(int customerId) throws SQLException {
        String query = "DELETE FROM customers WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, customerId);
            stmt.executeUpdate();
        }
    }

    // Lấy ID tiếp theo cho khách hàng
    public int getNextCustomerId() throws SQLException {
        String query = "SELECT MAX(customer_id) AS max_id FROM customers";
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
}
