<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<!doctype html>
<html lang="en">
<head>
	<title><decorator:title default="JLStory" /></title>
	<decorator:head />
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
	<!-- header -->
	<header style="width: 100%; text-align:center">
		<h2>This is header</h2>
	</header>
	
	<!-- content -->
	<decorator:body></decorator:body>

	<!-- FOOTER -->
	<footer style="width:100%; text-align:center;">
		<p>	This is footer</p>
	</footer>

</body>
</html>
