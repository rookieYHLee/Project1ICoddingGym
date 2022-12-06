<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import= "icg.FAQboardDAO" %>  
<%@ page import= "icg.FAQboardBean"%>
<%@ page import="java.sql.Timestamp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 게시판 댓글작성</title>
</head><link rel="stylesheet" href="css/css2.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">

<body style="margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;">
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	String fb_title= request.getParameter("fb_title");
	int num = Integer.parseInt(request.getParameter("num"));
	
	
	FAQboardDAO fbdao = new FAQboardDAO();
	FAQboardBean fbBean = fbdao.oneselectboard(num);
	
	if(id == null){
		%><script type="text/javascript">
		alert("답글달기 권한이 없습니다");
		history.back();
		</script><%
	}
%>
<h2 align="center" style="margin-top: 30px;"><strong>FAQ</strong></h2>	 
<div align="center">
<form action="FAQboardRewriteformPro.jsp" method="post" >
	<table class="board-table">
	<thead>
		<tr height="40" align="center"style="background:#E0ECF8;">
			<th>작성자</th>
			<th align="left"><%=id %></th>
			<th></th>
		</tr>
		<tr height="40" align="center" style= "background: white;">
			<th >글제목</th>
			<th><input type="text" class="form-control" name="fb_title" size="60"value="<%=fb_title%>" disabled></th>
			<th></th>
		</tr>
		<tr height="40" align="center" style= "background: white;" >
			<th>글 내용</th>
			<th>
				<div class="form-group">
					<textarea class="form-control" rows="10" cols="62"  style="resize: vertical;" disabled><%=fbBean.getFb_contents()%></textarea>
				</div>
			</th>
			<th></th>
		</tr>
		<tr height="40" align="center" style= "background: white;" >
			<th>답변 내용</th>
			<th>
				<div class="form-group">
					<textarea class="form-control" rows="10" cols="62" name="fb_contents" style="resize: none;" required></textarea>
				</div>
			</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		<tr height="40" align="center" style= "background: white;">
				<td align = "center" colspan="4">
					<input type="hidden" name="fb_writer" value = "<%=id%>">
					<input type="hidden" name="fb_title" value = "<%=fb_title%>">
					
					<input type="submit" class="btn btn-dark" value="답변달기" style="margin-top: 20px;margin-bottom: 20px;">&nbsp;&nbsp;
					<input type="button" class="btn btn-dark" onclick="location.href='main.jsp?center=FAQboardList.jsp'" value="목록조회">&nbsp;&nbsp;
			</tr>
			</tbody>
		</table>
	</form>
</div>
</body>
</html>