<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Admin.Customer" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/customers.css">
<%
    // Lấy danh sách khách hàng từ request attribute
    List<Customer> customerList = (List<Customer>) request.getAttribute("customerList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách khách hàng</title>
    <style>
        .container {
            display: flex;
            gap: 100px;
            padding-left: 270px;
        }

        .box {
            flex: 1;
            max-width: 30%;
            padding: 20px;
            text-align: center;
            background-color: whitesmoke;
            border: 1px solid #ccc;
            box-sizing: border-box;
            text-decoration: none; /* Remove underline from links */
            color: black; /* Ensure the text color looks good */
        }

        .box:hover {
            background-color: lightgrey; /* Change color on hover */
            cursor: pointer; /* Show pointer on hover */
        }
    </style>
</head>
<body>
<header>
    <div class="container">
        <a href="http://localhost:8080/BTL/ProductServlet" class="box">Quản lí sản phẩm</a>
        <a href="http://localhost:8080/BTL/CustomerServlet" class="box">Quản lí khách hàng</a>
    </div>
</header>
<!-- Thêm class cho nút Thêm khách hàng -->
<main>
    <a href="CustomerServlet?action=new" class="btn btn-add">Thêm khách hàng mới</a>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Họ</th>
            <th>Tên</th>
            <th>Tên đăng nhập</th>
            <th>Mật khẩu</th> <!-- passwordHash sau username -->
            <th>Email</th>
            <th>Số điện thoại</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <% if (customerList != null) {
            for (Customer customer : customerList) { %>
        <tr>
            <td><%= customer.getCustomerId() %></td>
            <td><%= customer.getFirstName() %></td>
            <td><%= customer.getLastName() %></td>
            <td><%= customer.getUsername() %></td>
            <td><%= customer.getPasswordHash() %></td> <!-- Hiển thị passwordHash (mã hóa) -->
            <td><%= customer.getEmail() %></td>
            <td><%= customer.getPhoneNumber() %></td>
            <td>
                <!-- Thêm class cho các nút hành động -->
                <a href="CustomerServlet?action=edit&id=<%= customer.getCustomerId() %>" class="btn btn-edit">Sửa</a>
                <a href="CustomerServlet?action=delete&id=<%= customer.getCustomerId() %>" class="btn btn-delete"
                   onclick="return confirm('Bạn có chắc chắn muốn xóa khách hàng này không?');">Xóa</a>
            </td>
        </tr>
        <% } } else { %>
        <tr>
            <td colspan="8">Không có khách hàng nào!</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</main>
</body>
</html>
