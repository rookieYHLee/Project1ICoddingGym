<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.exboardBean" %>  
<%@ page import="icg.exboardDAO" %>
<%@ page import="icg.memberBean" %>  
<%@ page import="icg.memberDAO" %>
<%@ page import="icg.replyBean" %>        
<%@ page import="icg.replyDAO" %>    
<%@ page import="java.sql.Timestamp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>광고 게시판 게시글 상세 보기</title>
<link href="./css/css2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
	.reply_f .reply_b {
		height : 80px;
		vertical-align:middle;	
	}
	
	.reply_f .reply_area {
		
		vertical-align:middle;
	}
</style>
<body style="
    margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;
">
<script>

	function deleteright(url){
		var answer;
		
		answer = confirm("삭제하시겠습니까?");
		if(answer == true){
			location = url; 
		}else{}
	}
	
</script>
<%
	int num = Integer.parseInt(request.getParameter("num"));

	exboardDAO edao = new exboardDAO();
	exboardBean eBean = edao.oneselectboard(num);

	memberDAO mdao = new memberDAO();

	
	
	replyDAO rdao = new replyDAO();
		
	double avg = rdao.boardReplyScore(num);
%>

<!-- 로그인한 세션 처리 -->

<%
	String userSessionID = null;
	if (session.getAttribute("id") != null) {
		userSessionID = (String) session.getAttribute("id");
	}
	if (userSessionID != null) {
		
%>	

<%
	}else{
		userSessionID = "GUEST";
	}
%>

<!-- 유저가 쓴 글과 해당 글쓴이를 가져옴 -->
<%
	String e_title = null;
	String e_writer = null;
	
		
	if (request.getParameter("e_title") != null) {
		e_title = request.getParameter("e_title");
	}

	if (request.getParameter("e_writer") != null) {
		e_writer = request.getParameter("e_writer");
	}
		
%>
<h2 align="center" style="margin-top: 30px;"><strong>강의 게시판</strong></h2>
	<div>
	<table class="board-table" align="center" width = "100%">
	 <thead>
		
		<tr height="40" align="center" style="background:lavender;">	
			<th>번호</th> 
			<th><%=eBean.getE_no() %></th>	
		 	<th>작성자</th>
		 	<th><%=eBean.getE_writer() %></th>
			<th>작성일자</th>
		 	  <th>
	  <%if(eBean.getE_rewriteDate() == null){
			Timestamp wDate = eBean.getE_writeDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate);
		}else {
			Timestamp wDate = eBean.getE_rewriteDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate+"(수정됨)");
		} %></th>
		 	<th>조회수</th> 
			<th><%=eBean.getE_viewCount() %></th>	
		 			 
		</tr>	
		
		
		 <tr height="40">
			
			<th>제목</th>
			<th colspan="5"><%=eBean.getE_title() %>&nbsp;&nbsp;[<%=eBean.getE_reviewCount()%>]</th>
			<th>평점</th>
		 	<th><%= avg %></th>
								
		</tr>
		</thead>
				
		<tbody>	
		<tr height="40" style="background-color:aliceblue;">
		 <%	if(eBean.getE_imageURL() != null){%>
			 <td colspan="8"><%="<br><br>"+"<img src = '"+eBean.getE_imageURL()+"'>"+"<br><br><br>"+eBean.getE_contents() %></td>
		<%}
		 if(eBean.getE_imageURL() == null){%>
		 	<td colspan="8"><%=eBean.getE_contents() %></td> 
		 <% }	
		 	%>
		</tr>	
		<tr height="40" align="center">
			
			<td colspan="8" align="center">
				<!-- 글번호, 글번호에 대한 번호, 댓글인지 확인, 몇번째 댓글인지 파악 -->
								
				<button class="btn btn-dark" onclick="location.href='main.jsp?center=exboardList.jsp?'">글목록</button>
				&nbsp;&nbsp;&nbsp;
				<% if (userSessionID.equals("admin2")) { %>
				<button class="btn btn-dark" onclick="location.href='main.jsp?center=exboardUpdateform.jsp?num=<%=eBean.getE_no() %>'">수정</button>
				&nbsp;&nbsp;&nbsp;
				<button class="btn btn-dark" onclick="deleteright(location.href='main.jsp?center=exboardDeleteFormPro.jsp?e_no=<%=eBean.getE_no() %>')">삭제</button>
				&nbsp;&nbsp;	
				<% 
			} 
			%>			
			</td>
		</tr>	 	
		</tbody>	
	</table>
	
<jsp:include page="exboardReplyWriteform.jsp"></jsp:include>
</div>
</body>
</html>