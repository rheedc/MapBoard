<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!doctype html>
<!-- 
 * 목적: my통계페이지
 * 작성자: 조은비
 * 작성일: 2018-12-17
 * 최종수정일: 2018-12-18
 -->
<html lang="en">
<head>
<title>Document</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
	table {
		border-collapse:collapse;
		margin:auto;
		text-align:center;
		width:50%;
	}
	#map{
		margin-left:20%;
		width:60%; height:700px;}
	
	/* UI Object 가로 */
	.hGraph {width:50%;margin:auto;opacity:0}
   	.hGraph ul{ margin:0 50px 0 50px; padding:1px 0 0 0; border:1px solid #ddd; border-top:0; border-right:0; font-size:15px; font-family:Tahoma, Geneva, sans-serif; list-style:none;}
	.hGraph li{ position:relative; margin:10px 0; white-space:nowrap; vertical-align:top;}
	.hGraph .gTerm{ position:absolute; width:40px; top:0; left:-50px; line-height:20px; text-align:right; color:#767676; font-weight:bold;}
	.hGraph .gBar{ position:relative; display:inline-block; height:15px; border:1px solid #ff0000; border-left:0; background:#ff0000;}
	.hGraph .gCnt{ position:relative; display:inline-block; height:15px; border:1px solid #ffff00; border-left:0; background:#ffff00;}
	.hGraph .gBar span{ position:absolute; width:40px; line-height:15px; top:0; right:-50px; color:#767676;}
	.hGraph .gCnt span{ position:absolute; width:40px; line-height:15px; top:0; right:-50px; color:#767676;}
	
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
<!-- 추가된 프로그램 -->
<script>


	$(function(){
		$("#view").animate({opacity:1});
		
	
		
		//지도그리는 부분
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng(${DATA.latitude} , ${DATA.longitude} ), // 지도의 중심좌표
	        level: 8 // 지도의 확대 레벨
	    };
		var map = new daum.maps.Map(mapContainer, mapOption);
		
		<c:forEach var="LOC" items="${locInfo}"  varStatus="status">
		
			// 마커가 표시될 위치입니다 
			var markerPosition  = new daum.maps.LatLng(${LOC.latitude} , ${LOC.longitude}); 
			
			// 마커 이미지의 이미지 크기 입니다 reviewcnt
		    var imageSize = new daum.maps.Size(25,35); 
		    
		    // 마커 이미지를 생성합니다
		    var imageloc="../resources/img/markLoc.png";
		    var markerImage = new daum.maps.MarkerImage(imageloc, imageSize);
		    
		 	// 마커를 생성합니다
			var marker2 = new daum.maps.Marker({
				map:map,
			    position: markerPosition,
			    image : markerImage 
			});   

		 	
		 	
			daum.maps.event.addListener(marker2, 'click', function(mouseEvent){
				$(location).attr("href","../board/hitProc.yo?bidx="+${LOC.bidx});
				});
			
		</c:forEach>
		
		
		// 내기준지 
		var markerPosition  = new daum.maps.LatLng(${DATA.latitude} , ${DATA.longitude}); 
		var marker = new daum.maps.Marker({
		    position: markerPosition
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		var iwContent = '<div>기준지</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwPosition = new daum.maps.LatLng(${DATA.latitude}, ${DATA.longitude}); //인포윈도우 표시 위치입니다
		// 인포윈도우를 생성합니다
		var infowindow = new daum.maps.InfoWindow({
		    position : iwPosition, 
		    content : iwContent 
		});
		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		infowindow.open(map, marker); 
	});
</script>
</head>
<body>
	<c:if test="${empty DATA}">
	<br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<table>
		<tr>
			<td>
				<h1>내 기준지 등록 후 사용하실 수 있습니다</h3>
				<br/>
				<a href="../place/placeList.yo">내기준지 등록하러가기</a>
			</td>
		</tr>
	</table>
	</c:if>
	<c:if test="${not empty DATA}">
	
	<table>
		<tr>
			<td>
				<h3 align="left">MY통계</h3>
			</td>
		</tr>
	</table>

	<br/>
	<%-- 1. 목록을 출력 --%>
	<table>
		<tr><td align="center"><h4>총이동거리 : ${DATA.move_total}Km &nbsp;&nbsp;&nbsp;&nbsp;총이동건수 : ${DATA.movecnt_total}건</h4></td></tr>
	</table>
	<br/>
	
    <div class="hGraph" id="view">
		<ul>
			<li><span class="gTerm">총계</span>
				<span class="gBar" style="width:100%"><span>${DATA.move_total}Km</span></span><br/>
				<span class="gCnt" style="width:100%"><span>${DATA.movecnt_total}건</span></span>
			</li>
			<li><span class="gTerm">1월</span>
				<span class="gBar" style="width:${monthMove.get('1월')*100/DATA.move_total}%"><span>${monthMove.get("1월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('1월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("1월")}건</span></span>
			</li>
			<li><span class="gTerm">2월</span>
				<span class="gBar" style="width:${monthMove.get('2월')*100/DATA.move_total}%"><span>${monthMove.get("2월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('2월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("2월")}건</span></span>
			</li>
			<li><span class="gTerm">3월</span>
				<span class="gBar" style="width:${monthMove.get('3월')*100/DATA.move_total}%"><span>${monthMove.get("3월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('3월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("3월")}건</span></span>
			</li>
			<li><span class="gTerm">4월</span>
				<span class="gBar" style="width:${monthMove.get('4월')*100/DATA.move_total}%"><span>${monthMove.get("4월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('4월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("4월")}건</span></span>
			</li>
			<li><span class="gTerm">5월</span>
				<span class="gBar" style="width:${monthMove.get('5월')*100/DATA.move_total}%"><span>${monthMove.get("5월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('5월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("5월")}건</span></span>
			</li>
			<li><span class="gTerm">6월</span>
				<span class="gBar" style="width:${monthMove.get('6월')*100/DATA.move_total}%"><span>${monthMove.get("6월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('6월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("6월")}건</span></span>
			</li>
			<li><span class="gTerm">7월</span>
				<span class="gBar" style="width:${monthMove.get('7월')*100/DATA.move_total}%"><span>${monthMove.get("7월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('7월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("7월")}건</span></span>
			</li>
			<li><span class="gTerm">8월</span>
				<span class="gBar" style="width:${monthMove.get('8월')*100/DATA.move_total}%"><span>${monthMove.get("8월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('8월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("8월")}건</span></span>
			</li>
			<li><span class="gTerm">9월</span>
				<span class="gBar" style="width:${monthMove.get('9월')*100/DATA.move_total}%"><span>${monthMove.get("9월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('9월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("9월")}건</span></span>
			</li>
			<li><span class="gTerm">10월</span>
				<span class="gBar" style="width:${monthMove.get('10월')*100/DATA.move_total}%"><span>${monthMove.get("10월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('10월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("10월")}건</span></span>
			</li>
			<li><span class="gTerm">11월</span>
				<span class="gBar" style="width:${monthMove.get('11월')*100/DATA.move_total}%"><span>${monthMove.get("11월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('11월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("11월")}건</span></span>
			</li>
			<li><span class="gTerm">12월</span>
				<span class="gBar" style="width:${monthMove.get('12월')*100/DATA.move_total}%"><span>${monthMove.get("12월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('12월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("12월")}건</span></span>
			</li>
			
		</ul>
	</div>
	<br/>
	<table>
		<tr><td align="center"><h4>지도에서 확인하기</h4></td></tr>
	</table>
	<div id="map"></div>
	</c:if>
	
</body>
</html>
