<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!doctype html>
<!-- 
 * 목적: my통계페이지
 * 작성자: 조은비
 * 작성일: 2018-12-17
 * 최종수정일: 2018-12-18
 -->
<html lang="en">
<head>
<title>Document</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
	table {
		border-collapse:collapse;
		margin:auto;
		text-align:center;
		width:50%;
	}

	/* UI Object 가로 */
	.hGraph {width:50%;margin:auto;opacity:0}
   	.hGraph ul{ margin:0 50px 0 50px; padding:1px 0 0 0; border:1px solid #ddd; border-top:0; border-right:0; font-size:15px; font-family:Tahoma, Geneva, sans-serif; list-style:none;}
	.hGraph li{ position:relative; margin:10px 0; white-space:nowrap; vertical-align:top;}
	.hGraph .gTerm{ position:absolute; width:40px; top:0; left:-50px; line-height:20px; text-align:right; color:#767676; font-weight:bold;}
	.hGraph .gBar{ position:relative; display:inline-block; height:15px; border:1px solid #ff0000; border-left:0; background:#ff0000;}
	.hGraph .gCnt{ position:relative; display:inline-block; height:15px; border:1px solid #ffff00; border-left:0; background:#ffff00;}
	.hGraph .gBar span{ position:absolute; width:40px; line-height:15px; top:0; right:-50px; color:#767676;}
	.hGraph .gCnt span{ position:absolute; width:40px; line-height:15px; top:0; right:-50px; color:#767676;}
	
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
<!-- 추가된 프로그램 -->
<script>
	$(function(){
		$("#view").animate({opacity:1});
	});
</script>
</head>
<body>
	<c:if test="${empty DATA}">
	<br/><br/><br/><br/><br/><br/><br/><br/><br/>
	<table>
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
	
	<table>
		<tr>
			<td>
				<h3 align="left">MY통계</h3>
			</td>
		</tr>
	</table>

	<br/>
	<%-- 1. 목록을 출력 --%>
	<table>
		<tr><td align="center"><h4>총이동거리 : ${DATA.move_total}Km &nbsp;&nbsp;&nbsp;&nbsp;총이동건수 : ${DATA.movecnt_total}건</h4></td></tr>
	</table>
	<br/>
	
    <div class="hGraph" id="view">
		<ul>
			<li><span class="gTerm">총계</span>
				<span class="gBar" style="width:100%"><span>${DATA.move_total}Km</span></span><br/>
				<span class="gCnt" style="width:100%"><span>${DATA.movecnt_total}건</span></span>
			</li>
			<li><span class="gTerm">1월</span>
				<span class="gBar" style="width:${monthMove.get('1월')*100/DATA.move_total}%"><span>${monthMove.get("1월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('1월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("1월")}건</span></span>
			</li>
			<li><span class="gTerm">2월</span>
				<span class="gBar" style="width:${monthMove.get('2월')*100/DATA.move_total}%"><span>${monthMove.get("2월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('2월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("2월")}건</span></span>
			</li>
			<li><span class="gTerm">3월</span>
				<span class="gBar" style="width:${monthMove.get('3월')*100/DATA.move_total}%"><span>${monthMove.get("3월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('3월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("3월")}건</span></span>
			</li>
			<li><span class="gTerm">4월</span>
				<span class="gBar" style="width:${monthMove.get('4월')*100/DATA.move_total}%"><span>${monthMove.get("4월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('4월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("4월")}건</span></span>
			</li>
			<li><span class="gTerm">5월</span>
				<span class="gBar" style="width:${monthMove.get('5월')*100/DATA.move_total}%"><span>${monthMove.get("5월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('5월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("5월")}건</span></span>
			</li>
			<li><span class="gTerm">6월</span>
				<span class="gBar" style="width:${monthMove.get('6월')*100/DATA.move_total}%"><span>${monthMove.get("6월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('6월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("6월")}건</span></span>
			</li>
			<li><span class="gTerm">7월</span>
				<span class="gBar" style="width:${monthMove.get('7월')*100/DATA.move_total}%"><span>${monthMove.get("7월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('7월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("7월")}건</span></span>
			</li>
			<li><span class="gTerm">8월</span>
				<span class="gBar" style="width:${monthMove.get('8월')*100/DATA.move_total}%"><span>${monthMove.get("8월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('8월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("8월")}건</span></span>
			</li>
			<li><span class="gTerm">9월</span>
				<span class="gBar" style="width:${monthMove.get('9월')*100/DATA.move_total}%"><span>${monthMove.get("9월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('9월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("9월")}건</span></span>
			</li>
			<li><span class="gTerm">10월</span>
				<span class="gBar" style="width:${monthMove.get('10월')*100/DATA.move_total}%"><span>${monthMove.get("10월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('10월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("10월")}건</span></span>
			</li>
			<li><span class="gTerm">11월</span>
				<span class="gBar" style="width:${monthMove.get('11월')*100/DATA.move_total}%"><span>${monthMove.get("11월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('11월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("11월")}건</span></span>
			</li>
			<li><span class="gTerm">12월</span>
				<span class="gBar" style="width:${monthMove.get('12월')*100/DATA.move_total}%"><span>${monthMove.get("12월")}Km</span></span><br/>
				<span class="gCnt" style="width:${monthCnt.get('12월')*100/DATA.movecnt_total}%"><span>${monthCnt.get("12월")}건</span></span>
			</li>
			
		</ul>
	</div>
	</c:if>
	
</body>
</html>
