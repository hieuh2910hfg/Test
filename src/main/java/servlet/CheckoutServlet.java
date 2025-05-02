package servlet;

import DAO.CartDAO;
import DAO.DatabaseConnection;
import DAO.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cart;
import model.Product;
import model.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User activeUser = (User) request.getSession().getAttribute("validateUser");

        if (activeUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CartDAO cartDao = new CartDAO();
        int cartId = cartDao.getCartByUserId(activeUser.getCustomerId());
        if (cartId == 0) {
            response.sendRedirect("index.jsp"); // Giỏ hàng trống
            return;
        }

        List<Cart> cartItems = cartDao.getCartItemsFromCart(cartId);
        double grandTotal = 0;
        ProductDAO productDao = new ProductDAO();
        Map<Integer, Product> productMap = new HashMap<>();

        for (Cart c : cartItems) {
            if (!productMap.containsKey(c.getProductId())) {
                Product product = productDao.getProductById(c.getProductId());
                productMap.put(c.getProductId(), product);
            }
            Product product = productMap.get(c.getProductId());
            grandTotal += product.getPrice() * c.getQuantity();
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu giao dịch

            // Lấy payment_id tiếp theo
            int nextPaymentId = getNextId(conn, "payments", "payment_id");
            String paymentMethod = request.getParameter("paymentMethod");
            String address  = request.getParameter("address");

            // Lưu thông tin thanh toán vào bảng payments
            String paymentQuery = "INSERT INTO payments (payment_id, customer_id, payment_date, payment_method, amount) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement psPayment = conn.prepareStatement(paymentQuery)) {
                psPayment.setInt(1, nextPaymentId);
                psPayment.setInt(2, activeUser.getCustomerId());
                psPayment.setDate(3, new Date(System.currentTimeMillis()));
                psPayment.setString(4, paymentMethod);
                psPayment.setBigDecimal(5, BigDecimal.valueOf(grandTotal));
                psPayment.executeUpdate();
            }

            // Lấy order_id tiếp theo
            int nextOrderId = getNextId(conn, "orders", "order_id");

            // Lưu thông tin đơn hàng vào bảng orders
            String orderQuery = "INSERT INTO orders (order_id, customer_id, payment_id, order_date, total_price) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement psOrder = conn.prepareStatement(orderQuery)) {
                psOrder.setInt(1, nextOrderId);
                psOrder.setInt(2, activeUser.getCustomerId());
                psOrder.setInt(3, nextPaymentId);
                psOrder.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
                psOrder.setBigDecimal(5, BigDecimal.valueOf(grandTotal));
                psOrder.executeUpdate();
            }

            // Lấy order_item_id tiếp theo
            int nextOrderItemId = getNextId(conn, "order_items", "order_item_id");

            // Lưu từng sản phẩm trong giỏ hàng vào bảng order_items
            String orderItemQuery = "INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement psOrderItem = conn.prepareStatement(orderItemQuery)) {
                for (Cart c : cartItems) {
                    Product product = productMap.get(c.getProductId());
                    psOrderItem.setInt(1, nextOrderItemId);
                    psOrderItem.setInt(2, nextOrderId);
                    psOrderItem.setInt(3, c.getProductId());
                    psOrderItem.setInt(4, c.getQuantity());
                    psOrderItem.setBigDecimal(5, BigDecimal.valueOf(product.getPrice()));
                    psOrderItem.addBatch();

                    nextOrderItemId++; // Cập nhật ID cho lần tiếp theo
                }
                psOrderItem.executeBatch();
            }

            conn.commit(); // Commit giao dịch nếu thành công
            // Xóa các sản phẩm trong giỏ hàng sau khi thanh toán thành công
            cartDao.clearCart(cartId);
            request.setAttribute("paymentMethod", paymentMethod);
            request.setAttribute("orderId", nextOrderId);
            request.setAttribute("totalAmount", grandTotal);
            request.setAttribute("address", address);
            RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/orderConfirmation.jsp");
            dispatcher.forward(request, response);



        } catch (SQLException e) {
            e.printStackTrace();
            try (Connection conn = DatabaseConnection.getConnection()) {
                conn.rollback(); // Rollback nếu có lỗi
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            response.sendRedirect("errorPage.jsp");
        }
    }

    /**
     * Lấy giá trị ID tiếp theo bằng cách sử dụng COALESCE(MAX(...), 0) + 1.
     *
     * @param conn      Kết nối cơ sở dữ liệu
     * @param tableName Tên bảng
     * @param column    Tên cột ID
     * @return ID tiếp theo
     * @throws SQLException Lỗi SQL
     */
    private int getNextId(Connection conn, String tableName, String column) throws SQLException {
        String query = String.format("SELECT COALESCE(MAX(%s), 0) + 1 AS next_id FROM %s", column, tableName);
        try (PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("next_id");
            } else {
                throw new SQLException("Không thể lấy ID tiếp theo từ bảng: " + tableName);
            }
        }
    }
}

