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
	<link href="../resources/css/default.css" rel="stylesheet">
	<!-- 부트스트랩 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<style type="text/css">
	/* style 작성부분 */
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	
	</script>
</head>
<body>
<c:set var="conPath" value="${pageContext.request.requestURI}"/>
	<!-- header -->
	<div class="navbar navbar-inverse" style="top:0; width:100%; height:60px; background-color: rgba(174, 218, 232, 1); border-color: rgba(174, 218, 232, 1);">
    	<div class="container" style="width:90%">
    		<div class="navbar-header " >
	            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
	              <span class="sr-only">Toggle navigation</span>
	              <span class="icon-bar"></span>
	              <span class="icon-bar"></span>
	              <span class="icon-bar"></span>
	            </button>
	            <a class="navbar-logo" href="/"><img src="../resources/img/seoul1.png" class="img-circle" style="width:59px; height:59px;" alt="mapboard logo" title="mapboard logo" /></a>
	            <a class="navbar-logo2" href="/" ><img src="../resources/img/iknowyouknow.png" style="width:auto; height:59px;" alt="iknowyouknowlogo" title="iknowyouknowlogo" /></a>
	            
          	</div>
          	<div class="navbar-collapse collapse" style="float:right;">
          		<!-- https://www.w3schools.com/bootstrap/bootstrap_tabs_pills.asp 참고 -->
	   			<ul class="nav navbar-nav">
	   				<li>
	   					<ul class="nav nav-tabs">
		   					<li><a href="/place/placeList.yo"><span class="glyphicon glyphicon-cloud"></span> 지도</a></li>
						    <li><a href="#"><span class="glyphicon glyphicon-cloud"></span> 커뮤니티</a></li>
		   					<c:if test="${sessionScope.userid eq null}">
							  <li <c:if test="${conPath eq '/member/loginFormAction.yo'}">class="active"</c:if>><a href="/member/LoginForm.yo" ><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
							  <li <c:if test="${conPath eq '/member/joinFormAction.yo'}">class="active"</c:if>><a href="/member/joinForm.yo"><span class="glyphicon glyphicon-cloud-upload"></span> 회원가입</a></li>
							</c:if>
							<c:if test="${sessionScope.userid ne null}">
								<li <c:if test="${conPath eq '/member/memberInfoFormAction.yo' or conPath eq '/member/memberUpdateFormAction.yo'}">class="active"</c:if>><a href="/member/memberInfoFormAction.yo"><span class="glyphicon glyphicon-user"></span> 회원정보</a></li>
								<c:if test="${sessionScope.ulevel eq 10}">
								<li><a href="/admin/orderHistoryListAction.yo"><span class="glyphicon glyphicon-lock"></span> 사이트관리</a></li>
								</c:if>
								<li><a href="/member/LogoutProc.yo"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>
							</c:if>
						</ul>
	   				</li>
	            </ul>
            </div>
   		</div>
    </div>
	
	<!-- content -->
	<decorator:body></decorator:body>

	<!-- FOOTER -->
	<div class="footer">
    	<span class="footer-text">Copyright&copy; 	(주)I KNOW YOU KNOW corp.</span>
    </div>

</body>
</html>
