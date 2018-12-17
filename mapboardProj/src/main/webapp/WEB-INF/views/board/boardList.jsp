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
	
			//승환 작성 -----------------------------------------------
			// 쿠키 설정 함수
			var setCookie = function(name, value, exp) {
				var date = new Date();
				date.setTime(date.getTime() + exp*24*60*60*1000);
				document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
			};
			
			// 쿠키 얻기 함수
			var getCookie = function(name) {
				var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
				return value? value[2] : null;
			};
			
			// 쿠키 삭제 함수
			var deleteCookie = function(name) {
				setCookie(name,'',-1);
			};
	
	
		$(document).ready(function(){
			//지도 보기 클릭시 페이지 넘어가는거
			$('#seoul').click(function(){			
				deleteCookie('guname');
				deleteCookie('mouseLat');
				deleteCookie('mouseLng');
				$(location).attr('href', '../place/placeList.yo')
			});
			//승환 작성 -----------------------------------------------	
			
		//제목검색 sBtn
		$("#sBtn").click(function(){
			//지역(구) 선택
			if($('select[name="gu"]>option:selected').index()<1){
				alert('지역(구)를 선택해주세요')
				$('select[name="gu"]').focus()
				return false;
			}
			//키워드 검색
			if(!$("#select").val()){
				alert("검색어를 입력해주세요.");
				$("#select").focus();
				return false;
			}
		});
		
	});
	</script>
</head>
<body>
  	<form id="" action="">
  		<div id="select">
  			<!-- 검색하기 -->
	  		<table align="center">
	  			<tr align="center">
	  				<th width="50%" align="center">
	  					<select name="gu">
	  						<option>--지역(구) 선택--</option>
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
	  					<!-- 검색단어 -->
						<input type="text" id="select" name="select"/>
					</td>
	  				<td>
	  					<!-- 검색버튼 -->
	  					<input type="button" id="sBtn"  value="조회"/>
	  				</td>
				</tr>
	  		</table>
  		</div>
  		
  		<table>
  			<c:forEach var="data" items="${LIST}">
	  			<tr>
	  				<th rowspan="3" width="15%">
	  					<!-- 첨부파일 보여주기 -->	
	  					<%-- <c:forEach var="info" items="${LIST}">
	  						<tr>
	  							<td>
	  								<a href="../board/fileDownload.yo?fidx=${info.no}">${info.oriName}</a> ( ${info.comma} Byte )FileBoardVO len
	  							</td>
	  						</tr>
  						</c:forEach> --%>
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
  			
  			<tr>
  			<!-- 페이징 처리 -->
  				<%--페이지 이동기능 --%>
				<!-- //3. 모델 만들기
					req.setAttribute("LIST", list); -->
			
				<td align="center" colspan="3">
					<%-- [<][1][2][3][4][5][>] --%>
					<%-- 이전페이지 [<] --%>
					<%-- 현재페이지가 1인 경우 --%>
					<c:if test="${PINFO.nowPage eq 1 }">
						이전
					</c:if>
				
					<%-- 현재페이지가 1이 아닌 경우 --%>
					<c:if test="${PINFO.nowPage ne 1 }">
						<a href="../board/boardList.yo?nowPage=${PINFO.nowPage-1}">이전</a>
					</c:if>
				
					<%--[1][2][3][4][5] --%>
					<c:forEach var="page" begin="${PINFO.startPage}" end="${PINFO.endPage}">
						<a href="../board/boardList.yo?nowPage=${page}">[${page}]</a>
					</c:forEach>
				
				
					<%-- 현재 보고있는 페이지가 마지막 페이지까지 갔으면 --%>
					<c:if test="${PINFO.nowPage eq PINFO.totalPage}">
						다음
					</c:if>
					
					<c:if test="${PINFO.nowPage ne PINFO.totalPage}">
						<a href="../board/boardList.yo?nowPage=${PINFO.nowPage+1}">다음</a>
					</c:if>
			</tr>
		</table>
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