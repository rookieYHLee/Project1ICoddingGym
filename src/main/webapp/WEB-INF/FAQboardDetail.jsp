<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import= "icg.FAQboardDAO" %>  
<%@ page import= "icg.FAQboardBean"%>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head><link rel="stylesheet" href="css/css2.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
<body style="margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;">
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	
	FAQboardDAO fbdao = new FAQboardDAO();
	FAQboardBean fbBean = fbdao.oneselectboard(num);
	String Wid = fbBean.getFb_writer();
	String id = (String)session.getAttribute("id");
%>
<script>
	function del(){
		  if (confirm("게시글을 삭제 하시겠습니까?")) {
			  location.href = "main.jsp?center=FAQboardDeleteformPro.jsp?fb_no=<%=fbBean.getFb_no()%>";
		    } else {
		       
		    }
	}
</script>
<h2 align="center" style="margin-top: 30px;"><strong>FAQ</strong></h2>	 
<div class="container" style="padding-top: 10px;">
	<table class="board-table">
		<thead>
		<tr height="40" style="background:#E0ECF8;">
			<th>번호</th>
			<th><%=fbBean.getFb_no() %></th>
			<th>조회수</th>
			<th><%=fbBean.getFb_viewCount() %></th>
		</tr>
		<tr height="40">
			<th>작성자</th>
			<th><%=fbBean.getFb_writer() %></th>
			<th>작성일자</th>
			<th><%if(fbBean.getFb_rewriteDate() == null){
			Timestamp wDate = fbBean.getFb_writeDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate);
		}else {
			Timestamp wDate = fbBean.getFb_rewriteDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate+"(수정됨)");
		}	%></th>
		</tr>
		<tr>
			
			<th>제목</th>
			<th colspan="3"><%=fbBean.getFb_title()%></th>
		</tr>
		</thead>
		<tbody>
		<tr style="border-bottom: 5px solid white;">
			<td colspan="4" style= "background: white;height:40px"></td>
		</tr>
		<tr style="border-bottom: 5px solid white;">
			<td width="0px" bgcolor = "white"></td>
			<td colspan="2" style= "background: white;"><xmp align="left"><%=fbBean.getFb_contents() %></xmp></td>
			<td width="0px" bgcolor = "white"></td>
		</tr>
		<tr>
			<td colspan="4" style= "background: white;height:40px"></td>
		</tr>
			<tr>
				<td align="right" colspan = "4"  style= "background: white; ">   <!--글번호                글번호에 대한 번호이고          댓글인지를 확인가능하고     몇번쨰댓글인지 파악할수있음  -->
					<% if(id != null){
						if (id.equals(Wid)||id.equals("test")||id.equals("adminmaster")){ %>
					<button class="btn btn-dark" onclick="location.href='main.jsp?center=FAQboardRewriteform.jsp?fb_title=<%=fbBean.getFb_title()%>&num=<%=fbBean.getFb_no()%>'">답변달기</button>&nbsp;&nbsp;
					<button class="btn btn-dark" onclick="location.href='main.jsp?center=FAQboardUpdateform.jsp?num=<%=fbBean.getFb_no()%>'">수정하기</button>&nbsp;&nbsp;
					<button class="btn btn-dark" onclick="del()">삭제하기</button>&nbsp;&nbsp;
					<%}} %>
					<button class="btn btn-dark" onclick="location.href='main.jsp?center=FAQboardList.jsp'">목록조회</button>&nbsp;&nbsp;
				</td>
			</tr>
	</table>
</div>
</body>
</html>