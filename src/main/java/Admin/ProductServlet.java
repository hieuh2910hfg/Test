package Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ProductServlet") // Định nghĩa URL mapping cho servlet này
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action"); // Lấy tham số action từ request

        try {
            if (action == null) {
                action = ""; // Mặc định là danh sách sản phẩm
            }

            switch (action) {
                case "new":
                    showNewForm(request, response); // Hiển thị form thêm sản phẩm
                    break;
                case "edit":
                    showEditForm(request, response); // Hiển thị form sửa sản phẩm
                    break;
                case "delete":
                    deleteProduct(request, response); // Xóa sản phẩm
                    break;
                default:
                    listProducts(request, response); // Hiển thị danh sách sản phẩm
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
                insertProduct(request, response); // Xử lý thêm sản phẩm
            } else if ("update".equals(action)) {
                updateProduct(request, response); // Xử lý cập nhật sản phẩm
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Product> products = productDAO.getAllProducts(); // Lấy danh sách sản phẩm từ CSDL
        request.setAttribute("productList", products); // Gửi danh sách sang JSP
        request.getRequestDispatcher("products/list.jsp").forward(request, response); // Chuyển tiếp đến list.jsp
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("products/add.jsp").forward(request, response); // Chuyển tiếp đến add.jsp
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id")); // Lấy ID sản phẩm từ request
        Product existingProduct = productDAO.getProductById(id); // Lấy thông tin sản phẩm từ CSDL
        request.setAttribute("product", existingProduct); // Gửi dữ liệu sản phẩm sang JSP
        request.getRequestDispatcher("products/edit.jsp").forward(request, response); // Chuyển tiếp đến edit.jsp
    }

    private void insertProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // Lấy thông tin từ form
        String SKU = request.getParameter("sku");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        String productLinks = request.getParameter("product_links");

        // Tạo đối tượng sản phẩm và lấy product_id mới
        Product newProduct = new Product();
        newProduct.setProductId(productDAO.getNextProductId()); // Lấy product_id mới
        newProduct.setSKU(SKU);
        newProduct.setDescription(description);
        newProduct.setPrice(price);
        newProduct.setCategoryId(categoryId);
        newProduct.setProductLinks(productLinks);

        // Thêm sản phẩm vào cơ sở dữ liệu
        productDAO.addProduct(newProduct);

        // Quay về danh sách sản phẩm
        response.sendRedirect("ProductServlet");
    }


    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // Lấy thông tin từ form
        int id = Integer.parseInt(request.getParameter("id"));
        String SKU = request.getParameter("sku");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        String productLinks = request.getParameter("product_links");

        // Cập nhật thông tin sản phẩm trong CSDL
        Product product = new Product();
        product.setProductId(id);
        product.setSKU(SKU);
        product.setDescription(description);
        product.setPrice(price);
        product.setCategoryId(categoryId);
        product.setProductLinks(productLinks);

        productDAO.updateProduct(product);

        // Quay về danh sách sản phẩm
        response.sendRedirect("ProductServlet");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id")); // Lấy ID sản phẩm từ request
        productDAO.deleteProduct(id); // Xóa sản phẩm trong CSDL
        response.sendRedirect("ProductServlet"); // Quay lại danh sách sản phẩm
    }
}
