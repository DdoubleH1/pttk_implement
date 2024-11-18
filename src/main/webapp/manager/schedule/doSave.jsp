<%@ page import="hoangdh.dev.pttk_implement.control.RegisteredShiftDAO" %>
<%@ page import="hoangdh.dev.pttk_implement.model.RegisteredShift" %>
<%@ page import="java.util.List" %>
<%@ page import="static java.awt.SystemColor.window" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 11/15/2024
  Time: 11:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    RegisteredShiftDAO registeredShiftDAO = new RegisteredShiftDAO();
    List<RegisteredShift> registeredShifts = (List<RegisteredShift>) session.getAttribute("registeredShifts");
    if (registeredShifts == null || registeredShifts.isEmpty()) {
        response.sendRedirect("createWorkingSchedule.jsp?error=1");
    }
    boolean result = registeredShiftDAO.saveSchedule(registeredShifts);
    if (result) {
        session.removeAttribute("registeredShifts");
        %>
        <script>
            alert("Save successfully!")
            window.location.href = "../managerHomePage.jsp";
        </script>
        <%
    } else {
        response.sendRedirect("createWorkingSchedule.jsp?error=1");
    }
%>
