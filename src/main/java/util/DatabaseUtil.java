package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DatabaseUtil {
    // Oracle �����ͺ��̽� ���� ����
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl"; // �Ǵ� ���񽺸�, SID�� �°� ����
    private static final String DB_USER = "c##hr"; // ������ Oracle DB ����ڸ�
    private static final String DB_PASSWORD = "1234"; // ������ Oracle DB ��й�ȣ

    public static Connection getConnection() throws SQLException {
        try {
            // Oracle JDBC ����̹� �ε�
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("JDBC ����̹��� �ε��� �� �����ϴ�.");
        }

        // �����ͺ��̽� ���� ��ȯ
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
    public List<Map<String, String>> getTasksByUserId(int userId) {
        List<Map<String, String>> tasks2 = new ArrayList<>();
        String sql = "SELECT task_id, title, description, due_date, status FROM tasks WHERE user_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId); // ���ǿ��� userId ��������
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> task = new HashMap<>();
                    task.put("task_id", rs.getString("task_id"));
                    task.put("title", rs.getString("title"));
                    task.put("description", rs.getString("description"));
                    task.put("due_date", rs.getString("due_date"));
                    task.put("status", rs.getString("status"));
                    tasks2.add(task); // tasks ����Ʈ�� �߰�
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return tasks2; // tasks ����Ʈ ��ȯ
    }
}
