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
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		$(function(){
			
			// newWBtn 클릭시
			$('#newWBtn').click(function(){
				alert('w');
			});	// newWBtn 끝
			
			// newBBtn 클릭시
			$('#newBBtn').click(function(){
				alert('b');
			});	// newBBtn 끝
			
			
		});
	</script>
</head>
<body>
  <form id="myPlaceForm" action="#" method="get">
  	<table>
  		<tr>
  			<td>장소명</td>
  			<td>
  				<input type="text" id="newPlaceName" name="newPlaceName" placeholder="장소를 한 글자 이상 입력해주세요" />
  			</td>
  		</tr>
  		<tr>
  			<td>좌표정보</td>
  			<td>
  				<input type="text" id="newPlaceLocation" name="newPlaceLocation" value="x좌표, y좌표"  readonly/>
  				<input type="hidden" id="newPlaceLocationX" name="newPlaceLocationX"/>
  				<input type="hidden" id="newPlaceLocationY" name="newPlaceLocationY"/>
  			</td>
  		</tr>
  		<tr>
  			<td>주소</td>
  			<td>
  				<input type="text" id="newPlaceAddress" name="newPlaceAddress"  readonly/>
  			</td>
  		</tr>
  		<tr>
  			<td>상세주소</td>
  			<td>
  				<input type="text" id="newPlaceDetailAddress" name="newPlaceDetailAddress" placeholder="상세주소를 한 글자 이상 입력해주세요"/ >
  			</td>
  		</tr>
  		<tr>
  		<td></td>
  		<td><input type="button" id=newWBtn  name="newWBtn" value="등록"/></td>
  		<td><input type="button" id=newBBtn  name="newBBtn" value="입력취소"/></td>
  		</tr>
  	</table>
  </form>
</body>
</html>
