<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 글 작성하기</title>

</head><link rel="stylesheet" href="css/css2.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">

<body style="margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;">
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	//테스트용
	//id="세션아이디";
	if(id == null){
		%><script type="text/javascript">
		alert("글쓰기 권한이 없습니다");
		history.back();
		</script><%
	}
%>
<h2 align="center" style="margin-top: 30px;"><strong>FAQ</strong></h2>
<form action="FAQboardWriteformPro.jsp" method="post" >
	<table class="board-table">
		<thead>
		<tr height="30" align="center"style="background:#E0ECF8;">
			<th>작성자</th>
			<th align="left"><%=id %></th>
			<th style="width: 15%;">
			<% if(id != null)
					if (id.equals("adminmaster")||id.equals("test")){ %>
			  <label class="form-check form-switch"><input class="form-check-input" style="position:relative;right:5%;width: 32px;" type="checkbox" role="switch" name="fb_notice" value=1 id="flexSwitchCheckDefault" />공지사항</label>
			<%} %>
			</th>
			<th></th>
		</tr>
		<tr height="40" align="center" style= "background: white;">
			<th >글제목</th>
			<th colspan="2"><input type="text" class="form-control mt-4 mb-2" name="fb_title" size="60" placeholder="" required></th>
			<th width="20px"></th>
		</tr>
		<tr height="40" align="center" style= "background: white;" >
			<th >글 내용</th>
			<th colspan="2">
				<div class="form-group">
					<textarea class="form-control" rows="10" cols="62" name="fb_contents" style="resize: none;" required></textarea>
				</div>
			</th>
			<th></th>
		</tr>
		</thead>
		<tbody>
		<tr height="40" align="center" style= "background: white;" >
			<td colspan="4">
				<input type="hidden" name="fb_writer" value="<%=id%>">
				<input type="submit" class="btn btn-dark" value="글작성하기" style="margin-top: 20px;margin-bottom: 20px;"/>&nbsp;&nbsp;
				<input type="button" class="btn btn-dark" onclick="location.href='javascript:history.back()'" value="뒤로가기">&nbsp;&nbsp;
				<input type="button" class="btn btn-dark" value="글목록보기" onclick="location.href='main.jsp?center=FAQboardList.jsp'">&nbsp;&nbsp;
			</td>
		</tr>
		</tbody>
	</table>
</form>
</body>
</html>