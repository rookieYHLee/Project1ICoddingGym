<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import= "icg.boardDAO" %>  
 <%@ page import= "icg.replyDAO" %>  
<%	request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	boardDAO bdao = new boardDAO();
	replyDAO rdao = new replyDAO();
	int num = Integer.parseInt(request.getParameter("b_no"));
	rdao.boardRereplyAllDelete(num);
	bdao.deldeteBoard(num);
%>
	<script type="text/javascript">
		alert("삭제가 완료되었습니다.");
		location.href="main.jsp?center=boardList.jsp";
	</script>
</body>
</html>