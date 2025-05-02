<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm khách hàng mới</title>
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
            background-color: #28a745; /* Nền màu xanh lá */
            color: white; /* Chữ màu trắng */
            padding: 10px;
            border-radius: 5px;
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

        input {
            margin-bottom: 20px;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px;
            font-size: 14px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #218838; /* Màu xanh lá đậm khi hover */
        }

        a {
            text-decoration: none;
            color: #007bff;
            text-align: center;
            display: block;
            margin-top: 10px;
        }

        a:hover {
            color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Thêm khách hàng mới</h1>
    <form action="CustomerServlet" method="post">
        <input type="hidden" name="action" value="insert">

        <label for="first_name">Họ:</label>
        <input type="text" id="first_name" name="first_name" required>

        <label for="last_name">Tên:</label>
        <input type="text" id="last_name" name="last_name" required>

        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" required>

        <label for="passwordHash">Mật khẩu:</label>
        <input type="password" id="passwordHash" name="passwordHash" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="phone_number">Số điện thoại:</label>
        <input type="text" id="phone_number" name="phone_number" required>

        <button type="submit">Thêm khách hàng</button>
    </form>
    <a href="CustomerServlet">Quay lại danh sách khách hàng</a>
</div>
</body>
</html>
