<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer List</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
    </style>
</head>
<body>
<h1>Customer Management</h1>
<a href="CustomerServlet?action=new">Add New Customer</a>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Username</th>
            <th>Email</th>
            <th>Phone Number</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="customer" items="${listCustomer}">
            <tr>
                <td>${customer.customerId}</td>
                <td>${customer.firstName}</td>
                <td>${customer.lastName}</td>
                <td>${customer.username}</td>
                <td>${customer.email}</td>
                <td>${customer.phoneNumber}</td>
                <td>
                    <a href="CustomerServlet?action=edit&id=${customer.customerId}">Edit</a>
                    <a href="CustomerServlet?action=delete&id=${customer.customerId}"
                       onclick="return confirm('Are you sure you want to delete this customer?');">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</body>
</html>
