<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%request.setCharacterEncoding("UTF-8"); %>
<%@ page import= "icg.FAQboardDAO" %>  
<%@ page import= "icg.FAQboardBean"%>
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
    margin-left: 200px;"><%
	int num = Integer.parseInt(request.getParameter("num"));
	String id = (String)session.getAttribute("id");
	FAQboardDAO fbdao = new FAQboardDAO();
	FAQboardBean fbBean = fbdao.UpdateOneSelectBoard(num);
	String Wid = fbBean.getFb_writer();
	
	
	
	if(id == null){
		%><script type="text/javascript">
		alert("수정 권한이 없습니다");
		history.back();
		</script><%
	}
	else if (id.equals(Wid)||id.equals("test")||id.equals("adminmaster")){
		
	
//테스트용
//dao설정 등등
%>
<h2 align="center" style="
    margin-top: 30px;"><strong>FAQ</strong></h2>
<form action="FAQboardUpdateformPro.jsp" method="post" >
	<table class="board-table">
		<thead>
		<tr height="40" align="center"style="background:#E0ECF8;">
			<th>작성자</th>
			<th align="left"><%=id %></th>
			<th></th>
		</tr>
		<tr height="40" align="center" style= "background: white;">
			<th >글제목</th>
			<th ><input type="text" class="form-control" name="fb_title" size="60"value="<%=fbBean.getFb_title()%>" required></th>
			<th width="20px"></th>
		</tr>
		<tr height="40" align="center" style= "background: white;" >
			<th>글 내용</th>
			<th>
				<div class="form-group">
					<textarea class="form-control" rows="10" cols="62" name="fb_contents" style="resize: none;" required><%=fbBean.getFb_contents()%></textarea>
				</div>
			</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		<tr height="40" align="center" style= "background: white;">
			<td colspan="2">
				<input type="hidden" name="fb_no" value=<%=fbBean.getFb_no()%>>
				<input type="submit" class="btn btn-dark" value="수정하기" style="margin-top: 20px;margin-bottom: 20px;"/>&nbsp;&nbsp;
				<input type="button" class="btn btn-dark" onclick="location.href='javascript:history.back()'" value="뒤로가기">&nbsp;&nbsp;
				<input type="button" class="btn btn-dark" value="글목록보기" onclick="location.href='main.jsp?center=FAQboardList.jsp'">&nbsp;&nbsp;
			</td>
			<td></td>
		</tr>
		</tbody>
	</table>
</form>
<% }else if(!id.equals(Wid)){
	%><script type="text/javascript">
	alert("수정 권한이 없습니다");
	history.back();
	</script><%
}
%>
</body>
</html>