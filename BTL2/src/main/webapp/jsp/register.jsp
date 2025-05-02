<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng Ký</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css">
</head>
<body>

<div class="register-container">
  <h2>Đăng Ký</h2>

  <!-- Hiển thị thông báo lỗi nếu có -->
  <% if (request.getAttribute("errorMessage") != null) { %>
  <p class="error-message"><%= request.getAttribute("errorMessage") %></p>
  <% } %>

  <form action="register" method="post">
    <div class="form-group">
      <label for="firstname">Họ:</label>
      <input type="text" id="firstname" name="firstname" required><br><br>
    </div>
    <div class="form-group">
      <label for="lastname">Tên:</label>
      <input type="text" id="lastname" name="lastname" required><br><br>
    </div>
    <div class="form-group">
      <label for="username">Tên Đăng Nhập:</label>
      <input type="text" id="username" name="username" required><br><br>
    </div>
    <div class="form-group">
      <label for="password">Mật Khẩu:</label>
      <input type="password" id="password" name="passwordHash" required><br><br>
    </div>
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" id="email" name="email"><br><br>
    </div>
    <div class="form-group">
      <label for="phone">Số Điện Thoại:</label>
      <input type="text" id="phone" name="phonenumber" required><br><br>
    </div>
    <button type="submit" class="register-button">Đăng Ký</button>
  </form>
  <div class="login-link">
    <span>Đã có tài khoản?</span>
    <a href="${pageContext.request.contextPath}/login">Đăng Nhập</a>
  </div>
</div>

</body>
</html>