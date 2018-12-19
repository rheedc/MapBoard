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
										
		
					
		#text-left { text-align : left;
							padding-left:10px;
							}
		
		#title {text-align : center;
					font-size : 30px;
					width : 500px;
					height : 50px;
					}
		
		#width {width : 100px;
						}		
							
		
						
		#wide {width : 700px;
					 }
		
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
		$(document).ready(function(){
			
			//원글 수정
			$("#mBtn").click(function(){
				//수정폼으로 이동
				$(location).attr("href","../board/updateForm.yo?bidx=${VIEW.bidx}&nowPage=${nowPage}");
			});
			
			//원글 삭제
			$("#dBtn").click(function(){
				if(confirm("정말로 삭제하시겠습니까?")){
					$(location).attr("href","../board/boardDelete.yo?bidx=${VIEW.bidx}&nowPage=${nowPage}");
				}
			});
			
			//댓글 등록 버튼 
			$("#wrBtn").click(function(){
				$("#wrfrm").submit();
			});
			
			//댓글 수정버튼 클릭시 댓글 수정폼으로 변경
			$(".mCBtn").click(function(){
				var button=$(this);
				var table=button.parents("table");
				var id=table.attr("id");
				//테이블 감추기
				$("#"+id).hide();
				//수정폼 보여주기
				$("#"+id+"frm").show();
			})
			
			//댓글 수정 등록하기
			$(".sCBtn").click(function(){
				var button=$(this);
				var form=button.parent("form");
				$(form).submit();
			});
			
			//댓글 수정 취소하기
			$(".bCBtn").click(function(){
				var button=$(this);
				var table=button.parents("table");
				var id=table.attr("id");
				$(location).attr("href","../board/boardDetail.yo?reNo="+id+"&bidx=${bidx}&nowPage=${nowPage}");
			})
			
			//댓글 삭제 버튼
			$("#dCBtn").click(function(){
				if(confirm("정말로 삭제하시겠습니까?")){
					var button=$(this);
					var table=button.parents("table");
					var id=table.attr("id");
					$(location).attr("href","../board/replyDelete.yo?reNo="+id+"&oriNo=${oriNo}&nowPage=${nowPage}");
				}
			});
			
		});	
	</script>
</head>
<body>
<%-- 게시판 상세보기 --%>
  		<table align="center" width="70%">
  			<tr>
  				<td>
  					<h3 align="left">제목 : ${VIEW.subject}</h3>
  				</td>
  			</tr>
  		</table>
 	<!-- 원글상세보기 --> 		
  		<table align="center" width="70%" class="style1">
  			<tr>
  				<th id="text-left">작성자: ${VIEW.userid}	작성일: ${VIEW.createdt}</td>
  				<td id="width">
  					<input type="button" id="mBtn" value="수정"/>
  				</td>
  				<td id="width">
  					<input type="button" id="dBtn" value="삭제"/>
  				</td>
  			</tr>
  			<tr>
  				<th colspan="3">사진, 페이징처리
  				</th>
  			</tr>
  			<tr>
  				<th colspan="3">
  					<textarea id="body" name="body" cols="136" style="resize:none;">${VIEW.comm}</textarea>
  				</th>
  			</tr>
  		</table>
  		
  	<!-- 지도보기 -->
  		<table align="center" width="70%">
  			<tr>
  				<td>지도삽입 : map</td>
  				<td>장소명: ${VIEW.place_name}<br/>분류명: ${categoryName}<br/>장소평가:${VIEW.point}</td>
  			</tr>
  	<%-- 추천하기 체크를 위한 form --%>
  	
  			
	<!-- 댓글쓰기 추가 form-->
  		
  		<!-- 목록보기 -->
  		<table aling="center" width="70%">
  			<tr align="center">
  				<td>
  					<input type="button" id="lBtn" value="목록보기" class="button" 
  					onclick="location.href='../../board/boardList2.yo?bidx=${VIEW.bidx}&nowPage=${nowPage}'"/>
  				</td>
  			</tr>
  		</table>
</body>
</html>