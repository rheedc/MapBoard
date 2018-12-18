<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!doctype html>
<!-- 
 * 목적: 내글목록을 확인하는 페이지
 * 작성자: 조은비
 * 작성일: 2018-12-18
 * 최종수정일:
 
 -->
<html lang="en">
<head>
<title>Document</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
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
<!-- 추가된 프로그램 -->
<script>
</script>
</head>
<body>
	<br/><br/><br/>
	<c:if test="${empty LIST}">
	<table align="center" width="70%">
		<tr><td>
		<h1>등록된 게시글이 없습니다</h1>
		<br/>
		<a href="../place/placeList.yo">게시물 등록하러가기</a>
		</td></tr>
	</table>
	</c:if>
	<c:if test="${not empty LIST}">
	
	<table align="center" width="70%">
		<tr>
			<td>
				<h3 align="left">내글목록</h3>
			</td>
		</tr>
	</table>
	<%-- 1. 목록을 출력 --%>
	<table align="center" width="70%" class="style1">
		<tr height="40px">
			<th width="10%">장소명</th>
			<th width="10%">분류명</th>
			<th width="10%">시군구명</th>
			<th width="20%">제목</th>
			<th width="35%">내용</th>
			<th width="5%">평가점수</th>
			<th width="10%">작성일</th>
		</tr> 
		<c:forEach var="data" items="${LIST}">
			<tr height="40px" id="${data.bidx}">
				<td>${data.place_name}</td>
				<td>${data.categoryName}</td>
				<td>${data.sigungu_name}</td>
				<td>${data.subject}</td>
				<td><a href="../board/boardView.yo?bidx=${data.bidx}">${data.commStr}</a></td>
				<td>${data.pointStr}</td>
				<td>${data.createdt}</td>
			</tr>
		</c:forEach>		
	</table>
	<br/><br/>
	<%-- 2. 페이지 이동 기능을 추가  [이전][1][2][3][다음]--%>
	<table align="center" width="70%">		
		<tr>
			<td>
			<%-- 이전링크만들기 --%>
			<c:if test="${PINFO.nowPage eq 1}">
				[이전]
			</c:if>
			<c:if test="${PINFO.nowPage ne 1}">
				<%-- 링크는 목록보기를 요청 + 원하는 페이지를 알려주면 된다 --%>
				<a href="../member/memberBoardList.yo?nowPage=${PINFO.nowPage-1}">[이전]</a>		
			</c:if>
			
			<%-- [1][2][3]만들기 --%>
			<c:forEach var="page" begin="${PINFO.startPage}"  end="${PINFO.endPage }">
				<c:if test="${PINFO.nowPage eq page }">
			  		<a href="../member/memberBoardList.yo?nowPage=${page}"><font color="blue">[${page}]</font></a>
			  	</c:if>
			  	<c:if test="${PINFO.nowPage ne page }">
			  		<a href="../member/memberBoardList.yo?nowPage=${page}">[${page}]</a>
			  	</c:if>
			</c:forEach>
	
		
			<%-- 다음링크만들기 --%>
			<c:if test="${PINFO.nowPage eq PINFO.totalPage}">
				[다음]
			</c:if>
			<c:if test="${PINFO.nowPage ne PINFO.totalPage}">
				<a href="../member/memberBoardList.yo?nowPage=${PINFO.nowPage+1}">[다음]</a>	
			</c:if>

			</td>
		</tr>
	</table>
	</c:if>
</body>
</html>