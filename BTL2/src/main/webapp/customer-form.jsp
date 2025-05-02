<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Form</title>
</head>
<body>
<h1>${customer != null ? "Edit Customer" : "Add New Customer"}</h1>
<form action="CustomerServlet" method="post">
    <input type="hidden" name="id" value="${customer != null ? customer.customerId : ''}">
    <label for="firstName">First Name:</label>
    <input type="text" name="firstName" id="firstName" value="${customer != null ? customer.firstName : ''}" required><br><br>

    <label for="lastName">Last Name:</label>
    <input type="text" name="lastName" id="lastName" value="${customer != null ? customer.lastName : ''}" required><br><br>

    <label for="username">Username:</label>
    <input type="text" name="username" id="username" value="${customer != null ? customer.username : ''}" required><br><br>

    <label for="passwordHash">Password:</label>
    <input type="password" name="passwordHash" id="passwordHash" value="${customer != null ? customer.passwordHash : ''}" required><br><br>

    <label for="email">Email:</label>
    <input type="email" name="email" id="email" value="${customer != null ? customer.email : ''}" required><br><br>

    <label for="phoneNumber">Phone Number:</label>
    <input type="text" name="phoneNumber" id="phoneNumber" value="${customer != null ? customer.phoneNumber : ''}" required><br><br>

    <input type="hidden" name="action" value="${customer != null ? 'update' : 'insert'}">
    <input type="submit" value="${customer != null ? 'Update' : 'Save'}">
    <a href="CustomerServlet">Cancel</a>
</form>
</body>
</html>
