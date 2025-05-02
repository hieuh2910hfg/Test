package servlet;

import DAO.UserDAO;
import model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Điều hướng đến trang login.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập mã hóa
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form đăng nhập
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Kiểm tra đăng nhập cho admin
        if (userDAO.validateAdmin(username, password)) {
            // Lưu thông tin admin vào session và chuyển hướng đến products/list.jsp
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", "admin");
            response.sendRedirect("ProductServlet");

            // Kiểm tra đăng nhập cho customer
        } else if (userDAO.validateUser(username, password)) {
            User user =  userDAO.getUserByUsernamePassword(username,password);
            // Lưu thông tin customer vào session và chuyển hướng đến index.jsp
            HttpSession session = request.getSession();
            session.setAttribute("validateUser", user);
            session.setAttribute("username", username);
            session.setAttribute("role", "customer");
            response.sendRedirect("jsp/index.jsp");

        } else {
            // Nếu đăng nhập thất bại, hiển thị thông báo lỗi
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
