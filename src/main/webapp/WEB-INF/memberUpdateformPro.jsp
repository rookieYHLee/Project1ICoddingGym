<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.memberDAO" %>  
<%@ page import="icg.memberBean" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 수정 구현</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<jsp:useBean id="mBean" class="icg.memberBean">
		<jsp:setProperty name="mBean" property="*"/>
	</jsp:useBean>

<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	memberDAO mdao = new memberDAO();
	String pass = mdao.getPassword(id);
	
	if(pass.equals(password)){
		mdao.updatemember(mBean);
		
		response.sendRedirect("main.jsp");
	}else{
%>
	<script type="text/javascript">
		alert("비밀번호가 틀립니다. 확인해 주세요.")
		history.back();//go(-1);
	</script>
<% } %>
</body>
</html>