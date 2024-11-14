<%@ page import="hoangdh.dev.pttk_implement.control.RegisteredShiftDAO" %>
<%@ page import="hoangdh.dev.pttk_implement.model.RegisteredShift" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: HoangDH3
  Date: 11/14/2024
  Time: 4:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    RegisteredShiftDAO registeredShiftDAO = new RegisteredShiftDAO();
    List<RegisteredShift> registeredShifts = (List<RegisteredShift>) session.getAttribute("registeredShifts");
    if(registeredShifts == null || registeredShifts.isEmpty()){
        response.sendRedirect("registerShift.jsp?error=1");
    }
    boolean result = registeredShiftDAO.saveRegisteredShift(registeredShifts);
    if (result) {
        session.removeAttribute("registeredShifts");
    } else {
        response.sendRedirect("registerShift.jsp?error=1");
    }
%>
<script>
    alert("Register shift successfully!");
    window.location.href = "DoctorHomePage.jsp";
</script>
