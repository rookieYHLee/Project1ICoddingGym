<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.memberDAO" %>  
<%@ page import="icg.memberBean" %>  
<%@ page import="icg.boardDAO" %>
<%@ page import="java.util.Vector" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록 보기</title>
<link href="./css/css2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
</head>
<body>
<%
	memberDAO mdao = new memberDAO();
	boardDAO bdao = new boardDAO();
	
	Vector<memberBean> vec = mdao.allselectmember();
%>
<h2 align="center" style="margin-top: 30px;"><strong>회원정보조회</strong></h2>
<br>
<table class="board-table">
	<thead>
	<tr  style="height: 40px; background:#E6E6E6;">
		<th>아이디</th>
		<th>이&nbsp;&nbsp;&nbsp;름</th>
		<th>전자우편</th>
		<th>전화번호</th>
	</tr>
	</thead>
	<%
		for(int i=0; i < vec.size(); i++){
			
			memberBean mBean = vec.get(i);		
	%>
	<tbody>
	<tr height="40">
		<td><a style="text-decoration:none;" href="main.jsp?center=MyPage.jsp?id=<%=mBean.getId() %>"><%=mBean.getId() %></a></td>
		<td><%=mBean.getName() %></td>
		<td><%=mBean.getEmail() %></td>
		<td><%=mBean.getTele() %></td>	
	</tr>
	<%} %>
	<tr align="center" style="height: 40px; background:#E6E6E6;">
		<th>총 회원수</th>
		<th><%= mdao.memberCount()%></th>
		<th>총 일반게시글수</th>
		<th><%= bdao.bsCount()%></th>
	</tr>
	</tbody>	
</table>
<br>
	<table align="center">
		<tr>
			<td>
				<button class="btn btn-dark" onclick="location.href='main.jsp'">메인으로</button>
		</tr>
	</table>
</body>
</html>