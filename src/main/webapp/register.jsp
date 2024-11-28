<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        /* 기본 스타일 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* 회원가입 박스 스타일 */
        .register-container {
            background-color: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
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

        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
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

        .link-button {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            background-color: #008CBA;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        .link-button:hover {
            background-color: #007B8A;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .button-container button {
            width: 48%;
        }

    </style>
</head>
<body>
    <div class="register-container">
        <h1>회원가입</h1>
        <form action="RegisterServlet" method="post">
            <label for="username">아이디:</label>
            <input type="text" id="username" name="username" required><br><br>
            
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required><br><br>
            
            <label for="name">이름:</label>
            <input type="text" id="name" name="name"><br><br>
            
            <label for="email">이메일:</label>
            <input type="email" id="email" name="email"><br><br>

            <div class="button-container">
                <button type="submit">회원가입</button>
                <button type="button" class="link-button" onclick="location.href='login.jsp'">로그인 페이지로 이동</button>
            </div>
        </form>
    </div>
</body>
</html>
