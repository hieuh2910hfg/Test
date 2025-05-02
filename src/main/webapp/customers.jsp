<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Danh sách khách hàng</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        form { display: inline; }
    </style>
</head>
<body>
    <h1 style="text-align: center;">Danh sách khách hàng</h1>

    <!-- Form thêm khách hàng -->
    <h3>Thêm khách hàng mới</h3>
    <form action="customers" method="post">
        <input type="hidden" name="action" value="add">
        <input type="text" name="firstName" placeholder="Họ" required>
        <input type="text" name="lastName" placeholder="Tên" required>
        <input type="text" name="username" placeholder="Tài khoản" required>
        <input type="password" name="password" placeholder="Mật khẩu" required>
        <input type="email" name="email" placeholder="Email" required>
        <button type="submit">Thêm</button>
    </form>

    <br><br>

    <!-- Bảng danh sách khách hàng -->
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Họ</th>
                <th>Tên</th>
                <th>Tài khoản</th>
                <th>Email</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="customer" items="${customers}">
            <tr>
                <td>${customer.customerId}</td>
                <td>${customer.firstName}</td>
                <td>${customer.lastName}</td>
                <td>${customer.username}</td>
                <td>${customer.email}</td>
                <td>
                    <!-- Nút sửa -->
                    <form action="edit_customer.jsp" method="get">
                        <input type="hidden" name="customerId" value="${customer.customerId}">
                        <button type="submit">Sửa</button>
                    </form>
                    <!-- Nút xóa -->
                    <form action="customers" method="get" onsubmit="return confirm('Bạn có chắc chắn muốn xóa khách hàng này?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="customerId" value="${customer.customerId}">
                        <button type="submit">Xóa</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</body>
</html>
