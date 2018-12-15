<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>로그인 Form</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
	.formGroup{width:600px;text-align:center;padding:10px;}
	.formControl{width: 100%;
						  padding: 15px 20px;
						  margin: 8px 0;
						  display: inline-block;
						  border: 1px solid #ccc;
						  border-radius: 4px;
						  box-sizing: border-box;}
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
	#subTitle{font-size:50px; font-weight:bold;width:600px;text-align:center;padding:10px;}

	</style>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		$(document).ready(function(){
				<%--로그인 버튼을 클릭했을 때 submit처리하는 함수  --%>
				$("#loginBtn").click(function(e){
					e.preventDefault();
					login_validate();
				});
							
				<%--회원가입 버튼을 클릭했을 때 회원가입폼 화면으로 이동시키는 함수--%>
				$("#joinBtn").click(function(){
					location.href = '/member/joinForm.yo';
				});
				
			});
		function login_validate(){
			if($("#id").val().length <1){
				alert("아이디를 입력하세요.");
			}else if($("#pw").val().length <1){
				alert("비밀번호를 입력하세요.");
			}else{
				$("#loginForm").submit();
			}
			
		}
		
			
	</script>
</head>
<body>
<div class="loginFrm">
<p id="subTitle">로그인</p>
<br>

<form id="loginForm" name="loginForm"  method="post" action="/member/LoginProc.yo" class="navbar-form navbar-left">
	<div class="formGroup">
		<input type="text" name="userid"  id="id" placeholder="아이디를 입력하세요" class="formControl" />
	</div>
	<div class="formGroup">
	    <input type="password" name="passwd" id="pw" placeholder="비밀번호를 입력하세요" class="formControl">
	</div>
	<div class="formGroup">
		<button type="button" id="loginBtn" class="actionBtn" >로그인</button>
		<button type="button" id="joinBtn" class="actionBtn">회원가입</button>
	</div>
	
</form>

</div>  
</body>
</html>