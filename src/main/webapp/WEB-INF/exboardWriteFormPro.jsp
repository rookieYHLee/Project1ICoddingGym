<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.exboardDAO" %>
<%@ page import="icg.exboardBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
%>


	<jsp:useBean id="eBean" class="icg.exboardBean">
		<jsp:setProperty name="eBean" property="*" />
	</jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");

	exboardDAO edao = new exboardDAO();
	edao.insertBoard(eBean);
	
	response.sendRedirect("main.jsp?center=exboardList.jsp");
	
%>
</body>
</html>