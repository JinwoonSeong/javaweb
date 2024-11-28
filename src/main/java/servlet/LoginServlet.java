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
                            // 로그인 성공, 세션 생성
                            HttpSession session = request.getSession();
                            session.setAttribute("user_id", rs.getInt("user_id"));
                            session.setAttribute("username", rs.getString("username"));
                            response.sendRedirect("tasks.jsp"); // 할 일 목록 페이지로 이동
                        } else {
                            response.getWriter().println("비밀번호가 올바르지 않습니다.");
                        }
                    } else {
                        response.getWriter().println("사용자 ID가 존재하지 않습니다.");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("로그인 실패: " + e.getMessage());
        }
    }
}

