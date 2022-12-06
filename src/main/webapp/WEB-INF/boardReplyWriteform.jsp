<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.replyBean" %>  
<%@ page import="icg.replyDAO" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반게시판 댓글</title>
</head>
<script type="text/javascript" src="./jq/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
<script type="text/javascript">
	$(document).ready(function() {
		$(".re_reply_b").on("click", function(){
			$(this).closest(".re_reply_f").find(".re_reply_area").css({"display":"inline-block"});
		});
		
		$(".re_reply_hide").on("click",function(){
			$(this).closest(".re_reply_area").css({"display":"none"});
		});
		
		$(document).on("click", ".reply_up",function() {
			$(this).closest('tr').next().find(".reply_area_up").attr("readonly",false);
			$(this).closest('tr').next().find(".reply_area_up").focus();
			$(this).parent().html("<a href=# style='text-decoration:none;  color: inherit;' class='reply_up_submit' type='submit'>수정확인</a> <a style='text-decoration:none;  color: inherit;' href=# class='reply_up_cancel'>취소</a><br>");
		});
		
		$(document).on("click",".reply_up_cancel", function() {
			$(this).closest('tr').next().find(".reply_area_up").attr("readonly",true);
			$(this).parent().html('<a href=# style="text-decoration:none;  color: inherit;" class="reply_up">수정</a> <a href=# style="text-decoration:none;  color: inherit;" class="reply_de">삭제</a><br>');
		});
		
	    $(document).on("click", ".reply_up_submit", function() {
	         if($(this).closest('tr').next().find(".reply_area").val()=="") {
	            alert("내용을 입력해주세요.");
	            $(this).blur();
	         } else {
	            $(this).closest('tr').next().find(".re_reply_f").attr("action", "boardReplyUpdatePro.jsp");
	            $(this).closest('tr').next().find(".re_reply_f").submit();
	         }
	      });
		
		$(document).on("click", ".reply_de", function() {
			if(confirm("댓글을 삭제하시겠습니까?")) {
				$(this).closest('tr').next().find(".re_reply_f").attr("action", "boardReplyDeletePro.jsp");
				$(this).closest('tr').next().find(".re_reply_f").submit();
			}
		});
		
		$(document).on("focus","textarea[readonly!='readonly']",function() {
			if(<%=session.getAttribute("id")%>==null) {
				alert("로그인 후 사용 가능합니다.");
				$(this).blur();
			}
		});
		$(document).on("click","input[type='submit']",function(event) {
	         if($(this).closest('form').find('.reply_area').val()=="") {
	            event.preventDefault();
	            alert("내용을 입력해주세요.");
	            $(this).blur();
	         }
	      });
		
	});
</script>
<body>
<%
	
	int b_no = Integer.parseInt(request.getParameter("num"));
	String id = (String)session.getAttribute("id");
	//int b_no = 1;
	//String id = "admin2";
	
	
	if(id == null){
		id = "student";
	}
	
	replyBean rBeanI = new replyBean();
	replyDAO rdao = new replyDAO();
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
	Vector<replyBean> rVec = rdao.boardReplyAllSelect(b_no);
	

%>
<%!
	
%>

	<table>
		
	<%
	 for(int i = 0; i < rVec.size(); i++){
		replyBean rBean = rVec.get(i);
		
	 %>
		<tr>
			<td colspan="3">
				<hr>
				작성자 : <%=rBean.getR_writer() %>
			</td>
		</tr>
		<tr>
			<td width="40">
				|&nbsp;작성일자 : <%=sdf.format(rBean.getR_writeDate()) %>
			</td>
			<td width="40">
			<%if(rBean.getR_rewriteDate()!=null) {%>
				|&nbsp;수정일자 : <%=sdf.format(rBean.getR_rewriteDate()) %>
			<%} %>
			</td>
			<td width="20">
				<% if(id.equals(rBean.getR_writer())) {%>
					<span style="display:inline-block; float:right">
						<a  style="text-decoration:none;  color: inherit;" href=# class="reply_up">수정</a>
						<a  style="text-decoration:none;  color: inherit;" href=# class="reply_de">삭제</a>
					</span><br>
				<%} %>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<form class="re_reply_f">
					<% if(rBean.getR_reNo()== 0) { %>	
					<textarea class="reply_area_up" name="r_contents_up" cols="81" style="resize:none" readonly="readonly"><%=rBean.getR_contents() %></textarea><br>
					<span style="display:inline-block; float:right">
						<input type="button" value="답글" class="re_reply_b" style="width:70px;  height:40px; background:black; color:white; border-radius : 8px;">
					</span>
					<br>
					<div class="re_reply_area" style="display:none">
						<br>
						&nbsp;&nbsp;┖&nbsp;&nbsp;<textarea class="reply_area" name="r_contents" rows="5" cols="75" style="resize:none"></textarea><br>
						<span style="display:inline-block; float:right">
							<input type="submit"  style="width:70px;  height:40px; background:black; color:white; border-radius : 8px;" value="확인" formaction="boardReplyWriteformPro.jsp">
							<input type="button"  style="width:70px;  height:40px; background:black; color:white; border-radius : 8px;" value="취소" class="re_reply_hide">
						</span>
					</div>
					
					<%} else { %>
					&nbsp;&nbsp;┖&nbsp;<textarea class="reply_area_up" name="r_contents_up" cols="75" style="resize:none" readonly="readonly"><%=rBean.getR_contents() %></textarea>
					<%} %>
					<input type="hidden" name="r_writer" value="<%=id %>" />
					<input type="hidden" name="b_no" value="<%=rBean.getB_no() %>"/>
					<input type="hidden" name="r_no" value="<%=rBean.getR_no() %>"/>
					<input type="hidden" name="r_reNo" value="<%=rBean.getR_reNo() %>"/>
				</form>
			</td>
		</tr>
		
	<%}	%>
		
		
		
		<tr height="30">
			<td colspan="3"><hr></td>
		</tr>
		
		
		
		
		
		<tr>
			<td colspan="3">
				<form class="reply_f" action="boardReplyWriteformPro.jsp">
					<textarea class="reply_area" name="r_contents" rows="5" cols="70" style="resize:none"></textarea>
					<input type="hidden" name="r_writer" value="<%=id %>" />
					<input type="hidden" name="b_no" value="<%=b_no %>"/>
					<input class="reply_b" type="submit" style="width:70px; height:100px; background:black; color:white; border-radius : 8px;" value="댓글"/>
				</form>
			</td>
		</tr>
	</table>
</body>
</html>