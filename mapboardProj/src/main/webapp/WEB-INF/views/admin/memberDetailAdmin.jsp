<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>회원 정보 상세화면</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
	
	.formGroup{width:800px;display:flex;}
	.formBtn{text-align:center;padding:10px}
	.detailBox{width: 100%;
						  padding: 15px 20px;
						  margin: 8px 0;
						  display: inline-block;
						  border: 1px solid #ccc;
						  border-radius: 4px;
						  box-sizing: border-box;
						  width:400px;
						  background:#eeeeee;}
	.selectBox{width: 100%;
						  padding: 15px 0px;
						  display: inline-block;
						  box-sizing: border-box;
						  width:400px;}

	select {
			    width: 200px;
			    height: 40px;
			    padding-left: 10px;
			    font-size: 18px;
			    color: #006fff;
			    border: 1px solid #006fff;
			    border-radius: 3px;
				}
	.inputTitle{font-weight:bold;font-size:20px;margin:8px 20px 8px 0px;width:150px;padding: 15px 20px;}
		
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
	#subTitle{font-size:50px; text-align:center; font-weight:bold;}
	.alertText{color:red; font-weight:bold;padding-left:230px;}
	#loginText{color:darkgray;font-size:20px; font-weight:bold;padding-top: 20px; }

	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	$(function(){
		<%--수정 버튼을 클릭했을 때 수정처리  --%>
		$("#updateBtn").click(function(e){
			$("#memForm").submit();
		});
		
		$("#listBtn").click(function(){
			location.href = "/member/memberList.yo?nowPage=${nowPage}";
		});
		
	});
	
	</script>
</head>
<body>
<div class="joinFrm">
<p id="subTitle">회원 정보 상세보기</p>
<br>
	<form id="memForm" method="post" action="/member/memberUpdateAdmin.yo">
		<div class="formGroup">
			<div class="inputTitle">아이디</div>
			<div class="detailBox">${VIEW.userid}	</div>
			<input type="hidden" name="userid"  id="userid" value="${VIEW.userid}" />
			<input type="hidden" name="nowPage"  id="nowPage" value="${nowPage}" />
		</div>
		<div class="formGroup">
			<div class="inputTitle">비밀번호</div>
			<div class="detailBox">********</div>
		</div>
		<div class="formGroup">
			<div class="inputTitle">이름</div>
			<div class="detailBox">${VIEW.uname}</div>
		</div>
		<div class="formGroup">
			<div class="inputTitle">닉네임</div>
			<div class="detailBox">${VIEW.nick}</div>
		</div>
		<div class="formGroup">
			<div class="inputTitle">내 기준지</div>
			<div class="detailBox">위도: ${VIEW.latitude}, 경도: ${VIEW.longitude}<br/>주소: ${VIEW.juso}</div>
		</div>
		<div class="formGroup">
			<div class="inputTitle">등급</div>
			<div class="selectBox">
				<select name="ulevel" id="ulevel">
	  				<option value=1>1</option>
	  				<option value=10>10</option>
	  			</select>
			</div>
		</div>
		<div class="formGroup">
			<div class="inputTitle">상태</div>
			<div class="selectBox">
				<select name="status" id="status">
	  				<option value="Y">Y</option>
	  				<option value="N">N</option>
	  			</select>
			</div>
		</div>
	
		<div class="formBtn">
			<input type="submit" id="updateBtn" class="actionBtn" value="수정"  />
			<input type="button" id="listBtn" class="actionBtn" value="목록" />
		</div>
	</form>
</div>
</body>
</html>