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
	<jsp:useBean id="fbBean" class="icg.FAQboardBean">
		<jsp:setProperty name="fbBean" property="*" />
	</jsp:useBean>
<%
	FAQboardDAO fbdao = new FAQboardDAO();
		
	fbdao.updateBoard(fbBean);
%>
	<script type="text/javascript">
		alert("수정이 완료되었습니다.");
		location.href="main.jsp?center=FAQboardList.jsp";
	</script>
</body>
</html>