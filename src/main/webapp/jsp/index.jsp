<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>StyleNest - Fashion Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

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
        <div>
            <form action="${pageContext.request.contextPath}/Search" method="GET" class="search-form">
                <input type="text" id="searchInput" name="query" placeholder="Search products..." autocomplete="off" required>
                <button type="submit" formaction="${pageContext.request.contextPath}/products?query=0&category=0">Search</button>
                <div id="suggestions" class="dropdown-suggestions"></div>
            </form>
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

<section class="banner" id="home">
    <h2>STYLE NEST</h2>
    <p>Giải đáp cho mọi vấn đề thời trang của bạn.</p>
    <button><a href= "${pageContext.request.contextPath}/products?category=0">Shop Now</a></button>
</section>

<section id="collections">
    <div class="top">
        <h2 class="tt-nam">Fashion Nam</h2>
        <div class="lst-category">
            <div class="category-item">
                <a href="${pageContext.request.contextPath}/products?category=1">
                    <h3>Áo Nam</h3>
                </a>
            </div>
            <br>
            <div class="category-item">
                <a href="${pageContext.request.contextPath}/products?category=2">
                    <h3>Quần Nam</h3>
                </a>
            </div>
            <div class="category-item">
                <a href="${pageContext.request.contextPath}/products?category=3">
                    <h3>Giày Nam</h3>
                </a>
            </div>
            <div class="category-item">
                <a href="${pageContext.request.contextPath}/products?category=0">
                    <h3>Xem tất cả &rarr;</h3>
                </a>
            </div>
        </div>
    </div>
    <hr class="hr">
    <div class="product-grid">
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=111">
                <img src="https://product.hstatic.net/200000239547/product/z4027625781672_dd3ecdcc436be29533dae4b27168419b_d6608ef5f9e04af4a552ba02d2b86972_1024x1024.jpg" alt="Best Seller 1">
                <h3>Áo Dài Tay Có Cổ - UNIQLO</h3>

                <p>300.000đ</p>
            </a>
        </div>

        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=129">
                <img src="https://image.uniqlo.com/UQ/ST3/AsianCommon/imagesgoods/455492/sub/goods_455492_sub14_3x4.jpg?width=369" alt="Best Seller 2">
                <h3>Quần Smart Pants Dài | Vải Wool-like</h3>
                <p>700.000đ</p>
            </a>
        </div>
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=123">
                <img src="https://product.hstatic.net/200000525243/product/image-xam-2-quan-khaki-nam-dai-n-m-18101452_447aad16b4424e3dae07a74ccf6cf38c_master.jpg" alt="Best Seller 3">
                <h3>Quần Khaki Nam Dài - ROUTINE</h3>
                <p>310.000đ</p>
            </a>
        </div>
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=132">
                <img src="https://th.bing.com/th/id/R.8e586eb4dc53cd661e9212ad88a523b8?rik=ytPKtwuruFiqQw&riu=http%3a%2f%2fsupersports.com.vn%2fcdn%2fshop%2ffiles%2fIG7512-1_1200x1200.jpg%3fv%3d1706783461&ehk=T72brHJAqNbTib4epgqfm1eZf%2bbDTYtP5VrN83XolRQ%3d&risl=&pid=ImgRaw&r=0" alt="Best Seller 3">
                <h3>Giày Chạy Bộ Supernova Rise - ADIDAS</h3>
                <p>3.800.000đ</p>
            </a>
        </div>
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=133">
                <img src="https://assets.adidas.com/images/w_600,f_auto,q_auto/daef2f92cf8942e8b8061a6222d45a38_9366/Giay_Chay_Bo_Ultrarun_5_Mau_xanh_da_troi_IE8792.jpg" alt="Best Seller 3">
                <h3>Giày Chạy Bộ Ultrarun 5 - ADIDAS</h3>
                <p>2.200.000đ</p>
            </a>
        </div>
    </div>
    <div class="top">
        <h2 class="tt-nam">Fashion Nữ</h2>
        <div class="lst-category">
            <div class="category-item">
                <a href="${pageContext.request.contextPath}/products?category=4">
                    <h3>Áo Nữ</h3>
                </a>
            </div>

            <div class="category-item">
                <a href="${pageContext.request.contextPath}/products?category=5">

                    <h3>Quần Nữ</h3>
                </a>
            </div>
            <div class="category-item">
                <a href="${pageContext.request.contextPath}/products?category=6">

                    <h3>Giày Nữ</h3>
                </a>
            </div>
            <div class="category-item">
                <a href="${pageContext.request.contextPath}/products?category=7">
                    <h3>Váy Nữ</h3>
                </a>
            </div>
            <div class="category-item">
                <a href="${pageContext.request.contextPath}/products?category=0">
                    <h3>Xem tất cả &rarr;</h3>
                </a>
            </div>
        </div>
    </div>
    <hr class="hr">
    <div class="product-grid">
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=211">
                <img src="https://assets.adidas.com/images/w_600,f_auto,q_auto/f465ded03c66416a9b091792e0ddd7e7_9366/Ao_Co_DJung_Go-To_mau_xanh_la_IX0547_01_laydown.jpg" alt="New Clothing 1">
                <h3>Áo Cổ Đứng Go-To - ADIDAS</h3>
                <p>450.000đ</p>
            </a>
        </div>
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=216">
                <img src="https://content.pancake.vn/2-24/s1000x1050/fwebp0/2024/3/4/d1386ec7981b541fedd90e8f44ef7b53fb7d876c.jpg" alt="New Clothing 2">
                <h3>Áo Babytee CEMMERY</h3>
                <p>280.000đ</p>
            </a>
        </div>
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=246">
                <img src="https://pos.nvncdn.com/b153ea-53436/ps/20220319_QD6wOECSsM4ksTSDIiTSQaUJ.jpg" alt="New Clothing 3">
                <h3>Váy Tiểu Thư Dáng Ngắn Cổ V LECOONG</h3>
                <p>650.000đ</p>
            </a>
        </div>
        <div class="product-item">
            <a hre="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=235">
                <img src="https://product.hstatic.net/1000268641/product/2.3_copy_042cc2fa656b42f0ba684eaa84480045_1024x1024.jpg" alt="New Clothing 3">
                <h3>Giày Lười Nữ Da Bò </h3>
                <p>120.000</p>
            </a>
        </div>
        <div class="product-item">
            <a href="https://product.hstatic.net/1000268641/product/2.3_copy_042cc2fa656b42f0ba684eaa84480045_1024x1024.jpg">
                <img src="https://th.bing.com/th/id/R.756d769a9fbe8038e34589aa58d88531?rik=2T5YDfcK%2bUs8kA&pid=ImgRaw&r=0" alt="New Clothing 3">
                <h3>Quần Dài Leo Núi -ADIDAS</h3>
                <p>120.000</p>
            </a>
        </div>
    </div>
    <div class="top">
        <h2 class="tt-nam">Phụ kiện</h2>
        <div class="lst-category">
            <div class="category-item">
                <a href="${pageContext.request.contextPath}/products?category=8">
                    <h3>Phụ Kiện</h3>
                </a>
            </div>
            <div class="category-item">
                <a href="${pageContext.request.contextPath}/products?category=0">
                    <h3>Xem tất cả &rarr;</h3>
                </a>
            </div>
        </div>
    </div>

    <hr class="hr">
    <div class="product-grid">
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=311">
                <img src="https://bizweb.dktcdn.net/100/059/374/products/img-1347.jpg?v=1605946442390" alt="New Clothing 1">
                <h3>Thắt Lưng Da Bò - LAFORCE</h3>
                <p>350.000đ</p>
            </a>
        </div>
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=313">
                <img src="https://th.bing.com/th/id/OIP.ZRZgmJDvcgwldV_Nzlx5swHaHa?rs=1&pid=ImgDetMain" alt="New Clothing 2">
                <h3>Mũ Lưỡi Trai Đen - ZERDIO</h3>
                <p>220.000đ</p>
            </a>
        </div>
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=314">
                <img src="https://th.bing.com/th/id/OIP.hdSM6ogw2IY3bamRkcKmXAHaHa?rs=1&pid=ImgDetMain" alt="New Clothing 3">
                <h3>Mũ Phớt Nam Đen - ZERDIO</h3>
                <p>270.000đ</p>
            </a>
        </div>
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=316">
                <img src="https://zerdio.com.vn/wp-content/uploads/2023/03/mu-noi-hoa-si-mnn010-9.jpg" alt="New Clothing 3">
                <h3>Mũ beret Màu Đen Phong Cách Retro Nhật Bản</h3>
                <p>150.000đ</p>
            </a>
        </div>
        <div class="product-item">
            <a href="http://localhost:8080/BTL/jsp/productDetail.jsp?productId=312">
                <img src="https://bizweb.dktcdn.net/100/027/341/products/that-lung-da-ca-sau-lien-bung-5c.jpg?v=1679734833257" alt="New Clothing 3">
                <h3>Thắt Lưng Cá Sấu Da Liền - LAFORCE</h3>
                <p>400.000đ</p>
            </a>
        </div>
    </div>
</section>
<br>

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
<script>
    const searchInput = document.getElementById('searchInput');
    const suggestions = document.getElementById('suggestions');
    console.log(searchInput);
    console.log(suggestions);
    searchInput.addEventListener('input', () => {
        const query = searchInput.value.trim();
        console.log(query);
        if (query.length > 0) {
            const xhr = new XMLHttpRequest();
            xhr.open("GET", `${pageContext.request.contextPath}/Search?query=` + query, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    const responseText = xhr.responseText;
                    const productNames = responseText.split(","); // Chia chuỗi thành mảng
                    suggestions.innerHTML = '';
                    productNames.forEach(productName => {
                        const suggestionItem = document.createElement('div');
                        suggestionItem.textContent = productName.trim();
                        suggestionItem.addEventListener('click', () => {
                            searchInput.value = productName.trim();
                            suggestions.innerHTML = '';
                            window.location.href = `${pageContext.request.contextPath}/jsp/productDetail.jsp?query=`+ productName.trim();
                        });
                        suggestions.appendChild(suggestionItem);

                    });
                }
            };
            xhr.send();
        } else {
            suggestions.innerHTML = '';
        }
    });

    document.addEventListener('click', (e) => {
        if (!searchInput.contains(e.target) && !suggestions.contains(e.target)) {
            suggestions.innerHTML = '';
        }
    });

</script>
</body>
</html>

