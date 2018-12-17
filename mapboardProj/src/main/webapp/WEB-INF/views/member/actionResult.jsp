<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>결과페이지</title>
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
	#homeBtn{background-color: #555555; /* black */}
	.subTitle{font-size:20px; font-weight:bold;width:600px;text-align:center;margin:auto;padding-top:50px;}
	#subTitle1{font-size:50px;color:#4169e1;}
	
	
	</style>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		
	$(function(){
		
		<%--로그인 버튼을 클릭했을 때 submit처리하는 함수  --%>
		$("#loginBtn").click(function(e){
			e.preventDefault();
			login_validate();
		});
		
		
		$("#homeBtn").click(function(){
			location.href = '/home.yo';
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
<div class="joinResult">
<div class="subTitle">
	<p id="subTitle1">I KNOW YOU KNOW <br/>가입을 환영합니다.</P>
	<p id="subTitle2">이제 로그인을 하고 저희가 제공하는 모든 서비스를 즐기세요</p>
</div>
<br>
	<div class="loginFrm">
		<form id="loginForm" name="loginForm"  method="post" action="/member/LoginProc.yo" class="navbar-form navbar-left">
			<div class="formGroup">
				<input type="text" name="userid"  id="id" value="${VIEW.userid}" class="formControl" />
			</div>
			<div class="formGroup">
			    <input type="password" name="passwd" id="pw" placeholder="비밀번호를 입력하세요" class="formControl">
			</div>
			<div class="formGroup">
				<button type="button" id="loginBtn" class="actionBtn" >로그인</button>
				<button type="button" id="homeBtn" class="actionBtn">메인으로 이동</button>
			</div>
		</form>
	</div>  
	
</div>
</body>
</html>