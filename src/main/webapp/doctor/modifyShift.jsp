<%@ page import="hoangdh.dev.pttk_implement.model.WorkingShift" %>
<%@ page import="java.util.List" %>
<%@ page import="hoangdh.dev.pttk_implement.control.WorkingShiftDAO" %>
<%@ page import="hoangdh.dev.pttk_implement.model.RegisteredShift" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Doctor" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Shift" %>
<%@ page import="hoangdh.dev.pttk_implement.control.ShiftDAO" %>
<%@ page import="org.hibernate.jdbc.Work" %>
<%@ page import="hoangdh.dev.pttk_implement.control.RegisteredShiftDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modify Shift</title>
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
            background: #fff;
            padding: 50px;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px; /* Add border-radius */
            display: inline-block; /* Ensure it wraps content */
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
        }

        select {
            width: 100%;
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .save-button {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            background: #88B7A4; /* Primary theme color */
            color: white;
            cursor: pointer;
            border-radius: 4px; /* Add border-radius */
            transition: background-color 0.3s ease;
        }

        .save-button:hover {
            background-color: #76A18E; /* Darker shade of primary theme color */
        }

        .save-button:disabled {
            background-color: #ccc;
            color: #666;
            cursor: not-allowed;
            border: 1px solid #999;
        }
    </style>
    <%
        Integer modifyShift = Integer.valueOf(request.getParameter("shiftID"));
        // save id to sesion
        session.setAttribute("modifyShift", modifyShift.toString());
    %>
</head>
<body onload="checkShiftSelection()">
<div class="container">
    <h1>Modify Shift</h1>

    <form action="modifyShift.jsp?shiftID=<%= modifyShift%>" method="post">
        <div class="form-group">
            <label for="workingShift">Working Shift:</label>
            <select id="workingShift" name="workingShift" onchange="checkShiftSelection()">
                <%

                    List<WorkingShift> workingShifts = (List<WorkingShift>) session.getAttribute("workingShifts");
                    List<RegisteredShift> registeredShifts = (List<RegisteredShift>) session.getAttribute("registeredShifts");
                    if (workingShifts == null || workingShifts.isEmpty()) {
                        WorkingShiftDAO workingShiftDAO = new WorkingShiftDAO();
                        workingShifts = workingShiftDAO.getAllWorkingShifts();
                        session.setAttribute("workingShifts", workingShifts);
                    }
                    WorkingShift selectedWorkingShift = workingShifts.stream()
                            .filter(ws -> ws.getId().equals(modifyShift))
                            .findFirst()
                            .orElse(null);

                    String selectedShift = selectedWorkingShift.getDate() + ", " + selectedWorkingShift.getShift().getStartTime() + "-" + selectedWorkingShift.getShift().getEndTime();

                    if (registeredShifts == null) {
                        registeredShifts = new ArrayList<>();
                        session.setAttribute("registeredShifts", registeredShifts);
                    }
                    List<WorkingShift> availableWorkingShifts = new ArrayList<>(workingShifts);
                    for (RegisteredShift registeredShift : registeredShifts) {
                        availableWorkingShifts.removeIf(ws -> ws.getId().equals(registeredShift.getWorkingShift().getId()));
                    }
                    availableWorkingShifts.add(0, selectedWorkingShift);
                    for (WorkingShift workingShift : availableWorkingShifts) {
                        String optionValue = workingShift.getDate() + ", " + workingShift.getShift().getStartTime() + "-" + workingShift.getShift().getEndTime();
                %>
                <option value="<%= optionValue %>">
                    <%= optionValue %>
                </option>
                <% } %>
            </select>
        </div>

        <button id="saveButton" type="submit" class="save-button">Save</button>
    </form>

    <%

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String workingShiftParam = request.getParameter("workingShift");
            if (workingShiftParam != null && !workingShiftParam.isEmpty()) {
                String[] parts = workingShiftParam.split(", ");
                String date = parts[0];
                String[] timeParts = parts[1].split("-");
                String startTime = timeParts[0];
                String endTime = timeParts[1];

                ShiftDAO shiftDAO = new ShiftDAO();
                Shift shift = shiftDAO.getShiftByTime(startTime, endTime);
                if (shift != null) {
                    // Use the shift object as needed
                    WorkingShiftDAO workingShiftDAO = new WorkingShiftDAO();
                    WorkingShift workingShift = workingShiftDAO.getWorkingShiftByDateAndTime(date, shift.getStartTime(), shift.getEndTime());
                    if (workingShift != null) {
                        // Use the workingShift object as needed
                        RegisteredShiftDAO registeredShiftDAO = new RegisteredShiftDAO();
                        Boolean editResult = registeredShiftDAO.updateRegisteredShift(modifyShift, workingShift.getId());
                        if (editResult) {
                            // Update the registeredShifts list in the session
                            for(RegisteredShift registeredShift : registeredShifts) {
                                if (registeredShift.getWorkingShift().getId().equals(modifyShift)) {
                                    registeredShift.setWorkingShift(workingShift);
                                    break;
                                }
                            }
                            session.setAttribute("registeredShifts", registeredShifts);
    %>
    <script>
        alert("Shift modified successfully!");
        window.location.href = "registerShift.jsp?isEdited=true"; </script>
    <%

                        } else {
                            // Handle the case where the working shift does not exist
                            response.sendRedirect("registerShift.jsp?error=1");
                        }

                    } else {
                        // Handle the case where the working shift does not exist
                        response.sendRedirect("registerShift.jsp?error=1");
                    }

                } else {
                    // Handle the case where the shift does not exist
                    response.sendRedirect("registerShift.jsp?error=1");
                }
            } else {
                // Handle the case where the working shift is not selected
                response.sendRedirect("registerShift.jsp?error=1");

            }
        }

    %>

    <script>
        function checkShiftSelection() {
            const selectedShift = document.getElementById('workingShift').value;
            const modifyShift = "<%= selectedShift %>";
            const saveButton = document.getElementById('saveButton');
            saveButton.disabled = selectedShift === modifyShift;
        }
    </script>


</div>
</body>
</html>