<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận thanh toán</title>
</head>
<body>
<header>
    <h1>Thanh toán thành công</h1>
</header>

<main>
    <h2>Đơn hàng của bạn đã được thanh toán thành công!</h2>
    <p>Cảm ơn bạn đã mua hàng tại cửa hàng của chúng tôi.</p>
    <p>Mã đơn hàng của bạn: <strong>${orderId}</strong></p>
    <p>Phuong thuc thanh toan: <strong>${paymentMethod}</strong></p>
    <p>Tổng số tiền thanh toán: <strong>${totalAmount}</strong></p>
    <p>Nhan hang tai dia chi: <strong>${address}</strong></p>

    <a href="${pageContext.request.contextPath}/jsp/index.jsp">Trở lại trang chủ</a>
</main>

<footer>
    <p>&copy; 2024 Cửa hàng của bạn</p>
</footer>
</body>
</html>
