<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="util.DatabaseUtil" %>
<%@ page import="java.sql.*" %>
<%
    // 수정하려는 할 일 ID 가져오기
    String taskId = request.getParameter("task_id");
    String title = "";
    String description = "";
    String dueDate = "";

    if (taskId != null) {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM tasks WHERE task_id = ?")) {
            stmt.setInt(1, Integer.parseInt(taskId));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    title = rs.getString("title");
                    description = rs.getString("description");
                    dueDate = rs.getString("due_date");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>할 일 <%= taskId == null ? "추가" : "수정" %></title>
    <style>
        /* 기본 스타일 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* 폼을 감싸는 박스 스타일 */
        .form-container {
            background-color: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            font-size: 14px;
            color: #555;
            margin-bottom: 8px;
            display: block;
        }

        input[type="text"],
        textarea,
        input[type="date"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        textarea {
            height: 100px;
            resize: none;
        }

        button {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #45a049;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: #007BFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
        .logout-button {
    padding: 10px 20px;
    background-color: #007bff; /* 파란색 배경 */
    color: white; /* 글자 색 */
    border: none; /* 기본 버튼 테두리 제거 */
    border-radius: 5px; /* 둥근 모서리 */
    font-size: 16px;
    cursor: pointer; /* 클릭 가능한 아이콘 표시 */
    transition: background-color 0.3s ease;
}

.logout-button:hover {
    background-color: #0056b3; /* hover 시 색상 변경 */
}
        
    </style>
</head>
<body>
    <div class="form-container">
<form action="LogoutServlet" method="post">
    <button type="submit" class="logout-button">로그아웃</button>
</form>
        <h1>할 일 <%= taskId == null ? "추가" : "수정" %></h1>
        <form action="TaskServlet" method="post">
            <input type="hidden" name="task_id" value="<%= taskId %>">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" value="<%= title %>" required><br><br>

            <label for="description">설명:</label>
            <textarea id="description" name="description" required><%= description %></textarea><br><br>

            <label for="due_date">마감일:</label>
            <input type="date" id="due_date" name="due_date" value="<%= dueDate %>" required><br><br>

            <button type="submit">저장</button>
        </form>
        <a href="tasks.jsp">취소</a>
    </div>
</body>
</html>
