<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User customer = (User) session.getAttribute("validateUser");
    if (customer == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật thông tin</title>
    <style>
        .message { color: green; font-weight: bold; }
        .error { color: red; font-weight: bold; }
    </style>
</head>
<body>
<h1>Cập nhật thông tin khách hàng</h1>

<% if (request.getAttribute("message") != null) { %>
<p class="message"><%= request.getAttribute("message") %></p>
<% } %>
<% if (request.getAttribute("error") != null) { %>
<p class="error"><%= request.getAttribute("error") %></p>
<% } %>

<form action="<%= request.getContextPath() %>/changeInfoServlet" method="post">
    <table>
        <tr>
            <td>Họ</td>
            <td><input type="text" name="firstName" value="<%= customer.getFirstname() %>" required></td>
        </tr>
        <tr>
            <td>Tên</td>
            <td><input type="text" name="lastName" value="<%= customer.getLastname() %>" required></td>
        </tr>
        <tr>
            <td>Tên đăng nhập</td>
            <td><input type="text" name="username" value="<%= customer.getUsername() %>" required></td>
        </tr>
        <tr>
            <td>Mật khẩu</td>
            <td><input type="password" name="passwordHash" placeholder="Nhập mật khẩu mới"></td>
        </tr>
        <tr>
            <td>Email</td>
            <td><input type="email" name="email" value="<%= customer.getEmail() %>" required></td>
        </tr>
        <tr>
            <td>Số điện thoại</td>
            <td><input type="text" name="phone_number" value="<%= customer.getPhonenumber() %>" required></td>
        </tr>
    </table>
    <button type="submit">Cập nhật</button>
</form>
</body>
</html>
