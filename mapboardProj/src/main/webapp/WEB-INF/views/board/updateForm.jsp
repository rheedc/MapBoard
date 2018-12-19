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
					
		#center{text-align:center;
						}
					
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		$(document).ready(function(){
			var count=1;		//업로드할 파일 개수
			
			$("#mBtn").click(function(){//수정하기 버튼 클릭
				
				
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
				if(!$('input[name="point"]').is(':checked')){
					alert('장소 평가를 해주세요')
					$('input[name="point"]:eq[1]').focus()
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
				var tr= "<tr><th>파일첨부"+count+"</th>"+
				"<td id='left'><input type='file' id='files"+count+"' name='files' value='파일첨부'/>"+
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
			
			//취소하기(목록보기로 이동)
			$("#cBtn").click(function(){
				//boardList로 가기
				$(location).attr("href","../board/boardList.yo");
			});
		});
	</script>
</head>
<body>
<h1 id="center" style="color:darkblue;">게시글 수정</h1>
<h4 id="center">해당 장소에 대한 게시글을 수정해주세요</h4>
	<form id="wForm" method="post" action="../board/updateProc.yo?bidx=${VIEW.bidx}&nowPage${nowPage}"
											encType="multipart/form-data">
		<table>
			<!-- <tr>
				<th>장소명</th>
				<td id="left"><input type="text" id="place" name="place"/></td>
			</tr>
			<tr>
			관광/여가/오락, 숙박, 의료, 식당, 커피점/카페, 기타
				<th>장소분류</th>
				<td id="left">
					<select name="category">
						<option>--분류명 선택--</option>
						<option value="1">관광/여가/오락</option>
						<option value="2">숙박</option>
						<option value="3">의료</option>
						<option value="4">식당</option>
						<option value="5">커피점/카페</option>
						<option value="6">기타</option>
					</select>
				</td>
			</tr>-->
			<tr>
				<th>제목</th>
				<td id="left"><input type="text" id="subject" name="subject" value="${VIEW.subject}"/> </td>
			</tr> 
			<tr>
				<th>글내용</th>
				<td>
					<textarea id="comm" name="comm" cols="124" rows="10" style="resize:none;">${VIEW.comm}</textarea>
				</td>
			</tr>
			<tr>
				<th>장소평가</th>
				<td id="left">
					<input type="radio" name="point" value="5">Good
					<input type="radio" name="point" value="3">Soso<!-- default값주기 -->
					<input type="radio" name="point" value="1">Bad
				</td>
			</tr>
			
			<tr>
				<th>파일첨부</th>
				<td>
					<input type="button" id="aBtn" value="추가"/>
					<input type="button" id="dBtn" value="삭제"/>
				</td>
			</tr>
			<tr>
				<th>파일첨부1</th>
				<td>
					<input type="file" id="files1" name="files" value="파일선택"/>
				</td>
			</tr>
			
			<tr id="copy">
				<th colspan="2">
					<input type="button" id="mBtn" value="수정"/>
					<input type="button" id="cBtn" value="취소"/>
				</th>
			</tr>
		</table>
	</form>
</body>
</html>