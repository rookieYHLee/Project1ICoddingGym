<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="icg.exboardDAO" %>
 <%@ page import= "icg.replyDAO" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%
	
	replyDAO rdao = new replyDAO();
	exboardDAO edao = new exboardDAO();
	int e_no = Integer.parseInt(request.getParameter("e_no"));
	rdao.exboardRereplyAllDelete(e_no);
	edao.delete(e_no);

   
	%>				
			<script>
			alert('삭제가 완료되었습니다.');
			location.href= "main.jsp?center=exboardList.jsp";
			</script>
	
	
</body>
</html>