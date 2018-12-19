<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>Document</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
	/* style 작성부분 */
		table, tr, th, td {margin : auto;
										border : 1px solid;
										text-align : center;
										height : 42px;
										}
										
		
					
		#text-left { text-align : left;
							padding-left:10px;
							}
		
		#title {text-align : center;
					font-size : 30px;
					width : 500px;
					height : 50px;
					}
		
		#width {width : 100px;
						}		
							
		
						
		#wide {width : 700px;
					 }
		
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		$(document).ready(function(){
			
			//원글 수정
			$("#mBtn").click(function(){
				//수정폼으로 이동
				$(location).attr("href","../board/updateForm.yo?bidx=${VIEW.bidx}&nowPage=${nowPage}&place_name=${place_name}&sigungu_name=${sigungu_name}");
			});
			
			//원글 삭제
			$("#dBtn").click(function(){
				if(confirm("정말로 삭제하시겠습니까?")){
					$(location).attr("href","../board/boardDelete.yo?bidx=${VIEW.bidx}&nowPage=${nowPage}&place_name=${place_name}&sigungu_name=${sigungu_name}");
					
				}
			});
			
			//댓글 등록 버튼 
			$("#wrBtn").click(function(){
				$("#wrfrm").submit();
			});
			
			//댓글 수정버튼 클릭시 댓글 수정폼으로 변경
			$(".mCBtn").click(function(){
				var button=$(this);
				var table=button.parents("table");
				var id=table.attr("id");
				//테이블 감추기
				$("#"+id).hide();
				//수정폼 보여주기
				$("#"+id+"frm").show();
			})
			
			//댓글 수정 등록하기
			$(".sCBtn").click(function(){
				var button=$(this);
				var form=button.parent("form");
				$(form).submit();
			});
			
			//댓글 수정 취소하기
			$(".bCBtn").click(function(){
				var button=$(this);
				var table=button.parents("table");
				var id=table.attr("id");
				$(location).attr("href","../board/boardDetail.yo?reNo="+id+"&bidx=${bidx}&nowPage=${nowPage}");
			})
			
			//댓글 삭제 버튼
			$("#dCBtn").click(function(){
				if(confirm("정말로 삭제하시겠습니까?")){
					var button=$(this);
					var table=button.parents("table");
					var id=table.attr("id");
					$(location).attr("href","../board/replyDelete.yo?reNo="+id+"&oriNo=${oriNo}&nowPage=${nowPage}");
				}
			});
			
		});	
		
		//-- 송승환의 지도 추가 부분~~~~~~~~~~
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
		
		var iwContent = '<div style="padding:5px;">상가명 : ${VIEW.place_name}<br/>지번주소: ${VIEW.juso} </div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		    iwPosition = new daum.maps.LatLng(${VIEW.latitude} , ${VIEW.longitude}); //인포윈도우 표시 위치입니다
		
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
<%-- 게시판 상세보기 --%>
  		<table align="center" width="70%">
  			<tr>
  				<td>
  					<h3 align="left">제목 : ${VIEW.subject}</h3>
  				</td>
  			</tr>
  		</table>
 	<!-- 원글상세보기 --> 		
  		<table align="center" width="70%" class="style1">
  			<tr>
  				<th id="text-left">작성자: ${VIEW.userid}	작성일: ${VIEW.createdt}</td>
  				<td id="width">
  					<input type="button" id="mBtn" value="수정"/>
  				</td>
  				<td id="width">
  					<input type="button" id="dBtn" value="삭제"/>
  				</td>
  			</tr>
  			<tr>
  				<th colspan="3">사진, 페이징처리
  				</th>
  			</tr>
  			<tr>
  				<th colspan="3">
  					<textarea id="body" name="body" cols="136" style="resize:none;">${VIEW.comm}</textarea>
  				</th>
  			</tr>
  		</table>
  		
  	<!-- 지도보기 -->
  		<table align="center" width="70%">
  			<tr>
  				<td>장소명: ${VIEW.place_name}<br/>분류명: ${categoryName}<br/>장소평가:${VIEW.point}</td>
  			</tr>
  			<tr>
  				<td>지도삽입 : map
  					<div id="map" style="width:100%;height:350px;"></div>
  				</td>  				
  			</tr>
  	<%-- 추천하기 체크를 위한 form --%>
  	
	<!-- 댓글쓰기 추가 form-->
  		
  		<!-- 목록보기 -->
  		<table aling="center" width="70%">
  			<tr align="center">
  				<td>
  					<input type="button" id="lBtn" value="목록보기" class="button" 
  					onclick="location.href='../../board/boardList2.yo?bidx=${VIEW.bidx}&nowPage=${nowPage}&place_name=${place_name}&sigungu_name=${sigungu_name}'"/>
  				</td>
  			</tr>
  		</table>
</body>
</html>