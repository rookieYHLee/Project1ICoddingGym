<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.exboardDAO" %>
<%@ page import="icg.exboardBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="eBean" class="icg.exboardBean">
	<jsp:setProperty name="eBean" property="*"/>
</jsp:useBean>
<%
    	
	exboardDAO edao = new exboardDAO();
		
	edao.updateBoard(eBean);
%>
	<script type="text/javascript">
		alert("수정이 완료되었습니다.");
		location.href="main.jsp?center=exboardList.jsp";
	</script>
</body>
</html>