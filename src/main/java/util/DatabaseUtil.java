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
    // Oracle 데이터베이스 연결 정보
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl"; // 또는 서비스명, SID에 맞게 수정
    private static final String DB_USER = "c##hr"; // 본인의 Oracle DB 사용자명
    private static final String DB_PASSWORD = "1234"; // 본인의 Oracle DB 비밀번호

    public static Connection getConnection() throws SQLException {
        try {
            // Oracle JDBC 드라이버 로드
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("JDBC 드라이버를 로드할 수 없습니다.");
        }

        // 데이터베이스 연결 반환
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
    public List<Map<String, String>> getTasksByUserId(int userId) {
        List<Map<String, String>> tasks2 = new ArrayList<>();
        String sql = "SELECT task_id, title, description, due_date, status FROM tasks WHERE user_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId); // 세션에서 userId 가져오기
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> task = new HashMap<>();
                    task.put("task_id", rs.getString("task_id"));
                    task.put("title", rs.getString("title"));
                    task.put("description", rs.getString("description"));
                    task.put("due_date", rs.getString("due_date"));
                    task.put("status", rs.getString("status"));
                    tasks2.add(task); // tasks 리스트에 추가
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return tasks2; // tasks 리스트 반환
    }
}
