<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<!-- 
 * 목적: my통계페이지
 * 작성자: 조은비
 * 작성일: 2018-12-17
 * 최종수정일:
 -->
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
	h3 {
		color:#337AB3;
	}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
<!-- 추가된 프로그램 -->
<script>

</script>
</head>
<body>
	<c:if test="${empty DATA}">
	<br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<table align="center" width="70%">
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
	<table align="center" width="70%">
		<tr>
			<td>
				<h3 align="left">장소 목록</h3>
			</td>
		</tr>
	</table>

	<%-- 1. 목록을 출력 --%>
	<table align="center" width="70%" class="style1">
		<tr>
			<th width="10%">총이동거리</th>
			<td>${DATA.move_total}Km</td>
		</tr>
		<tr>
			<th width="10%">총이동건수</th>
			<td>${DATA.movecnt_total}건</td>
		</tr>
	</table>
	<br/>
	<table align="center" width="70%" class="style1">
		<tr>
			<th width="10%" rowspan="2">1월</th>
			<td>${monthMove.get("1월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("1월")}건</td>
		</tr>
		<tr>
			<th width="10%" rowspan="2">2월</th>
			<td>${monthMove.get("2월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("2월")}건</td>
		</tr>
		<tr>
			<th width="10%" rowspan="2">3월</th>
			<td>${monthMove.get("3월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("3월")}건</td>
		</tr>
		<tr>
			<th width="10%" rowspan="2">4월</th>
			<td>${monthMove.get("4월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("4월")}건</td>
		</tr>
		<tr>
			<th width="10%" rowspan="2">5월</th>
			<td>${monthMove.get("5월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("5월")}건</td>
		</tr>
		<tr>
			<th width="10%" rowspan="2">6월</th>
			<td>${monthMove.get("6월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("6월")}건</td>
		</tr>
		<tr>
			<th width="10%" rowspan="2">7월</th>
			<td>${monthMove.get("7월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("7월")}건</td>
		</tr>
		<tr>
			<th width="10%" rowspan="2">8월</th>
			<td>${monthMove.get("8월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("8월")}건</td>
		</tr>
		<tr>
			<th width="10%" rowspan="2">9월</th>
			<td>${monthMove.get("9월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("9월")}건</td>
		</tr>
		<tr>
			<th width="10%" rowspan="2">10월</th>
			<td>${monthMove.get("10월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("10월")}건</td>
		</tr>
		<tr>
			<th width="10%" rowspan="2">11월</th>
			<td>${monthMove.get("11월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("11월")}건</td>
		</tr>
		<tr>
			<th width="10%" rowspan="2">12월</th>
			<td>${monthMove.get("12월")}Km</td>
		</tr>
		<tr>
			<td>${monthCnt.get("12월")}건</td>
		</tr>
	</table>
	</c:if>
	
</body>
</html>
