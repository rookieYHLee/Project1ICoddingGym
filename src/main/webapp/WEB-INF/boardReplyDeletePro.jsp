<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.replyBean" %>
<%@ page import="icg.replyDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="rBean" class="icg.replyBean">
	<jsp:setProperty name="rBean" property="*"/>
</jsp:useBean>
<%
	replyDAO rdao = new replyDAO();
	
	if(rBean.getR_reNo() == 0) {
		if(rdao.reReplyIs(rBean)){
			rdao.boardRereplyDeleteUpdate(rBean);
		}else{
			rdao.boardRereplyDelete(rBean);
		}
	} else{
		rdao.boardRereplyDelete(rBean);
	}

%>
<script type="text/javascript">
	location.href="main.jsp?center=boardDetail.jsp?num=<%=rBean.getB_no() %>"
</script>
</body>
</html>