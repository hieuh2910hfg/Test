<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    int customerId = Integer.parseInt(request.getParameter("customerId"));
    Admin.CustomerDAO dao = new Admin.CustomerDAO();
    Admin.Customer customer = dao.getCustomerById(customerId);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sửa khách hàng</title>
</head>
<body>
    <h1>Sửa thông tin khách hàng</h1>
    <form action="customers" method="post">
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="customerId" value="${customer.customerId}">
        <input type="text" name="firstName" value="${customer.firstName}" required>
        <input type="text" name="lastName" value="${customer.lastName}" required>
        <input type="text" name="username" value="${customer.username}" required>
        <input type="password" name="password" value="${customer.passwordHash}" required>
        <input type="email" name="email" value="${customer.email}" required>
        <button type="submit">Cập nhật</button>
    </form>
</body>
</html>
