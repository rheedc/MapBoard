<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>newPlaceForm</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
	/* style 작성부분 */
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	
		// 쿠키 얻기 함수
		var getCookie = function(name) {
			var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
			return value? value[2] : null;
		};
		
		// 쿠키 설정 함수
		var setCookie = function(name, value, exp) {
			var date = new Date();
			date.setTime(date.getTime() + exp*24*60*60*1000);
			document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
		};
		
		// 쿠키 삭제 함수
		var deleteCookie = function(name) {
			setCookie(name,'',-1);
		};
		
		var mouseLat="";
		var mouseLng="";
		var detailAddr="";
	
		$(function(){
			
			
			// newWBtn 클릭시-------------------------------------------------------
			$('#newWBtn').click(function(){
				// 장소명을 무결성검사하고...-----------
				var newPlaceName = $('#newPlaceName').val();
				if(newPlaceName.length<1){
					alert("장소명을 한글자 이상 작성해주세요.");
					return;
				}
				// 분류 무결성 검사-----------
				if(!$(':input:radio[name=category_no]:checked').val()) {
				    alert("분류를 선택해 주세요");
				    return;
				}
				// newPlaceForm에 보내기-----------
				$("#newPlaceForm").submit();
			});	// newWBtn 끝-------------------------------------------------------
			
			// seoul 클릭시 place/placeList.yo로 이동
			$('#seoul').click(function(){			
				deleteCookie('gupath');
				deleteCookie('guname');
				deleteCookie('mouseLat');
				deleteCookie('mouseLng');
				console.log(getCookie('guname'));
				$(location).attr('href', '../place/placeList.yo')
			});
			
			// resetBtn 클릭시 위도경도와 주소는 사라지지 않고 장소명과, 상세주소만 리셋
			$('#resetBtn').click(function(){
				$('#newPlaceName').val('');
				$('#newPlaceDetailAddress').val('');
			});	// resetBtn 끝
			
			mouseLat	=	getCookie('mouseLat'); 
			mouseLng	=	getCookie('mouseLng');
			detailAddr	=	getCookie('detailAddr');
			//detailAddr = detailAddr1.replace('</div>','')
			var array=[];
			array = detailAddr.split(" ");			
			
			console.log('x'+mouseLat);
			console.log('y'+mouseLng);
			
			$("#newPlaceX").val(mouseLat);
			$("#newPlaceY").val(mouseLng);
			$("#newPlaceAddress1").val(detailAddr);
			$("#guname").val(array[1]);
			
		});
	</script>
</head>
<body>
<h1>newPlaceForm</h1>
	<%-- action부분에 insert부분으로 넘기기 --%>
  <form id="newPlaceForm" action="../place/newPlaceProc.yo" method="get">
  	<!-- 임시로 !!!!!!!!!!!! jojo로 넣고 나중에 고치기 -->
  	<input type="hidden" id="id" name="id" value="${sessionScope.userid}"/>
  	<!-- <input type="hidden" id="id" name="id" value="jojo"/> -->
	<input type="hidden" id="guname" name="guname"/>
  	<table width="50%" align="center">
  		<tr>
  			<td align="center" width="20%">장소명</td>
  			<td  width="30%">
  				<input type="text" id="newPlaceName" name="newPlaceName" placeholder="장소를 한 글자 이상 입력해주세요" />
  			</td>
  		</tr>
  		<tr>
  			<td align="center" width="20%">분류명</td>
  			<td>
					<input type="radio" name="category_no" value=1 class="category_no"> 관광/여가/오락
					<input type="radio" name="category_no" value=2 class="category_no"> 숙박
					<input type="radio" name="category_no" value=3 class="category_no"> 의료<br/>
					<input type="radio" name="category_no" value=4 class="category_no"> 한식/중식/양식
					<input type="radio" name="category_no" value=5 class="category_no"> 커피점/카페
					<input type="radio" name="category_no" value=6 class="category_no"> 기타
				</td>
  		</tr>
  		<tr>
  			<td align="center" width="20%">좌표정보</td>
  			<td>
  				위도:<input type="text" id="newPlaceX" name="newPlaceX"readonly/>
  				경도:<input type="text" id="newPlaceY" name="newPlaceY" readonly/>
  			</td>
  		</tr>
  		<tr>
  			<td align="center" width="20%">지번주소</td>
  			<td>
  				<input type="text" id="newPlaceAddress1" name="newPlaceAddress1" readonly />
  			</td>
  		</tr>
  		<tr>
  		<td colspan="2" align="center">
	  		<input type="button" id=seoul  name="seoul" value="서울시전체보기"/>
	  		<input type="button" id=newWBtn  name="newWBtn" value="등록"/>
	  		<input type="button" id=resetBtn  name="resetBtn" value="입력취소"/>
  		</td>
  		</tr>
  	</table>
  </form>
</body>
</html>
