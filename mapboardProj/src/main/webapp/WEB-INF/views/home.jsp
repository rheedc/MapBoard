<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
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
				<a href="/place/placeList.yo"><img src="../resources/img/u38.jpg" style="width:700px; height:500px;" alt="map_logo" title="map_logo" /></a>
			</td>
			<td>
				<a href="#"><img src="../resources/img/u32.jpg" style="width:700px; height:500px;" alt="board_logo" title="board_logo" /></a>
			</td>
		</tr>
		<tr>
			<td text-align="center">
				<a href="/place/placeList.yo"><h1>지도로 즐기기</h1></a>
			</td>
			<td>
				<a href="#"><h1>글로 즐기기</h1></a>
			</td>
		</tr>
	</table>
</body>
</html>
