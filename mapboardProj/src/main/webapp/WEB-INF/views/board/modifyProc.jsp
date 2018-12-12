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
	
	</script>
</head>
<body>
<h1>ModifyProc.jsp</h1>
<%--
수정이 완료되었으므로 보여줄건 없고.. 
대신 수정내용을 확인하기 위해 상세보기로 가겠다
 --%>
<c:redirect url="../board/boardDetail.yo">
	<c:param name="oriNo" value="${oriNo}"/>
	<c:param name="nowPage" value="${nowPage}"/>
</c:redirect>  
</body>
</html>