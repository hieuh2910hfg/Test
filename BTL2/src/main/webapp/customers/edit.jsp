<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Admin.Customer" %>
<%
    // Lấy thông tin khách hàng hiện tại từ request attribute
    Customer customer = (Customer) request.getAttribute("customer");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa thông tin khách hàng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            width: 400px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            padding: 20px;
        }

        h1 {
            text-align: center;
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }

        input, textarea, button {
            margin-bottom: 20px;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        textarea {
            resize: none;
        }

        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #0056b3;
        }

        a {
            text-decoration: none;
            color: #28a745;
            text-align: center;
            display: block;
            margin-top: 10px;
        }

        a:hover {
            color: #218838;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Sửa thông tin khách hàng</h1>
    <form action="CustomerServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= customer.getCustomerId() %>">

        <label for="first_name">Họ:</label>
        <input type="text" id="first_name" name="first_name" value="<%= customer.getFirstName() %>" required>

        <label for="last_name">Tên:</label>
        <input type="text" id="last_name" name="last_name" value="<%= customer.getLastName() %>" required>

        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" value="<%= customer.getUsername() %>" required>

        <label for="passwordHash">Mật khẩu:</label>
        <input type="password" id="passwordHash" name="passwordHash" value="<%= customer.getPasswordHash() %>" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="<%= customer.getEmail() %>" required>

        <label for="phone_number">Số điện thoại:</label>
        <input type="text" id="phone_number" name="phone_number" value="<%= customer.getPhoneNumber() %>" required>

        <button type="submit">Cập nhật thông tin khách hàng</button>
    </form>
    <a href="CustomerServlet">Quay lại danh sách khách hàng</a>
</div>
</body>
</html>
