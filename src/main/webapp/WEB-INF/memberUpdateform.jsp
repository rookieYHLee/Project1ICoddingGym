<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.memberDAO" %>  
<%@ page import="icg.memberBean" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link href="./css/css2.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%
	String id = request.getParameter("id");
	
	memberDAO mdao = new memberDAO();
	memberBean mBean = mdao.oneselectmember(id);
%>

<h2 align="center"><strong>회원정보 수정</strong></h2>
<br>
<form action="memberUpdateformPro.jsp" method="post"> 
<div>
	<table class="board-table">
		<tbody>
		<tr style="height: 40px;">
			<td>아이디</td>
			<td><%=mBean.getId() %></td>
		</tr>
		<tr style="height: 40px;">
			<td>이&nbsp;&nbsp;름</td>
			<td><%=mBean.getName() %></td>
		</tr>
		<tr style="height: 40px;">
			<td>이메일</td>
			<td>
				<input type="email" name="email" value="<%=mBean.getEmail() %>">
			</td>
		</tr>
		<tr style="height: 40px;">
			<td>전화번호</td>
			<td>
				<input type="tel" name="tele" value="<%=mBean.getTele() %>">
			</td>
		</tr>
		<tr style="height: 40px;">
			<td>비밀번호</td>
			<td>
				<input type="password" name="password">
			</td>
		</tr>
		<tr style="height: 40px;">
			<td colspan="2">
				<input type="hidden" name="id" value="<%=mBean.getId() %>">
				<input class="btn-dark" type="submit" value="수정완료" onclick="location.href='main.jsp?'">&nbsp;&nbsp;
				<input type="button" class="btn-dark" value="수정취소" onclick="history.go(-1)">
			</td>
		</tr>
		</tbody>
	</table>

</div>
</form>
</body>
</html>