<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>๋ก๊ทธ์์</title>
</head>
<body>
	
	<%
		session.setMaxInactiveInterval(0);
		session.invalidate();
	%>
	<script> location.href="main.jsp" </script>
	 
	
</body>
</html>