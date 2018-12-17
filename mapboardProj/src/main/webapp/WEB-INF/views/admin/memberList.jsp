<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>회원 목록조회</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
	#subTitle{font-size:50px; text-align:center; font-weight:bold;}
	#searchBtn{background-color: #555555; /* blue */
					  border: none;
					  color: white;
					  padding: 10px 20px;
					  text-align: center;
					  text-decoration: none;
					  display: inline-block;
					  font-size: 13px;
					  font-weight: bold;
					  margin: 4px 2px;
					  cursor: pointer;}
	.searchArea{border:1px solid gray;margin:auto;text-align:center; width:60%;height:60px; }
	#listArea{border:1px solid gray;margin:auto;text-align:center; width:60%;}
	table {
		border-collapse:collapse;
	}
	th {
		border-bottom:1px solid #337AB3;
		background-color:#337AB3;
		font-weight:bold;
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
	
	</script>
</head>
<body>

<p id="subTitle">회원목록보기</p>
<br>
	<%-- 검색부분 --%>
	<form id="searchFrm" action="/member/memberAdminDetail.yo" method="post">
		<table class="searchArea">
			<tr>
				<td>
					<input type="text" name="keyword" class="category_no" placeholder="검색어를 입력해 주세요."> 
					<input type="button" name="searchBtn" id="searchBtn" value="조회하기" class="category_no">
					
				</td>
			</tr>
		</table>
	</form>	
	<br>
	<%-- 1. 목록을 출력 --%>
	
	<table id="listArea"  class="style1">
		<tr height="40px">
			<th width="15%">ID</th>
			<th width="10%">성명</th>
			<th width="10%">닉네임</th>
			<th width="20%">등록일</th>
			<th width="10%">상태</th>
			<th width="10%">등급</th>
			<th width="15%">수정</th>
		</tr> 
		<c:forEach var="data" items="${LIST}">
			<tr height="40px" id="${data.place_no}">
				<td>${data.userid}</td>
				<td>${data.uname}</td>
				<td>${data.nick}</td>
				<td>${data.createdt}</td>
				<td>${data.status}</td>
				<td>${data.ulevel}</td>
				<td>	<input type="button" id="mBtn_y" value="수정"><input type="button" id="mBtn_n" value="삭제" />
				</td>
			</tr>
		</c:forEach>		
	</table>
	<br>
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
				<a href="../admin/placeList.yo?nowPage=${PINFO.nowPage-1}&type=${type}">[이전]</a>		
			</c:if>
			
			<%-- [1][2][3]만들기 --%>
			<c:forEach var="page" begin="${PINFO.startPage}"  end="${PINFO.endPage }">
				<c:if test="${PINFO.nowPage eq page }">
			  		<a href="../admin/placeList.yo?nowPage=${page}&type=${type}"><font color="blue">[${page}]</font></a>
			  	</c:if>
			  	<c:if test="${PINFO.nowPage ne page }">
			  		<a href="../admin/placeList.yo?nowPage=${page}&type=${type}">[${page}]</a>
			  	</c:if>
			</c:forEach>
	
		
			<%-- 다음링크만들기 --%>
			<c:if test="${PINFO.nowPage eq PINFO.totalPage}">
				[다음]
			</c:if>
			<c:if test="${PINFO.nowPage ne PINFO.totalPage}">
				<a href="../admin/placeList.yo?nowPage=${PINFO.nowPage+1}&type=${type}">[다음]</a>	
			</c:if>

			</td>
		</tr>
	</table>

</body>
</html>