<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Member" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Doctor" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Manager" %>
<%@ page import="hoangdh.dev.pttk_implement.control.MemberDAO" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Member member = new Member(null, username, password, null, null, null, null, null, null);
    MemberDAO memberDAO = new MemberDAO();
    Member loggedInMember = memberDAO.checkLogin(member);

    if (loggedInMember != null) {
        if (loggedInMember instanceof Doctor) {
            Doctor doctor = (Doctor) loggedInMember;
            session.setAttribute("loggedInDoctor", doctor);
            response.sendRedirect("DoctorHomePage.jsp");
        } else if (loggedInMember instanceof Manager) {
            Manager manager = (Manager) loggedInMember;
            System.out.println("Login successful! Welcome " + manager.getFullName() + ". Department: " + manager.getDepartment());
        }
    } else {
        System.out.println("Invalid username or password.");
    }
%>