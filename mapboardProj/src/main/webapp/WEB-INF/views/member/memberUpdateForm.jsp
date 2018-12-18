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
	
	.formGroup{width:1000px;padding:5px;display:flex;margin:auto;}
	.formBtn{text-align:center;padding:10px}
	.formControl, .detailBox{width:100%;
						  padding: 15px 20px;
						  margin: 8px 0;
						  display: inline-block;
						  border: 1px solid #ccc;
						  border-radius: 4px;
						  box-sizing: border-box;
						  width:500px;}
	.detailBox{background:lightgray;}
	.inputTitle{font-weight:bold;font-size:20px;margin:8px 20px 8px 0px;width:200px;padding: 15px 20px;}
	.inputbox{width:500px;}
		
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
	.alertText{color:red; font-weight:bold;padding-left:230px;width:700px;}
	#loginText{color:darkgray;font-size:20px; font-weight:bold;padding-top: 20px; }

	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	// 새로 입력 받을 필드를 초기화 한다.
	$(function(){
		document.getElementById("oldpasswd").focus();
		document.getElementById("passwd").value="";
		document.getElementById("passwdChk").value="";
		document.getElementById("nick").value="";
		document.getElementById("memberChk").disabled = false;
	});
	
	
	//수정하기 버튼 클릭 시 
	function checkValue(){
		var form=document.modifyForm
		var userid=document.getElementById("userid");
		var idfi=document.getElementById("identification");
		var passwd=document.getElementById("passwd");
		var passwdChk=document.getElementById("passwdChk");
		var nick=document.getElementById("nick");
		
		// 본인확인 버튼 클릭 여부
        if(idfi.value != "pwCheck"){ 	//본인확인 팝업창에서 실행한 결과값을 idCheck에 넣었다.
			alert("본인확인 버튼을 클릭해 주세요.");
			form.oldpasswd.focus();
			return false;
		}
        if(!passwd.value){
			alert("새 비밀번호를 입력 하세요.");
			passwd.focus();
			return false;
		}
        if(!passwdChk.value){
			alert("새 비밀번호를 다시 입력 하세요.");
			passwdChk.focus();
			return false;
		}
		//아이디와 비밀번호가 같은지 확인
		if ("${VIEW.userid}"==passwd.value) {
	      	alert("비밀번호가 ID와 똑같습니다. 다른 비밀번호를 입력해 주세요.");
	      	passwd.value = "";
	      	passwd.focus();
	      	return false;
    	}
		//비밀번호 공백 사용 금지
		if (passwd.value.indexOf(" ") >= 0) {
            alert("비밀번호에 공백을 사용할 수 없습니다.")
           	passwd.focus()
            passwd.select()
            return false;
        }
		
		// 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
		if(passwd.value != passwdChk.value){
			alert("비밀번호를 동일하게 입력하세요.");
			passwd.value = "";
			passwdChk.value = "";
			passwd.focus();
			return false;
		}	
		
		if(!nick.value){
			var result = confirm("새 닉네임을 입력하지 않았습니다. 기존 닉네임을 그대로 사용하시겠습니까?");
			if(result==true){
				nick.value = "${VIEW.nick}";
			}
			else if(result==false){
				nick.focus();
			}
			return false;
		}
		
		//닉네임 유효성 검사 (한글, 영문대소문자, 숫자만 허용)
        for (i = 0; i < nick.value.length; i++) {
            ch = nick.value.charAt(i)
            if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')&&!(ch >='가' && ch<='힣')) {
                alert("닉네임은 한글, 영문 대소문자, 숫자만 입력가능합니다.")
                nick.focus()
                nick.select()
                return false;
            }
        }
		$("#modifyForm").submit();
	
	}//end checkValue
	
	//본인확인 버튼 클릭 시 처리 기능
	function meChkAction() {
		var form = document.modifyForm;
		var passwd=$("#oldpasswd").val();
		var result=0;
				
		if(!form.oldpasswd.value){
			alert("비밀번호를 입력하세요.");
			form.oldpasswd.focus();
			return false;
		}
		//아이디와 비밀번호가 같은지 확인
		else if ("${VIEW.userid}"==form.oldpasswd.value) {
	      	alert("비밀번호가 ID와 똑같습니다. 다른 비밀번호를 입력해 주세요.");
	      	form.oldpasswd.value = "";
	      	form.oldpasswd.focus();
	      	return false;
    	}
		//비밀번호 공백 사용 금지
		else if (form.oldpasswd.value.indexOf(" ") >= 0) {
            alert("비밀번호에 공백을 사용할 수 없습니다.")
            form.oldpasswd.focus()
            form.oldpasswd.select()
            return false;
        }
        else{
        	$.ajax({
				async:false,
				type : "POST",
				url : "/member/meCheckProc.yo",
				data : passwd,
				dataType : "text",
				contentType: "application/json; charset=UTF-8",
				error : function(error){
					alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
				},
				success : function(result){
					
					if(result==0){
						alert("잘못된 비밀번호를 입력하였습니다.")
						$("#oldpasswd").focus();
						$("#oldpasswd").value = "";
					}
					
					else if(result==1){
						form.identification.value ="pwCheck";
						document.getElementById("oldpasswd").disabled=true;
						document.getElementById("memberChk").disabled=true;
						var result=confirm("본인확인 완료되었습니다. 비밀번호을 변경하시겠습니까?")
						if(result==true){
							document.getElementById("passwd").disabled = false;
							document.getElementById("passwdChk").disabled = false;
							document.getElementById("nick").disabled = false;
							document.getElementById("passwd").focus();
						}
						else if(result==false){
							document.getElementById("passwd").value="${VIEW.passwd}";
							document.getElementById("passwdChk").value="${VIEW.passwd}";
							document.getElementById("nick").disabled = false;
							document.getElementById("nick").focus();
						}
						
					}
					else{
						alert("에러가 발생하였습니다.")
					}
        	   	}//end success
			});//end ajax
        }//end else
	}//end meChkAction()
	
		
	// 취소 버튼 클릭시 회원 상제보기 화면으로 이동
	function goFirstForm() {
		location.href="/";
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
		<p class="alertText" >*내 기준지를 수정하려면 지도로 즐기기 화면에서 내 기준지 등록 기능을 사용해 주세요. 등록한 내용이 자동 반영됩니다.</p>
		
		<div class="formGroup">
			<div class="inputTitle">기존 비밀번호</div><div class="inputbox">
			<input type="password" name="oldpasswd"  id="oldpasswd" placeholder=" 기존 비밀번호를 입력하세요" class="formControl" maxlength="50" /></div>
			<button type="button" class="innerBtn" id="memberChk" onclick="meChkAction()" disabled="disabled">본인확인</button>
			<input type="hidden" name="identification"  id="identification" value="pwUncheck" >
		</div>
		
		
		<!-- 기존 비밀번호를 입력해서 맞을 경우만  수정할 수 있도록 처리-->	
		<div class="formGroup">
			<div class="inputTitle">새 비밀번호</div>
			<div class="inputbox"><input type="password" name="passwd"  id="passwd" placeholder="새 비밀번호를 입력하세요" class="formControl" maxlength="50" disabled="disabled" /></div>
		</div>
		<div class="formGroup">	
		<div class="inputTitle">새 비밀번호 확인</div>
			<div class="inputbox"><input type="password" name="passwdChk"  id="passwdChk" placeholder="비밀번호를 다시 입력하세요"" class="formControl" maxlength="50" disabled="disabled" /></div>
		</div>
		<div class="formGroup">
			<div class="inputTitle">닉네임</div>
			<div class="inputbox"><input type="text" name="nick"  id="nick" placeholder="${VIEW.nick}" class="formControl" maxlength="50" disabled="disabled" /></div>
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