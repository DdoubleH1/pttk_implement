<%@ page import="hoangdh.dev.pttk_implement.control.DoctorDAO" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Doctor" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 11/17/2024
  Time: 8:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Process Salary Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f5f5f5;
        }

        .container {
            text-align: center;
            width: 60%;
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table, th, td {
            border: 1px solid #000;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #88B7A4; /* Use your primary color */
            color: #fff;
        }

        tr:hover {
            background-color: #f1f1f1;
            cursor: pointer;
        }

        .buttons {
            margin-top: 20px;
        }

        button {
            padding: 10px 20px;
            margin: 0 10px;
            border: none;
            background-color: #88B7A4;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: #6b9b85;
        }
    </style>
    <script>
        function navigateToDetails(doctorId) {
            // Redirect to another page with the doctor ID as a query parameter
            window.location.href = "doctorDetailSalary.jsp?doctorId=" + doctorId;
        }
    </script>
    <%
        DoctorDAO doctorDAO = new DoctorDAO();
        List<Doctor> doctors = doctorDAO.getAllDoctors();
    %>
</head>
<body>
<div class="container">
    <h1>Process Salary Payment</h1>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
        </tr>
        </thead>
        <tbody>
        <% for (Doctor doctor : doctors) { %>
        <tr onclick="navigateToDetails(<%= doctor.getId() %>)">
            <td><%= doctor.getId() %>
            </td>
            <td><%= doctor.getFullName() %>
            </td>
            <td><%= doctor.getEmail() %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>


