<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="icg.boardDAO" %>
<%@ page import="icg.boardBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 저장</title>
</head>
<body>

<jsp:useBean id="bBean" class="icg.boardBean">
	<jsp:setProperty name="bBean" property="*"/>
</jsp:useBean>
<%
	
	
	boardDAO bdao = new boardDAO();
	bdao.insertBoard(bBean);
	
%>
<script type="text/javascript">
		alert("작성이 완료되었습니다.");
		location.href="main.jsp?center=boardList.jsp";
	</script>
</body>
</html>