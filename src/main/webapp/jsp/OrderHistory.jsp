<%@ page import="model.OrderHistory" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đơn hàng</title>
</head>
<body>
<h2>Lịch sử đơn hàng của khách hàng</h2>

<%
    // Lấy danh sách orderHistories từ request attribute
    List<OrderHistory> orderHistories = (List<OrderHistory>) request.getAttribute("orderHistories");

    if (orderHistories != null && !orderHistories.isEmpty()) {
%>
<table border="1">
    <thead>
    <tr>
        <th>Ngày đặt hàng</th>
        <th>Sản phẩm</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th>Số tiền thanh toán</th>
        <th>Phương thức thanh toán</th>
    </tr>
    </thead>
    <tbody>
    <%
        // Duyệt qua danh sách các đơn hàng và hiển thị thông tin
        for (OrderHistory order : orderHistories) {
            // Lấy thông tin sản phẩm từ OrderHistory
            Product product = order.getProduct(); // Giả sử OrderHistory có phương thức getProduct() trả về đối tượng Product
            double amount = product.getPrice() * order.getQuantity();  // Tính lại số tiền thanh toán
    %>
    <tr>
        <td><%= order.getOrderDate() %></td>
        <td><%= product.getDescription() %></td> <!-- Hiển thị tên sản phẩm từ Product -->
        <td><%= product.getPrice() %></td> <!-- Hiển thị giá từ Product -->
        <td><%= order.getQuantity() %></td> <!-- Số lượng trong OrderHistory -->
        <td><%= amount %></td> <!-- Tính toán số tiền thanh toán ngay trong JSP -->
        <td><%= order.getPaymentMethod() %></td> <!-- Phương thức thanh toán trong OrderHistory -->
    </tr>
    <%
        }
    %>
    </tbody>
</table>
<%
} else {
%>
<p>Không có lịch sử đơn hàng.</p>
<%
    }
%>
</body>
</html>
