<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "icg.FAQboardDAO" %>  
<%@ page import= "icg.FAQboardBean"%>
<%	request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
	FAQboardDAO fbdao = new FAQboardDAO();
	int num = Integer.parseInt(request.getParameter("fb_no"));
	
	fbdao.deldeteBoard(num);
%>
	<script type="text/javascript">
		alert("삭제가 완료되었습니다.");
		location.href="main.jsp?center=FAQboardList.jsp";
	</script>
</body>
</html>