package servlet;

import DAO.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;



@WebServlet("/CartOperationServlet")
public class CartOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CartDAO cartDAO = new CartDAO();
		int cid = Integer.parseInt(request.getParameter("cid"));
		int opt = Integer.parseInt(request.getParameter("opt"));
		int qty = cartDAO.getQuantity(cid);
	if (opt == 1) {
		cartDAO.updateQuantity(cid, qty - 1);
	} 
	else if (opt == 2) {
		cartDAO.updateQuantity(cid, qty + 1);
	}
	else if (opt == 3) {
		cartDAO.removeProduct(cid);
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		 out.println("<script type=\"text/javascript\">");
	       out.println("alert('Xoa san pham khoi gio hang thanh cong!');");
	       out.println("</script>");
	}
    response.setContentType("text/plain");
    response.getWriter().write("Success");
}
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
