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
										
		table {width : 1000px;
					}
					
		
		
		
		
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
  		<div id="select">
	  		<table >
	  			<tr>
	  				<th width="50%">
	  					<select>
	  						<option>--시군구 선택--</option>
	  						<option value="11680">강남구</option>
	  						<option value="11740">강동구</option>
	  						<option value="11305">강북구</option>
	  						<option value="11500">강서구</option>
	  						<option value="11620">관악구</option>
	  						
	  						<option value="11215">광진구</option>
	  						<option value="11530">구로구</option>
	  						<option value="11545">금천구</option>
	  						<option value="11350">노원구</option>
	  						<option value="11320">도봉구</option>
	  						
	  						<option value="11230">동대문구</option>
	  						<option value="11590">동작구</option>
	  						<option value="11440">마포구</option>
	  						<option value="11410">서대문구</option>
	  						<option value="11650">서초구</option>
	  						
	  						<option value="11200">성동구</option>
	  						<option value="11290">성북구</option>
	  						<option value="11710">송파구</option>
	  						<option value="11470">양천구</option>
	  						<option value="11560">영등포구</option>
	  						
	  						<option value="11170">용산구</option>
	  						<option value="11380">은평구</option>
	  						<option value="11110">종로구</option>
	  						<option value="11140">중구</option>
	  						<option value="11260">중랑구</option>
	  					</select>
	  				</th>
	  				<td width="30%">
						<input type="text" id="select" name="select"/>
					</td>
	  				<td>
	  					<input type="button" id="sBtn"  value="조회"/>
	  				</td>
				</tr>
	  		</table>
  		</div>
  		
  		<table>
  			<tr>
  				<th rowspan="3" width="15%">사진</th>
  				<td width="65%">상가명</td>
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
  				<th colspan="2">페이징</th>
  				<td>
  					<input type="button" id="mBtn" value="지도로 즐기기" action=""/>
  				</td>
  			</tr>
  		</table>
  		
  	</form>
</body>
</html>