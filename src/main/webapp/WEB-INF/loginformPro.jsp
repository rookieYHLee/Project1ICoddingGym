<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="icg.memberDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리 중</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	memberDAO mdao = new memberDAO();
	
	int check = mdao.userCheck(id, password);
	
	if(check==1){
	session.setAttribute("id", id);
	session.setAttribute("password", password);
	
	session.setMaxInactiveInterval(60*30);
	
	response.sendRedirect("main.jsp");
	}else if(check==0){%>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%}else{ %>
<script>
	alert("아이디가 맞지 않습니다.");
	history.go(-1);
</script>
<%} %>
</body>
</html>