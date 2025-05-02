<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm mới</title>
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
            background-color: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #218838;
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
    <h1>Thêm sản phẩm mới</h1>
    <form action="ProductServlet" method="post">
        <input type="hidden" name="action" value="insert">
        <label for="sku">SKU:</label>
        <input type="text" id="sku" name="sku" required>

        <label for="description">Tên sản phẩm:</label>
        <textarea id="description" name="description" required></textarea>

        <label for="price">Giá:</label>
        <input type="number" id="price" name="price" step="0.01" required>

        <label for="category_id">Danh mục:</label>
        <input type="number" id="category_id" name="category_id" required>

        <label for="product_links">Link hình ảnh sản phẩm:</label>
        <input type="text" id="product_links" name="product_links">

        <button type="submit">Thêm sản phẩm</button>
    </form>
    <a href="ProductServlet">Quay lại danh sách sản phẩm</a>
</div>
</body>
</html>
