package servlet;

import DAO.CartDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cart;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pid = Integer.parseInt(request.getParameter("pid"));
		int cid = Integer.parseInt(request.getParameter("cid"));
		System.out.println(pid);
		System.out.println(cid);
		
			CartDAO cartDAO = new CartDAO();
			int cartId = cartDAO.getCartByUserId(cid);
			int cartItemId = cartId + pid;
			int qty = cartDAO.getQuantity(cartItemId);
			if (qty == 0) {
				Cart cart = new Cart(cartId, cartItemId , pid, 1);
				cartDAO.addToCart(cart);
				System.out.println(cart);
				System.out.println("success");
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				 out.println("<script type=\"text/javascript\">");
			       out.println("alert('Them vao gio hang thanh cong!');");
			       out.println("</script>");
			      

			}

		RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/productDetail.jsp");
		dispatcher.forward(request, response);

	}

}
