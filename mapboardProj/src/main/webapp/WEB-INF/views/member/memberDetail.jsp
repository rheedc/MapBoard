<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>나의 정보 상세화면</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
	
	.formGroup{width:800px;padding:10px;display:flex;}
	.formBtn{text-align:center;padding:10px}
	.detailBox{width: 100%;
						  padding: 15px 20px;
						  margin: 8px 0;
						  display: inline-block;
						  border: 1px solid #ccc;
						  border-radius: 4px;
						  box-sizing: border-box;
						  width:400px;}
	.inputTitle{font-weight:bold;font-size:20px;margin:8px 20px 8px 0px;width:180px;padding: 15px 20px;}
		
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
		<%--수정 버튼을 클릭했을 때 수정화면으로 이동  --%>
		$("#updateBtn").click(function(e){
			location.href = "/member/memberUpdateForm.yo";
		});
		
		$("#homeBtn").click(function(){
			location.href = "/home.yo";
		});
		
	});
	// 본인확인 실행 함수
	function meChkAction(){
		//팝업창 경로
		var url="/popup/popup_meCheck.yo";
		//팝업창 표시 위치
		var popupX = (window.screen.width / 2) - (300 / 2);		// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupY= (window.screen.height /2) - (500 / 2);			// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
		
		window.name = "parentForm";
		//팝업창 경로, 팝업창 이름, 위치(화면 중앙정렬) 및 크기 등 설정
		window.open(url,"chkForm", "status=no, width=500, height=300, resizable = no, scrollbars = no, left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY);	
	}

	</script>
</head>
<body>
<div class="joinFrm">
<p id="subTitle">나의 정보 상세보기</p>
<br>
		<div class="formGroup">
			<div class="inputTitle">아이디</div>
			<div class="detailBox">${VIEW.userid}	</div>
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
	
		<div class="formBtn">
			<input type="submit" id="updateBtn" class="actionBtn" value="수정"  />
			<input type="button" id="homeBtn" class="actionBtn" value="취소" />
			<input type="submit" id="leaveBtn" class="actionBtn" value="탈퇴" onclick="meChkAction()" />
		</div>

</div> 
</body>
</html>