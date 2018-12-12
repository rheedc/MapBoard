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
<h1>ReplyDelete.jsp</h1>
<%-- 삭제여부 실행결과로 넘어오는 값이 
0이면 실패 "삭제가 실패되었습니다" 메세지출력
1이면 성공 "삭제성공" 메세지 출력 --%>
<c:if test="${CHANGE eq 0 }">
	<script>
		alert("삭제가 실패되었습니다")
	</script>
</c:if>
<c:if test="${CHANGE eq 1 }">
	<script>
		alert("삭제가 성공되었습니다")
	</script>
</c:if>
<script>
	location.href="../board/boardDetail.yo?oriNo=${oriNo}&nowPage=${nowPage}"
</script>  
</body>
</html>