<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 쓰기 화면</title>
<link href="./css/css2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	if(id == null){
		%><script type="text/javascript">
		alert("글쓰기 권한이 없습니다");
		history.back();
		</script><%
	}
%>

<body style="margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;">
	<h2 align="center" style="margin-top: 30px;"><strong>코딩 게시판</strong></h2>
	<br>
	<form action="boardWriteformPro.jsp" method="post">
			<table class="board-table">
			<thead>
			<tr height="40" style="background: #D8F6CE;">
				<th>작성자</th>
				<th><%=id %></th>
			</tr>
			<tr height="40" align="center">
				<th>제목</th>
				<th><input class="form-control mt-4 mb-2" type="text" name="b_title" size="67" 
				placeholder="제목을 입력"/></th>
			</tr>
			</thead>
			<tbody>
			<tr height="40" align="center">
				<td>글 내용</td>
				<td>
					<textarea class="form-control" rows="10" cols="67" name="b_contents"></textarea>
				</td>
			</tr>
			<tr height="40">
				<td colspan="2">
					<input type="hidden" name="b_writer" value="<%=id %>">
					<input class="btn btn-dark" type="submit" value="글쓰기"/>&nbsp;&nbsp;
					<input class="btn btn-dark" type="button" value="글쓰기취소" onclick="location.href='main.jsp?center=boardList.jsp'"/>&nbsp;&nbsp;
				</td>
			</tr>
			</tbody>
		</table>

	
	</form>
	
</body>
</html>