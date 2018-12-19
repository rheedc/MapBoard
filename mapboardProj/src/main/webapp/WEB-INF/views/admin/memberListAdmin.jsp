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
					  padding: 7px 20px;
					  text-align: center;
					  text-decoration: none;
					  display: inline-block;
					  font-size: 13px;
					  font-weight: bold;
					  margin: 0px 2px;
					  cursor: pointer;}
	.searchArea{border:1px solid gray;margin:auto;text-align:center; width:60%;height:60px; }
	#totalCnt{border:1px solid white;margin:auto; width:60%;padding-bottom:10px;}
	#listArea{border:1px solid gray;margin:auto;text-align:center; width:60%;}
	#pageArea{border-style:none;margin:auto;text-align:center; width:60%;}
	#word, #target{padding: 7px 20px;
  				margin: 0px 2px;
  				display: inline-block;
  				border: 1px solid #ccc;
  				border-radius: 4px;
  				box-sizing: border-box;}
	table {border-collapse:collapse;	}
	th {border-bottom:1px solid #337AB3;
		background-color:#337AB3;
		font-weight:bold;
		color:white;
		text-align:center;
		height:30px;}
	td {text-align:center; height: 50px;}
	.style1 th {text-align:center;}
	.style1 tr {border-bottom:1px solid gray;}
	.style1 tr:hover {background-color: #d7edf4;} 
	h3 {color:#337AB3;}
	a {color:black;}
	a:hover {font-weight:bold;color:#337AB3;}
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	$(function(){
		<%--조회 버튼을 클릭했을 때 탈퇴처리하는 함수--%>
		$("#searchBtn").click(function(){
			$("#searchFrm").submit();
		});
		
	});
	
	function memModify(id) {
		$('#userid').val(id);
		$('#nowPage').val("${PINFO.nowPage}");
		$('#hiddenForm').attr("action", "/member/memberDetailAdmin.yo");
		$('#hiddenForm').submit();
	}
	
	
	</script>
</head>
<body>
<p id="subTitle">회원목록보기</p>

<br>
	<%-- 검색부분 --%>
	<form id="searchFrm" action="/member/memberSearchAdmin.yo" method="post">
		<table class="searchArea">
			<tr>
				<td>
				<td align="center">
		  			<!-- 검색대상 -->
		  			<select name="target" id="target">
		  				<option value="uname">성명</option>
		  				<option value="userid">아이디</option>
		  				<option value="nick">닉네임</option>
		  			</select>
					<input type="text" name="word" id="word" class="category_no" placeholder="검색어를 입력해 주세요." size=40% /> 
					<input type="button" name="searchBtn" id="searchBtn" value="조회하기" class="category_no">
					
				</td>
			</tr>
		</table>
	</form>	
	<br>
	<%-- 1. 목록을 출력 --%>
	<div id="totalCnt"> 전체 회원 수 : ${PINFO.totalCount} </div>
	<form id="hiddenForm" method="post" action="">
				<input type="hidden" name="userid" id="userid" />
				<input type="hidden" name="nowPage" id="nowPage"  />
	</form>
	<table id="listArea"  class="style1">
		<tr>
			<th width="20%">ID</th>
			<th width="15%">성명</th>
			<th width="30%">닉네임</th>
			<th width="15%">등록일</th>
			<th width="5%">상태</th>
			<th width="5%">등급</th>
			<th width="10%">수정</th>
		</tr> 
		<c:forEach var="data" items="${MLIST}">
			<tr>
				<td>${data.userid}</td>
				<td>${data.uname}</td>
				<td>${data.nick}</td>
				<td>${data.createdt}</td>
				<td>${data.status}</td>
				<td>${data.ulevel}</td>
				<td>	<input type="button" id="memModify" value="수정"  onclick="memModify('${data.userid}');" />
				</td>
			</tr>
		</c:forEach>		
	</table>
	<br>
	<%-- 2. 페이지 이동 기능을 추가  [이전][1][2][3][다음]--%>
	<table id="pageArea">		
		
		<tr>
			<td>
			<%-- 이전링크만들기 --%>
			<c:if test="${PINFO.nowPage eq 1}">
				◀
			</c:if>
			<c:if test="${PINFO.nowPage ne 1}">
				<%-- 링크는 목록보기를 요청 + 원하는 페이지를 알려주면 된다 --%>
				<a href="/member/memberList.yo?nowPage=${PINFO.nowPage-1}">◀</a>		
			</c:if>
			
			<%-- [1][2][3]만들기 --%>
			<c:forEach var="page" begin="${PINFO.startPage}"  end="${PINFO.endPage }">
				<c:if test="${PINFO.nowPage eq page }">
			  		<a href="/member/memberList.yo?nowPage=${page}"><font color="blue">(${page})</font></a>
			  	</c:if>
			  	<c:if test="${PINFO.nowPage ne page }">
			  		<a href="/member/memberList.yo?nowPage=${page}">(${page})</a>
			  	</c:if>
			</c:forEach>
	
		
			<%-- 다음링크만들기 --%>
			<c:if test="${PINFO.nowPage eq PINFO.totalPage}">
				▶
			</c:if>
			<c:if test="${PINFO.nowPage ne PINFO.totalPage}">
				<a href="/member/memberList.yo?nowPage=${PINFO.nowPage+1}">▶</a>	
			</c:if>

			</td>
		</tr>
	</table>

</body>
</html>














