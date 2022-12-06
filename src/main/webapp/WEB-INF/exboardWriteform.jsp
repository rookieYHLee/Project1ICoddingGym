<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link href="./css/css2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
<script>

function onTestChange() {
	var key = event.keyCode;
	
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
<body style="
    margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;
">

<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	
	//테스트용
%>
<h2 align="center" style="margin-top: 30px;"><strong>외부 강사 게시판 글쓰기</strong></h2>
<br>
<div>
<form action="exboardWriteFormPro.jsp" method="post">

	<table class="board-table">
		<thead>
		<tr height = "40" align="center" style="background:lavender;">
			<th>작성자</th>
			<th><%=id %></th>
		</tr>
		
		<tr height = "40">
			<th>제목</th>
			<th><input class="form-control mt-4 mb-2" type="text" name="e_title" size ="67"
				 placeholder="제목" /></th>
		</tr>		
			
		<tr height = "40">
			<th>이미지 링크</th>
			<th><input class="form-control mt-4 mb-2" type="text" name="e_imageURL" size ="67"
				 placeholder="이미지링크" /></th>
		</tr>			
		</thead>
		
		<tbody>
		<tr height = "120">			
			<td colspan="2">
				<textarea class="form-control" id="textA" onkeypress="onTestChange();" 
				rows="10" cols="70" name="e_contents" placeholder="내용" /></textarea>
			</td>
		</tr>
				
		
		<tr height = "50" align="center">
			<td colspan="2">
				<input type="hidden" value ="<%=id %>" name="e_writer"/>
				<input class="btn btn-dark" type = "submit" value = "글쓰기" />&nbsp;&nbsp;&nbsp;
				<input class="btn btn-dark" type = "reset" value = "초기화"  />&nbsp;&nbsp;&nbsp;
				<input class="btn btn-dark" type = "button" value = "글목록" onclick="location.href='main.jsp?center=exboardList.jsp'"/>
			</td>
		</tr>
		</tbody>	
	</table>
</form>
</div>
</body>
</html>