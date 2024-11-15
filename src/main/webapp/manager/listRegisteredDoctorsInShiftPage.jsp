<%@ page import="java.util.List" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Doctor" %>
<%@ page import="hoangdh.dev.pttk_implement.control.DoctorDAO" %>
<%@ page import="hoangdh.dev.pttk_implement.control.RoomDAO" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Room" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="hoangdh.dev.pttk_implement.model.RegisteredShift" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>List Registered Doctors</title>
    <style>
        /* Basic styles for the table and buttons */
        /* Center entire content */
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f9f9f9;
        }

        /* Container styling */
        .container {
            width: 80%;
            max-width: 900px;
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th {
            background-color: #4F6D7A;
            color: #ffffff;
            padding: 10px;
            font-weight: bold;
        }

        td {
            background-color: #ffffff;
            padding: 8px;
            text-align: center;
            color: #333333;
        }

        th, td {
            border: 1px solid #CCCCCC;
        }

        /* Button container */
        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        /* Button styles */
        button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            background-color: #88B7A4;
            color: #ffffff;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #4F6D7A;
        }

    </style>
    <script>
        function validateForm() {
            const approvedCheckboxes = document.querySelectorAll('input[name^="approve_"]:checked');
            const selectedRooms = new Set();

            if (approvedCheckboxes.length > 4) {
                alert("Only 4 doctors can be approved per shift.");
                return false;
            }

            for (let checkbox of approvedCheckboxes) {
                const doctorId = checkbox.name.split('_')[1];
                const roomSelect = document.querySelector('select[name="room_' + doctorId + '"]');
                if (selectedRooms.has(roomSelect.value)) {
                    alert("Each room can only be assigned to one doctor per shift.");
                    return false;
                }
                selectedRooms.add(roomSelect.value);
            }
            return true;
        }
    </script>
</head>
<body>

<div class="container">
    <h2 style="text-align: center;">List Registered Doctors</h2>
    <%
        String shiftID = request.getParameter("shiftId");
        session.setAttribute("shiftId", shiftID);
    %>
    <form action="listRegisteredDoctorsInShiftPage.jsp?shiftId=<%= shiftID%>" method="post"
          onsubmit="return validateForm()">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Room</th>
                <th>Approve</th>
            </tr>
            </thead>
            <tbody>
            <%

                DoctorDAO doctorDAO = new DoctorDAO();
                List<Doctor> doctors = doctorDAO.getDoctorsInShift(Integer.parseInt(shiftID));
                if (doctors != null && !doctors.isEmpty()) {
                    for (Doctor doctor : doctors) {
            %>
            <tr>
                <td><%= doctor.getId() %>
                </td>
                <td><%= doctor.getFullName() %>
                </td>
                <td><%= doctor.getEmail() %>
                </td>
                <td>
                    <%
                        RoomDAO roomDAO = new RoomDAO();
                        List<Room> room = roomDAO.getRooms();
                    %>
                    <select name="room_<%= doctor.getId() %>">
                        <%
                            for (Room r : room) {
                        %>
                        <option value="<%= r.getId() %>"><%= r.getName() %>
                        </option>
                        <%
                            }
                        %>
                    </select>
                </td>
                <td><input type="checkbox" name="approve_<%= doctor.getId() %>"></td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>

        <div class="button-container">
            <button type="submit" name="confirm">Confirm</button>
        </div>
    </form>
</div>
</body>
</html>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        List<RegisteredShift> registeredShifts = (List<RegisteredShift>) session.getAttribute("registeredShifts");
        RoomDAO roomDAO = new RoomDAO();
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            if (paramName.startsWith("approve_")) {
                String doctorId = paramName.split("_")[1];
                for (RegisteredShift rs : registeredShifts) {
                    if (rs.getDoctor().getId().equals(Integer.parseInt(doctorId)) && rs.getWorkingShift().getId() == Integer.parseInt(shiftID)) {
                        rs.setIsScheduled(true);
                    }
                }
            }
            if (paramName.startsWith("room_")) {
                String doctorId = paramName.split("_")[1];
                String roomID = request.getParameter(paramName);
                Room room = roomDAO.getRoomById(Integer.parseInt(roomID));
                for (RegisteredShift rs : registeredShifts) {
                    if (rs.getDoctor().getId().equals(Integer.parseInt(doctorId)) && rs.getWorkingShift().getId() == Integer.parseInt(shiftID)) {
                        rs.setRoom(room);
                    }
                }
            }
        }
        session.setAttribute("registeredShifts", registeredShifts);
        response.sendRedirect("createWorkingSchedule.jsp");
    }
%>