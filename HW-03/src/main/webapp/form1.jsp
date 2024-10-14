<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>전송폼</title>
</head>
<body>
    <h1>데이터 전송폼</h1>
    <form action="form1_proc.jsp" method="post">
        <label for="name">이름:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="email">이메일:</label>
        <input type="email" id="email" name="email" required><br><br>

        <label for="message">메시지:</label><br>
        <textarea id="message" name="message" rows="4" cols="50" required></textarea><br><br>

        <input type="submit" value="전송">
    </form>
</body>
</html>
