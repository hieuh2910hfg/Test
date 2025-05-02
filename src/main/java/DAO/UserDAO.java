package DAO;

import Admin.DBConnection;
import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

	 public boolean validateUser(String username, String password) {
		 boolean flag = false;
	        String sql = "SELECT * FROM customers WHERE username = ? AND passwordHash = ?";

	        try (Connection conn = DatabaseConnection.getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)) {

	            pstmt.setString(1, username);
	            pstmt.setString(2, password);
	            ResultSet rs = pstmt.executeQuery();
	            flag = true;
	            return rs.next();  // Trả về true nếu có kết quả (người dùng hợp lệ)
	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }


 // Kiểm tra đăng nhập với bảng admin
    public boolean validateAdmin(String username, String password) {
        String sql = "SELECT * FROM admins WHERE username = ? AND passwordHash = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            return rs.next();  // Trả về true nếu có kết quả (admin hợp lệ)
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

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
	 public User getUserByUsernamePassword(String username, String password) {
		 User user = null;
		 try {
			Connection conn = DatabaseConnection.getConnection();
					String query = "select * from customers where username = ? and passwordHash = ?";
					PreparedStatement psmt = conn.prepareStatement(query);
					psmt.setString(1, username);
					psmt.setString(2, password);

					ResultSet rs = psmt.executeQuery();
					while (rs.next()) {
						user  = new User();
						user.setCustomerId(rs.getInt("customer_id"));
						user.setFirstname(rs.getString("first_name"));
						user.setLastname(rs.getString("last_name"));
						user.setUsername(rs.getString("username"));
						user.setPasswordHash(rs.getString("passwordHash"));
						user.setEmail(rs.getString("email"));
						user.setPhonenumber(rs.getString("phone_number"));
					}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}
	 public boolean updateUser(User user) {
		 	boolean flag = false;
			try {Connection conn = DatabaseConnection.getConnection();
				String query = "update customers set first_name = ?, last_name = ?, email = ?, phone_number = ? where customer_id = ?";
				PreparedStatement psmt = conn.prepareStatement(query);
				psmt.setString(1, user.getFirstname());
				psmt.setString(2, user.getLastname());
				psmt.setString(3, user.getEmail());
				psmt.setString(4, user.getPhonenumber());
				psmt.setInt(5, user.getCustomerId());

				psmt.executeUpdate();
					flag = true;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		 return flag;
	 }
	// Lấy khách hàng theo ID
	public User getCustomerById(int customerId) throws SQLException {
		String query = "SELECT * FROM customers WHERE customer_id = ?";
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(query)) {

			stmt.setInt(1, customerId);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					User user = new User();
					user.setCustomerId(rs.getInt("customer_id"));
					user.setFirstname(rs.getString("first_name"));
					user.setLastname(rs.getString("last_name"));
					user.setUsername(rs.getString("username"));
					user.setPasswordHash(rs.getString("passwordHash"));
					user.setEmail(rs.getString("email"));
					user.setPhonenumber(rs.getString("phone_number"));
					return user;
				}
			}
		}
		return null;
	}

}
