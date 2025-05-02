<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
  <title>Đăng nhập</title>
</head>
<body>

<div class="login-container">
  <h2>Đăng Nhập</h2>

  <% if (request.getAttribute("errorMessage") != null) { %>
  <p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
  <% } %>

  <!-- Form đăng nhập gửi yêu cầu tới servlet hoặc action tương ứng -->
  <form method="POST" action="login">
    <div class="form-group">
      <label for="username">Tên Đăng Nhập</label>
      <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required>
    </div>
    <div class="form-group">
      <label for="password">Mật Khẩu</label>
      <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required>
    </div>
    <button type="submit" class="login-button">Đăng Nhập</button>
  </form>
  <div class="register-link">
    <span>Chưa có tài khoản?</span>
    <a href="${pageContext.request.contextPath}/register">Đăng Ký</a>
  </div>
</div>

</body>
</html>