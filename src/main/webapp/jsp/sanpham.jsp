<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.List, java.text.NumberFormat, java.util.Locale" %>
<%@ page import="model.Product" %>
<%@ page session="true" %>
<%
 Locale locale = new Locale("vi", "VN");

    // Get the currency instance for the locale
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(locale);
    %>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Danh sách sản phẩm</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
          <style>

                  /* Dropdown menu styles */
                  .dropdown {
                      position: relative;
                      display: inline-block;
                  }
                  .nava a{
                      font-weight: bolder;
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
<!-- Header -->
<header>
    <div class="top-bar">
       <div class="landing-page">
              <a href= "${pageContext.request.contextPath}/jsp/index.jsp">
              <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo" width = 250px height = 75px>
          </a>
       </div>

        <nav class="top-nav">
            <ul class="nava">
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

<%
  // Lấy tham số category từ URL
  String categoryParam = request.getParameter("category");
  List<Product> selectedProducts = null;

  if ("1".equals(categoryParam)) {
    selectedProducts = (List<Product>) request.getAttribute("aonam");
  } else if ("2".equals(categoryParam)) {
    selectedProducts = (List<Product>) request.getAttribute("quannam");
  } else if ("3".equals(categoryParam)) {
    selectedProducts = (List<Product>) request.getAttribute("giaynam");
  }else if ("4".equals(categoryParam)) {
    selectedProducts = (List<Product>) request.getAttribute("aonu");
  } else if ("5".equals(categoryParam)) {
    selectedProducts = (List<Product>) request.getAttribute("quannu");
  }else if ("6".equals(categoryParam)) {
    selectedProducts = (List<Product>) request.getAttribute("giaynu");
  } else if ("7".equals(categoryParam)) {
    selectedProducts = (List<Product>) request.getAttribute("vaynu");
  }else if ("8".equals(categoryParam)) {
    selectedProducts = (List<Product>) request.getAttribute("phukien");
  }else if ("0".equals(categoryParam)) {
       selectedProducts = (List<Product>) request.getAttribute("allProducts");
     }

%>

<h2 >Danh sách sản phẩm</h2>



<%
  if (selectedProducts == null || selectedProducts.isEmpty()) {
%>
<p>Không có sản phẩm nào được tìm thấy.</p>
<%
} else {
%>
<div class="product-grid">
  <%
    for (Product product : selectedProducts) {
  %>
  <div class="product-card">
    <div class="product-square">

          <a href="${pageContext.request.contextPath}/jsp/productDetail.jsp?productId=<%= product.getProductId() %>">
                  <img src="<%= product.getProductLinks() %>" alt="<%= product.getDescription() %>" class="product-image"/>
          </a>
        </div>
    <div class="product-info">
        <a href="${pageContext.request.contextPath}/jsp/productDetail.jsp?productId=<%= product.getProductId() %>">
            <h3><%= product.getDescription() %></h3>
        </a>
        <p><%=currencyFormatter.format(product.getPrice())  %></p>
    </div>
  </div>
  <%
      }
    }
  %>
</div>




<style>
  .product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 100px;
  }

  .product-card {
    text-align: center;
  }

  .product-square {
    width: 300px;
    height: 300px;
    background-color: #f0f8ff; /* Màu nền khung ô vuông */
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin: 0 auto; /* Căn giữa ô vuông */
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden; /* Ẩn phần hình ảnh tràn ra ngoài */
  }

  .product-square img {
    max-width: 100%;
    max-height: 100%;
    object-fit: cover; /* Cắt ảnh để vừa khung */
  }

  .product-info {
    margin-top: 10px;
  }

  .product-info h3 {
    font-size: 16px;
    margin: 5px 0;
  }

  .product-info p {
    font-size: 14px;
    color: #888;
  }
</style>



</body>
<footer>
    <div class="footer-content">
        <div class="ff">
            <h3>Kết nối với Style Nest</h3>
            <hr class="hr2">
            <h4>Follow Us</h4>
            <a href="https://www.facebook.com/">Facebook</a>
            <br>
            <a href="https://www.youtube.com/">Youtube</a>
            <br>
            <a href="https://www.threads.net/">Threads</a>
            <br>

        </div>
        <hr>
        <div class="ff">
            <h3>Style Nest</h3>
            <hr class="hr2">
            <a href="${pageContext.request.contextPath}/jsp/gioithieu.jsp">Giới Thiệu</a>
            <br>
            <a href="${pageContext.request.contextPath}/jsp/lienhe.jsp">Liên Hệ</a>
        </div>
        <hr>
        <div class="ff">
            <h3>Newsletter</h3>
            <hr class="hr2">
            <p>Hãy để lại email của bạn để nhận được những thông tin về sản phẩm và các ưu đãi từ Style Nest</p>
            <br>
            <p>Email: h2910hfg123789@gmail.com</p>
        </div>
    </div>
    <p>&copy; 2024 StyleNest - All Rights Reserved</p>
</footer>
</html>