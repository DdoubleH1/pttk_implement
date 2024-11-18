<%@ page import="hoangdh.dev.pttk_implement.model.Manager" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manager Home Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #ffffff;
            border: 1px solid #88B7A4;
            padding: 40px;
            border-radius: 5px;
            width: 600px;
            text-align: center;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333333;
            margin-bottom: 30px;
            font-size: 32px;
        }

        p {
            color: #666666;
            margin: 20px 0;
            font-size: 18px;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
            margin-top: 30px;
        }

        .button {
            background-color: #88B7A4;
            color: #ffffff;
            padding: 15px 30px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 18px;
        }

        .button:hover {
            background-color: #76A18E;
        }
    </style>
    <%
        Manager manager = (Manager) session.getAttribute("Manager");
    %>
</head>
<body>
<div class="container">
    <h1>Manager Home Page</h1>
    <p>Welcome Manager <%= manager.getFullName() %></p>
    <div class="button-container">
        <button class="button" onclick="window.location.href='schedule/createWorkingSchedule.jsp'">Create Working Schedule</button>
        <button class="button" onclick="window.location.href='salary/processSalaryPayment.jsp'">Process Salary Payment</button>
    </div>
</div>
</body>
</html>