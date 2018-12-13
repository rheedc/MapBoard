<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="en">
<head>
	<title>결과페이지</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">
	

	</style>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		function goMemberInfo(id) {	
			$('#userid').val(id);
			$('#resFrm').submit();
		}
		
		function goHome() {
			location.href = '/';
		}
	</script>
</head>
<body>
<div id="wrap">
	<br><br>
	<div class="board" style="text-align:center;">
	<form id="resFrm" name="resFrm" action="#" method="post">
		<input type="hidden" id="userid" name="userid" /> 
	</form>
	<c:set var="msg" value="${sessionScope.msg}" scope="session" />
	<c:choose>
		<c:when test="${msg!=null && msg=='0'}">
			<font size='6'>회원정보가 수정되었습니다.</font>
			<script>
				$(function(){
					//setTimeout(goMemberInfo('${id}'),10000);
				});
			</script>
		</c:when>
		<c:when test="${msg!=null && msg=='1'}">
			<font size='6'>회원가입을 축하드립니다.</font>
			<c:remove var="msg" scope="session"></c:remove>
			<script>
				$(function(){
					//setTimeout(goHome(),10000);
				});
			</script>
		</c:when>
		<c:otherwise>
			<font size='6'>탈퇴되었습니다.</font>
			<script>
				$(function(){
					//setTimeout(goHome(),10000);
				});
		</script>
		</c:otherwise>
		
	</c:choose>

	<br><br>
	<input type="button" value="메인으로" onclick="javascript:window.location='/'"/>
	</div>
</div>
</body>
</html>