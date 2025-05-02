package servlet;

import DAO.ProductDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tham số category từ URL (nếu có)
        String categoryParam = request.getParameter("category");
        String nameParam = request.getParameter("query");
        int categoryId = 0; // Mặc định là lấy tất cả sản phẩm

        // Nếu có tham số category thì sử dụng, nếu không thì lấy tất cả sản phẩm
        if (categoryParam != null) {
            try {
                categoryId = Integer.parseInt(categoryParam);
            } catch (NumberFormatException e) {
                // Nếu category không hợp lệ, vẫn lấy tất cả sản phẩm
                categoryId = 0;
            }
        }

        // Lấy danh sách sản phẩm theo categoryId
        List<Product> aonam = productDAO.getProductsByCategory(11); // Áo nam
        List<Product> quannam = productDAO.getProductsByCategory(12); // Quần nam
        List<Product> giaynam = productDAO.getProductsByCategory(13); // Giày nam
        List<Product> aonu = productDAO.getProductsByCategory(21); // Áo nữ
        List<Product> quannu = productDAO.getProductsByCategory(22); // Quần nữ
        List<Product> giaynu = productDAO.getProductsByCategory(23); // Giày nữ
        List<Product> vaynu = productDAO.getProductsByCategory(24); // Váy nữ
        List<Product> phukien = productDAO.getProductsByCategory(31); // Phụ kiện
        List<Product> allProducts = productDAO.getProductsByCategory(0); // Tất cả sản phẩm
        List<Product> selectedProducts = null;

        // Lấy sản phẩm theo categoryId
        if (categoryId == 0) {
            if (nameParam != null) {
                //them cac san pham khi tim kiem vao list
                selectedProducts = new ArrayList<Product>();
                for (Product product : allProducts) {
                    if (product.getDescription().toLowerCase().contains(nameParam.toLowerCase())) {
                        selectedProducts.add(product);

                    }
                }
            }else {
                selectedProducts = allProducts; // Nếu categoryId = 0, lấy tất cả sản phẩm
            }
        } else if (categoryId == 11) {
            selectedProducts = aonam;
        } else if (categoryId == 12) {
            selectedProducts = quannam;
        } else if (categoryId == 13) {
            selectedProducts = giaynam;
        } else if (categoryId == 21) {
            selectedProducts = aonu;
        } else if (categoryId == 22) {
            selectedProducts = quannu;
        } else if (categoryId == 23) {
            selectedProducts = giaynu;
        } else if (categoryId == 24) {
            selectedProducts = vaynu;
        } else if (categoryId == 31) {
            selectedProducts = phukien;
        }

        // Truyền các danh sách sản phẩm vào request
        request.setAttribute("selectedProducts", selectedProducts);
        request.setAttribute("aonam", aonam);
        request.setAttribute("quannam", quannam);
        request.setAttribute("giaynam", giaynam);
        request.setAttribute("aonu", aonu);
        request.setAttribute("quannu", quannu);
        request.setAttribute("giaynu", giaynu);
        request.setAttribute("vaynu", vaynu);
        request.setAttribute("phukien", phukien);
        request.setAttribute("allProducts", allProducts);

        // Chuyển hướng đến trang JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/sanpham.jsp");
        dispatcher.forward(request, response);
    }
}
