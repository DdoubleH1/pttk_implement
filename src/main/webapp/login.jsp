<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: #ffffff;
            border: 1px solid #88B7A4;
            padding: 20px;
            border-radius: 5px;
            width: 300px;
            text-align: center;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: black;
            margin-bottom: 20px;
        }

        label {
            display: block;
            color: black;
            font-weight: bold;
            margin-top: 10px;
            text-align: left;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px;
            margin: 5px 0 15px;
            border: 1px solid #88B7A4;
            border-radius: 3px;
            box-sizing: border-box;
        }

        .login-button {
            background-color: #88B7A4;
            color: #ffffff;
            padding: 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }

        .login-button:hover {
            background-color: #76A18E;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Login</h2>
    <form action="doLogin.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username"
               value="<%= session.getAttribute("loginUsername") != null ? session.getAttribute("loginUsername") : "" %>"
               required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password"
               value="<%= session.getAttribute("loginPassword") != null ? session.getAttribute("loginPassword") : "" %>"
               required>

        <button type="submit" class="login-button">Login</button>
    </form>
    <% if (request.getParameter("error") != null) { %>
    <p style="color: red;">Invalid username or password.</p>
    <% } %>
</div>
</body>
</html>