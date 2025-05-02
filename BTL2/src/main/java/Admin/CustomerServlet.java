package Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/CustomerServlet") // Định nghĩa URL mapping cho servlet này
public class CustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action"); // Lấy tham số action từ request

        try {
            if (action == null) {
                action = ""; // Mặc định là danh sách khách hàng
            }

            switch (action) {
                case "new":
                    showNewForm(request, response); // Hiển thị form thêm khách hàng
                    break;
                case "edit":
                    showEditForm(request, response); // Hiển thị form sửa khách hàng
                    break;
                case "delete":
                    deleteCustomer(request, response); // Xóa khách hàng
                    break;
                default:
                    listCustomers(request, response); // Hiển thị danh sách khách hàng
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("insert".equals(action)) {
                insertCustomer(request, response); // Xử lý thêm khách hàng
            } else if ("update".equals(action)) {
                updateCustomer(request, response); // Xử lý cập nhật khách hàng
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Customer> customers = customerDAO.getAllCustomers(); // Lấy danh sách khách hàng từ CSDL
        request.setAttribute("customerList", customers); // Gửi danh sách sang JSP
        request.getRequestDispatcher("customers/list.jsp").forward(request, response); // Chuyển tiếp đến list.jsp
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("customers/add.jsp").forward(request, response); // Chuyển tiếp đến add.jsp
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id")); // Lấy ID khách hàng từ request
        Customer existingCustomer = customerDAO.getCustomerById(id); // Lấy thông tin khách hàng từ CSDL
        request.setAttribute("customer", existingCustomer); // Gửi dữ liệu khách hàng sang JSP
        request.getRequestDispatcher("customers/edit.jsp").forward(request, response); // Chuyển tiếp đến edit.jsp
    }

    private void insertCustomer(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // Lấy thông tin từ form
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String username = request.getParameter("username");
        String passwordHash = request.getParameter("passwordHash"); // Đảm bảo lấy đúng tên cột
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone_number");

        // Tạo đối tượng khách hàng
        Customer newCustomer = new Customer();
        newCustomer.setFirstName(firstName);
        newCustomer.setLastName(lastName);
        newCustomer.setUsername(username);
        newCustomer.setPasswordHash(passwordHash);
        newCustomer.setEmail(email);
        newCustomer.setPhoneNumber(phoneNumber);

        // Thêm khách hàng vào cơ sở dữ liệu
        customerDAO.addCustomer(newCustomer);

        // Quay về danh sách khách hàng
        response.sendRedirect("CustomerServlet");
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // Lấy thông tin từ form
        int id = Integer.parseInt(request.getParameter("id"));
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String username = request.getParameter("username");
        String passwordHash = request.getParameter("passwordHash"); // Đảm bảo lấy đúng tên cột
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phone_number");

        // Cập nhật thông tin khách hàng trong CSDL
        Customer customer = new Customer();
        customer.setCustomerId(id);
        customer.setFirstName(firstName);
        customer.setLastName(lastName);
        customer.setUsername(username);
        customer.setPasswordHash(passwordHash);
        customer.setEmail(email);
        customer.setPhoneNumber(phoneNumber);

        customerDAO.updateCustomer(customer);

        // Quay về danh sách khách hàng
        response.sendRedirect("CustomerServlet");
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id")); // Lấy ID khách hàng từ request
        customerDAO.deleteCustomer(id); // Xóa khách hàng trong CSDL
        response.sendRedirect("CustomerServlet"); // Quay lại danh sách khách hàng
    }
}
