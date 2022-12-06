<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.memberDAO" %>  
<%@ page import="icg.memberBean" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link href="./css/css2.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<h2 align="center"><strong>회원탈퇴</strong></h2>
	<div> 
	<form action="memberDeleteformPro.jsp" method="post">
	<table class="board-table">
	<thead>
		<tr style="height: 40px;">
			<th>아이디</th>
			<th><%=request.getParameter("id") %></th> 
		</tr>
	</thead>				
	<tbody>
		<tr align="center" style="height: 40px;">
			<td>비밀번호</td>
			<td>
				<input type="password" name="password">
			</td>
		</tr>		
		<tr style="height: 40px;">
			<td colspan="2"> 
				<input type="hidden" name="id" value="<%=request.getParameter("id") %>">
				<input class="btn-dark" type="submit" value="회원정보삭제">&nbsp;&nbsp;
				<input type="button" class="btn-dark" value="삭제취소" onclick="history.go(-1)">						
			</td>	
		</tr>
		</tbody>		
	</table>	
	</form>
</div>
</body>
</html>