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
	#map{margin-left:30px;width:100%; height:350px;}
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

	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		$(document).ready(function(){
			//화면이 보여질때 지도숨기기 버튼과 지도를 안보이도록 한다.
			document.getElementById('showMap').hidden = true;
	        document.getElementById('map').hidden = false;
			

		});
		
		$(function(){
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new daum.maps.LatLng(${VIEW.latitude} , ${VIEW.longitude} ), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
			var map = new daum.maps.Map(mapContainer, mapOption);
			
			// 마커가 표시될 위치입니다 
			var markerPosition  = new daum.maps.LatLng(${VIEW.latitude} , ${VIEW.longitude}); 
			
			// 마커를 생성합니다
			var marker = new daum.maps.Marker({
			    position: markerPosition
			});
			
			// 마커가 지도 위에 표시되도록 설정합니다
			marker.setMap(map);
			
			var iwContent = '<div style="padding:5px;">등록자: ${VIEW.nick} <br/>지번주소: ${VIEW.juso} </div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwPosition = new daum.maps.LatLng(${VIEW.latitude}, ${VIEW.longitude}); //인포윈도우 표시 위치입니다
			
			// 인포윈도우를 생성합니다
			var infowindow = new daum.maps.InfoWindow({
			    position : iwPosition, 
			    content : iwContent 
			});
			  
			// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
			infowindow.open(map, marker); 
		});
		// 숨기기 버튼 클릭 시 보이기 버튼을 보이게 하고 과 지도와 숨기기 버튼을 숨긴다.
		function hide(){
	        document.getElementById('showMap').hidden = false;
	        document.getElementById('map').hidden = true;
	        document.getElementById('closeMap').hidden = true;
	    }
		// 보이기 버튼 클릭 시 숨기기 버튼을 보이게 하고 지도를 보이게 하고 보이기 버튼은 숨긴다. 
	    function show(){
	    	document.getElementById('showMap').hidden = true;
	        document.getElementById('map').hidden = false;
	        document.getElementById('closeMap').hidden = false;
	       
	    }
	
	</script>
</head>
<body>
<div class="joinFrm">
<p id="subTitle">회원 정보 상세보기</p>
<br/>
 <form id="memForm" name="memForm" method="post" action="/member/memberUpdateAdmin.yo">
<!-- <form id="memForm" name="memForm" method="post" action="/member/m.yo"> -->
		<div class="formGroup">
			<div class="inputTitle">아이디</div>
			<div class="detailBox">${VIEW.userid}	</div>
			<input type="hidden" name="userid"  id="userid" value="${VIEW.userid}" />
			<input type="hidden" name="nowPage"  id="nowPage" value="${nowPage}" />
		</div>
		<div class="formGroup">
			<div class="inputTitle">비밀번호</div>
			<div class="detailBox">*******<font color="#eeeeee">${VIEW.passwd}</font></div>
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
			
			<button type="button" class="innerBtn" id="showMap" onclick="show()">지도보이기</button>
			<c:if test="${VIEW.juso ne null}">
			<button type="button" class="innerBtn" id="closeMap" onclick="hide()">숨기기</button>
			</c:if>
		</div>
		<div>
			<c:if test="${VIEW.juso ne null}">
				<div id="map"></div>
			</c:if>
		</div>
			
		<div class="formGroup">
			<div class="inputTitle">등급</div>
			<div class="selectBox">
				<select name="ulevel" >
	  				<option value=1 selected="selected">1</option>
	  				<option value=10>10</option>
	  			</select>
			</div>
		</div>
		<div class="formGroup">
			<div class="inputTitle">상태</div>
			<div class="selectBox">
				<select name="status" id="status">
	  				<option value="Y" selected="selected">Y</option>
	  				<option value="N">N</option>
	  			</select>
			</div>
		</div>
	
		<div class="formBtn">
			<input type="submit" id="updateBtn" class="actionBtn" value="수정"  />
			<input type="button" id="listBtn" class="actionBtn" value="취소" onclick="location.href='/member/memberList.yo?nowPage=${nowPage}'"/>
		</div>
</form>
</div>
</body>
</html>