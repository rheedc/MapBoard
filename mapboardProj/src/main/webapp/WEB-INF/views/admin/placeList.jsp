<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
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
$(document).ready(function(){
	
	//검색조건을 받아오고 기본세팅해놓기
 	searchType="${type}";
	if(searchType=="all"){
		$('input[name="type"]:eq(0)').attr('checked','checked')
	};
	if(searchType=="old"){
		$('input[name="type"]:eq(1)').attr('checked','checked')
	};
	if(searchType=="new"){
		$('input[name="type"]:eq(2)').attr('checked','checked')
	};
	//검색조건이 변경되면 새로고침
	$('.category_no').click(function(){	
		$("#searchFrm").submit();
	});  

	//상태변경버튼 클릭시 update수행하기
	$(".mBtn_y").click(function(){
		//해당 장소번호 넘기기
		place_no=$(this).parents('tr').attr('id');
		$(location).attr("href","../admin/changeStatus.yo?place_no="+place_no+"&nowPage=${PINFO.nowPage}&type=${type}&nowStatus=Y");
	});
	$(".mBtn_n").click(function(){ 
		//해당 장소번호 넘기기
		place_no=$(this).parents('tr').attr('id');
		$(location).attr("href","../admin/changeStatus.yo?place_no="+place_no+"&nowPage=${PINFO.nowPage}&type=${type}&nowStatus=N");
		
	}); 
	
});
</script>
</head>
<body>
	<table align="center" width="70%">
		<tr>
			<td>
				<h3 align="left">장소 목록</h3>
			</td>
		</tr>
	</table>
	<%-- 검색부분 --%>
	<form id="searchFrm" action="../admin/placeList.yo" method="post">
		<table border="1" align="center" width="70%"  height="50px">
			<tr>
				<td>
					<input type="radio" name="type" value="all" class="category_no"> 전체장소리스트 
					<input type="radio" name="type" value="old" class="category_no"> 관리자등록리스트 
					<input type="radio" name="type" value="new" class="category_no"> 회원등록리스트
				</td>
			</tr>
		</table>
	</form>	
	<br>
	<%-- 1. 목록을 출력 --%>
	
	<table align="center" width="70%" class="style1">
		<tr height="40px">
			<th width="15%">장소명</th>
			<th width="10%">분류명</th>
			<th width="10%">시군구명</th>
			<th width="20%">주소</th>
			<th width="10%">위도</th>
			<th width="10%">경도</th>
			<th width="15%">작성일</th>
			<th width="10%">상태</th>
		</tr> 
		<c:forEach var="data" items="${LIST}">
			<tr height="40px" id="${data.place_no}">
				<td>${data.place_name}</td>
				<td>${data.categoryName}</td>
				<td>${data.sigungu_name}</td>
				<td>${data.juso}</td>
				<td>${data.longitude}</td>
				<td>${data.latitude}</td>
				<td>${data.createdt}</td>
				<td>${data.status}&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" class="mBtn_y" value="노출"><input type="button" class="mBtn_n" value="미노출">
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