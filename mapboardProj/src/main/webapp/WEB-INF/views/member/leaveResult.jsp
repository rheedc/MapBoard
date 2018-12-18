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
	#homeBtn{background-color: #4169e1; /* black */}
	.subTitle{font-size:40px; font-weight:bold;width:600px;text-align:center;margin:auto;padding-top:50px;}
	
	
	
	</style>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		
	$(function(){
		
		$("#homeBtn").click(function(){
			location.href = '/home.yo';
		});
	});
	</script>
</head>
<body>
<div class="joinResult">
<div class="subTitle">
	회원탈퇴가 완료되었습니다.<br/>그동안 함께 해서 즐거웠어요!!!
</div>
<br>
	<div class="loginFrm">
		<div class="formGroup">
			<button type="button" id="homeBtn" class="actionBtn">메인으로 이동</button>
		</div>
	</div>  
	
</div>
</body>
</html>