<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 11/12/2024
  Time: 9:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8d7da;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: #ffffff;
            border: 1px solid #f5c6cb;
            padding: 20px;
            border-radius: 5px;
            width: 300px;
            text-align: center;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #721c24;
            margin-bottom: 20px;
        }

        label {
            display: block;
            color: #721c24;
            font-weight: bold;
            margin-top: 10px;
            text-align: left;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px;
            margin: 5px 0 15px;
            border: 1px solid #f5c6cb;
            border-radius: 3px;
            box-sizing: border-box;
        }

        .login-button {
            background-color: #f5c6cb;
            color: #721c24;
            padding: 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }

        .login-button:hover {
            background-color: #f8d7da;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Login</h2>
    <form action="doLogin.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>

        <button type="submit" class="login-button">Login</button>
    </form>
</div>
</body>
</html>
