<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="icg.memberBean" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>: 코딩짐 :</title>
   
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
</head>
<style>
	
</style>
  <body style="margin-top: 30px;
    margin-right: 200px;
    margin-bottom: 20px;
    margin-left: 200px;">
  <%
 
  	String id = null;
    if(session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");
	}
  	memberBean mbean = new memberBean();
  %>
  <nav class="navbar navbar-expand-lg bg-light static-top">
  <div class="container">
    <a class="navbar-brand" href="#">
      <img src="./images/logo.png" alt="..." height="36" onclick="location.href='main.jsp?'">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav ms-auto">
      
        <li class="nav-item">
          <a class="nav-link active" href="#" onclick="location.href='main.jsp?center=boardList.jsp?'">코딩</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="#" onclick="location.href='main.jsp?center=exboardList.jsp?'">강의</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="#" onclick="location.href='main.jsp?center=FAQboardList.jsp?'">FAQ</a>
        </li>
        </ul>
<%
	if(id == null) {
					
%>
        <ul class="navbar-nav">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            GUEST
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
           	<a class="dropdown-item" href="main.jsp?center=loginform.jsp">로그인</a>
           	<a class="dropdown-item" href="memberJoinform.jsp">회원가입</a>
            </div>
            </li>
          </ul>
<%
	} else {
%>	
		 <ul class="navbar-nav">
         <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <%=id %>
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
            <a class="dropdown-item" href="logout.jsp">로그아웃</a>
           	<a class="dropdown-item" href="main.jsp?center=MyPage.jsp?id=<%=id%>">My Page</a>
           	<%if(id.equals("adminmaster")){ %>
           	<a class="dropdown-item" href="main.jsp?center=memberList.jsp">회원목록</a>
           	<%} %>
           	</div>
           	</li>
          </ul>
<%
	}
%>
    </div>
  </div>
</nav>
<%
	String center = request.getParameter("center");
	
	if(center == null) {
		center = "Center.jsp";
	}
%>
<div align="center">
<table style="align:center; width:800px;">
<jsp:include page = "<%=center %>"></jsp:include>
</table>
</div>
<br><br>
<br><br>
<br>
<footer class="bg-light">
	<div class="container">
		<div class="row">
			<div class="col text-center">
				<h6 class="text-muted font-weight-light text-capitalize p-3">CodingGym - 코딩 체육관</h6>
				<h6 class="text-muted font-weight-light font-italic mb-3" style="cursor:pointer;" onclick="alert('준비 중입니다.')">More Info..</h6>
				<p class ="text-muted py-4 m-0">&copy;Copyright 2022 - Made by 2rdProject.</p>
			</div>
		</div>
	</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
</body>
</html>	