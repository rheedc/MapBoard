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
	height:50px;
	text-align:center;
	padding:10px;
	background-color:#ebf6f9;
	}
	#left_content {
	width:500px;
	height:750px;
	float:left;
	text-align:left;
	background-color:white;
	}
	#right_content {
	width:1900px;
	height:750px;
	text-align:center;
	}
	.placeResult_jo,.boardResult_jo{
	overflow-y:scroll;
	height:600px;
	border:1px solid #444444;
	}
	.placeResult_jo td,.placeResult_jo th,
	.boardResult_jo td,.boardResult_jo th{
	border-bottom: 1px solid #444444;
	padding:10px;
	}
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	$(document).ready(function(){
		
		category_no="${DATA.category_no}";
		sigungu_name="${DATA.sigungu_name}";
		place_name="${DATA.place_name}";
		
		//구이름,장소이름,카테고리 정보가 넘어온게 있다면 
		//그 값을 화면에 세팅해놓기
		if(category_no!=0){
			if(category_no!=10){
				$('input[name="category_no"]:eq('+category_no+')').attr('checked','checked')			
			}
			if(category_no==10){
				$('input[name="category_no"]:eq(0)').attr('checked','checked')
			}
		}	
		if(sigungu_name.length!=0){
			$("#sigungu_name").val(sigungu_name)
		}
		if(place_name.length!=0){
			$("#place_name").val(place_name)
		}
		
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
	<div id="top_content">
	<!-- <form id="searchFrm_j" method="get" action="../place/placeList.yo"> -->
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
	
	<div id="left_content">
	<table border="1px" width="500px" height="70px">
		<tr>
			<td align="center">장소검색결과</td>
			<td align="center">게시글검색결과</td>
		</tr>
	</table>
	
	<table border="1px" width="500px" height="30px">
		<tr>
			<td colspan="2" style="padding:10px;">검색결과(${placecnt_total}건)</td>
		</tr>
	</table>
	
	<div  class="placeResult_jo">
		<c:if test="${empty PLIST }">
		<table width="500px" height="600px">
			<tr align="center">
				<td>검색결과가 없습니다</td>
			</tr>
		</table>
		</c:if>
		<table width="500px" >
			<c:forEach var="data" items="${PLIST}">
				<tr height="100px">
					<td width="350px">
					${data.place_name}<br/>
					${data.juso}<br/>
					관련글:${data.reviewcnt}건
					</td>
					<td>
					good:${data.goodcnt}<br/>
					soso:${data.sosocnt}<br/>
					bad:${data.badcnt}
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<table border="1px" width="500px" height="50px">	
		<tr>
			<td align="center">
	  		<%-- 완성예시 : [<][1][2][3][4][5][>] --%>
	  		<%-- 이전페이지 --%>
	  		<%-- 현재 보고있는 페이지가 첫번째 페이지라면 --%>
	  		<c:if test="${PINFO.nowPage eq 1}">
	  			이전
	  		</c:if>
	  		<c:if test="${PINFO.nowPage ne 1}">
	  			<a href="../total/totalPlaceList.yo?nowPage=${PINFO.nowPage-1}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}">이전</a>
	  		</c:if>
	  		
	  		<%-- [1][2][3][4][5] --%>
	  		<c:forEach var="page" begin="${PINFO.startPage }" end="${PINFO.endPage}">
	  			<c:if test="${PINFO.nowPage eq page }">
	  			<a href="../total/totalPlaceList.yo?nowPage=${page}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}"><font color="blue">[${page}]</font></a>
	  			</c:if>
	  			<c:if test="${PINFO.nowPage ne page }">
	  			<a href="../total/totalPlaceList.yo?nowPage=${page}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}">${page}</a>
	  			</c:if>
	  		</c:forEach>
	  		
	  		<%-- 다음페이지 --%>
	  		<%-- 현재 보고있는 페이지가 마지막 페이지까지 갔으면 --%>
	  		<c:if test="${PINFO.nowPage eq PINFO.totalPage}">
	  			다음
	  		</c:if>
	  		<c:if test="${PINFO.nowPage ne PINFO.totalPage}">
	  			<a href="../total/totalPlaceList.yo?nowPage=${PINFO.nowPage+1}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}">다음</a>
	  		</c:if>
	  		</td>
		</tr>
	</table>
	</div>
	<div id="right_content">지도 부분 오른쪽내용</div>
	</div>
</body>
</html>