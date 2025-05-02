<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>KPI Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .kpi-container { display: flex; flex-wrap: wrap; gap: 20px; }
        .kpi-block { width: 500px; padding: 15px; border: 1px solid #ccc; border-radius: 5px; background-color: #f9f9f9; }
        .kpi-title { font-weight: bold; font-size: 16px; margin-bottom: 10px; }
        .kpi-value { font-size: 14px; }
    </style>
</head>
<body>
<h2>KPI Dashboard</h2>
<div class="kpi-container">

    <div class="kpi-block">
        <div class="kpi-title">Total Sales Revenue</div>
        <div class="kpi-value">${kpiResults[0][0]['total_revenue']}</div>
    </div>

    <div class="kpi-block">
        <div class="kpi-title">Monthly Sales Trend</div>
        <ul>
            <c:forEach var="row" items="${kpiResults[1]}">
                <li>${row['month']}: ${row['revenue']}</li>
            </c:forEach>
        </ul>
    </div>

    <div class="kpi-block">
        <div class="kpi-title">Sales Growth Rate (%)</div>
        <ul>
            <c:forEach var="row" items="${kpiResults[2]}">
                <li>${row['month']}: ${row['growth_rate']}%</li>
            </c:forEach>
        </ul>
    </div>

    <div class="kpi-block">
        <div class="kpi-title">Top Selling Products</div>
        <ul>
            <c:forEach var="row" items="${kpiResults[3]}">
                <li>${row['description']}: ${row['total_sold']} sold</li>
            </c:forEach>
        </ul>
    </div>

    <div class="kpi-block">
        <div class="kpi-title">Customer Purchase Frequency</div>
        <ul>
            <c:forEach var="row" items="${kpiResults[4]}">
                <li>${row['first_name']} ${row['last_name']} (${row['email']}): ${row['total_orders']} orders</li>
            </c:forEach>
        </ul>
    </div>

    <div class="kpi-block">
        <div class="kpi-title">Customer Retention Rate (%)</div>
        <div class="kpi-value">${kpiResults[5][0]['retention_rate']}%</div>
    </div>

    <div class="kpi-block">
        <div class="kpi-title">Fastest Selling Products</div>
        <ul>
            <c:forEach var="row" items="${kpiResults[6]}">
                <li>${row['description']}: Stock turnover Ratio: ${row['stock_turnover_ratio']}</li>
            </c:forEach>
        </ul>
    </div>

    <div class="kpi-block">
        <div class="kpi-title">Dead Stock</div>
        <ul>
            <c:forEach var="row" items="${kpiResults[7]}">
                <li>${row['description']}: ${row['Soluong']} in stock</li>
            </c:forEach>
        </ul>
    </div>

    <div class="kpi-block">
        <div class="kpi-title">Profit Margin per Category</div>
        <ul>
            <c:forEach var="row" items="${kpiResults[8]}">
                <li>${row['name']}: ${row['profit_margin']}%</li>
            </c:forEach>
        </ul>
    </div>

</div>
</body>
</html>
