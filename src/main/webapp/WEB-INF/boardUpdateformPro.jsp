<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="icg.boardDAO" %>
<%@ page import="icg.boardBean" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 수정 처리</title>
</head>
<body>
<jsp:useBean id="bBean" class="icg.boardBean">
	<jsp:setProperty name="bBean" property="*"/>
</jsp:useBean>
<%
    	
	boardDAO fdao = new boardDAO();
		
	fdao.updateBoard(bBean);
%>
	<script type="text/javascript">
		alert("수정이 완료되었습니다.");
		location.href="main.jsp?center=boardList.jsp";
	</script>
</body>
</html>