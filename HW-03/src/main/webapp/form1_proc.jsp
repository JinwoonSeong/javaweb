<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>전송 데이터 처리</title>
</head>
<body>
    <h1>전송된 데이터</h1>
    <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        if (name != null && email != null && message != null) {
    %>
        <table border="1">
            <tr>
                <th>항목</th>
                <th>값</th>
            </tr>
            <tr>
                <td>이름</td>
                <td><%= name %></td>
            </tr>
            <tr>
                <td>이메일</td>
                <td><%= email %></td>
            </tr>
            <tr>
                <td>메시지</td>
                <td><%= message %></td>
            </tr>
        </table>
        <p><a href="form1_success.jsp">성공 페이지로 이동</a></p>
    <%
        } else {
    %>
        <p>데이터 전송에 실패했습니다.</p>
        <p><a href="form1_fail.jsp">실패 페이지로 이동</a></p>
    <%
        }
    %>
</body>
</html>
