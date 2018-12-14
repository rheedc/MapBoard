<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>myPlaceForm</title>
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
		
		$(function(){
			
			// myWBtn 클릭시
			$('#myWBtn').click(function(){
				// 장소명을 무결성검사하고...
				var myPlaceName = $('#myPlaceName').val();
				if(myPlaceName.length<1){
					alert("장소명을 한글자 이상 작성해주세요.");
					return;
				}
				
				// 상세주소명을 무결성검사하고...
				var myPlaceDetailAddress = $('#myPlaceDetailAddress').val();
				if(myPlaceDetailAddress.length<1){
					alert("상세주소명을 한글자 이상 작성해주세요.");
					return;
				}
			
				// myPlaceForm에 보내기
				$("#myPlaceForm").submit();
				
			});	// myWBtn 끝
			
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
				$('#myPlaceName').val('');
				$('#myPlaceDetailAddress').val('');
			});	// resetBtn 끝
			
			
			mouseLat	=	getCookie('mouseLat'); 
			mouseLng	=	getCookie('mouseLng');
			detailAddr5	=	getCookie('detailAddr');
			detailAddr4 = detailAddr5.replace('지번',' 지번')
			detailAddr3 = detailAddr4.replace('<div>','')
			detailAddr2 = detailAddr3.replace('<div>','')
			detailAddr1 = detailAddr2.replace('</div>','')
			detailAddr = detailAddr1.replace('</div>','')
			console.log('x'+mouseLat);
			console.log('y'+mouseLng);
			
			$("#myPlaceLocationX").val(mouseLat);
			$("#myPlaceLocationY").val(mouseLng);
			$("#myPlaceAddress1").val(detailAddr);
			
		});
	</script>
</head>
<body>
<h1>myPlaceForm</h1>
	<%-- action부분에 insert부분으로 넘기기 --%>
  <form id="myPlaceForm" action="#" method="get">
  	<table width="50%" align="center">
  		<tr>
  			<td align="center" width="20%">장소명</td>
  			<td  width="30%">
  				<input type="text" id="myPlaceName" name="myPlaceName" placeholder="장소를 한 글자 이상 입력해주세요" />
  			</td>
  		</tr>
  		<tr>
  			<td>좌표정보</td>
  			<td>
  				위도:<input type="text" id="myPlaceLocationX" name="myPlaceLocationX"readonly/>
  				경도:<input type="text" id="myPlaceLocationY" name="myPlaceLocationY" readonly/>
  			</td>
  		</tr>
  		<tr>
  			<td>주소</td>
  			<td>
  				<textarea rows="2" cols="80" id="myPlaceAddress1" readonly></textarea>
  			</td>
  		</tr>
  		<tr>
  			<td >상세주소</td>
  			<td>
  				<input type="text" id="myPlaceDetailAddress" name="myPlaceDetailAddress" placeholder="상세주소를 한 글자 이상 입력해주세요"/ >
  			</td>
  		</tr>
  		<tr>
	  		<td colspan="2" align="center">
	  			<input type="button" id=seoul  name="seoul" value="서울시전체보기"/>
	  			<input type="button" id=myWBtn  name="myWBtn" value="등록"/>
	  			<input type="button" id=resetBtn  name="resetBtn" value="입력취소"/>
			</td>
  		</tr>
  	</table>
  </form>
</body>
</html>
