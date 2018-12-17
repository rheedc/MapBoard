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
	   						<!-- 로그인 전/후 모두 노출 -->
		   					<li><a href="/place/placeList.yo"><span class="glyphicon glyphicon-cloud"></span> 지도</a></li>
						    <li><a href="/board/boardList.yo"><span class="glyphicon glyphicon-cloud"></span> 커뮤니티</a></li>
		   					<c:if test="${sessionScope.userid eq null}">
							  <li><a href="/member/LoginForm.yo" ><span class="glyphicon glyphicon-log-in"></span> 로그인</a></li>
							  <li><a href="/member/joinForm.yo"><span class="glyphicon glyphicon-cloud-upload"></span> 회원가입</a></li>
							</c:if>
				
							<!-- 로그인시 노출 -->
							<c:if test="${sessionScope.userid ne null}">
								<!-- 일반레벨 로그인유저에게 노출 -->
								<c:if test="${sessionScope.ulevel ne 10}">
								<li <c:if test="${conPath eq '/member/memberDetail.yo' or conPath eq '/member/memberUpdate.yo'}">class="active"</c:if>><a href="/member/memberDetail.yo"><span class="glyphicon glyphicon-user"></span> 회원정보</a></li>
								</c:if>
								<!-- 관리자레벨 로그인유저에게 노출 -->
								<c:if test="${sessionScope.ulevel eq 10}">
								<li class="dropdown">
							    <a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="glyphicon glyphicon-lock"></span> 사이트관리<span class="caret"></span></a>
							    <ul class="dropdown-menu">
							      <li><a href="/admin/memberList.yo"><span class="glyphicon glyphicon-user"></span> 회원관리</a></li>
							      <li><a href="/admin/placeList.yo"><span class="glyphicon glyphicon-globe"></span> 장소관리</a></li>
							    </ul>
							  	</li>
								</c:if>
							  	<!-- 일반/관리자 모두에게 노출 -->
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