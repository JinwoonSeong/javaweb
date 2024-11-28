<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="util.DatabaseUtil" %>
<%@ page session="true" %>
<%
    // 세션에서 사용자 정보 가져오기
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 데이터베이스에서 사용자별 할 일 목록 가져오기
    List<Map<String, String>> tasks = new ArrayList<>();
    String sort = request.getParameter("sort"); // 정렬 기준
    String keyword = request.getParameter("search"); // 검색어
    String sql = "SELECT * FROM tasks WHERE user_id = ?";

    if (keyword != null && !keyword.isEmpty()) {
        sql += " AND (title LIKE ? OR description LIKE ?)";
    }
    if ("due_date".equals(sort)) {
        sql += " ORDER BY due_date";
    }

    try (Connection conn = DatabaseUtil.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, userId);
        if (keyword != null && !keyword.isEmpty()) {
            stmt.setString(2, "%" + keyword + "%");
            stmt.setString(3, "%" + keyword + "%");
        }
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, String> task = new HashMap<>();
                task.put("id", rs.getString("task_id"));
                task.put("title", rs.getString("title"));
                task.put("description", rs.getString("description"));
                task.put("due_date", rs.getString("due_date"));
                task.put("status", rs.getString("status")); // 상태 컬럼 추가
                tasks.add(task);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>할 일 목록</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        form {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        input[type="text"],
        select,
        button {
            padding: 8px;
            margin: 5px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #007BFF;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
            color: #333;
        }

        td button {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        td button:hover {
            background-color: #45a049;
        }

        a {
            color: #007BFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .task-action {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .task-action form {
            margin: 0;
        }

        .task-action a {
            margin-left: 10px;
        }

        .add-task {
            margin-top: 20px;
            text-align: center;
        }
        .logout-button {
            padding: 10px 20px;
            background-color: #007bff; 
            color: white; 
            border: none; 
            border-radius: 5px; 
            font-size: 16px;
            cursor: pointer; 
            transition: background-color 0.3s ease;
        }

        .logout-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <form action="LogoutServlet" method="post">
            <button type="submit" class="logout-button">로그아웃</button>
        </form>
        <h1>할 일 목록</h1>
        <form method="get">
            <input type="text" name="search" placeholder="검색어 입력" value="<%= request.getParameter("search") %>">
            <select name="sort">
                <option value="">정렬 없음</option>
                <option value="due_date" <%= "due_date".equals(sort) ? "selected" : "" %>>마감일 순</option>
            </select>
            <button type="submit">검색 및 정렬</button>
        </form>

        <table>
            <tr>
                <th>제목</th>
                <th>설명</th>
                <th>마감일</th>
                <th>상태</th>
                <th>작업</th>
            </tr>
            <%
                for (Map<String, String> task : tasks) {
                    String taskStatus = task.get("status");
            %>
            <tr>
                <td><%= task.get("title") %></td>
                <td><%= task.get("description") %></td>
                <td><%= task.get("due_date") %></td>
                <td>
    <form action="TaskStatusServlet" method="post" style="display:inline;">
        <!-- 특정 할일 ID를 숨겨진 필드로 전달 -->
        <input type="hidden" name="task_id" value="<%= task.get("id") %>">
        <!-- 상태값 전달 -->
        <input type="hidden" name="status" value="<%= "Completed".equals(task.get("status")) ? "Pending" : "Completed" %>">
        <button type="submit">
            <%= "Completed".equals(task.get("status")) ? "완료 해제" : "완료" %>
        </button>
    </form>
</td>

                <td class="task-action">
                    <a href="TaskDeleteServlet?task_id=<%= task.get("id") %>">삭제</a>
                </td>
            </tr>
            <% } %>
        </table>

        <div class="add-task">
            <a href="taskForm.jsp">새 할 일 추가</a>
        </div>
    </div>
</body>
</html>
