<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="icg.boardDAO" %>
    <%@ page import="icg.boardBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 정보 수정 화면</title>
<link href="./css/css2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
</head>
<body style="margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;">
<%

	int num = Integer.parseInt(request.getParameter("num"));
	String id = (String)session.getAttribute("id");
	boardDAO bdao = new boardDAO();
	boardBean bBean =  bdao.UpdateOneSelectBoard(num);
String Wid = bBean.getB_writer();
	
	
	
	if(id == null){
		%><script type="text/javascript">
		alert("수정 권한이 없습니다");
		history.back();
		</script><%
	}
	else if (id.equals(Wid)||id.equals("adminmaster")){
		
	
//테스트용
//dao설정 등등
%>
	<h2 align="center" style="margin-top: 30px;"><strong>코딩 게시판</strong></h2>
<div>
		<form action="boardUpdateformPro.jsp" method="post">
			<table class="board-table">
			<thead>
				<tr style="height: 40px; background: #D8F6CE;">
					<th>번호</th>
					<th><%=bBean.getB_no() %></th>
					<th>작성자</th>
					<th><%=bBean.getB_writer() %></th>
				</tr>
				<tr style="height: 40px;">
					<th>제목</th>
					<th colspan="3">
					<input class="form-control mt-4 mb-2" type="text" name="b_title" size="30" value="<%=bBean.getB_title()%>"></th>
					</tr>
					</thead>
					<tbody>
				<tr style="height: 40px;">
					<td colspan="4">
					<textarea class="form-control" rows="10" cols="77" name="b_contents"><%=bBean.getB_contents()%></textarea></td>
				</tr>
				<tr style="height:40px;">
					<td colspan="4">
						 <input type="hidden" name="b_no" value="<%=bBean.getB_no() %>">
						<input class="btn btn-dark" type="submit" value="수정완료">&nbsp;&nbsp;
						<input class="btn btn-dark" type="reset" value="수정취소">&nbsp;&nbsp;
						<input class="btn btn-dark" type="button" onclick="location.href='main.jsp?center=boardList.jsp'" value="글목록보기"/>&nbsp;&nbsp;
					</td>
				</tr>
				</tbody>
			</table>
		</form>	
		
	</div>
<% }else if(!(id.equals(Wid)||id.equals("adminmaster"))){
	%><script type="text/javascript">
	alert("수정 권한이 없습니다");
	history.back();
	</script><%
}
%>
</body>
</html>