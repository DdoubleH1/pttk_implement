<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 11/12/2024
  Time: 10:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Doctor" %>
<%
    Doctor doctor = (Doctor) session.getAttribute("loggedInDoctor");

%>
<!DOCTYPE html>
<html>
<head>
    <title>Doctor Home Page</title>
</head>
<body>
<h1>Welcome Dr. <%= doctor.getFullName() %></h1>
<p>Specialization: <%= doctor.getDescription() %></p>
<p>Years of Experience: <%= doctor.getYearOfExperience() %></p>
<p>Shift Salary: <%= doctor.getShiftSalary() %></p>
</body>
</html>
