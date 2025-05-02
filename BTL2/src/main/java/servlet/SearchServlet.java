package servlet;

import DAO.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/Search")
public class SearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO ;
    private List<Product> products;

    public void init() throws ServletException {
        productDAO = new ProductDAO();
        products = productDAO.getProductsByCategory(0); // Lấy sản phẩm từ DB

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> list = new ArrayList<String>();
        String query = request.getParameter("query");
        for (Product product : products) {
            if (product.getDescription().toLowerCase().contains(query.toLowerCase())) {
                list.add(product.getDescription());

            }
        }
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        String result = String.join(",", list);
        out.write(result);
        out.close();

    }
}



