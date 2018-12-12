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
		//세부카테고리 숨기기
		$("#check_category").hide();
		
		//분류에서 전체를 선택했을 때 
		$(".check_all").click(function(){
			//전체 체크를 하지 않으면 카테고리 목록 보여주기
			if(!$(".check_all").is(":checked")){
				$("#check_category").show();	
			}
			//전체 체크를 했다면 카테고리 목록 숨기기
			else{
				$("#check_category").hide();
			}
		})
		//세부카테고리에서 클릭이벤트 발생할 때
		$(".category").click(function(){
			alert(this.value);
		})
	})
	</script>
</head>
<body>
  <div id="div_root">
	<div id="top_content">윗부분
	<table>
		<tr>
			<td><input type="text" id="place_name_j" name="place_name_j" placeholder="장소이름을 입력해주세요"></td>
			<td><input type="button" id="sBtn_j" name="sBtn_j" value="검색"></td>
			<td><input type="checkbox" name="c_check" class="check_all" value=0 checked="checked"/> 전체</td>
			<td id="check_category">
				<input type="checkbox" name="c_check" class="category" value=1> 관광/여가/오락
				<input type="checkbox" name="c_check" class="category" value=2> 숙박
				<input type="checkbox" name="c_check" class="category" value=3> 의료
				<input type="checkbox" name="c_check" class="category" value=4> 한식/중식/양식
				<input type="checkbox" name="c_check" class="category" value=5> 커피점/카페
				<input type="checkbox" name="c_check" class="category" value=6> 기타
			</td>
		</tr>
	</table>
	</div>
	<div id="left_content">왼쪽내용</div>
	<div id="right_content">지도 부분 오른쪽내용</div>
	</div>
</body>
</html>
