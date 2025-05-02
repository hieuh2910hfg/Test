<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Admin.Product" %>
<%
    // Lấy sản phẩm hiện tại từ request attribute
    Product product = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
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
    <h1>Sửa sản phẩm</h1>
    <form action="ProductServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= product.getProductId() %>">

        <label for="sku">SKU:</label>
        <input type="text" id="sku" name="sku" value="<%= product.getSKU() %>" required>

        <label for="description">Tên sản phẩm:</label>
        <textarea id="description" name="description" required><%= product.getDescription() %></textarea>

        <label for="price">Giá:</label>
        <input type="number" id="price" name="price" step="0.01" value="<%= product.getPrice() %>" required>

        <label for="category_id">Danh mục:</label>
        <input type="number" id="category_id" name="category_id" value="<%= product.getCategoryId() %>" required>

        <label for="product_links">Link hình ảnh sản phẩm:</label>
        <input type="text" id="product_links" name="product_links" value="<%= product.getProductLinks() %>">

        <button type="submit">Cập nhật sản phẩm</button>
    </form>
    <a href="ProductServlet">Quay lại danh sách sản phẩm</a>
</div>
</body>
</html>
