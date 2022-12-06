<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.memberDAO" %>  
<%@ page import="icg.memberBean" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보삭제</title>
</head>
<body>
<jsp:useBean id="mBean" class="icg.memberBean">
		<jsp:setProperty name="mBean" property="*"/>
	</jsp:useBean>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	String admin = (String)session.getAttribute("id");//접속아이디가 관리자인가?
	
	memberDAO mdao = new memberDAO();
	mdao.getConnection();
	int check = mdao.userCheck(id, password);
	if(admin.equals("test")){//"test는 관리자아이디 "
		mdao.deldeteMember(mBean);
		%>
		<script> alert("회원이 탈퇴되었습니다.")
		location.href='main.jsp'</script>
		<%
	}else
	
	
	if(check==1){
	
		mdao.deldeteMember(mBean);
	%>
	<script> alert("회원이 탈퇴되었습니다.")</script>
	<%
		response.sendRedirect("main.jsp");
	}else if(check==0){%>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%}else{ %>
<script>
	alert("아이디가 맞지 않습니다.");
	history.go(-1);
</script>
<%} %>
</body>
</html>