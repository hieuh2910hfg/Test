package servlet;

import DAO.DatabaseConnection;
import DAO.OrderHistoryDAO;
import model.OrderHistory;
import model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/orderHistory")
public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy đối tượng người dùng đã đăng nhập từ session
        User activeUser = (User) request.getSession().getAttribute("validateUser");

        if (activeUser == null) {
            response.sendRedirect("jsp/OrderHistory.jsp"); // Nếu không có người dùng đăng nhập, chuyển hướng đến trang đăng nhập
            return;
        }

        // Khởi tạo DAO để lấy thông tin lịch sử đơn hàng
        OrderHistoryDAO orderHistoryDAO = new OrderHistoryDAO();

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Lấy danh sách đơn hàng từ DAO
            List<OrderHistory> orderHistories = orderHistoryDAO.getOrderHistoryByCustomerId(activeUser.getCustomerId(), conn);

            // Truyền dữ liệu vào JSP
            request.setAttribute("orderHistories", orderHistories);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/OrderHistory.jsp");
            dispatcher.forward(request, response);  // Chuyển hướng đến trang JSP để hiển thị thông tin
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp"); // Nếu có lỗi, chuyển hướng đến trang lỗi
        }
    }
}
