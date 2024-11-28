package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import util.DatabaseUtil;
import util.PasswordUtil;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT * FROM users WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String storedPassword = rs.getString("password");
                        if (PasswordUtil.verifyPassword(password, storedPassword)) {
                            // �α��� ����, ���� ����
                            HttpSession session = request.getSession();
                            session.setAttribute("user_id", rs.getInt("user_id"));
                            session.setAttribute("username", rs.getString("username"));
                            response.sendRedirect("tasks.jsp"); // �� �� ��� �������� �̵�
                        } else {
                            response.getWriter().println("��й�ȣ�� �ùٸ��� �ʽ��ϴ�.");
                        }
                    } else {
                        response.getWriter().println("����� ID�� �������� �ʽ��ϴ�.");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("�α��� ����: " + e.getMessage());
        }
    }
}

