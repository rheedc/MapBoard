<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
	<title>본인확인 팝업</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<style type="text/css">
		#chk{text-align :center;}
		#cancelBtn{visibility:visible;}
		#leaveBtn{visibility:hidden;}
		#subTitle{font-size:30px; margin:auto;text-align:center; font-weight:bold; width:100%;}
	</style>

	
	<script>
		
		// 본인확인 실행 함수
		function pwCheck(){
			var passwd=$("#passwd").val();
			var result=0;
						
			if(!passwd){
				alert("비밀번호를 입력하세요.");
				$("#passwd").focus();
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
							$("#passwd").focus();
							$("#cancelBtn").css('visibility','visible');
							$("#leaveBtn").css('visibility','hidden');
							$("#msg").html("");
							$("#passwd").value = "";
						}
						
						else if(result==1){
							$("#cancelBtn").css('visibility','hidden');
							$("#leaveBtn").css('visibility','visible');
							$("#msg").html("본인확인 완료되었습니다.");
							
						}
						else{
							alert("에러가 발생하였습니다.")
						}
					}				
				
				});
			}
		}
		
		$(function(){
			$("#leaveBtn").click(function(e){
				opener.parent.location= "/member/memberLeaveProc.yo";
				window.close();
			});
			
		})	;
		
	</script>
</head>
<body>
  <div id="wrap">
	<br>
	<div id="subTitle">본인확인</div>
	<hr size="1" width="460">
	<br>
	<div id="chk">
		<form id="checkForm">
			<input type="password" name="passwd" id="passwd">
			<input type="button" value="본인확인" onclick="pwCheck()">
		</form>
		<div id="msg"></div>
		<br>
		<input id="cancelBtn" type="button" value="취소" onclick="window.close()" /><br>
		<input id="leaveBtn" type="button" value="탈퇴하기" onclick="pwCheck()" />
	</div>
</div>	
</body>
</html>