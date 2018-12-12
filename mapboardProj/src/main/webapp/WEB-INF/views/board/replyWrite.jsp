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
 	<%--	이 문서는 댓글 등록을 한 후
	          상세보기를 보여줌으로써 댓글이 등록된 결과를 확인하도록..
	--%>
	<c:redirect url="../board/boardDetail.yo">
		<c:param name="oriNo" value="${oriNo}" />
		<c:param name="nowPage" value="${nowPage}" />
	</c:redirect> 
</body>
</html>