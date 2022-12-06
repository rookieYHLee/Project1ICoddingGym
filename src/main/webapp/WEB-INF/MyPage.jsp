<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.memberDAO" %>  
<%@ page import="icg.memberBean" %>
<%@ page import="java.sql.Timestamp" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 상세 보기</title>
<link href="./css/css2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
</head>
<body>
<%
	String id = request.getParameter("id");

	memberDAO mdao = new memberDAO();
	memberBean mBean = mdao.oneselectmember(id);
%>

<h2 align="center" style="margin-top: 30px;"><strong>My Page</strong></h2>
<br>
<div>
	<table class="board-table">
		<tbody>
		<tr style="height: 40;">
			<td style="background:#E6E6E6;"><strong>아이디</strong></td>
			<td><%=mBean.getId() %></td>
		</tr>
		<tr style="height: 40;">
			<td><strong>이&nbsp;&nbsp;름</strong></td>
			<td><%=mBean.getName() %></td>
		</tr>
		<tr style="height: 40;">
			<td style="background:#E6E6E6;"><strong>이메일</strong></td>
			<td><%=mBean.getEmail() %></td>
		</tr>
		<tr style="height: 40;">
			<td><strong>전화번호</strong></td>
			<td><%=mBean.getTele() %></td>
		</tr>
		<tr style="height: 40;">
			<td style="background:#E6E6E6;"><strong>최근 로그인</strong></td>
			<td>
			<%if(mBean.getLastLoginDate() == null){
			Timestamp wDate = mBean.getJoinDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate);
		}else {
			Timestamp wDate = mBean.getLastLoginDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate);
		}	%></td>
		</tr>
		<tr style="height: 40;">
		<tr style="height: 40;">
			<td><strong>출석 수</strong></td>
			<td><%=mBean.getLoginCount() %></td>
		</tr>
		<tr style="height: 40;">
			<td colspan="2">
				<button class="btn btn-dark" onclick="location.href='main.jsp?center=memberUpdateform.jsp?id=<%=mBean.getId() %>'">회원정보수정</button>&nbsp;&nbsp;
				<button class="btn btn-dark" onclick="location.href='main.jsp?center=memberDeleteform.jsp?id=<%=mBean.getId() %>'">회원탈퇴</button>&nbsp;&nbsp;
			</td>
		</tr>
		</tbody>
	</table>

</div>
</body>
</html>