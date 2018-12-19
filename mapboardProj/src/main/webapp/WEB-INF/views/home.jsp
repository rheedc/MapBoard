<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>

<html>
<head> 
	<link href="https://fonts.googleapis.com/css?family=Poor+Story|Yeon+Sung" rel="stylesheet">
	<title>Home</title>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
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
		
		$(function(){	
			$('#seoul').click(function(){			
				deleteCookie('guname');
				deleteCookie('mouseLat');
				deleteCookie('mouseLng');
				$(location).attr('href', '../place/placeList.yo')
			});	
			
			$('#seoul2').click(function(){			
				deleteCookie('guname');
				deleteCookie('mouseLat');
				deleteCookie('mouseLng');
				$(location).attr('href', '../place/placeList.yo')
			});	
		});	
		// 함수끝
	</script>
</head>
<body>
	<table align="center">
		<tr>
			<td>
				<a href="/"><img src="../resources/img/u36.png" style="width:600px; height:150px;" alt="place_logo" title="place_logo" /></a>
			</td>
		</tr>
	</table>
	<table align="center">
		<tr >
			<td>
				<a href="/place/placeList.yo" id="seoul2"><img src="../resources/img/seoul10.png" style="width:700px; height:500px;" alt="map_logo" title="map_logo" /></a>
			</td>
			<td>
				<a href="/board/boardList2.yo"><img src="../resources/img/u32.jpg" style="width:700px; height:500px;" alt="board_logo" title="board_logo" /></a>
			</td>
		</tr>
		<tr>
			<td align="center">				
				<a href="#" id="seoul"><h1 style="font-family: 'Poor Story';">지도로 즐기기</h1></a>
			</td>
			<td align="center">
				<a href="/board/boardList2.yo"><h1 style="font-family: 'Poor Story';">글로 즐기기</h1></a>
			</td> 
		</tr>
	</table>
</body>
</html>