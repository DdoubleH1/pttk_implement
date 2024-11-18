<%@ page import="hoangdh.dev.pttk_implement.model.RecordedShift" %>
<%@ page import="hoangdh.dev.pttk_implement.control.RecordedShiftDAO" %>
<%@ page import="hoangdh.dev.pttk_implement.model.SalarySlip" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.format.TextStyle" %>
<%@ page import="hoangdh.dev.pttk_implement.control.RegisteredShiftDAO" %>
<%@ page import="hoangdh.dev.pttk_implement.model.RegisteredShift" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modify Salary Information</title>
    <style>
        :root {
            --primary-color: #88B7A4;
            --primary-hover: #79a694;
            --primary-light: #e8f0ed;
            --text-dark: #2c3e50;
        }

        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #fafafa;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);

        }

        h1 {
            text-align: center;
            color: var(--text-dark);
            margin-bottom: 30px;
        }

        .date {
            text-align: center;
            margin-bottom: 30px;
            color: var(--primary-color);
            font-weight: 500;
        }

        .form-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .form-group {
            flex: 1;
            margin: 0 10px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: var(--text-dark);
            font-weight: 500;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 4px;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(136, 183, 164, 0.2);
        }

        .center-input {
            width: 50%;
            margin: 20px auto;
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 35px;
            border: 2px solid var(--primary-color);
            border-radius: 4px;
            background-color: #fff;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            font-size: 15px;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--primary-hover);
            border-color: var(--primary-hover);
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }
    </style>
    <%
        int shiftId = Integer.parseInt(request.getParameter("shiftId"));
        RecordedShiftDAO recordedShiftDAO = new RecordedShiftDAO();
        RecordedShift recordedShift = recordedShiftDAO.getRecordedShiftById(shiftId);
        List<RecordedShift> recordedShifts = (List<RecordedShift>) session.getAttribute("recordedShifts");
        String date = recordedShift.getWorkingShift().getDate();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.parse(date, formatter);
        String dayOfWeek = localDate.getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.ENGLISH);
        String checkIn = recordedShift.getWorkingShift().getShift().getStartTime();
        String checkOut = recordedShift.getWorkingShift().getShift().getEndTime();
        float hoursOT = recordedShift.getHoursOfOvertime();
        float hoursLateEarly = recordedShift.getHoursOfCompensation();
        float score = recordedShift.getRatingScore();
        float bonus;
        if (recordedShift.getSalarySlip() == null) {
            bonus = 0;
        } else {
            bonus = recordedShift.getSalarySlip().getBonus();
        }
    %>
</head>
<body>
<div class="container">
    <h1>Modify Salary Information</h1>

    <div class="date">
        <span><%= dayOfWeek + " - " + date %></span>
    </div>

    <form action="modifySalaryInformation.jsp?shiftId=<%=shiftId%>" method="post">
        <div class="form-row">
            <div class="form-group">
                <label for="checkIn">Check-in</label>
                <input type="text" id="checkIn" name="checkIn" value="<%= checkIn %>">
            </div>

            <div class="form-group">
                <label for="checkOut">Check-out</label>
                <input type="text" id="checkOut" name="checkOut" value="<%= checkOut %>">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="hoursOT">Hours of OT</label>
                <input type="number" id="hoursOT" name="hoursOT" value="<%= hoursOT %>">
            </div>

            <div class="form-group">
                <label for="hoursLateEarly">Hours of come late and leave early</label>
                <input type="number" id="hoursLateEarly" name="hoursLateEarly" value="<%= hoursLateEarly %>">
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label for="score">Score</label>
                <input type="number" id="score" name="score" value="<%= score %>">
            </div>

            <div class="form-group">
                <label for="bonus">Bonus</label>
                <input type="number" id="bonus" name="bonus" value="<%= bonus %>">
            </div>
        </div>

        <div class="button-container">
            <button type="submit" class="btn btn-primary">Save</button>
        </div>
    </form>
</div>
</body>
</html>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        checkIn = request.getParameter("checkIn");
        checkOut = request.getParameter("checkOut");
        hoursOT = Float.parseFloat(request.getParameter("hoursOT"));
        hoursLateEarly = Float.parseFloat(request.getParameter("hoursLateEarly"));
        score = Float.parseFloat(request.getParameter("score"));
        RegisteredShiftDAO registeredShiftDAO = new RegisteredShiftDAO();
        RegisteredShift registeredShift = registeredShiftDAO.getRegisteredShiftById(recordedShift.getId());
        RecordedShift updatedRecordedShift = new RecordedShift(registeredShift, checkIn, checkOut, hoursOT, hoursLateEarly, score, recordedShift.getIsPaid(), recordedShift.getPatientProfiles(), recordedShift.getSalarySlip());
        recordedShifts.set(recordedShifts.indexOf(recordedShift), updatedRecordedShift);
        session.setAttribute("recordedShifts", recordedShifts);
        response.sendRedirect("doctorDetailSalary.jsp?doctorId=" + registeredShift.getDoctor().getId() + "&isEdited=true");
    }
%>