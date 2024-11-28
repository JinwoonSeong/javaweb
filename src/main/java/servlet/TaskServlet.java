package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DatabaseUtil;

@WebServlet("/TaskServlet")
public class TaskServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	String title = request.getParameter("title");
        String description = request.getParameter("description");
        String dueDate = request.getParameter("due_date");

        // 사용자 ID 세션 확인
        Integer userId = (Integer) request.getSession().getAttribute("user_id");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "INSERT INTO tasks (user_id, title, description, due_date) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                stmt.setString(2, title);
                stmt.setString(3, description);
                stmt.setString(4, dueDate);
                stmt.executeUpdate();
            }
            response.sendRedirect("tasks.jsp"); // 작업 후 tasks.jsp로 리디렉션
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB 처리 중 오류가 발생했습니다.");
        }
        
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String taskId = request.getParameter("task_id");

        // 사용자 ID 세션 확인
        Integer userId = (Integer) request.getSession().getAttribute("user_id");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("delete".equals(action) && taskId != null && !taskId.isEmpty()) {
            try (Connection conn = DatabaseUtil.getConnection()) {
                String sql = "DELETE FROM tasks WHERE task_id = ? AND user_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, Integer.parseInt(taskId));
                    stmt.setInt(2, userId);
                    stmt.executeUpdate();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "DB 처리 중 오류가 발생했습니다.");
            }
        }
        response.sendRedirect("tasks.jsp"); // 작업 후 tasks.jsp로 리디렉션
    }
}
