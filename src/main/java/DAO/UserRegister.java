package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRegister {

    public boolean registerUser(String firstname, String lastname, String username, String passwordHash, String email, String phonenumber) {
        String insertCustomerSQL = "INSERT INTO customers (first_name, last_name, username, passwordHash, email, phone_number) VALUES (?, ?, ?, ?, ?, ?)";
        String insertCartSQL = "INSERT INTO carts (customer_id) VALUES (?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmtCustomer = conn.prepareStatement(insertCustomerSQL, PreparedStatement.RETURN_GENERATED_KEYS);
             PreparedStatement pstmtCart = conn.prepareStatement(insertCartSQL)) {

            // Thêm thông tin người dùng vào bảng customers
            pstmtCustomer.setString(1, firstname);
            pstmtCustomer.setString(2, lastname);
            pstmtCustomer.setString(3, username);
            pstmtCustomer.setString(4, passwordHash);
            pstmtCustomer.setString(5, email);
            pstmtCustomer.setString(6, phonenumber);
            int rowsAffected = pstmtCustomer.executeUpdate();

            if (rowsAffected > 0) {
                // Lấy customer_id vừa được tạo
                ResultSet rs = pstmtCustomer.getGeneratedKeys();
                if (rs.next()) {
                    int customerId = rs.getInt(1);

                    // Thêm một dòng vào bảng cart với customer_id
                    pstmtCart.setInt(1, customerId);
                    pstmtCart.executeUpdate();
                }
                return true; // Đăng ký thành công
            } else {
                return false; // Không thể thêm người dùng
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Đăng ký thất bại
        }
    }
}
