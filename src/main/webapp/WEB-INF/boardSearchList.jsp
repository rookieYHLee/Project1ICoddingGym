<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%request.setCharacterEncoding("UTF-8"); %>
<%@ page import= "icg.boardDAO" %>  
<%@ page import= "icg.boardBean"%>
<%@ page import="java.util.Vector" %>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./css/css.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css">
<script>
function Validation() {
	
if(document.getElementById("search").value==''){
	alert("검색어를 입력해주세요.");
	return false;
}
}
</script>
</head>
<body style="
    margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;
">
<%
	String WorT = request.getParameter("WorT");
	String what = request.getParameter("what");
	boardDAO bdao = new boardDAO();

	int pageSize = 10;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	int count = 0;//전체글의 갯수 저장
	int number = 0;//페이지 넘버링 변수
	
	int currentPage = Integer.parseInt(pageNum);//현재 페이지 저장
	
	
	count = bdao.getSearchcount(what,WorT);//전체 게시글의 숫자를 파악하여 저장

	//현재 페이지에 보여줄 시작번호 설정과 끝 페이지를 설정합니다.
	//데이터베이스에서 불러올 시작번호 : 1
	int startRow = (currentPage - 1) * pageSize + 1;//(1-1)*10+1
	int endRow = currentPage * pageSize;// 1 * 10 = 10
	
		Vector<boardBean> Svec = bdao.searchboard(what,WorT,startRow,endRow);
		number = count - (currentPage -1) * pageSize;// 테이블에 표시할 번호 설정 19 -  
%>
<h2 align="center" style="
    margin-top: 30px;"><strong>코딩 게시판 검색결과</strong></h2>

	<!-- 공지글 -->
<div class="container" style="padding-top: 10px;">
<table class="board-table" style="align:center; width:100%;">
<thead>
	<tr height="40" style= "height:40; background: #D8F6CE;">
		<th width="15%">번호</th>
		<th width="30%" align="left">제목</th>
		<th width="15%">작성자</th>
		<th width="25%">작성일자</th>
		<th width="15%">조회수</th>
	</tr>
</thead>	
	
	
	<!-- 일반게시글 -->
	<%
	for(int i=0; i<Svec.size();i++){
		
		boardBean bBean = Svec.get(i);
		
	%>
	<tbody>
	<tr height="40"  align="center">
		<td><%=number-- %>
		
			<td><a class="link" href="main.jsp?center=boardDetail.jsp?num=<%=bBean.getB_no() %>" style="text-decoration:none;  color: inherit;">
				&nbsp; &nbsp;<%=bBean.getB_title() %>&nbsp;&nbsp;[<%=bBean.getB_replyCount()%>]</a></td>
		
		<td><%=bBean.getB_writer() %></td>
		
		<td>
		<%if(bBean.getB_rewriteDate() == null){
			Timestamp wDate = bBean.getB_writeDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate);
		}else {
			Timestamp wDate = bBean.getB_rewriteDate();
			String wwDate = wDate.toString();
			String wwwDate = wwDate.substring(2,16);
			out.print(wwwDate+"(수정됨)");
		}	%></td>
		
		<td><%=bBean.getB_viewCount()%></td>
	</tr>
	</tbody>
	<%
	}
	%>
</table>
</div>
	<input type="button" class="btn btn-dark" value="글쓰기" style="position: relative;top: 18px;left: 88%;" onclick="location.href='main.jsp?center=boardWriteform.jsp'">&nbsp;&nbsp;
			
	<nav aria-label="Page navigation example"  style=" position: relative;left: 5%;bottom: 20px;width: 500px;margin-right: 500px;">
		<ul class="pagination">
		<%
			if(count > 0){
				int pagecount = count / pageSize + (count % pageSize == 0 ? 0 : 1);//139 / 10 + 1 = 13 + 1 = 14
				
				int startPage = 1;
				if(currentPage % 10 != 0){
					startPage = (currentPage / 10) * 10 + 1;//(1 / 10) * 10 + 1 = 0 * 10 + 1 = 0 + 1 = 1
				}else{
					startPage = ((currentPage / 10)-1) * 10 + 1;
				}
				int pageBlock = 10;
				int endPage = startPage + pageBlock - 1;// 1 + 10 - 1 = 11 - 1 = 10
						
				//[이전]링크를 만드는 부분
				if(endPage > pagecount){
					endPage = pagecount;
				}
				if(startPage > 10){
		%>
				<li class="page-item"><a class="page-link" href="main.jsp?center=boardSearchList.jsp?pageNum=<%=startPage - 10%>&what=<%=what %>&WorT=<%=WorT %>" style="text-decoration:none;  color: inherit;">[previous]</a></li>			
		<%
			
				}
				for(int i = startPage; i <= endPage; i ++){
				%>
					<li class="page-item"><a class="page-link" href="main.jsp?center=boardSearchList.jsp?pageNum=<%=i%>&what=<%=what %>&WorT=<%=WorT %>"style="text-decoration:none;  color: inherit;"><%=i %></a></li>
				<%	
				}
				//[다음]링크를 만드는 부분
				if(endPage < pagecount){
				
				%>
				<li class="page-item"><a class="page-link" href="main.jsp?center=boardSearchList.jsp?pageNum=<%=startPage + 10%>&what=<%=what %>&WorT=<%=WorT %>" style="text-decoration:none;  color: inherit;">[next]</a></li>
				<% 
				}
			}
		%>
			</ul>
		</nav>
		<div id="board-search" style="width: 100%;">
	        <div class="container" style="width: 100%;padding-left: 0px;padding-right: 0px;">
	            <div class="search-window" style="height: 80px;">
	                <form action="boardSearchListPro.jsp" onsubmit="return Validation();">
	                 <div class="search-wrap" style="left: 70px;bottom:35px;">
	                	<div style="position: relative;right: 20%; top:40px; width: 0px;">
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