<%@ page import="hoangdh.dev.pttk_implement.model.RegisteredShift" %>
<%@ page import="java.util.List" %>
<%@ page import="hoangdh.dev.pttk_implement.control.RegisteredShiftDAO" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Doctor" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="hoangdh.dev.pttk_implement.model.WorkingShift" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Shift" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Shift</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }

        .container {
            text-align: center;
            width: 60%;
            background: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        button {
            padding: 8px 16px;
            font-size: 14px;
            border: 1px solid #333;
            background: #fff;
            cursor: pointer;
            border-radius: 8px;
        }

        button:hover {
            background-color: #f0f0f0;
        }

        .save-button {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
        }

        .edit-icon {
            font-size: 16px;
            cursor: pointer;
        }

        .delete-icon {
            font-size: 16px;
            cursor: pointer;
        }

        .total-shifts {
            text-align: right;
            padding: 10px;
            font-size: 14px;
        }

        button.register-shift {
            background-color: #88B7A4;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        button.register-shift:hover {
            background-color: #76A18E;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Register Shift</h1>

    <table>
        <thead>
        <tr>
            <th>No</th>
            <th>Day</th>
            <th>Shift</th>
            <th>Time</th>
            <th>Edit</th>
            <th>Delete</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<RegisteredShift> registeredShifts;
            String updateParam = request.getParameter("isAdded");
            String errorParam = request.getParameter("error");
            if (updateParam != null && updateParam.equals("true")) {
                // Update the registered shift list
                registeredShifts = (List<RegisteredShift>) session.getAttribute("registeredShifts");
            } else {
                Doctor doctor = (Doctor) session.getAttribute("Doctor");
                RegisteredShiftDAO registeredShiftDAO = new RegisteredShiftDAO();
                registeredShifts = registeredShiftDAO.getRegisteredShiftsByDoctorId(doctor.getId());
                session.setAttribute("registeredShifts", registeredShifts);
            }
            //sort registeredShifts by date from earliest to latest and by shift id
            registeredShifts.sort(Comparator.comparing(RegisteredShift::getWorkingShift, Comparator.comparing(WorkingShift::getDate)).thenComparing(RegisteredShift::getWorkingShift, Comparator.comparing(WorkingShift::getShift, Comparator.comparing(Shift::getId))));
            for (int i = 0; i < registeredShifts.size(); i++) {
                RegisteredShift shift = registeredShifts.get(i);
        %>
        <tr>
            <td><%= i + 1 %>
            </td>
            <td><%= shift.getWorkingShift().getDate() %>
            </td>
            <td><%= shift.getWorkingShift().getShift().getId() %>
            </td>
            <td><%= shift.getWorkingShift().getShift().getStartTime() %>
                - <%= shift.getWorkingShift().getShift().getEndTime() %>
            </td>
            <td><span class="edit-icon">✏️</span></td>
            <td><span class="delete-icon">🗑️</span></td>

        </tr>
        <%

            }
        %>
        </tbody>
    </table>

    <div class="total-shifts">
        Total shifts: <%= registeredShifts.size() %>
    </div>

    <div class="action-buttons">
        <button class="register-shift" onclick="window.location.href='registerNewShift.jsp'">Register shift</button>
    </div>

    <button class="save-button" onclick="window.location.href='doSave.jsp'">Save registration</button>
</div>


<script>
    <% if (errorParam != null && errorParam.equals("1")) { %>
    alert("An error occurred while saving the registration. Please try again.");
    <% } %>
</script>
</body>
</html>