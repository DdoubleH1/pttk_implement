<%@ page import="hoangdh.dev.pttk_implement.control.RecordedShiftDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="hoangdh.dev.pttk_implement.model.RecordedShift" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.TextStyle" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.time.temporal.WeekFields" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="hoangdh.dev.pttk_implement.model.SalarySlip" %>
<%@ page import="hoangdh.dev.pttk_implement.control.DoctorDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Doctor Detail Salary</title>
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
            width: 90%;
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table, th, td {
            border: 1px solid #000;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #88B7A4;
            color: #fff;
        }

        .total-salary {
            text-align: right;
            margin-top: 10px;
            font-size: 18px;
            font-weight: bold;
        }

        .buttons {
            text-align: center;
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

        .edit-icon {
            cursor: pointer;
        }

    </style>
    <script>
        function saveChanges() {
            const checkboxes = document.querySelectorAll('input[type="checkbox"][name^="pay_"]');
            const isChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);
            if (!isChecked) {
                alert('Please select at least one shift to pay.');
                return false;
            }
            document.getElementById("salaryForm").submit();
        }
    </script>
    <%
        String doctorId = request.getParameter("doctorId");
        DoctorDAO doctorDAO = new DoctorDAO();
        session.setAttribute("Doctor", doctorDAO.getDoctorById(Integer.parseInt(doctorId)));
        String editParam = request.getParameter("isEdited");
        List<RecordedShift> recordedShifts;
        RecordedShiftDAO recordedShiftDAO = new RecordedShiftDAO();
        if (editParam != null && editParam.equals("true")) {
            recordedShifts = (List<RecordedShift>) session.getAttribute("recordedShifts");
        } else {
            recordedShifts = recordedShiftDAO.getRecordedShiftsByDoctorId(Integer.parseInt(doctorId));
            session.setAttribute("recordedShifts", recordedShifts);
        }


        LocalDate today = LocalDate.now();
        LocalDate nextMonday = today.plusDays((DayOfWeek.MONDAY.getValue() - today.getDayOfWeek().getValue() + 7) % 7);
        LocalDate nextSunday = nextMonday.plusDays(6);  // End of the next week

        List<RecordedShift> currentWeekShifts = recordedShifts.stream()
                .filter(recordedShift -> {
                    LocalDate date = LocalDate.parse(recordedShift.getWorkingShift().getDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    return date.isAfter(nextMonday.minusDays(1)) && date.isBefore(nextSunday.plusDays(1));
                })
                .collect(Collectors.toList());

        List<RecordedShift> previousWeeksShifts = recordedShifts.stream()
                .filter(recordedShift -> {
                    LocalDate date = LocalDate.parse(recordedShift.getWorkingShift().getDate(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    return date.isBefore(nextMonday.minusDays(1));
                })
                .collect(Collectors.toList());
    %>
</head>
<body>
<div class="container">
    <h1>Doctor Detail Salary</h1>
    <%
        if (recordedShifts.isEmpty()) {
    %>
    <p>No recorded shifts available for this doctor.</p>
    <%
    } else {
    %>
    <form action="doSave.jsp" method="post" onsubmit="return saveChanges();">
    <h2>Current Week</h2>
        <table>
            <thead>
            <tr>
                <th>Day</th>
                <th>Date</th>
                <th>Check-in</th>
                <th>Checkout</th>
                <th>Shift salary</th>
                <th>Hours of OT</th>
                <th>OT salary</th>
                <th>Hours of late and leave early</th>
                <th>Fines</th>
                <th>Score</th>
                <th>Number of patients</th>
                <th>Bonus</th>
                <th>Total salary</th>
                <th>Edit</th>
                <th>Pay</th>
            </tr>
            </thead>
            <tbody>
            <%
                double totalSalaryCurrentWeek = 0.0;
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                for (RecordedShift recordedShift : currentWeekShifts) {
                    LocalDate date = LocalDate.parse(recordedShift.getWorkingShift().getDate(), formatter);
                    double shiftSalary = recordedShift.getDoctor().getShiftSalary();
                    double overtimeSalary = recordedShift.getHoursOfOvertime() * shiftSalary * 1.5;
                    double fines = recordedShift.getHoursOfCompensation() * shiftSalary;
                    double bonus = recordedShift.getRatingScore() * 10;
                    double totalShiftSalary = shiftSalary * 4 + overtimeSalary - fines + bonus;
                    totalSalaryCurrentWeek += totalShiftSalary;
            %>
            <tr>
                <td><%= date.getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.ENGLISH) %>
                </td>
                <td><%= recordedShift.getWorkingShift().getDate() %>
                </td>
                <td><%= recordedShift.getWorkingShift().getShift().getStartTime() %>
                </td>
                <td><%= recordedShift.getWorkingShift().getShift().getEndTime() %>
                </td>
                <td><%= shiftSalary %>
                </td>
                <td><%= recordedShift.getHoursOfOvertime() %>
                </td>
                <td><%= overtimeSalary %>
                </td>
                <td><%= recordedShift.getHoursOfCompensation() %>
                </td>
                <td><%= fines %>
                </td>
                <td><%= recordedShift.getRatingScore() %>
                </td>
                <td><%= recordedShift.getPatientProfiles().size() %>
                </td>
                <td><%= bonus %>
                </td>
                <td><%= totalShiftSalary %>
                </td>
                <td><span class="edit-icon"
                          onclick="window.location.href='modifySalaryInformation.jsp?shiftId=' + <%=recordedShift.getId()%>">✏️</span>
                </td>
                <td><input type="checkbox" name="pay_" value="<%= recordedShift.getId() %>"></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <div class="total-salary">
            Total salary of current week: <span id="total-salary-current-week"><%= totalSalaryCurrentWeek %></span>
        </div>

        <%
            if (!previousWeeksShifts.isEmpty()) {
        %>
        <h2>Previous Week</h2>
        <table>
            <thead>
            <tr>
                <th>Day</th>
                <th>Date</th>
                <th>Check-in</th>
                <th>Checkout</th>
                <th>Shift salary</th>
                <th>Hours of OT</th>
                <th>OT salary</th>
                <th>Hours of late and leave early</th>
                <th>Fines</th>
                <th>Score</th>
                <th>Number of patients</th>
                <th>Bonus</th>
                <th>Total salary</th>
                <th>Edit</th>
                <th>Pay</th>
            </tr>
            </thead>
            <tbody>
            <%
                double totalSalaryPreviousWeek = 0.0;
                for (RecordedShift recordedShift : previousWeeksShifts) {
                    LocalDate date = LocalDate.parse(recordedShift.getWorkingShift().getDate(), formatter);
                    double shiftSalary = recordedShift.getDoctor().getShiftSalary();
                    double overtimeSalary = recordedShift.getHoursOfOvertime() * shiftSalary * 1.5;
                    double fines = recordedShift.getHoursOfCompensation() * shiftSalary;
                    double bonus = recordedShift.getRatingScore() * 10;
                    double totalShiftSalary = shiftSalary + overtimeSalary - fines + bonus;
                    totalSalaryPreviousWeek += totalShiftSalary;
            %>
            <tr>
                <td><%= date.getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.ENGLISH) %>
                </td>
                <td><%= recordedShift.getWorkingShift().getDate() %>
                </td>
                <td><%= recordedShift.getWorkingShift().getShift().getStartTime() %>
                </td>
                <td><%= recordedShift.getWorkingShift().getShift().getEndTime() %>
                </td>
                <td><%= shiftSalary %>
                </td>
                <td><%= recordedShift.getHoursOfOvertime() %>
                </td>
                <td><%= overtimeSalary %>
                </td>
                <td><%= recordedShift.getHoursOfCompensation() %>
                </td>
                <td><%= fines %>
                </td>
                <td><%= recordedShift.getRatingScore() %>
                </td>
                <td><%= recordedShift.getPatientProfiles().size() %>
                </td>
                <td><%= bonus %>
                </td>
                <td><%= totalShiftSalary %>
                </td>
                <td><span class="edit-icon"
                          onclick="window.location.href='modifySalaryInformation.jsp?shiftId=' + <%=recordedShift.getId()%>">✏️</span>
                </td>
                <td><input type="checkbox" name="pay_<%= recordedShift.getId() %>" value="<%= recordedShift.getId() %>"></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <div class="total-salary">
            Total salary of previous weeks: <span id="total-salary-previous-week"><%= totalSalaryPreviousWeek %></span>
        </div>
    </form>


    <%
        }
    %>
    <div class="buttons">
        <button type="submit" name="save">Save changes</button>
    </div>
    <%
        }
    %>
</div>
</body>
</html>