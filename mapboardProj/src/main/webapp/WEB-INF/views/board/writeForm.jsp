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
					
		#left {text-align:left;
					padding-left:10px;}
					
		
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		$(document).ready(function(){
			var count=1;		//업로드할 파일 개수
			
			$("#wBtn").click(function(){//글쓰기 버튼 클릭
				if(!$("#place").val()){
					alert("장소명을 입력해주세요.");
					$("#place").focus();
					return false;
				}
				//관광/여가/오락, 숙박, 의료, 식당, 커피점/카페, 기타
				if(!$("#category").val()){
					alert("분류명을 입력해주세요.");
					$("#category").focus();
					return false;
				}
				if(!$("#title").val()){
					alert("제목을 입력해주세요.");
					$("#title").focus();
					return false;
				}
				if(!$("#body").val()){
					alert("내용을 입력해주세요.");
					$("#body").focus();
					return false;
				}
				$("#wForm").submit();
			});
			
			//첨부파일 추가하기
			$("#aBtn").click(function(){
				count++;
				if(count==6){
					alert("5개 이상은 추가할 수 없습니다.")
					count=5;
					return false;
				}
				//폼 추가
				var tr= "<tr><th>첨부파일"+count+"</th>"+
				"<td><input type='file' name='files'  id='files"+count+"'/>"+
				"</td></tr>"
				$("#copy").before(tr);
			});
			
			//첨부파일 삭제하기
			$("#dBtn").click(function(){
				if(count==1){
					alert=("더 이상 삭제 할 수 없습니다.")
					count=1;
					return false;
				}
				var tr=$("#files"+count).parents("tr");
				tr.remove();
				count--;
			});
			
			//목록보기
			$("#lBtn").click(function(){
				//boardList로 가기
			});
		});
	</script>
</head>
<body>
	<form id="wForm" method="post" action=""
											encType="multipart/form-data">
		<table>
			<tr>
				<th>장소명</th>
				<td id="left"><input type="text" id="place" name="place"/></td>
			</tr>
			<tr>
			<!-- 관광/여가/오락, 숙박, 의료, 식당, 커피점/카페, 기타 -->
				<th>분류명</th>
				<td id="left">
					<select>
						<option>--분류명 선택--</option>
						<option value="1">관광/여가/오락</option>
						<option value="2">숙박</option>
						<option value="3">의료</option>
						<option value="4">식당</option>
						<option value="5">커피점/카페</option>
						<option value="6">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td id="left"><input type="text" id="title" name="title"/></td>
			</tr>
			<tr>
				<th>글내용</th>
				<td>
					<textarea id="body" name="body" cols="120" rows="5" style="resize:none;"></textarea>
				</td>
			</tr>
			<tr>
				<th>장소평가</th>
				<td id="left">
					<input type="checkbox" name="point" value="5">Good
					<input type="checkbox" name="point" value="3">Soso<!-- default -->
					<input type="checkbox" name="point" value="1">Bad
				</td>
			</tr>
			<tr>
				<th>파일 추가/삭제</th>
				<td id="left">
					<input type="button" id="aBtn" value="추가"/>
					<input type="button" id="dBtn" value="삭제"/>
				</td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td id="left">
					<input type="file" id="files" name="files" value="파일선택"/>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="button" id="wBtn" value="글등록"/>
					<input type="button" id="lBtn" value="목록보기"/>
				</th>
			</tr>
		</table>
	</form>
</body>
</html>