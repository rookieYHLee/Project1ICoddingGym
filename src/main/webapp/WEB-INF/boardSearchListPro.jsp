<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String WorT = request.getParameter("WorT");
	String what = request.getParameter("what");
%>
<script>
	location.href="main.jsp?center=boardSearchList.jsp?WorT=<%=WorT%>&what=<%=what%>";
</script>
</body>
</html>