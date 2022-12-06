<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="icg.exboardDAO" %>
<%@ page import="icg.exboardBean" %>
<%@ page import="icg.replyDAO" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.Timestamp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>외부 강사 게시판</title>
<link href="./css/css.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
</head>
<body style="
    margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;
">
<script>
	function openReport(){
		myWindow = window.open('exboardReportform.html', '_blank','width=500, height=600, left=500, top=200');
	}
	function Validation() {
		
		if(document.getElementById("search").value==''){
			alert("검색어를 입력해주세요.");
			return false;
		}
		}
</script>
<%
		int pageSize = 10;
		String pageNum = request.getParameter("pageNum");
	
		if(pageNum == null){
			pageNum = "1";
		}
					
		int count = 0; //전체글 갯수
		int number = 0; //페이지 넘버링 변수
		
		int currentPage = Integer.parseInt(pageNum); //현재 페이지 저장
	
		exboardDAO edao = new exboardDAO();
		count = edao.getAllcount(); //전체 게시글 숫자를 파악하여 저장		
		
		//현제 페이지에 보여줄 시작번호 설정과 끝페이지를 설정합니다
		//데이터베이스에서 불러올 시작번호
		//글번호가 아니라 시퀀스(시퀀스는 사라지지 않음)로 지정한다
		int startRow = (currentPage -1)*pageSize + 1;
		int endRow = (currentPage)*pageSize;
	
		Vector<exboardBean> vec = edao.allselectboard(startRow, endRow);
		
		number = count - (currentPage - 1)*pageSize; //테이블에 표시할 번호 설정
			
	%>
	
	<h2 align="center" style="margin-top: 30px;"><strong>강의 게시판</strong></h2>
	<div class="container" style="padding-top: 10px;">
	<table class="board-table" align="center" width="100%" >
		<thead>
	 <tr height="40" style="background:lavender;">
		<th width="15%">번호</th> 	
		<th width="30%" class="th-title">제목</th>
		<th width="15%">작성자</th>	 	
		<th width="15%">작성일</th>
		<th width="10%">조회수</th>
		<th width="15%">평점</th>		
	 </tr>
	 </thead>
	 
	 <tbody>
	 <%
	 for(int i = 0; i < vec.size(); i++){
		exboardBean eBean = vec.get(i);
	 %>
	
	  <tr height="40" align="center">
	  <td><%=eBean.getE_no() %></td>
	  <td width="140">
	  	<a href="main.jsp?center=exboardDetail.jsp?num=<%=eBean.getE_no() %>" style="text-decoration:none;  color: inherit;"> 
	  	
	  &nbsp; &nbsp;<%=eBean.getE_title()%>&nbsp;&nbsp;[<%=eBean.getE_reviewCount()%>]</a></td>
	  <td><%=eBean.getE_writer() %></td>
	  <td>
	  <%if(eBean.getE_rewriteDate() == null){
			Timestamp wDate = eBean.getE_writeDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate);
		}else {
			Timestamp wDate = eBean.getE_rewriteDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate+"(수정됨)");
		} %></td>
	  <td><%=eBean.getE_viewCount() %></td>
	  <td>
	  <%
	  replyDAO rdao = new replyDAO();		
	  double avg = rdao.boardReplyScore(eBean.getE_no());
	  %>
	  <%= avg %>
	<%	} %>
	  </td>
	 </tr>
	 </tbody>
	 </table>
 </div>
	<%
	String userSessionID = (String)session.getAttribute("id");	
	
	if(userSessionID == null){
		%>
		<input type="button" class="btn btn-dark" value="회원가입" style="position: relative;top: 18px;left: 88%;" onclick="location.href='memberJoinform.jsp'">&nbsp;&nbsp;
	<% 
	} else if (userSessionID.equals("admin2")) {
	%>
	<input type="button" class="btn btn-dark" value="글쓰기" style="position: relative;top: 18px;left: 88%;" onclick="location.href='main.jsp?center=exboardWriteform.jsp'">&nbsp;&nbsp;

	<% 
	} else{
	%>
		<input type="button" class="btn btn-dark" value="문의하기" style="position: relative;top: 18px;left: 88%;" onclick="openReport()">&nbsp;&nbsp;
	<% 
	} 
	%>

	<!-- 페이지 카운터링 작성 -->
	<nav aria-label="Page navigation example"  style=" position: relative;left: 5%;bottom: 20px;width: 500px;margin-right: 500px;">
	<ul class="pagination">
		
	<%
		if(count > 0){
			int pageCount = count/pageSize +(count%pageSize ==0? 0 : 1);		
		
			int startPage = 1;
			
			if(currentPage%10 != 0){
				startPage = (currentPage/10) * 10 + 1;
			}else {
				startPage = ((currentPage/10) -1) * 10 + 1;
			}
			
		int pageBlock = 10;
		int endPage = startPage + pageBlock -1;
		
		//[이전]링크 만들기
		//10페이지를 넘어가야 [이전]이 생기도록 만든다
		if(endPage > pageCount){
			endPage = pageCount;
			}
		
		if(startPage > 10){
	%>		
		<li class ="page-item"><a class="page-link" href="main.jsp?center=exboardList.jsp?pageNum=<%=startPage - 10 %>" style="text-decoration:none;  color: inherit;">[previous]</a></li>
	
	<%
		}
			for(int i = startPage; i <= endPage; i++){
	%>
		
		<li class ="page-item"><a class="page-link" href="main.jsp?center=exboardList.jsp?pageNum=<%=i %>" style="text-decoration:none;  color: inherit;"><%=i %></a></li>
		
	<%		
			}	
		
		//[다음]링크 만들기
		if(endPage < pageCount){
			endPage = pageCount;
	%>
		<li class ="page-item"><a class="page-link" href="main.jsp?center=exboardList.jsp?pageNum=<%=startPage + 10 %>" style="text-decoration:none;  color: inherit;">[next]</a></li>
			
		<%
		 }	
	 }	
	%>
		</ul>
	</nav>	
	<div id="board-search" style="width: 100%;">
	        <div class="container" style="width: 100%;position:relative; left:0%;right:0%;">
	            <div class="search-window" style="height: 80px;">
	                <form action="exboardSearchListPro.jsp" onsubmit="return Validation();">
	                    <div class="search-wrap" style="left: 70px;bottom:35px;">
	                    	<div style="position: relative; right: 20%; top:40px; width:0px;">
	                    	 <select name = "WorT" style="padding-bottom: 7px;padding-top: 7px;"  >
								<option value="title">제목</option>
								<option value="writer">작성자</option>
							 </select>
							 </div>
	                        <input id="search" type="search" name="what" placeholder="검색어를 입력해주세요." value="">
	                        <button type="submit" class="btn btn-dark" style="position: absolute;right: -1%; top:40px;    height: 40px;">검색</button>
	                    </div>
	                </form>
	            </div>
	        </div>
	    </div>
</body>
</html>