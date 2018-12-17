<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>나의 정보 수정하기</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
	
	.formGroup{width:800px;padding:5px;display:flex;}
	.formBtn{text-align:center;padding:10px}
	.formControl, .detailBox{width:100%;
						  padding: 15px 20px;
						  margin: 8px 0;
						  display: inline-block;
						  border: 1px solid #ccc;
						  border-radius: 4px;
						  box-sizing: border-box;
						  width:400px;}
	.detailBox{background:lightgray;}
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
	#cancelBtn{background-color: #555555; /* black */}
	.innerBtn{background-color: #bbbbbb; /* 회색 */
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
	#subTitle{font-size:50px; text-align:center; font-weight:bold;}
	.alertText{color:red; font-weight:bold;padding-left:50px;}
	#loginText{color:darkgray;font-size:20px; font-weight:bold;padding-top: 20px; }

	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	// 회원가입 화면의 입력값들을 검사한다.
	function checkValue()
	{
		var form = document.modifyForm;
	
			
		if(!form.passwd.value){
			alert("비밀번호를 입력하세요.");
			form.passwd.focus();
			return false;
		}
		//아이디와 비밀번호가 같은지 확인
		if ("${VIEW.userid}"==form.passwd.value) {
	      	alert("비밀번호가 ID와 똑같습니다. 다른 비밀번호를 입력해 주세요.");
	      	form.passwd.value = "";
	      	form.passwd.focus();
	      	return false;
    	}
		//비밀번호 공백 사용 금지
        if (form.passwd.value.indexOf(" ") >= 0) {
            alert("비밀번호에 공백을 사용할 수 없습니다.")
            form.passwd.focus()
            form.passwd.select()
            return false;
        }
			
		// 본인확인 버튼 클릭 여부
        if(form.identification.value != "pwCheck"){ 	//본인확인 팝업창에서 실행한 결과값을 idCheck에 넣었다.
			alert("본인확인 버튼을 클릭해 주세요.");
			form.passwd.focus();
			return false;
		}
		
		
		if(!form.nick.value){
			alert("닉네임을 입력하세요.");
			form.nick.focus();
			return false;
		}
		
		
		//닉네임 유효성 검사 (한글, 영문대소문자, 숫자만 허용)
        for (i = 0; i < form.nick.value.length; i++) {
            ch = form.nick.value.charAt(i)
            if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')&&!(ch >='가' && ch<='힣')) {
                alert("닉네임은 한글, 영문 대소문자, 숫자만 입력가능합니다.")
                form.nick.focus()
                form.nick.select()
                return false;
            }
        }
	
	}
	
	//본인확인 버튼 클릭 시 처리 기능
	function memberChkAction() {
		alert("비밀번호를 잘못 입력하였습니다. 다시 입력해 주세요.")
		//1. 해당 사용자의 id/pw를 가지고 pw 매칭 여부를 result(1= true, 0=false)로 가져오기 기능 수행
		//2. result가 1일 경우 비밀번호 변경 버튼과 닉네임 inputbox가 활성화
		//3. result가 0일 경우 알림창 표시
		
	}	
	
	//비밀번호 변경하기 버튼 클릭 시 처리 기능
	function passwdCngAction() {
		alert("비밀번호 변경 팝업창입니다.")
		
	}	
	
		
	// 취소 버튼 클릭시 회원 상제보기 화면으로 이동
	function goFirstForm() {
		location.href="/";
	}	
	
	// 아이디 입력창에 값 입력시 hidden에 idUncheck를 세팅한다.
	// 이렇게 하는 이유는 중복체크 후 다시 아이디 창이 새로운 아이디를 입력했을 때
	// 다시 중복체크를 하도록 한다.
	function inputPwChk(){
		form.identification.value ="pwUncheck";
	}
	
		

	</script>
</head>
<body>
<div class="joinFrm">
<p id="subTitle">회원정보수정</p>
<br>

	<form id="modifyForm" name="modifyForm"  method="post" action="/member/memberUpdateProc.yo" onsubmit="return checkValue()">
		<div class="formGroup">
			<div class="inputTitle">아이디</div>
			<div class="detailBox">${VIEW.userid}	</div>
		</div>
		<div class="formGroup">
			<div class="inputTitle">이름</div>
			<div class="detailBox">${VIEW.uname}</div>
		</div>
		
		<div class="formGroup">
			<div class="inputTitle">내 기준지</div>
			<div class="detailBox">위도: ${VIEW.latitude}, 경도: ${VIEW.longitude}<br/>주소: ${VIEW.juso}</div>
		</div>
		<p class="alertText" >*내 기준지를 수정하려면 지도로 즐기기 화면에서 내 기준지 등록 기능을 사용해 주세요. 등록한 내용이 자동 반영되어 표시됩니다.</p>
		
		<div class="formGroup">
			<div class="inputTitle">기존 비밀번호</div><div class="inputbox">
			<input type="password" name="passwd"  id="passwd" placeholder=" 기존 비밀번호를 입력하세요" class="formControl" maxlength="50" onkeydown="inputPwChk()"/></div>
			<button type="button" class="innerBtn" id="memberChk" onclick="memberChkAction()">본인확인</button>
			<input type="hidden" name="identification"  id="identification" value="pwUncheck" >
		</div>
		
		
		<!-- 기존 비밀번호를 입력해서 맞을 경우만  수정할 수 있도록 처리-->	
		<div class="formGroup">
			<div class="inputTitle">비밀번호변경</div>
			<button type="button" class="innerBtn" id="passwdCng" onclick="passwdCngAction()">비밀번호 변경하기</button>
		</div>
		<div class="formGroup">
			<div class="inputTitle">닉네임</div>
			<div class="inputbox"><input type="text" name="nick"  id="nick" value="${VIEW.nick}" class="formControl" maxlength="50" /></div>
		</div>
		<p class="alertText" >*특수문자는 제외하고 입력하세요.</p>
		
	
	
		<div class="formBtn">
			<input type="submit" id="modifyBtn" class="actionBtn" value="수정하기"  />
			<input type="button" id="cancelBtn" class="actionBtn" onclick="goFirstForm()" value="취소" />
			
		</div>
	</form>


</div> 
</body>
</html>