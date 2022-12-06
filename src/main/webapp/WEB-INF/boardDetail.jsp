<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="icg.boardDAO" %>
    <%@ page import="icg.boardBean" %>
    <%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세 보기</title>
<link href="./css/css2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
<style type="text/css">
	.reply_f .reply_b {
		height : 80px;
		vertical-align:middle;	
	}
	
	.reply_f .reply_area {
		
		vertical-align:middle;
	}
</style>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	boardDAO bdao = new boardDAO();
	boardBean bBean =  bdao.oneselectboard(num);
	String Wid = bBean.getB_writer();
	String id = (String)session.getAttribute("id");
%>
<script>
	function del(){
		  if (confirm("게시글을 삭제 하시겠습니까?")) {
			  location.href = "main.jsp?center=boardDeleteformPro.jsp?b_no=<%=bBean.getB_no()%>";
		    } else {
		       
		    }
	}
</script>
</head>
<body style="margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;">

	<h2 align="center" style="margin-top: 30px;"><strong>코딩 게시판</strong></h2>
	<div>
	<table class="board-table">
		<tbody>
		<tr height="40" style="background: #D8F6CE;">
			<td><strong>번호</strong></td>
			<td><%=bBean.getB_no() %></td>
			<td><strong>조회수</strong></td>
			<td><%=bBean.getB_viewCount() %></td>
		</tr>
		<tr height="40">
			<td><strong>작성자</strong></td>
			<td><%=bBean.getB_writer() %></td>
			<td><strong>작성일자</strong></td>
			<td><%if(bBean.getB_rewriteDate() == null){
			Timestamp wDate = bBean.getB_writeDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate);
		}else {
			Timestamp wDate = bBean.getB_rewriteDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate+"(수정됨)");
		}	%></td>
		</tr>
		<tr>
			<td><strong>제목</strong></td>
			<td colspan="3"><%=bBean.getB_title()%>&nbsp;&nbsp;[<%=bBean.getB_replyCount()%>]</td>
		</tr>
		<tr style="border-bottom: 5px solid white;">
			<td colspan="4" style= "background: white;height:40px"></td>
		</tr>
		<tr style="border-bottom: 5px solid white;">		
			<td width="0px" bgcolor = "white"></td>
			<td colspan="2"><xmp align="left"><%=bBean.getB_contents() %></xmp></td>
			<td width="0px" bgcolor = "white"></td>
			
		</tr>
	<tr>
			<td colspan="4" style= "background: white;height:40px"></td>
		</tr>
		<tr>
			<td colspan="4" align="right">
			<% if(id != null){
						if (id.equals(Wid)||id.equals("adminmaster")){ %>										
				<button class="btn btn-dark" onclick="location.href='main.jsp?center=boardUpdateform.jsp?num=<%=bBean.getB_no() %>'">수정하기</button>&nbsp;&nbsp;
				<button class="btn btn-dark"  onclick="del()">삭제하기</button>&nbsp;&nbsp;
				<%}} %>
				<button class="btn btn-dark" onclick="location.href='main.jsp?center=boardList.jsp'">목록조회</button>&nbsp;&nbsp;
			</td>
		</tr>
		</tbody>
	</table>
	<jsp:include page="boardReplyWriteform.jsp"></jsp:include>
	</div>
	
</body>
</html>