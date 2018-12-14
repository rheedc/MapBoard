<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>회원가입 화면</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
	.joinFrm{width:800px;}
	.formGroup{width:800px;padding:10px;display:flex;}
	.formBtn{width:800px;text-align:center;padding:10px}
	.formControl{width: 100%;
						  padding: 15px 20px;
						  margin: 8px 0;
						  display: inline-block;
						  border: 1px solid #ccc;
						  border-radius: 4px;
						  box-sizing: border-box;}
	.inputTitle{font-weight:bold;font-size:20px;margin:8px 20px 8px 0px;width:180px;padding: 15px 20px;}
	.inputbox{width:400px;}
	
	.actionBtn{background-color: #008CBA; /* blue */
					  border: none;
					  color: white;
					  padding: 15px 32px;
					  text-align: center;
					  text-decoration: none;
					  display: inline-block;
					  font-size: 16px;
					  font-weight: bold;
					  margin: 4px 2px;
					  cursor: pointer;}
	#joinBtn{background-color: #555555; /* black */}
	#idChk{background-color: #bbbbbb; /* 회색 */
					  border: none;
					  color: black;
					  padding: 2px 30px;
					  text-align: center;
					  text-decoration: none;
					  display: inline-block;
					  font-size: 14px;
					  font-weight: bold;
					  margin: 18px 10px;
					  cursor: pointer;}
	#subTitle{font-size:50px; text-align:center; font-weight:bold;width:800px;}

	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	// 회원가입 화면의 입력값들을 검사한다.
	function checkValue()
	{
		var form = document.joinForm;
	
		if(!form.userid.value){
			alert("아이디를 입력하세요.");
			form.userid.focus();
			return false;
		}
		//아이디 유효성 검사 (영문대소문자, 숫자만 허용)
        for (i = 0; i < form.userid.value.length; i++) {
            ch = form.userid.value.charAt(i)
            if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
                alert("아이디는 대소문자, 숫자만 입력가능합니다.")
                form.userid.focus()
                form.userid.select()
                return false;
            }
        }
		
		//아이디 공백 사용 금지
        if (form.userid.value.indexOf(" ") >= 0) {
            alert("아이디에 공백을 사용할 수 없습니다.")
           form.userid.focus()
           form.userid.select()
            return false;
        }
		
		if(form.idDuplication.value != "idChk"){
			alert("아이디 중복체크를 해주세요.");
			form.userid.focus();
			return false;
		}
		
		if(!form.passwd.value){
			alert("비밀번호를 입력하세요.");
			form.passwd.focus();
			return false;
		}
		//아이디와 비밀번호가 같은지 확인
		if (form.userid.value==form.passwd.value) {
      	alert("비밀번호가 ID와 똑같습니다. 다른 비밀번호를 입력해 주세요.");
      	form.passwd.value = "";
      	form.passwd.focus();
    	}
		
		
		
		
		// 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
		if(form.passwd.value != form.passwordcheck.value ){
			alert("비밀번호를 동일하게 입력하세요.");
			form.passwd.value = "";
			form.passwordcheck.value = "";
			form.passwd.focus();
			return false;
		}	
		
		if(!form.uname.value){
			alert("이름을 입력하세요.");
			form.uname.focus();
			return false;
		}
		
		if(!form.nick.value){
			alert("닉네임을 입력하세요.");
			form.nick.focus();
			return false;
		}
		

	}
	
	// 취소 버튼 클릭시 첫화면으로 이동
	function goFirstForm() {
		location.href="/";
	}	
	
	// 아이디 중복체크 화면open
	function openIdChk(){
	
		window.name = "parentForm";
		window.open("/view/popup/idCheckForm.jsp",
				"chkForm", "width=500, height=300, resizable = no, scrollbars = no");	
	}

	// 아이디 입력창에 값 입력시 hidden에 idUncheck를 세팅한다.
	// 이렇게 하는 이유는 중복체크 후 다시 아이디 창이 새로운 아이디를 입력했을 때
	// 다시 중복체크를 하도록 한다.
	function inputIdChk(){
		document.userInfo.idDuplication.value ="idUncheck";
	}
	

	</script>
</head>
<body>
<div class="joinFrm">
<p id="subTitle">회원가입</p>
<br>

	<form id="joinForm" name="joinForm"  method="post" action="/member/joinProc.yo" onsubmit="return checkValue()">
		<div class="formGroup">
			<div class="inputTitle">아이디</div><div class="inputbox"><input type="text" name="userid"  id="userid" placeholder="아이디를 입력하세요" class="formControl" maxlength="50" onkeydown="inputIdChk()" /></div>
			<button type="button" id="idChk" onclick="openIdChk()">중복체크</button>
			<input type="hidden" name="idDuplication" value="idUncheck" >
		</div>
		<div class="formGroup">
			<div class="inputTitle">비밀번호</div><div class="inputbox"><input type="text" name="passwd"  id="passwd" placeholder="비밀번호를 입력하세요" class="formControl" maxlength="50" /></div>
		</div>
		<div class="formGroup">
			<div class="inputTitle">비밀번호확인</div><div class="inputbox"><input type="text" name="passwordcheck"  id="passwordcheck" placeholder="비밀번호를 다시 입력하세요" class="formControl" maxlength="50" /></div>
		</div>
		<div class="formGroup">
			<div class="inputTitle">이름</div><div class="inputbox"><input type="text" name="uname"  id="uname" placeholder="이름을 입력하세요" class="formControl" maxlength="50" /></div>
		</div>
		<div class="formGroup">
			<div class="inputTitle">닉네임</div><div class="inputbox"><input type="text" name="nick"  id="nick" placeholder="닉네임을 입력하세요" class="formControl" maxlength="50" /></div>
		</div>
		
	
		<div class="formBtn">
			<button type="submit" id="loginBtn" class="actionBtn" >회원가입</button>
			<button type="button" id="joinBtn" class="actionBtn" onclick="goFirstForm()">취소</button>
		</div>
	</form>


</div> 
</body>
</html>