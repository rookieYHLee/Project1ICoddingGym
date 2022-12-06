<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>    
	<%@ page import="icg.memberDAO" %> 
	<%@ page import="icg.memberBean" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");


	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	session.setAttribute("id", id);
	session.setAttribute("password", password);
	
	session.setMaxInactiveInterval(60*60*24*365);

%>
<jsp:useBean id="mBean" class="icg.memberBean">
		<jsp:setProperty name="mBean" property="*"/>
	</jsp:useBean>
<%
	
	memberDAO mdao = new memberDAO();
	memberBean bBean = new memberBean();
	
	mBean.setCitizennum(request.getParameter("citizennum1"), request.getParameter("citizennum2"));

	mdao.insertmember(mBean);
%>
<% 
response.getWriter().print("<script>alert('회원가입 완료! 메인화면으로 이동합니다.'); location.href='main.jsp';</script>");
%>



</body>
</html>