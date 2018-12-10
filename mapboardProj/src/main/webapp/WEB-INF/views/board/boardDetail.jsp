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
		table, tr, th, td {margin : auto;
										border : 1px solid;
										text-align : center;
										height : 42px;
										}
										
		table {width : 1000px;
					}
					
		#text-left { text-align : left;
							padding-left:10px;
							}
						
						
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		$(document).read(function(){
			//수정버튼
			$("#mBtn").click(function(){
				//수정폼으로 이동
			});
			//삭제버튼
			$("#dBtn").click(function(){
				//리뷰삭제
			});
			//추천버튼 cBtn
			$("#cBtn").click(function(){
				
			});
			//댓글추가 버튼 rBtn
			$("#rBtn").click(function(){
				
				
				//추가할 폼
				var tr = "<tr><th>"+$닉네임+"</th>"+
								"<td><input type='button' id='rmBtn' value='수정'/>"+
								"<input type='button' id='rdBtn' value='삭제'/></td></tr>"+
								"<tr><th colspan='2'>"+댓글내용+"</th><td></td></tr>"+
								"<tr><th>"+sysdate+"</th><td></td></tr>"
				
				//원하는 위치에 추가
				//원하는 위치 id가 copy인 element => <tr>~~~
				//추가
				$("#review").after(tr);
				count++;
			});
			
			//댓글 수정 버튼
			$("#rmBtn").click(function(){
				//수정팝업 띄우기
				
			});
			//댓글 삭제 버튼
			$("#rdBtn").click(function(){
				//댓글 삭제
			});
			
		});	
	</script>
</head>
<body>
  	<form id="" action="">
  		<table>
  			<tr>
  				<th  id="text-left" colspan="2">제목 : 
  					<input type="text" id="title" name="title"/>
  				</th>
  			</tr>
  			<tr>
  				<th id="text-left">작성자: 	작성일:</td>
  				<td>
  					<input type="button" id="mBtn" value="수정"/>
  					<input type="button" id="dBtn" value="삭제"/>
  				</td>
  			</tr>
  			
  			<tr>
  				<th colspan="2">사진, 페이징처리
  				</th>
  			</tr>
  			<tr>
  				<th colspan="2">
  					<textarea id="body" name="body" cols="137" style="resize:none;"></textarea>
  				</th>
  			</tr>
  			
  			<tr>
  				<td rowspan="5">지도삽입</td>
  				<td>장소명:</td>
  			</tr>
  			<tr>
  				<td>분류명:</td>
  			</tr>
  			<tr>
  				<td>장소평가</td>
  			</tr>
  			<tr>
  				<td></td>
  			</tr>
  			<tr>
  				<td></td>
  			</tr>
  			
  			<tr>
  				<th id="text-left">
  					<input type="button" id="cBtn" value="추천하기"/>
  				</th>
  				<td>조회수: 	추천수: 	</td>
  			</tr>
  			
  			<tr id="review">
  				<th>
  					<textarea id="review" name="review" cols="120" rows="5" style="resize:none">댓글쓰기</textarea>
  				</th>
  				<td>
  					<input type="button" id="rBtn" value="등록"/>
  				</td>
  			</tr>
  			<tr>
  				<th colspan="2">
  					<input type="button" id="lBtn" value="목록보기"/>
  				</th>
  			</tr>
  		</table>
  	
  	</form>
</body>
</html>