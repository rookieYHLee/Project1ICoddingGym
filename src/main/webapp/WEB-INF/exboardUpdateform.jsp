<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.exboardDAO" %>
<%@ page import="icg.exboardBean" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>광고 게시판 글 수정</title>
</head>
<link href="./css/css2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
<body style="
    margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;
">
<script>
function onTestChange() {
	var key = window.event.keyCode;
	
	//ifthe user has pressed enter
	if(key == 13) {
		document.getElementById("textA").value = document.getElementById("textA").value + "\n<br>";
		return false;
	} else {
		return true;
	}
	
}

function autolink(textA) {
	    var container = document.getElementById("textA");
	    var doc = container.innerHTML;
	    var regURL = new RegExp("(http|https|ftp|telnet|news|irc)://([-/.a-zA-Z0-9_~#%$?&=:200-377()]+)","gi");
	    var regEmail = new RegExp("([xA1-xFEa-z0-9_-]+@[xA1-xFEa-z0-9-]+\.[a-z0-9-]+)","gi");
	    container.innerHTML = doc.replace(regURL,"<a href='$1://$2' target='_blank'>$1://$2</a>").replace(regEmail,"<a href='mailto:$1'>$1</a>");
}
</script>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String id = (String)session.getAttribute("id");

	exboardDAO edao = new exboardDAO();
	exboardBean eBean = edao.UpdateOneSelectBoard(num);

	
	
	
	if(id == null){
		%><script type="text/javascript">
		alert("수정 권한이 없습니다");
		history.back();
		</script><%
	}
	else if (id.equals("admin2")){
		
	
//테스트용
//dao설정 등등
%>
<h2 align="center" style="margin-top: 30px;"><strong>외부 강사 게시판 글 수정</strong></h2>
<div>
	<form action="exboardUpdateformPro.jsp" method="post"
		style="	margin-top: 20px;
			    margin-bottom: 20px;
			    padding-bottom: 0px;	
			  ">
		<table class="board-table" align="center" width = "100%">
		
		<tr height="40" style="background:lavender;">
			<th>번호</th>
			<th>&nbsp;&nbsp;<%=eBean.getE_no() %></th>
			<th>작성자</th>
			<th>&nbsp;&nbsp;<%=eBean.getE_writer() %></th>
		</tr>
		
		<tr height="40">
			<th>제목</th>
			<th colspan="3">&nbsp;&nbsp;
			<input type="text" class="form-control mt-4 mb-2" name="e_title" size ="80"
				 value="<%=eBean.getE_title() %>" />
		</tr>	
							
			
		<tr height="160">
			<td>내용</td>
			<td colspan="3">
			<textarea class="form-control" id="textA" onkeypress="onTestChange();" rows="10" cols="90" name="e_contents">
			&nbsp;<%=eBean.getE_contents() %></textarea>
		</tr>
			
		<tr height="40">
				<td colspan="4">
					<input class="btn btn-dark" type="hidden" name="e_no" value="<%=eBean.getE_no() %>">
					<input class="btn btn-dark" type="submit" value="수정완료">&nbsp;&nbsp;
					<input class="btn btn-dark" type="reset" value="수정취소">&nbsp;&nbsp;&nbsp;
					<input class="btn btn-dark" type="button" onclick="location.href='main.jsp?center=exboardList.jsp'" value="글목록">
					&nbsp;&nbsp;&nbsp;
				</td>
		</table>	
	</form>
</div>
<% }else if(!id.equals("admin2")){
	%><script type="text/javascript">
	alert("수정 권한이 없습니다");
	history.back();
	</script><%
}
%>

</body>
</html>