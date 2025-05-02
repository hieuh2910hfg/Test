<%@ page import="model.Product, DAO.ProductDAO,model.User,DAO.CartDAO" %>
<%@ page import="java.util.List, java.text.NumberFormat, java.util.Locale" %>
<%@ page import="jakarta.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    Locale locale = new Locale("vi", "VN");

// Get the currency instance for the locale
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(locale);
%>

<%
    // Lấy productId từ tham số request
    // Lấy tên sản phẩm từ tham số query khi tìm kiếm
    User user = (User) session.getAttribute("validateUser");
    String productIdParam = request.getParameter("productId");
    String productNameParam = request.getParameter("query");
    CartDAO cartDAO = new CartDAO();
    Product product = null;

    if (productNameParam != null) {
        // Tìm sản phẩm theo tên
        ProductDAO productDAO = new ProductDAO();
        product = productDAO.getProductByName(productNameParam);
    } else {
        if (productIdParam != null) {
            try {
                // Chuyển đổi productId thành số nguyên
                int productId = Integer.parseInt(productIdParam);

                // Tạo đối tượng ProductDAO để truy vấn cơ sở dữ liệu
                ProductDAO productDAO = new ProductDAO();

                // Lấy thông tin sản phẩm từ ID
                product = productDAO.getProductById(productId);

                if (product == null) {
                    // Nếu sản phẩm không tồn tại
                    request.setAttribute("error", "Sản phẩm không tồn tại.");
                }
            } catch (NumberFormatException e) {
                // Xử lý lỗi nếu productId không hợp lệ
                request.setAttribute("error", "ID sản phẩm không hợp lệ.");
            }
        } else {
            // Nếu không có productId trong request
            request.setAttribute("error", "Không tìm thấy ID sản phẩm.");
        }
    }

    // Kiểm tra và in thông tin sản phẩm
    if (product != null) {
        System.out.println(product.getProductId());
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productsDetail.css">
</head>
<body>
<header>
    <h1>Chi tiết sản phẩm</h1>
</header>

<main>
    <%
   
        // Hiển thị thông tin sản phẩm nếu tồn tại
        if (product != null) {
    %>
    <div class="product-detail">
        <div class="product-image">
            <img src="<%= product.getProductLinks() %>" alt="<%= product.getDescription() %>" class="product-img">
        </div>

        <div class="product-info">
            <h2><%= product.getDescription() %></h2>
            <p>Giá: <%= currencyFormatter.format(product.getPrice())  %></p>

            <div class="contact-info">
                <p><strong>Gọi để mua hàng nhanh hơn:</strong></p>
                <p class="phone-number">
                    <span class="phone">0243 9780 595</span> (<span class="time">8h30 : 18h</span>)
                </p>
                <p class="phone-number">
                    <span class="phone">0913 590 799</span> (<span class="time">18h : 21h</span>)
                </p>
                <p><strong>Giao hàng trong 1 - 5 ngày</strong></p>
                <ul>
                    <li>Sửa miễn phí trong vòng 15 ngày (Kể từ ngày mua)</li>
                    <li>Đổi trong vòng 3 ngày</li>
                    <li>Thanh toán khi nhận hàng</li>
                </ul>
                
<div>
    <% if (user == null) { %>
        <a href="${pageContext.request.contextPath}/login" class="btn-buy">Mua ngay</a>
        <a href="${pageContext.request.contextPath}/login" class="btn-buy">Thêm vào Giỏ Hàng</a>
    <% } else { %>
        <div>
            <a href="muahang.jsp" class="btn-buy">Mua ngay</a>
            <% if(cartDAO.isInCart(product.getProductId(),cartDAO.getCartByUserId(user.getCustomerId())) == false) { %>
            <form id="addToCartForm" method="post" 
                  action="${pageContext.request.contextPath}/AddToCartServlet" target="hiddenIframe">
                <input type="hidden" name="cid" value="<%= user.getCustomerId() %>">
                <input type="hidden" name="pid" value="<%= product.getProductId() %>">
            </form>
            <iframe name="hiddenIframe" style="display:none;" onload="handleIframeLoad()"></iframe>
            <button type="button" onclick="document.getElementById('addToCartForm').submit();setIframeTrigger()" class="btn-buy">
                Thêm vào Giỏ Hàng
            </button>
            <%} else { %>
            <a href="${pageContext.request.contextPath}/jsp/giohang.jsp" class="btn-buy">Xem trong Giỏ Hàng</a>
            <%} %>
        </div>
        <%} %>
</div>


    </div>
    <%
    } else {
        // Hiển thị lỗi nếu không tìm thấy sản phẩm
        String errorMessage = (String) request.getAttribute("error");
    %>
    <div class="error">
        <p><%= errorMessage %></p>
    </div>
    <%
        }
    %>
    <a href="${pageContext.request.contextPath}/products?category=0">Quay lại danh sách sản phẩm</a>
</main>

<footer>
    <p>&copy; 2024 Cửa hàng của bạn</p>
</footer>

<script>
    // A flag to track whether the iframe is used for cart operations
    let iframeOperationTriggered = false;

    function handleIframeLoad() {
        // Reload the page only if an operation was triggered
        if (iframeOperationTriggered) {
            iframeOperationTriggered = false; // Reset the flag
            location.reload(); // Reload the page
        }
    }

    function setIframeTrigger() {
        // Set the flag before submitting a form
        iframeOperationTriggered = true;
    }
</script>
</body>
</html>
