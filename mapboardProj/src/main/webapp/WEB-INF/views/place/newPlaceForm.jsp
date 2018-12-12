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
		$(function(){
			
			// newWBtn 클릭시
			$('#newWBtn').click(function(){
				// 장소명을 무결성검사하고...
				var newPlaceName = $('#newPlaceName').val();
				if(newPlaceName.length<1){
					alert("장소명을 한글자 이상 작성해주세요.");
					return;
				}
				
				// 상세주소명을 무결성검사하고...
				var newPlaceDetailAddress = $('#newPlaceDetailAddress').val();
				if(newPlaceDetailAddress.length<1){
					alert("상세주소명을 한글자 이상 작성해주세요.");
					return;
				}
			
				// newPlaceForm에 보내기
				$("#newPlaceForm").submit();
				
			});	// newWBtn 끝
			
			// SeoulBtn 클릭시 place/placeList.yo로 이동
			$('#SeoulBtn').click(function(){
				location.href = "/place/placeList.yo";
			});	// SeoulBtn 끝
			
			// resetBtn 클릭시 위도경도와 주소는 사라지지 않고 장소명과, 상세주소만 리셋
			$('#resetBtn').click(function(){
				$('#newPlaceName').val('');
				$('#newPlaceDetailAddress').val('');
			});	// resetBtn 끝
			
			
		});
	</script>
</head>
<body>
<h1>신규장소등록</h1>
	<%-- action부분에 insert부분으로 넘기기 --%>
  <form id="newPlaceForm" action="#" method="get">
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
  				~~~~
  			</td>
  		</tr>
  		<tr>
  			<td align="center" width="20%">좌표정보</td>
  			<td>
  				<input type="text" id="newPlaceLocation" name="newPlaceLocation" value="위도=,경도="  readonly/>
  				<input type="hidden" id="newPlaceLocationX" name="newPlaceLocationX"/>
  				<input type="hidden" id="newPlaceLocationY" name="newPlaceLocationY"/>
  			</td>
  		</tr>
  		<tr>
  			<td align="center" width="20%">주소</td>
  			<td>
  				<input type="text" id="newPlaceAddress" name="newPlaceAddress"  readonly/>
  			</td>
  		</tr>
  		<tr>
  			<td align="center" width="20%">상세주소</td>
  			<td>
  				<input type="text" id="newPlaceDetailAddress" name="newPlaceDetailAddress" placeholder="상세주소를 한 글자 이상 입력해주세요"/ >
  			</td>
  		</tr>
  		<tr>
  		<td colspan="2" align="center">
	  		<input type="button" id=SeoulBtn  name="SeoulBtn" value="서울시전체보기"/>
	  		<input type="button" id=newWBtn  name="newWBtn" value="등록"/>
	  		<input type="button" id=resetBtn  name="resetBtn" value="입력취소"/>
  		</td>
  		</tr>
  	</table>
  </form>
</body>
</html>
