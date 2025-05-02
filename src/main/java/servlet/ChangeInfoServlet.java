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

@WebServlet("/changeInfoServlet")
public class ChangeInfoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("validateUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String passwordHash = request.getParameter("passwordHash");
        String phone_number = request.getParameter("phone_number");

        // Cập nhật thông tin user
        user.setFirstname(firstName);
        user.setLastname(lastName);
        user.setEmail(email);
        user.setUsername(username);
        user.setPasswordHash(passwordHash);
        user.setPhonenumber(phone_number);

        // Gọi DAO để cập nhật database
        boolean success = userDAO.updateUser(user);

        if (success) {
            session.setAttribute("validateUser", user); // Cập nhật lại session
            request.setAttribute("message", "✅ Cập nhật thông tin thành công!");
        } else {
            request.setAttribute("error", "❌ Cập nhật thất bại. Vui lòng thử lại.");
        }

        // Quay lại trang cập nhật
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/changeInfo.jsp");
        dispatcher.forward(request, response);
    }
}
