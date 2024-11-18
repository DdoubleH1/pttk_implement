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
<%@ page import="static java.awt.SystemColor.window" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register New Shift</title>
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
    </style>
</head>
<body>
<div class="container">
    <h1>Register New Shift</h1>

    <form action="registerNewShift.jsp" method="post">
        <div class="form-group">
            <label for="workingShift">Working Shift:</label>
            <select id="workingShift" name="workingShift">
                <%
                    //get all working shift that doctor have not registered
                    List<WorkingShift> workingShifts = (List<WorkingShift>) session.getAttribute("workingShifts");
                    List<RegisteredShift> registeredShifts = (List<RegisteredShift>) session.getAttribute("registeredShifts");
                    if (workingShifts == null || workingShifts.isEmpty()) {
                        WorkingShiftDAO workingShiftDAO = new WorkingShiftDAO();
                        workingShifts = workingShiftDAO.getAllWorkingShifts();
                        // save to session
                        session.setAttribute("workingShifts", workingShifts);
                    }
                    if (registeredShifts == null) {
                        registeredShifts = new ArrayList<>();
                        session.setAttribute("registeredShifts", registeredShifts);
                    }
                    List<WorkingShift> availableWorkingShifts = new ArrayList<>(workingShifts);
                    for (RegisteredShift registeredShift : registeredShifts) {
                        availableWorkingShifts.removeIf(ws -> ws.getId().equals(registeredShift.getWorkingShift().getId()));
                    }
                    for (WorkingShift workingShift : availableWorkingShifts) {
                %>
                <option value="<%= workingShift.getId() %>">
                    <%= workingShift.getDate() + ", " + workingShift.getShift().getStartTime() + "-" + workingShift.getShift().getEndTime() %>
                </option>
                <% } %>
            </select>
        </div>

        <button type="submit" class="save-button">Save</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String workingShiftParam = request.getParameter("workingShift");
            if (workingShiftParam != null && !workingShiftParam.isEmpty()) {
                WorkingShiftDAO workingShiftDAO = new WorkingShiftDAO();
                WorkingShift workingShift = workingShiftDAO.getWorkingShiftById(Integer.parseInt(workingShiftParam));
                if (workingShift != null) {
                    // Use the workingShift object as needed
                    Doctor doctor = (Doctor) session.getAttribute("Doctor");
                    //create new registered shift and add to list
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    LocalDateTime now = LocalDateTime.now();
                    RegisteredShift registeredShift = new RegisteredShift(null, formatter.format(now), false, doctor, workingShift, null);
                    registeredShifts.add(registeredShift);
                    session.setAttribute("registeredShifts", registeredShifts);
                    response.sendRedirect("registerShift.jsp?isAdded=true");
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
                // Handle the case where the shift does not exist
                response.sendRedirect("registerShift.jsp?error=1");
            }
        }
    %>
</div>
</body>
</html>