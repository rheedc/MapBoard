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
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		$(document).read(function(){
			//댓글수정 등록
			$("#wBtn").click(function(){
				
			});
			
			//댓글수정 취소
			$("#cBtn").click(function(){
				
			});
		});
	</script>
</head>
<body>
  	<form id="" action="">
  		<table>
  			<tr>
  				<th colspan="2"></th>
  			</tr>
  			<tr>
  				<th colspan="2"></th>
  			</tr>
  			<tr>
  				<th>sysdate</th>
  				<td>
  					<input type="button" id="wBtn" value="등록"/>
  					<input type="button" id="cBtn" value="취소"/>
  				</td>
  			</tr>
  		</table>
  	</form>
</body>
</html>