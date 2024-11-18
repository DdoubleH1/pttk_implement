<%@ page import="hoangdh.dev.pttk_implement.model.WorkingShift" %>
<%@ page import="hoangdh.dev.pttk_implement.control.WorkingShiftDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="hoangdh.dev.pttk_implement.control.RegisteredShiftDAO" %>
<%@ page import="hoangdh.dev.pttk_implement.model.RegisteredShift" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Working Schedule</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f2f2f2;
        }

        .schedule-container {
            width: 300px;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
            color: #000;
        }

        select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #88B7A4;
            color: white;
            font-size: 16px;
        }

        option {
            color: white;
        }

        .shift-button {
            font-size: 18px; /* Increase font size for start time and end time */
            padding: 10px;
            margin: 5px 0;
            border: none;
            border-radius: 5px;
            background-color: #88B7A4;
            color: white;
            cursor: pointer;
        }

    </style>
    <script>
        function showShifts(date) {
            const shifts = document.getElementsByClassName('shifts');
            for (let i = 0; i < shifts.length; i++) {
                shifts[i].style.display = 'none';
            }
            document.getElementById(date).style.display = 'block';
        }

        function redirectToShift(shiftId) {
            window.location.href = 'listRegisteredDoctorsInShiftPage.jsp?shiftId=' + shiftId;
        }
    </script>
</head>
<body>

<div class="schedule-container">
    <h2>Create Working Schedule</h2>

    <%
        String error = request.getParameter("error");
        if (error != null && error.equals("1")) {
            %>
            <script> alert("An error occurred. Please try again."); </script>
            <%
        }

        List<RegisteredShift> registeredShifts;
        registeredShifts = (List<RegisteredShift>) session.getAttribute("registeredShifts");
        if (registeredShifts == null) {
            RegisteredShiftDAO registeredShiftDAO = new RegisteredShiftDAO();
            registeredShifts = registeredShiftDAO.getAllRegisteredShifts();
            session.setAttribute("registeredShifts", registeredShifts);
        }

        WorkingShiftDAO workingShiftDAO = new WorkingShiftDAO();
        List<WorkingShift> workingShifts = workingShiftDAO.getAllWorkingShifts();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        Map<LocalDate, List<WorkingShift>> shiftsByDate = workingShifts.stream()
                .collect(Collectors.groupingBy(ws -> LocalDate.parse(ws.getDate(), formatter)));

        // Sort the map by key (date)
        Map<LocalDate, List<WorkingShift>> sortedShiftsByDate = shiftsByDate.entrySet().stream()
                .sorted(Map.Entry.comparingByKey())
                .collect(Collectors.toMap(
                        Map.Entry::getKey,
                        Map.Entry::getValue,
                        (e1, e2) -> e1,
                        LinkedHashMap::new
                ));
    %>

    <select onchange="showShifts(this.value)">
        <option value="">Select a date</option>
        <%
            for (Map.Entry<LocalDate, List<WorkingShift>> entry : sortedShiftsByDate.entrySet()) {
                LocalDate date = entry.getKey();
        %>
        <option value="<%= date %>"><%= date.format(formatter) %>
        </option>
        <%
            }
        %>
    </select>

    <%
        for (Map.Entry<LocalDate, List<WorkingShift>> entry : sortedShiftsByDate.entrySet()) {
            LocalDate date = entry.getKey();
            List<WorkingShift> shifts = entry.getValue();
    %>
    <div id="<%= date %>" class="shifts" style="display: none;">
        <%
            for (WorkingShift shift : shifts) {
        %>
        <button class="shift-button" onclick="redirectToShift(<%= shift.getId() %>)">
            <%= shift.getShift().getStartTime() %> - <%= shift.getShift().getEndTime() %>
        </button>
        <%
            }
        %>
    </div>
    <%
        }
    %>

    <button class="shift-button" onclick="window.location.href='doSave.jsp'" name="save">Save</button>


</div>

</body>
</html>
