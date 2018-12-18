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
	table {
		border-collapse:collapse;
	}
	th {
		border-bottom:1px solid #337AB3;
		background-color:#337AB3;
		font-weight:lighter;
		color:white;
		text-align:center;
	}
	td {
		text-align:center;
	}
	
	.style1 th {
		text-align:center;
	}
	.style1 tr {
		border-bottom:1px solid #d7edf4;
	}
	.style1 tr:hover { 
		background-color: #d7edf4; 
	} 
	h3 {
		color:#337AB3;
	}
	a {
		color:black;
	}
	a:hover {
		font-weight:bold;
		color:#337AB3;
	}
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	$(document).ready(function(){
		//제목검색 sBtn
		$("#sBtn").click(function(){
			$("#searchFrm").submit();
		});
	});
	</script>
</head>
<body>
	<table align="center" width="70%">
		<tr>
			<td>
				<h3 align="left">게시물 목록보기</h3>
			</td>
		</tr>
	</table>
  	<form id="searchFrm" action="../board/boardList2.yo" method="get">
 			<!-- 검색하기 -->
  		<table border="1" align="center" width="70%"  height="50px">
  			<tr>
  				<td>
  					<select name="sigungu_name">
  						<option value="전체">--지역(구) 선택--</option>
  						<option value="강남구">강남구</option>
  						<option value="강동구">강동구</option>
  						<option value="강북구">강북구</option>
  						<option value="강서구">강서구</option>
  						<option value="관악구">관악구</option>
  						<option value="광진구">광진구</option>
  						<option value="구로구">구로구</option>
  						<option value="금천구">금천구</option>
  						<option value="노원구">노원구</option>
  						<option value="도봉구">도봉구</option>
  						<option value="동대문구">동대문구</option>
  						<option value="동작구">동작구</option>
  						<option value="마포구">마포구</option>
  						<option value="서대문구">서대문구</option>
  						<option value="서초구">서초구</option>
  						<option value="성동구">성동구</option>
  						<option value="성북구">성북구</option>
  						<option value="송파구">송파구</option>
  						<option value="양천구">양천구</option>
  						<option value="영등포구">영등포구</option>
  						<option value="용산구">용산구</option>
  						<option value="은평구">은평구</option>
  						<option value="종로구">종로구</option>
  						<option value="중구">중구</option>
  						<option value="중랑구">중랑구</option>
  					</select>
  					&nbsp;&nbsp;<input type="text" id="place_name" name="place_name" placeholder="장소명을 입력해주세요"/>
  					&nbsp;&nbsp;<input type="button" id="sBtn" value="조회"/>
  				</td>
			</tr>
  		</table>
  		<br/><br/><br/>
  		<table align="center" width="70%" class="style1">
  			<c:forEach var="data" items="${LIST}">
	  			<tr>
	  				<th rowspan="3" width="15%">
					${data.place_name }
	  				</th>
	  				<td width="65%">${data.place_name}</td>
	  				<td>조회수</td>
	  			</tr>
	  			<tr>
	  				<td colspan="2"><%-- 조회수 증가 --%>
	  					<a href="../board/hitProc.yo?bidx=${data.bidx}&&nowPage=${PINFO.nowPage}">
	  					${data.subject}
	  					</a>
	  				</td>
	  			</tr>
	  			<tr>
	  				<td>${data.userid}</td>
	  				<td>조회수 : ${data.readcnt}/추천수 : ${data.likecnt}</td>
	  			</tr>
  			</c:forEach>
  		</table>
  		<br/><br/>
  		<table align="center" width="70%">	
			<tr>
				<td align="center">
		  		<%-- 완성예시 : [<][1][2][3][4][5][>] --%>
		  		<%-- 이전페이지 --%>
		  		<%-- 현재 보고있는 페이지가 첫번째 페이지라면 --%>
		  		<c:if test="${PINFO.nowPage eq 1}">
		  			이전
		  		</c:if>
		  		<c:if test="${PINFO.nowPage ne 1}">
		  			<a href="../board/boardList2.yo?nowPage=${PINFO.nowPage-1}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}">이전</a>
		  		</c:if>
		  		
		  		<%-- [1][2][3][4][5] --%>
		  		<c:forEach var="page" begin="${PINFO.startPage }" end="${PINFO.endPage}">
		  			<c:if test="${PINFO.nowPage eq page }">
		  			<a href="../board/boardList2.yo?nowPage=${page}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}&searchType=boardSearch"><font color="blue">[${page}]</font></a>
		  			</c:if>
		  			<c:if test="${PINFO.nowPage ne page }">
		  			<a href="../board/boardList2.yo?nowPage=${page}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}&searchType=boardSearch">${page}</a>
		  			</c:if>
		  		</c:forEach>
		  		
		  		<%-- 다음페이지 --%>
		  		<%-- 현재 보고있는 페이지가 마지막 페이지까지 갔으면 --%>
		  		<c:if test="${PINFO.nowPage eq PINFO.totalPage}">
		  			다음
		  		</c:if>
		  		<c:if test="${PINFO.nowPage ne PINFO.totalPage}">
		  			<a href="../board/boardList2.yo?nowPage=${PINFO.nowPage+1}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}">다음</a>
		  		</c:if>
		  		</td>
			</tr>
		</table>
		<br/>
		<table align="center">
			<tr>	
 				<td align="right">
 					<input type="button" id="seoul" value="지도로 즐기기"/>
 				</td>
 			</tr>
	  	</table>
  	</form>
</body>
</html>