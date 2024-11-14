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

        if (loggedInMember instanceof Doctor) {

            session.setAttribute("Doctor", loggedInMember);
            response.sendRedirect("doctor/DoctorHomePage.jsp");
        } else if (loggedInMember instanceof Manager) {
            session.setAttribute("Manager", loggedInMember);
            response.sendRedirect("ManagerHomePage.jsp");
        } else {
            session.setAttribute("loginUsername", username);
            session.setAttribute("loginPassword", password);
            response.sendRedirect("login.jsp?error=1");
        }
%>