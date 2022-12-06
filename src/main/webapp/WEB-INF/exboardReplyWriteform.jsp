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
<title>광고 게시판 리뷰 쓰기</title>
</head>
<script type="text/javascript" src="./jq/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
	.reply_f .reply_b {
		height : 80px;
		vertical-align:middle;	
	}
	
	.reply_f .reply_area {
		
		vertical-align:middle;
	}
	
	.r_pointBar {
		height: 5px;
		cursor: pointer;
		
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
			$(this).parent().html("<a style='text-decoration:none;  color: inherit;' href=# class='reply_up_submit' type='submit'>수정확인</a> <a style='text-decoration:none;  color: inherit;' href=# class='reply_up_cancel'>취소</a><br>");
		});
		
		$(document).on("click",".reply_up_cancel", function() {
			$(this).closest('tr').next().find(".reply_area_up").attr("readonly",true);
			$(this).parent().html('<a style="text-decoration:none;  color: inherit;" href=# class="reply_up">수정</a> <a style="text-decoration:none;  color: inherit;" href=# class="reply_de">삭제</a><br>');
		});
		
		 $(document).on("click", ".reply_up_submit", function() {
	         if($(this).closest('tr').next().find(".reply_area").val()=="") {
	            alert("내용을 입력해주세요.");
	            $(this).blur();
	         } else {
	            $(this).closest('tr').next().find(".re_reply_f").attr("action", "exboardReplyUpdatePro.jsp");
	            $(this).closest('tr').next().find(".re_reply_f").submit();
	         }
	      });
		
		$(document).on("click", ".reply_de", function() {
			if(confirm("댓글을 삭제하시겠습니까?")) {
				$(this).closest('tr').next().find(".re_reply_f").attr("action", "exboardReplyDeletePro.jsp");
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
		
		$(document).on("input",".r_pointBar", function() {
			var stars;
			switch ($(".r_pointBar").val()) {
			case "1":
				stars = "☆"; break;
			case "2":
				stars = "★"; break;
			case "3":
				stars = "★☆"; break;
			case "4":
				stars = "★★"; break;
			case "5":
				stars = "★★☆"; break;
			case "6":
				stars = "★★★"; break;
			case "7":
				stars = "★★★☆"; break;
			case "8":
				stars = "★★★★"; break;
			case "9":
				stars = "★★★★☆"; break;
			case "10":
				stars = "★★★★★"; break;
			}
			
			$(".reviewScore").val(stars);
		});
	
		
	});
</script>
<body>
<%
	
	int e_no = Integer.parseInt(request.getParameter("num"));
	String id = (String)session.getAttribute("id");
	
	if(id == null){
		id = "student";
	}
	
	replyBean rBeanI = new replyBean();
	replyDAO rdao = new replyDAO(); 
	SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm");
	Vector<replyBean> rVec = rdao.exboardReplyAllSelect(e_no, id);
	Vector<replyBean> my_rVec = rdao.my_exboardReplyAllSelect(e_no, id);

%>


	<table>
	<%if(my_rVec.size()==0) { %>
		<tr>
			<td colspan="3" align="right">
			<hr>
				<form class="reply_f" action="exboardReplyWriteformPro.jsp">
					리뷰점수 : <input type="range" class="r_pointBar" name="r_reviewScore" min="1" max="10" step="1" value="10" list="starScore"/>
					<datalist id="starScore">
						<option value="1" label="1">
						<option value="10" label="10">
					</datalist>
					<input type="text" class="reviewScore" size="7" value="★★★★★" readonly="readonly"/>
					<br><br>
					<textarea class="reply_area" name="r_contents" rows="5" cols="70" style="resize:none"></textarea>
					<input type="hidden" name="r_writer" value="<%=id %>" />
					<input type="hidden" name="e_no" value="<%=e_no %>"/>
					<input style="width:70px; height:100px; background:black; color:white; border-radius : 8px;" class="reply_b" type="submit" value="리뷰쓰기"/>
				</form>
				<hr>
			</td>
		</tr>
	<%} %>
	<%
	 for(int i = 0; i < my_rVec.size(); i++){
		replyBean my_rBean = my_rVec.get(i);
		
		String rv_star ="정보 없음";
		switch ((int)my_rBean.getR_reviewScore()) {
		case 1:
			rv_star = "☆"; break;
		case 2:
			rv_star = "★"; break;
		case 3:
			rv_star = "★☆"; break;
		case 4:
			rv_star = "★★"; break;
		case 5:
			rv_star = "★★☆"; break;
		case 6:
			rv_star = "★★★"; break;
		case 7:
			rv_star = "★★★☆"; break;
		case 8:
			rv_star = "★★★★"; break;
		case 9:
			rv_star = "★★★★☆"; break;
		case 10:
			rv_star = "★★★★★"; break;
		}
	 %>
	 	
		<tr>
			<td width="400" colspan="2">
				작성자 : <%=my_rBean.getR_writer() %>
			</td>
			<td>
				<%if(my_rBean.getR_reNo()== 0) {%>
				내 점수 : <%=rv_star %>
				<%} %>
			</td>
		</tr>
		<tr>
			<td width="200">
				|&nbsp;작성일자 : <%=sdf.format(my_rBean.getR_writeDate()) %>
			</td>
			<td width="200">
			<%if(my_rBean.getR_rewriteDate()!=null) {%>
				|&nbsp;수정일자 : <%=sdf.format(my_rBean.getR_rewriteDate()) %>
			<%} %>
			</td>
			<td width="150">
				<% if(id.equals(my_rBean.getR_writer())) {%>
					<span style="display:inline-block; float:right">
						<a style="text-decoration:none;  color: inherit;" href=# class="reply_up">수정</a>
						<a style="text-decoration:none;  color: inherit;" href=# class="reply_de">삭제</a>
					</span><br>
				<%} %>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<form class="re_reply_f">
					<% if(my_rBean.getR_reNo()== 0) { %>	
					<textarea class="reply_area_up" name="r_contents_up" cols="81" style="resize:none" readonly="readonly"><%=my_rBean.getR_contents() %></textarea><br>
					<span style="display:inline-block; float:right">
						<input type="button" value="댓글" class="re_reply_b" style="width:70px;  height:40px; background:black; color:white; border-radius : 8px;">
					</span>
					<br>
					<div class="re_reply_area" style="display:none">
						<br>
						&nbsp;&nbsp;┖&nbsp;&nbsp;<textarea class="reply_area" name="r_contents" rows="5" cols="75" style="resize:none"></textarea><br>
						<span style="display:inline-block; float:right">
							<input type="submit" style="width:70px;  height:40px; background:black; color:white; border-radius : 8px;" value="확인" formaction="exboardReplyWriteformPro.jsp">
							<input type="button" style="width:70px;  height:40px; background:black; color:white; border-radius : 8px;" value="취소" class="re_reply_hide">
						</span>
					</div>
					
					<%} else { %>
					&nbsp;&nbsp;┖&nbsp;<textarea class="reply_area_up" name="r_contents_up" cols="75" style="resize:none" readonly="readonly"><%=my_rBean.getR_contents() %></textarea>
					<%} %>
					<input type="hidden" name="r_writer" value="<%=id %>" />
					<input type="hidden" name="e_no" value="<%=my_rBean.getE_no() %>"/>
					<input type="hidden" name="r_no" value="<%=my_rBean.getR_no() %>"/>
					<input type="hidden" name="r_reNo" value="<%=my_rBean.getR_reNo() %>"/>
					
				</form>
			</td>
		</tr>
		<tr height="30">
			<td colspan="3"><hr></td>
		</tr>
	<%} %>
		<tr>
			<td colspan="3">
				<hr>
			</td>
		</tr>
	<%
	 for(int i = 0; i < rVec.size(); i++){
		replyBean rBean = rVec.get(i);
		
		String rv_star ="정보 없음";
		switch ((int)rBean.getR_reviewScore()) {
		case 1:
			rv_star = "☆"; break;
		case 2:
			rv_star = "★"; break;
		case 3:
			rv_star = "★☆"; break;
		case 4:
			rv_star = "★★"; break;
		case 5:
			rv_star = "★★☆"; break;
		case 6:
			rv_star = "★★★"; break;
		case 7:
			rv_star = "★★★☆"; break;
		case 8:
			rv_star = "★★★★"; break;
		case 9:
			rv_star = "★★★★☆"; break;
		case 10:
			rv_star = "★★★★★"; break;
		}
	 %>
	 	
		<tr>
			<td width="400" colspan="2">
				작성자 : <%=rBean.getR_writer() %>
			</td>
			<td>
				<%if(rBean.getR_reNo()== 0) {%>
				리뷰점수 : <%=rv_star %>
				<%} %>
			</td>
		</tr>
		<tr>
			<td width="200">
				|&nbsp;작성일자 : <%=sdf.format(rBean.getR_writeDate()) %>
			</td>
			<td width="200">
			<%if(rBean.getR_rewriteDate()!=null) {%>
				|&nbsp;수정일자 : <%=sdf.format(rBean.getR_rewriteDate()) %>
			<%} %>
			</td>
			<td width="150">
				<% if(id.equals(rBean.getR_writer())) {%>
					<span style="display:inline-block; float:right">
						<a style="text-decoration:none;  color: inherit;" href=# class="reply_up">수정</a>
						<a style="text-decoration:none;  color: inherit;" href=# class="reply_de">삭제</a>
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
						<input style="width:70px;  height:40px; background:black; color:white; border-radius : 8px;" type="button" value="댓글" class="re_reply_b">
					</span>
					<br>
					<div class="re_reply_area" style="display:none">
						<br>
						&nbsp;&nbsp;┖&nbsp;&nbsp;<textarea class="reply_area" name="r_contents" rows="5" cols="75" style="resize:none"></textarea><br>
						<span style="display:inline-block; float:right">
							<input type="submit" style="width:70px;  height:40px; background:black; color:white; border-radius : 8px;" value="확인" formaction="exboardReplyWriteformPro.jsp">
							<input type="button" style="width:70px;  height:40px; background:black; color:white; border-radius : 8px;" value="취소" class="re_reply_hide">
						</span>
					</div>
					
					<%} else { %>
					&nbsp;&nbsp;┖&nbsp;<textarea class="reply_area_up" name="r_contents_up" cols="75" style="resize:none" readonly="readonly"><%=rBean.getR_contents() %></textarea>
					<%} %>
					<input type="hidden" name="r_writer" value="<%=id %>" />
					<input type="hidden" name="e_no" value="<%=rBean.getE_no() %>"/>
					<input type="hidden" name="r_no" value="<%=rBean.getR_no() %>"/>
					<input type="hidden" name="r_reNo" value="<%=rBean.getR_reNo() %>"/>
					
				</form>
			</td>
		</tr>
		<tr height="30">
			<td colspan="3"><hr></td>
		</tr>
	<%}	%>
		
		
	</table>
	


</body>
</html>