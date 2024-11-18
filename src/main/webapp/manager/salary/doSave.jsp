<%@ page import="java.util.Enumeration" %>
<%@ page import="hoangdh.dev.pttk_implement.model.RecordedShift" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="hoangdh.dev.pttk_implement.model.SalarySlip" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Manager" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Doctor" %>
<%@ page import="hoangdh.dev.pttk_implement.control.SalarySlipDao" %>
<%@ page import="static java.awt.SystemColor.window" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 11/17/2024
  Time: 8:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if("Post".equalsIgnoreCase(request.getMethod())){
        Doctor doctor = (Doctor) session.getAttribute("Doctor");
        Manager manager = (Manager) session.getAttribute("Manager");
        List<RecordedShift> recordedShifts = (List<RecordedShift>) session.getAttribute("recordedShifts");
        List<RecordedShift> payRecordedShifts = new ArrayList<>();
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            if(paramName.startsWith("pay")){
                String payShiftId = request.getParameter(paramName);
                RecordedShift payRecordedShift = recordedShifts.stream().filter(rs -> rs.getId() == Integer.parseInt(payShiftId)).findFirst().orElse(null);
                payRecordedShifts.add(payRecordedShift);
            }
        }

        float baseWeekSalary = 0, overtimeSalary = 0, bonus = 0, fines = 0, receivedSalary = 0;
        for (RecordedShift payRecordedShift : payRecordedShifts) {
            baseWeekSalary += payRecordedShift.getDoctor().getShiftSalary() * 4;
            overtimeSalary += (float) (payRecordedShift.getDoctor().getShiftSalary() * payRecordedShift.getHoursOfOvertime() * 1.5);
            bonus += payRecordedShift.getRatingScore() * 10;
            fines += payRecordedShift.getDoctor().getShiftSalary() * payRecordedShift.getHoursOfCompensation();
            receivedSalary += baseWeekSalary + overtimeSalary + bonus - fines;
            payRecordedShift.setIsPaid(true);
        }

        SalarySlip salarySlip = new SalarySlip(null, overtimeSalary, bonus, fines, baseWeekSalary, receivedSalary, payRecordedShifts, doctor, manager);
        SalarySlipDao salarySlipDao = new SalarySlipDao();
        boolean result = salarySlipDao.saveSalarySlip(salarySlip);

        if(result){
            for(RecordedShift payRecordedShift : payRecordedShifts){
                payRecordedShift.setSalarySlip(salarySlip);
            }
            session.removeAttribute("recordedShifts");
            %>
            <script>
                alert("Save successfully!")
                window.location.href = "processSalaryPayment.jsp";
            </script>
            <%
        } else {
            response.sendRedirect("salaryPayment.jsp?error=1");
        }
    }
%>
