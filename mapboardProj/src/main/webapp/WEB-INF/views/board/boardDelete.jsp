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
<h1>BoardDelete.jsp</h1>
	<%-- 이 화면에서는
	1. 유저에게 삭제성공여부를 alert를 이용해서 알려준다
		1이면 삭제성공, 0이면 삭제X
	2. 목록보기로 이동--%>
	<c:if test="${CHANGE eq 1}">
	<script>alert("게시물이 삭제되었습니다");	</script>
	</c:if>
	<c:if test="${CHANGE eq 0}">
	<script>alert("게시물이 삭제되지 않았습니다");	</script>
	</c:if>
	<%-- 주의!!! ★★★
	redirect를 시키면 이전의 작업내용은 실행되지 않는다 --%>
	<script>
		location.href="../board/boardList.yo";
	</script>  
</body>
</html>