<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List, java.text.NumberFormat, java.util.Locale"%>
<%@ page import="jakarta.*" %>
<%@ page import="model.Cart, model.User , model.Product, DAO.CartDAO, DAO.ProductDAO" %>
<%@ page session="true" %>
<% User activeuser = (User) session.getAttribute("validateUser");
    if (activeuser != null) {
        System.out.println("success");
    } %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Địa chỉ giao hàng</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
      }
    .container {
    display: flex;
    justify-content: space-between;
    max-width: 100%;
    padding: 20px;
    }

    .left, .right {
    width: 48%;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 8px;
    background-color: #f9f9f9;
    }

    .right {
    background-color: #fff;
    }
      .address {
        margin-bottom: 15px;
      }
      .address label {
        display: block;
        margin-bottom: 5px;
      }
      .address input,
      .address select {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
      }
      .choice button:hover {
        color: #088178;
      }
      .choice button {
        border-radius: 50px;
        width: 200px;
        height: 50px;
      }
      .choice{
        padding-left: 100px;
      }
      .delivery .checkout {
        display: flex;
        align-items: center;
        margin: 10px 0;
      }
      .checkout
        img {
        width: 50px;
        margin-left: 10px;
      }
    .btn-checkout {
        padding: 10px 20px;
        background-color: #ff5722;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .btn-checkout:hover {
        background-color: #e64a19;
    }
    </style>
  </head>
  <body>

    <h1 style="text-align: center;">THANH TOÁN</h1>
    <div class="container">
    <form method="post"  action="${pageContext.request.contextPath}/checkout" class="left">
        <!-- Thông tin người nhận -->
        <div class="address">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Nhập email của bạn" />
            <small>Bạn có thể tạo một tài khoản sau khi thanh toán.</small>
        </div>

        <div class="address">
            <label for="name">Tên</label>
            <input type="text" id="name" name="name" placeholder="Nhập tên của bạn" required/>
        </div>

        <div class="address">
            <label for="phone">Số điện thoại</label>
            <input type="tel" id="phone" name="phone" placeholder="Nhập số điện thoại của bạn" required/>
        </div>

        <div class="address">
            <label for="address">Địa chỉ</label>
            <input type="text" id="address" name="address" placeholder="Nhập địa chỉ của bạn" required/>
        </div>

        <div class="address">
            <label for="city">Tỉnh / Thành phố</label>
            <input type="text" id="city" name="city" placeholder="Nhập tỉnh/thành phố" required/>
        </div>

        <div class="address">
            <label for="district">Quận / Huyện</label>
            <input type="text" id="district" name="district" placeholder="Nhập quận/huyện" required/>
        </div>

        <div class="address">
            <label for="ward">Phường / Xã</label>
            <input type="text" id="ward" name="ward" placeholder="Nhập phường/xã" required/>
        </div>

        <!-- Lựa chọn địa chỉ -->
        <div class="choice" >
            <button type="button">Nhà Riêng</button>
            <button type="button">Văn Phòng</button>
        </div>

        <!-- Phương thức vận chuyển -->
        <h3>Chọn Phương Thức Vận Chuyển</h3>
        <div class="delivery" >
            <label><input type="radio" name="shippingMethod" value="Giao hàng nhanh" required/> Giao hàng nhanh</label><br>
            <label><input type="radio" name="shippingMethod" value="Giao hàng tiết kiệm" required/> Giao hàng tiết kiệm</label><br>
            <label><input type="radio" name="shippingMethod" value="Hỏa tốc" required/> Hỏa tốc</label>
        </div>

        <!-- Phương thức thanh toán -->
        <h3>Chọn Phương Thức Thanh Toán</h3>
        <div class="payment">
            <label><input type="radio" name="paymentMethod" value="COD" required/> COD</label><br>
            <label><input type="radio" name="paymentMethod" value="MoMo" required/><img src="https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png" alt="MOMO" width="50px" height="50px">MOMO</label><br>
            <label><input type="radio" name="paymentMethod" value="VNPay" required/><img src="https://downloadlogomienphi.com/sites/default/files/logos/logo-vnpayqr-experience.jpg" alt="VNPay" width="50px" height="50px">VNPay</label><br>
            <label><input type="radio" name="paymentMethod" value="ZaloPay" required/><img src="data:image/png;base64,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" alt=""  width="50px" height="50px">
                ZaloPay</label>
        </div>

        <!-- Mã thẻ quà tặng -->
        <h3>Nhập mã thẻ quà tặng</h3>
        <div class="gift-card-container">
            <input type="text" name="giftCardCode" class="gift-card-input" placeholder="Nhập mã thẻ quà tặng">
            <button type="button" class="apply-button">ÁP DỤNG</button>
        </div>

        <!-- Địa chỉ nhận hàng bổ sung -->
        <h3>Địa chỉ nhận hàng</h3>
        <div class="receivegrocery">
            <input style="height: 100px; width: 70%;" type="text" class="diachi" name="altAddress" placeholder="">
        </div>

        <!-- Nút gửi -->
        <div style="margin-top: 20px;">
            <button type="submit" class="btn btn-primary">Xác Nhận Thanh Toán</button>
        </div>
    </form>


    <div class="right">
            <h3 style="text-align: center;"> Tóm Tắt Đơn Hàng</h3>
            <%
            CartDAO cartDao = new CartDAO();
            List<Cart> cartItems = new ArrayList<Cart>();
            double grandTotal = 0;
            assert activeuser != null;
            int cartId = cartDao.getCartByUserId(activeuser.getCustomerId());
            cartItems = cartDao.getCartItemsFromCart(cartId);
            %>
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
                        <span><%= c.getQuantity() %></span>
                    </td>
                    <td><%= currencyFormatter.format(product.getPrice() * c.getQuantity())  %></td>
                    <td>

                    </td>

                </tr>
                <%
                        grandTotal += product.getPrice() * c.getQuantity();
                    }
                %>
                </tbody>

            </table>


        <div>
            <form method="post" action="${pageContext.request.contextPath}/checkout">
                <button type="submit" class="btn-checkout">Checkout</button>
            </form>
        </div>
    </div>
    </div>
  </body>
</html>
