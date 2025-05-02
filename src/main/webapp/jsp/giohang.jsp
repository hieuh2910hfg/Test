<%@page import="model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List, java.text.NumberFormat, java.util.Locale"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.*" %>
<%@ page import="model.Cart, model.User , model.Product, DAO.CartDAO, DAO.ProductDAO" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="vi">
<head>

  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <title>Giỏ Hàng</title>
  <style>

    /* Dropdown menu styles */
    .dropdown {
      position: relative;
      display: inline-block;
    }

    .dropdown-content {
      display: none;
      position: absolute;
      background-color: #222222;
      box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
      padding: 12px 16px;
      z-index: 1;
    }

    .dropdown:hover .dropdown-content {
      display: block;
    }

    .dropdown-content a {
      display: block;
      color: black;
      text-decoration: none;
      padding: 8px 0;
    }

    .dropdown-content a:hover {
      background-color: #ddd;
    }
  </style>



</head>
<body>
<header>
  <div class="top-bar">
    <div class="landing-page">
      <a href= "${pageContext.request.contextPath}/jsp/index.jsp">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo" width = 250px height = 75px>
      </a>
    </div>

    <nav class="top-nav">
      <ul>
        <li></li>
        <!-- Dropdown menu for products -->
        <li class="dropdown">
          <a href="${pageContext.request.contextPath}/products?category=0">Sản Phẩm</a>
          <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/products?category=1">Áo Nam</a>
            <a href="${pageContext.request.contextPath}/products?category=2">Quần Nam</a>
            <a href="${pageContext.request.contextPath}/products?category=3">Giày Nam</a>
            <a href="${pageContext.request.contextPath}/products?category=4">Áo Nữ</a>
            <a href="${pageContext.request.contextPath}/products?category=5">Quần Nữ</a>
            <a href="${pageContext.request.contextPath}/products?category=6">Giày Nữ</a>
            <a href="${pageContext.request.contextPath}/products?category=7">Váy Nữ</a>
            <a href="${pageContext.request.contextPath}/products?category=8">Phụ Kiện</a>
          </div>
        </li>
        <li><a href="${pageContext.request.contextPath}/jsp/gioithieu.jsp">Giới Thiệu</a></li>
        <li><a href="${pageContext.request.contextPath}/jsp/lienhe.jsp">Liên Hệ</a></li>
        <%
            String username = (String) session.getAttribute("username");
        %>
        <li>
            <% if (username != null) { %>
                <!-- Hiển thị nút Đăng xuất -->
                <a href="${pageContext.request.contextPath}/logout" class="logout-button">Đăng xuất</a>
            <% } else { %>
                <!-- Hiển thị nút Đăng nhập -->
                <a href="${pageContext.request.contextPath}/login" class="login-button">Đăng nhập</a>
            <% } %>
        </li>
        <li>
            <% if (username != null) { %>
                <!-- Hiển thị tên người dùng -->
                <a href="${pageContext.request.contextPath}/jsp/toi.jsp" class="username-link"><%= username %></a>
            <% } else { %>
                <!-- Hiển thị nút "Tôi" -->
                <a href="${pageContext.request.contextPath}/jsp/toi.jsp" class="profile-link">Tôi</a>
            <% } %>
        </li>

      </ul>
    </nav>
  </div>
</header>

<section class="about-section">

    <h2>My Cart</h2>
    <% User activeuser = (User) session.getAttribute("validateUser");
if (activeuser != null) {
System.out.println("success");
}
else{
	response.sendRedirect("index.jsp");
}
%>

<%
    CartDAO cartDao = new CartDAO();
    List<Cart> cartItems = new ArrayList<Cart>();
    double grandTotal = 0;
    assert activeuser != null;
    int cartId = cartDao.getCartByUserId(activeuser.getCustomerId());
    cartItems = cartDao.getCartItemsFromCart(cartId);
    if (cartItems == null || cartItems.isEmpty()){
    %>
    	<div class="cart-container">
		<div class="cart-message">
		<h4 >Your cart is empty!</h4>
		<p>Add items to it now.</p>
		<a href="../products?category=0" class="btn-checkout" role="button"
			aria-disabled="true">Shop Now</a>
		</div>


		</div>
    <%
    } else{
    %>
     <iframe name="hiddenIframe" style="display:none;" onload="handleIframeLoad()"></iframe>
    <div class="cart-container">
    <table class="cart-table">
      <thead>

      <tr>
        <th>Ten san pham</th>
        <th>Anh</th>
        <th>So luong</th>
        <th>Gia</th>

      </tr>
      </thead>
      <tbody>
     <%
      ProductDAO productDAO = new ProductDAO();
     Locale locale = new Locale("vi", "VN");

     // Get the currency instance for the locale
     NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(locale);
      for (Cart c : cartItems) {
    	  Product product = productDAO.getProductById(c.getProductId());
      %>
      <tr>
        <td><%= product.getDescription() %></td>
        <td><img alt="sanpham" src="<%=product.getProductLinks()%>" width=50px height=40px></td>
        <td>
                            <div class="quantity-controls">
                                <!-- Decrease Quantity -->
                                <form method="post"
                                      action="${pageContext.request.contextPath}/CartOperationServlet?cid=<%=c.getCartItemId() %>&opt=1"
                                      target="hiddenIframe"
                                      style="display:inline;"
                                      onsubmit="setIframeTrigger()">
                                    <button type="submit" class="btn-operation" <%= c.getQuantity() <= 1 ? "disabled" : "" %>>-</button>
                                </form>

                                <span><%= c.getQuantity() %></span>

                                <!-- Increase Quantity -->
                                <form method="post"
                                      action="${pageContext.request.contextPath}/CartOperationServlet?cid=<%=c.getCartItemId() %>&opt=2"
                                      target="hiddenIframe"
                                      style="display:inline;"
                                      onsubmit="setIframeTrigger()">
                                    <button type="submit" class="btn-operation">+</button>
                                </form>
                            </div>
                        </td>
						<td><%= currencyFormatter.format(product.getPrice() * c.getQuantity())  %></td>
                        <td>
                            <!-- Remove Item -->
                            <form method="post"
                                  action="${pageContext.request.contextPath}/CartOperationServlet?cid=<%=c.getCartItemId() %>&opt=3"
                                  target="hiddenIframe"
                                  style="display:inline;"
                                  onsubmit="setIframeTrigger()">
                                <button type="submit" class="btn-operation">X</button>
                            </form>
                        </td>

      </tr>
    <%
	  grandTotal += product.getPrice() * c.getQuantity();
    }
    %>
      </tbody>

    </table>

    <div class="cart-summary">
       <a href="checkout.jsp" class="btn-checkout">Checkout</a>

    </div>
  </div>


<%
}
%>

</section>

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