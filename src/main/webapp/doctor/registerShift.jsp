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

    <%
        List<RegisteredShift> registeredShifts;
        Doctor doctor = (Doctor) session.getAttribute("Doctor");
        String addParam = request.getParameter("isAdded");
        String updateParam = request.getParameter("isEdited");
        String errorParam = request.getParameter("error");
        String deleteParam = request.getParameter("shiftID");
        if ((addParam != null && addParam.equals("true")) || (updateParam != null && updateParam.equals("true")) || (deleteParam != null)) {
            registeredShifts = (List<RegisteredShift>) session.getAttribute("registeredShifts");
            if (deleteParam != null) {
                RegisteredShiftDAO registeredShiftDAO = new RegisteredShiftDAO();
                if (registeredShiftDAO.getRegisteredShiftById(Integer.parseInt(deleteParam)) != null) {
                    //show message
                    boolean result = registeredShiftDAO.deleteRegisteredShift(Integer.parseInt(deleteParam), doctor.getId());
                    if (result) {
                        //show message
                        for (int i = 0; i < registeredShifts.size(); i++) {
                            if (registeredShifts.get(i).getWorkingShift().getId() == Integer.parseInt(deleteParam)) {
                                registeredShifts.remove(i);
                                break;
                            }
                        }
    %>
    <script>alert('Shift deleted successfully.')</script>
    <%
    } else {
    %>
    <script>alert('Delete failed. Error occurred!')</script>
    <%
            response.sendRedirect("registerShift.jsp?error=1");
        }
    } else {
        for (int i = 0; i < registeredShifts.size(); i++) {
            if (registeredShifts.get(i).getWorkingShift().getId() == Integer.parseInt(deleteParam)) {
                registeredShifts.remove(i);
                break;
            }
        }
    %>
    <script>alert('Shift deleted successfully.')</script>
    <%
                }

            }
        } else {

            RegisteredShiftDAO registeredShiftDAO = new RegisteredShiftDAO();
            registeredShifts = registeredShiftDAO.getRegisteredShiftsByDoctorId(doctor.getId());
            session.setAttribute("registeredShifts", registeredShifts);
        }
        //sort registeredShifts by date from earliest to latest and by shift id
        registeredShifts.sort(Comparator.comparing(RegisteredShift::getWorkingShift, Comparator.comparing(WorkingShift::getDate)).thenComparing(RegisteredShift::getWorkingShift, Comparator.comparing(WorkingShift::getShift, Comparator.comparing(Shift::getId))));
    %>

    <%
        if (registeredShifts.isEmpty()) {
    %>
    <p>You have not registered any shift yet.</p>
    <%
    } else {
    %>
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
            <%
                if (!shift.getIsScheduled()) {
            %>
            <td><span class="edit-icon"
                      onclick="window.location.href='modifyShift.jsp?shiftID=<%= shift.getWorkingShift().getId() %>'">✏️</span>
            </td>
            <td><span class="delete-icon" onclick="confirmDelete('<%= shift.getWorkingShift().getId() %>')">🗑️</span>
            </td>
            <%
            } else {
            %>
            <td></td>
            <td></td>
            <%
                }
            %>


        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
        }
    %>

    <div class="total-shifts">
        Total shifts: <%= registeredShifts.size() %>
    </div>

    <div class="action-buttons">
        <button class="register-shift" onclick="window.location.href='registerNewShift.jsp'">Register shift</button>
    </div>

    <button id="saveButton" class="save-button" onclick="window.location.href='doSave.jsp'">Save registration</button>
</div>

<script>
    <% if (errorParam != null && errorParam.equals("1")) { %>
    alert("An error occurred. Please try again.");
    <% } %>

    window.onload = function () {
        const registeredShifts = <%= registeredShifts.size() %>;
        const saveButton = document.getElementById('saveButton');
        if (registeredShifts === 0) {
            saveButton.disabled = true;
            saveButton.style.backgroundColor = '#ccc';
            saveButton.style.color = '#666';
            saveButton.style.cursor = 'not-allowed';
        }
    };

    function confirmDelete(shiftID) {
        if (confirm('Are you sure you want to delete this shift?')) {
            window.location.href = 'registerShift.jsp?shiftID=' + shiftID;
        }
    }
</script>
</body>
</html>