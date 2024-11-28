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

@WebServlet("/TaskStatusServlet")
public class TaskStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ����� ID ���� Ȯ��
        Integer userId = (Integer) request.getSession().getAttribute("user_id");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String taskId = request.getParameter("task_id"); // Ư�� ������ ID
        String newStatus = request.getParameter("status"); // "Pending" �Ǵ� "Completed"

        if (taskId == null || taskId.isEmpty() || newStatus == null) {
            response.sendRedirect("tasks.jsp");
            return;
        }

        try (Connection conn = DatabaseUtil.getConnection()) {
            // Ư�� ������ ���¸� ������Ʈ
            String sql = "UPDATE tasks SET status = ? WHERE task_id = ? AND user_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, newStatus);
                stmt.setString(2, taskId);
                stmt.setInt(3, userId);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("tasks.jsp");
    }
}
