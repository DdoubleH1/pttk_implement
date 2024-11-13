<%@ page import="hoangdh.dev.pttk_implement.model.Member" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Doctor" %>
<%@ page import="hoangdh.dev.pttk_implement.model.Manager" %>
<%@ page import="hoangdh.dev.pttk_implement.control.MemberDAO" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Member member = new Member(null, username, password, null, null, null, null, null, null);
    MemberDAO memberDAO = new MemberDAO();
    Object loggedInMember = memberDAO.checkLogin(member);

    if (loggedInMember != null) {
        if (loggedInMember instanceof Doctor doctor) {
            session.setAttribute("loggedInDoctor", doctor);
            response.sendRedirect("DoctorHomePage.jsp");
        } else if (loggedInMember instanceof Manager manager) {
            session.setAttribute("loggedInManager", manager);
            response.sendRedirect("ManagerHomePage.jsp");
        } else {
            System.out.println("Invalid username or password.");
        }
    } else {
        System.out.println("Invalid username or password.");
    }
%>