<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
	<title>아이디 중복체크 팝업</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<style type="text/css">
		#chk{text-align :center;}
		#cancelBtn{visibility:visible;}
		#useBtn{visibility:hidden;}
		#subTitle{font-size:30px; margin:auto;text-align:center; font-weight:bold; width:100%;}
	</style>

	
	<script>
		$(function(){
			// 회원가입창의 아이디 입력란의 값을 가져온다.
			$("#userid").val(opener.document.joinForm.userid.value);
		});
		
		
		// 아이디 중복체크 실행 함수
		function idCheck(){
			var userid=$("#userid").val();
			var result=0;
	
			if(!userid){
				alert("아이디를 입력하지 않았습니다.");
				return false;
			} 
			else if((userid < "0" || userid > "9") && (userid < "A" || userid > "Z") && (userid < "a" || userid > "z" )){ 
				alert("한글 및 특수문자는 아이디로 사용하실 수 없습니다.");
				return false;
			}
			else{
					$.ajax({
					async:false,
					type : "POST",
					url : "/member/idCheckProc.yo",
					data : userid,
					dataType : "text",
					contentType: "application/json; charset=UTF-8",
					error : function(error){
						alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
					},
					success : function(result){
						if(result==0){
							$("#cancelBtn").css('visibility','hidden');
							$("#useBtn").css('visibility','visible');
							$("#msg").html("사용 가능한 아이디입니다.");
							
						}
						else if(result==1){
							alert("이미 존재하는 아이디입니다. \n다른 아이디를 사용해 주세요.")
							$("#cancelBtn").css('visibility','visible');
							$("#useBtn").css('visibility','hidden');
							$("#msg").html("");
						}
						else{
							alert("에러가 발생하였습니다.")
						}
					}				
				
				});
			}
		}
		
		// 사용하기 클릭 시 부모창으로 값 전달 
		function sendCheckValue(){
			// 중복체크 결과인 idCheck 값을 전달한다.
			opener.document.joinForm.idDuplication.value ="idCheck";
			// 회원가입 화면의 ID입력란에 값을 전달
			opener.document.joinForm.userid.value = $("#userid").val();
			opener.document.joinForm.passwd.focus();
			
			if (opener != null) {
	        	opener.chkForm = null;
	        	self.close();
			}	
		}	
	</script>
</head>
<body>
  <div id="wrap">
	<br>
	<div id="subTitle">아이디 중복체크</div>
	<hr size="1" width="460">
	<br>
	<div id="chk">
		<form id="checkForm">
			<input type="text" name="idinput" id="userid">
			<input type="button" value="중복확인" onclick="idCheck()">
		</form>
		<div id="msg"></div>
		<br>
		<input id="cancelBtn" type="button" value="취소" onclick="window.close()" /><br>
		<input id="useBtn" type="button" value="사용하기" onclick="sendCheckValue()" />
	</div>
</div>	
</body>
</html>