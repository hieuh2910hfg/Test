package Admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/KPIServlet")
public class KPIsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ArrayList<Map<String, Object>>> kpiResults = new ArrayList<>();
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        String action = request.getParameter("action"); // Lấy tham số action từ request
            try {
                if (action == null) {
                    action = "";
                }
            String[] queries = {
                    //Total Sales Revenue
            "SELECT SUM(total_price) AS total_revenue FROM orders;",

                    "SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_price) AS revenue\n" +
                            "FROM orders\n" +
                            "GROUP BY month\n" +
                            "ORDER BY month;",

                    //#Sales Growth Rate (%)
                    "SELECT month, revenue, prev_month_revenue, \n" +
                            "       ((revenue - prev_month_revenue) / prev_month_revenue) * 100 AS growth_rate \n" +
                            "FROM (\n" +
                            "    SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, \n" +
                            "           SUM(total_price) AS revenue, \n" +
                            "           LAG(SUM(total_price)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) AS prev_month_revenue \n" +
                            "    FROM orders \n" +
                            "    GROUP BY DATE_FORMAT(order_date, '%Y-%m')\n" +
                            ") AS subquery;\n",

                    //#Top Selling Products
                    "SELECT p.description, SUM(oi.quantity) AS total_sold\n" +
                            "FROM order_items oi\n" +
                            "JOIN products p ON oi.product_id = p.product_id\n" +
                            "GROUP BY p.description\n" +
                            "ORDER BY total_sold DESC\n" +
                            "LIMIT 10;",

                    //#Customer Purchase Frequency
                    "SELECT orders.customer_id, first_name, last_name, email, phone_number, COUNT(*) AS total_orders\n" +
                            "FROM orders\n" +
                            "join customers  on orders.customer_id = customers.customer_id\n" +
                            "GROUP BY customer_id\n" +
                            "ORDER BY total_orders DESC;",

                    //#Customer Retention Rate (%): Identify repeat buyers
                    "WITH first_purchase AS (\n" +
                            "    SELECT customer_id, MIN(order_date) AS first_order FROM orders GROUP BY customer_id\n" +
                            "),\n" +
                            "repeat_customers AS (\n" +
                            "    SELECT DISTINCT o.customer_id FROM orders o \n" +
                            "    JOIN first_purchase f ON o.customer_id = f.customer_id \n" +
                            "    WHERE o.order_date > DATE_ADD(f.first_order, INTERVAL 30 DAY)\n" +
                            ")\n" +
                            "SELECT \n" +
                            "    (COUNT(*) / (SELECT COUNT(DISTINCT customer_id) FROM orders)) * 100 AS retention_rate\n" +
                            "FROM repeat_customers;\n",

                    //#Fastest Selling Products (Based on inventory depletion speed)
                    "SELECT p.description, SUM(oi.quantity) AS total_sold, p.Soluong,\n" +
                            "    (p.Soluong / SUM(oi.quantity)) AS stock_turnover_ratio\n" +
                            "FROM order_items oi\n" +
                            "JOIN products p ON oi.product_id = p.product_id\n" +
                            "GROUP BY p.description, p.Soluong\n" +
                            "ORDER BY stock_turnover_ratio ASC\n" +
                            "LIMIT 10;",

                    //#Dead Stock (Products that haven't sold in X months)
                    "SELECT p.description, p.Soluong\n" +
                            "FROM products p\n" +
                            "LEFT JOIN order_items oi ON p.product_id = oi.product_id\n" +
                            "LEFT JOIN orders o ON oi.order_id = o.order_id\n" +
                            "WHERE o.order_date IS NULL OR o.order_date < DATE_SUB(NOW(), INTERVAL 6 MONTH);\n",

                    //#Profit Margin per Category
                    "SELECT c.name AS category, \n" +
                            "    SUM(oi.quantity * (oi.price - stock.Gianhap)) AS total_profit, \n" +
                            "    (SUM(oi.quantity * (oi.price - stock.Gianhap)) / SUM(oi.quantity * oi.price)) * 100 AS profit_margin\n" +
                            "FROM order_items oi\n" +
                            "JOIN kho stock ON oi.product_id = stock.product_id\n" +
                            "JOIN categories c ON stock.category_id = c.category_id\n" +
                            "GROUP BY category\n" +
                            "ORDER BY profit_margin DESC;",

            };

            for (String query : queries) {
                PreparedStatement stmt = conn.prepareStatement(query);
                ResultSet rs = stmt.executeQuery();
                ArrayList<Map<String, Object>> resultList = new ArrayList<>();
                ResultSetMetaData metaData = rs.getMetaData();
                int columnCount = metaData.getColumnCount();

                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    for (int i = 1; i <= columnCount; i++) {
                        row.put(metaData.getColumnName(i), rs.getObject(i));
                    }
                    resultList.add(row);
                }
                kpiResults.add(resultList);

                rs.close();
                stmt.close();
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("kpiResults", kpiResults);
        RequestDispatcher dispatcher = request.getRequestDispatcher("jsp/KPIs.jsp");
        dispatcher.forward(request, response);
    }
}

