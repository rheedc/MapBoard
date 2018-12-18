<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>newPlaceForm</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style>
	
		h3 {
			color:#7C5D44;
		}
		th {
			width:20%;
			text-align:center;
			font-weight:bold;
			background-color:#ebf6f9;
		}
		tr {
			height:30px;
		}
		input{
			width:80%;
		}
		textarea {
			height:30px;
			width:80%
		}
		select {
			width:30%;
		}
		.brdImage {
			height:500px;
			padding:15px; 
		}
		.btn2 {
		    width:50px;
		    background-color: #ebf6f9;
		    border: none;
		    color:black;
		    text-align: center;
		    text-decoration: none;
		    display: inline-block;
		    font-size: 13px;
		    margin: 4px;
		    cursor: pointer;
		    border-radius:5px;
		 }
		.btn2:hover {
			background-color: #f6f2ef;
			font-weight:bold;
		    color:black;
		} 
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
<table align="center" width="70%">
	<tr>
		<td>
			<h3 align="left">신규장소등록</h3> 
		</td>
	</tr>
</table>
	<%-- action부분에 insert부분으로 넘기기 --%>
  <form id="newPlaceForm" action="../place/newPlaceProc.yo" method="get">
  	<input type="hidden" id="id" name="id" value="${sessionScope.userid}"/>
	<input type="hidden" id="guname" name="guname"/>
  	<table border="1px" align="center" width="70%">
  		<tr>
  			<th>장소명</th>
  			<td>
  				<input type="text" id="newPlaceName" name="newPlaceName" placeholder="장소를 한 글자 이상 입력해주세요" />
  			</td>
  		</tr>
  		<tr>
  			<th>분류명</th>
  			<td>
					<input type="radio" name="category_no" value=1 class="category_no" style="width:15px;" /> 관광/여가/오락
					<input type="radio" name="category_no" value=2 class="category_no" style="width:15px;" /> 숙박
					<input type="radio" name="category_no" value=3 class="category_no" style="width:15px;" /> 의료
					<input type="radio" name="category_no" value=4 class="category_no" style="width:15px;" /> 한식/중식/양식
					<input type="radio" name="category_no" value=5 class="category_no" style="width:15px;" /> 커피점/카페
					<input type="radio" name="category_no" value=6 class="category_no" style="width:15px;" /> 기타
				</td>
  		</tr> 
  		<tr>
  			<th>좌표정보</th>
  			<td>
  				위도:<input type="text" id="newPlaceX" name="newPlaceX"readonly style="width:35%;"/>
  				경도:<input type="text" id="newPlaceY" name="newPlaceY" readonly style="width:35%;"/>
  			</td>
  		</tr>
  		<tr>
  			<th>지번주소</th>
  			<td>
  				<input type="text" id="newPlaceAddress1" name="newPlaceAddress1" readonly />
  			</td>
  		</tr>
	</table>
 	<table align="center" width="70%"> 
		<tr>
			<td colspan="2" align="center">
				<input type="button" class="btn2" id=seoul  name="seoul" value="서울시전체보기" style="width:100px;" />
		  		<input type="button" class="btn2" id=newWBtn  name="newWBtn" value="등록" style="width:100px;"/>
		  		<input type="button" class="btn2" id=resetBtn  name="resetBtn" value="입력취소" style="width:100px;"/>
			</td>
		</tr>
	</table>
  </form>
</body>
</html>
