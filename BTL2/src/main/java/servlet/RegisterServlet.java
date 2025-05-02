package servlet;

import DAO.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chuyển hướng đến trang đăng ký
        RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/register.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập mã hóa
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy thông tin từ form
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String username = request.getParameter("username");
        String passwordHash = request.getParameter("passwordHash");
        String email = request.getParameter("email");
        String phonenumber = request.getParameter("phonenumber");

        // Gọi DAO để đăng ký người dùng
        boolean isRegistered = userDAO.registerUser(firstname, lastname, username, passwordHash, email, phonenumber);

        if (isRegistered) {
            // Đăng ký thành công, chuyển đến trang login.jsp
            response.sendRedirect("login");
        } else {
            // Đăng ký thất bại, hiển thị thông báo lỗi
            request.setAttribute("errorMessage", "Đăng ký thất bại. Vui lòng thử lại.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/register.jsp");
            dispatcher.forward(request, response);
        }
    }
}
