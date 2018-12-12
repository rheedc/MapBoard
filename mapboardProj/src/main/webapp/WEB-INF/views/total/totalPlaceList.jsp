<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<!-- 
 * 목적: 지도게시판 기능별 따로 작성된 페이지들을 한번에 모아보는 페이지
 * 작성자: 조은비
 * 작성일: 2018-12-10
 * 최종수정일: 2018-12-11
 -->
<html lang="en">
<head>
	<title>Document</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
	/* style 작성부분 */
	#top_content {
	width:1900px;
	height:100px;
	text-align:center;
	background-color:pink;
	}
	#left_content {
	width:500px;
	height:800px;
	float:left;
	text-align:left;
	background-color:yellow;
	}
	#right_content {
	width:1900px;
	height:800px;
	text-align:center;
	background-color:brown;
	}
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	$(document).ready(function(){
		
		//카테고리에서 클릭이벤트 발생할 때
		$(".category_no").click(function(){
			$("#searchFrm_j").submit()
		})
		//검색버튼 클릭이벤트 발생했을 때
		$("#sBtn_j").click(function(){
			$("#searchFrm_j").submit()
		})
	})
	</script>
</head>
<body>
  <div id="div_root">
	<div id="top_content">윗부분
	<form id="searchFrm_j" method="get" action="../total/totalPlaceList.yo">
		<table>
			<tr>
				<!-- <td><input type="text" id="guname" name="guname" placeholder="서울특별시" readonly/><div id="guname1"></div></td> -->
				<td><input type="text" id="sigungu_name" name="sigungu_name" placeholder="서울특별시"  value="구로구"></td>
				<td><input type="text" id="place_name" name="place_name" placeholder="장소이름을 입력해주세요"></td>
				<td><input type="button" id="sBtn_j" name="sBtn_j" value="검색"></td>
				<td>
					<input type="radio" name="category_no" value=10 class="category_no"> 전체
					<input type="radio" name="category_no" value=1 class="category_no"> 관광/여가/오락
					<input type="radio" name="category_no" value=2 class="category_no"> 숙박
					<input type="radio" name="category_no" value=3 class="category_no"> 의료
					<input type="radio" name="category_no" value=4 class="category_no"> 한식/중식/양식
					<input type="radio" name="category_no" value=5 class="category_no"> 커피점/카페
					<input type="radio" name="category_no" value=6 class="category_no"> 기타
				</td>
			</tr>
		</table>
	</form>
	</div>
	<div id="left_content">왼쪽내용</div>
	<div id="right_content">지도 부분 오른쪽내용</div>
	</div>
</body>
</html>
