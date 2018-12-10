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
		$(document).read(function(){
		//제목검색 sBtn
		$("#sBtn").click(function(){
			
		});
		//지도로 보기 mBtn
		$("#mBtn").click(function(){
			//지도보기로 가기
		});
	});
	</script>
</head>
<body>
  	<form id="" action="">
  		<table>
  			<tr>
  				<th>
  					<select>
  						<option value="강남">강남구</option>
  						<option value="강동">강동구</option>
  						<option value="강북">강북구</option>
  						<option value="강서">강서구</option>
  						<option value="관악">관악구</option>
  						
  						<option value="광진">광진구</option>
  						<option value="구로">구로구</option>
  						<option value="금천">금천구</option>
  						<option value="노원">노원구</option>
  						<option value="도봉">도봉구</option>
  						
  						<option value="동대문">동대문구</option>
  						<option value="동작">동작구</option>
  						<option value="마포">마포구</option>
  						<option value="서대문">서대문구</option>
  						<option value="서초">서초구</option>
  						
  						<option value="성동">성동구</option>
  						<option value="성북">성북구</option>
  						<option value="송파">송파구</option>
  						<option value="양천">양천구</option>
  						<option value="영등포">영등포구</option>
  						
  						<option value="용산">용산구</option>
  						<option value="은평">은평구</option>
  						<option value="종로">종로구</option>
  						<option value="중구">중구</option>
  						<option value="중랑">중랑구</option>
  					</select>
  				</th>
  				<td>검색
  					<insert type="button" id="sBtn"  value="조회"/>
  				</td>
			</tr>
  		</table>
  		
  		<table>
  			<tr>
  				<th rowspan="3">사진</th>
  				<td>상가명</td>
  				<td>작성일</td>
  			</tr>
  			<tr>
  				<td colspan="2">제목</td>
  			</tr>
  			<tr>
  				<td>작성자</td>
  				<td>조회수/추천수</td>
  			</tr>
  			
  			<tr>
  				<th rowspan="3">사진</th>
  				<td>상가명</td>
  				<td>작성일</td>
  			</tr>
  			<tr>
  				<td colspan="2">제목</td>
  			</tr>
  			<tr>
  				<td>작성자</td>
  				<td>조회수/추천수</td>
  			</tr>
  			
  			<tr>
  				<th rowspan="3">사진</th>
  				<td>상가명</td>
  				<td>작성일</td>
  			</tr>
  			<tr>
  				<td colspan="2">제목</td>
  			</tr>
  			<tr>
  				<td>작성자</td>
  				<td>조회수/추천수</td>
  			</tr>
  			
  			<tr>
  				<th rowspan="3">사진</th>
  				<td>상가명</td>
  				<td>작성일</td>
  			</tr>
  			<tr>
  				<td colspan="2">제목</td>
  			</tr>
  			<tr>
  				<td>작성자</td>
  				<td>조회수/추천수</td>
  			</tr>
  			
  			<tr>
  				<th rowspan="3">사진</th>
  				<td>상가명</td>
  				<td>작성일</td>
  			</tr>
  			<tr>
  				<td colspan="2">제목</td>
  			</tr>
  			<tr>
  				<td>작성자</td>
  				<td>조회수/추천수</td>
  			</tr>
  			
  			<tr>
  			<!-- 페이징 처리 -->
  				<th>페이징</th>
  				<td>
  					<input type="button" id="mBtn" value="지도로 즐기기" action=""/>
  				</td>
  			</tr>
  		</table>
  		
  	</form>
</body>
</html>