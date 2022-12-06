<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<style>
* {
	margin: 0px;
	padding: 0px;
	text-decoration: none;
	font-family: sans-serif;
}

body {
	background-image: #34495e;
}

.joinForm {
	position: absolute;
	width: 400px;
	height: 400px;
	padding: 30px, 20px;
	background-color: #FFFFFF;
	text-align: center;
	top: 20%;
	left: 50%;
	transform: translate(-50%, -50%);
	border-radius: 15px;
}

.joinForm h2 {
	text-align: center;
}

.textForm {
	border-bottom: 2px solid #adadad;
	margin: 30px;
	padding: 10px 10px;
}

.id {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
	text-align: center;
}

.pw {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
	text-align: center;
}

.name {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
	text-align: center;
}

.email {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
	text-align: center;
}

#citizennum {
	width: 100%;
	border: 1px;
	outline: 1px;
	color: #636e72;
	font-size: 16px;
	height: 40px;
	background: none;
	display:inline;
}

.tele {
	width: 100%;
	border: none;
	outline: none;
	color: #636e72;
	font-size: 16px;
	height: 25px;
	background: none;
	text-align: center;
}

.btn {
	position: relative;
	align: center;
	transform: translate;
	margin-bottom: 40px;
	width: 30%;
	height: 40px;
	background: black;
	background-position: left;
	background-size: 200%;
	color: white;
	font-weight: bold;
	border: none;
	border-radius : 8px;
	cursor: pointer;
	transition: 0.4s;
	display: inline;
}

.back {
	position: relative;
	align: center;
	transform: translate;
	margin-bottom: 40px;
	width: 30%;
	height: 40px;
	background: lightgrey;
	background-position: left;
	background-size: 200%;
	color: white;
	font-weight: bold;
	border: none;
	cursor: pointer;
	transition: 0.4s;
	display: inline;
}

.reset {
	position: relative;
	align: center;
	transform: translate;
	margin-bottom: 40px;
	width: 30%;
	height: 40px;
	background: red;
	background-position: left;
	background-size: 200%;
	color: white;
	font-weight: bold;
	border: none;
	cursor: pointer;
	transition: 0.4s;
	display: inline;
}

.btn:hover {
	background-position: right;
}
img { 
	display : block;
    margin : auto;
    width: 70%;
}

</style>
<script type="text/javascript">
	function Validation() {
		var RegExp = /^[a-zA-Z0-9]{4,12}$/; //id와 pwassword 유효성 검사 정규식
		var RegExp2 = /^[a-zA-Z0-9]{8,16}$/; //id와 pwassword 유효성 검사 정규식
		// 이메일 유효성검사
		var e_RegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var n_RegExp = /^[가-힣]{2,15}$/;
		var t_RegExp =  /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
		
		var jnumArr = new Array(); // 입력 한 주민번호를 저장해줄 배열 선언
		var jnumplus = [2,3,4,5,6,7,8,9,2,3,4,5,1]; // 주민번호 계산할때 쓰이는 배열
		var jnumSum = 0; //objNum[i] * jnumplus[i] 더한 값
		
		var objId = document.getElementById("id"); //아이디
		var objPwd = document.getElementById("password"); //비밀번호
		var objPwd2 = document.getElementById("checkpassword"); //비밀번호확인
		var objName = document.getElementById("name"); //이름
		var objNum1 = document.getElementById("citizennum1").value; //주민번호
		var objNum2 = document.getElementById("citizennum2").value; //주민번호
		var objNum = objNum1 + objNum2;
		var objEmail = document.getElementById("email");//메일
		var objTele = document.getElementById("tele");
		// ================ ID 유효성검사 ================ //
		
		if(objId.value==''){            
		alert("ID를 입력해주세요.");            
		return false;       
	}
		if(!RegExp.test(objId.value)){ //아이디 유효성검사            
		alert("ID는 4~12자의 영문 대소문자와 숫자로만 입력하여 주세요.");                    
		return false;       
	}
		// ================ PASSWORD 유효성검사 ===============//
		
		if(objPwd.value==''){ // 비밀번호 입력여부 검사
		alert("Password를 입력해주세요.");
		return false;
	}
		if(!RegExp2.test(objPwd.value)){ //패스워드 유효성검사
		alert("Password는 8~12자의 영문 대소문자와 숫자로만 입력하여 주세요.");
		return false;
	}
		if(objPwd.value==objId.value){ //패스워드와 ID가 동일한지 검사
		alert("Password는 ID와 동일하면 안됩니다.");
		return false;
	}
		if(objPwd2.value!=objPwd.value){ //비밀번호와 비밀번호확인이 동일한지 검사
		alert("비밀번호가 틀립니다. 다시 확인하여 입력해주세요.");
		return false;
	}
			// ================ 이름 유효성검사 ================ //
		
		if(objName.value ==''){
		alert("이름을 입력해주세요.");
		return false;
	}
		if(!n_RegExp.test(objName.value)){
		alert("특수문자,영어,숫자는 사용할수 없습니다. 한글만 입력하여주세요.");
		return false;
	}
		// ================ 주민등록번호 유효성검사 ================ //
		
		if(objNum1 == ''){
		alert("주민번호 앞자리를 입력해주세요."); 
		return false;
	}
		else	if(objNum2 == ''){
			alert("주민번호 뒷자리를 입력해주세요."); 
			return false;
		}
		else {
			for(var i = 0; i<objNum.length;i++){ // 입력받은 주민번호 jnumArr배열에 넣기
				jnumArr[i] = objNum.charAt(i);
		}
			for(var i = 0; i<objNum.length-1;i++){ // 입력받은 주민번호 jnumArr배열에 넣기
				jnumSum+=jnumArr[i]*jnumplus[i];
		}
			jnumSum = (11-(jnumSum % 11)) % 10; //주민번호 계산
		
			if(jnumSum != jnumArr[12]){ // 계산되서 나온 결과값(jnumSum)과 입력한 주민번호의 마지막이 맞지 않으면 
				 alert("주민번호가 올바르지 않습니다."); //alert 창 띄우기
			return false;
		}
		}
	// ================ email 유효성검사 ================ //
		
		if(objEmail.value == ''){ 
		alert("이메일을 입력해주세요.");
		return false;
	}
		if(!e_RegExp.test(objEmail.value)){ //이메일 유효성 검사
		alert("올바른 이메일 형식이 아닙니다.");
		return false;
	}
	//================= 전화번호 유효성검사 ================= //
	if(objTele.value == ''){
		alert("전화번호를 입력해주세요.");
		return false;
	}
	if(!t_RegExp.test(objTele.value)){
		alert("올바른 전화번호가 아닙니다.");
		return false;
	}
}	
</script>
</head>
<body>
<form method="post" onsubmit="return Validation();" action="memberJoinformPro.jsp" class="joinForm">
<div style="text-align : center;">
     <img src="./images/Coding Gym.png">
</div>
		<h2>회원정보입력</h2>
		
		<div class="textForm">
		아이디<br>
			<input type="text" name="id" id="id" class="id" maxlength="12" placeholder="영어 대소문자, 숫자 포함 4~12자 이내">
		</div>
		
		<div class="textForm">
		비밀번호<br>
			<input type="password" name="password" id="password" class="pw" maxlength="16" placeholder="영어 대소문자, 숫자 포함 8~16글자 이내">
		</div>
		<div class="textForm">
		비밀번호 확인<br>
			<input type="password" name="checkpassword" id="checkpassword" class="pw" maxlength="16">
		</div>
		<br>
		<h4>: 개인 정보 :</h4>
		
        <div class="textForm">
		이름<br>
			<input type="text" name="name" id="name" class="name">
		</div>
		<div class="textForm">
		주민등록번호<br>
			<input type="text" name="citizennum1" id="citizennum1" style="height:30px; width:110px; font-size:15px;" size="12"  maxlength="6" placeholder="주민번호 앞자리">&nbsp;-&nbsp;<input type="password" align="center" name="citizennum2" id="citizennum2" style="height:30px; width:110px; font-size:15px;" size="12" maxlength="7" placeholder="주민번호 뒷자리">
		</div>
			
		<div class="textForm">
		이메일<br>
			<input type="email" name="email" class="email" id="email" placeholder="id@domain.com 입력">
		</div>	
		
		 <div class="textForm">	
		전화번호<br>
			<input type="text" name="tele" class="tele" id="tele" placeholder="010-1234-5678 양식으로 입력">
		 </div>
	<br><br>
 
    <p align="center">
        <input type="button" value="뒤로가기" class="btn btn-dark" onclick="location.href='javascript:history.back()'">
         <input type="submit" value="회원 가입" class="btn btn-dark" style="background: red;"></input>
        <input type="reset" name="reset" value="다시 입력" class="btn btn-dark"></input>
    </p>
	</form>
</body>
</html>