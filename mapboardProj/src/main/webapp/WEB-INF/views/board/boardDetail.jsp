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
				$(location).attr("href","../board/modifyForm.yo?oriNo=${oriNo}&nowPage=${nowPage}");
			});
			
			//원글 삭제
			$("#dBtn").click(function(){
				if(confirm("정말로 삭제하시겠습니까?")){
					$(location).attr("href","../board/boardDelete.yo?oriNo=${oriNo}&nowPage=${nowPage}");
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
				$(location).attr("href","../board/boardDetail.yo?reNo="+id+"&oriNo=${oriNo}&nowPage=${nowPage}");
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
  					<h3 align="left">제목 : </h3>
  				</td>
  			</tr>
  		</table>
 	<!-- 원글상세보기 --> 		
  		<table align="center" width="70%" class="style1">
  			<tr>
  				<th id="text-left">작성자: 	작성일:</td>
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
  					<textarea id="body" name="body" cols="136" style="resize:none;">글내용</textarea>
  				</th>
  			</tr>
  		</table>
  	<!-- 지도보기 -->
  		<table>
  			<tr>
  				<td>지도삽입 : </td>
  				<td>장소명: <br/>분류명: <br/>장소평가:</td>
  			</tr>
  	<%-- 추천하기 체크를 위한 form --%>
  	<c:if test="${not empty sessionScope.userid}">
  		<form id="LCheckfrm" action="../board/writeCommand.yo" method="post">
  			<input type="hidden" name="oriNo" value="${oriNo}">
  			<input type="hidden" name="nowPage" value="${nowPage}">
  			<input type="hidden" name="userid" value="${sessionScope.userid}">
  			<table align="center" width="70%">
  				<tr align="center">
  					<td>
  						<input type="submit" id="LBtn" value="추천/취소" class="button">
  					</td>
  					<td>조회수: 	</td>
  					<td>추천수: 	</td>
  				</tr>
  			</table>
  		</form>
  	</c:if>
  			
  	<%-- 댓글 작성 테이블 --%>
  	<c:if test="${not empty sessionScope.uesrid}">
  		<form id="wrfrm" name="wrfrm" action="../board/replyWrite.yo" method="post">
  			<input type="hidden" id="oriNo" name="oriNo" value="${oriNo}">
  			<input type="hidden" id="nowPage" name="nowPage" value="${nowPage}">
			<table align="center" width="70%">
				<tr>
					<td>
						<textarea name="comm" id="comm" placeholder="댓글 작성란"></textarea>
					</td>
					<td algin="center" width="10%">
						<input type="button" id="wrBtn" value="글등록" class="button">
					</td>
				</tr>
			</table>  		
  		</form>	
  	</c:if>	
  	
  	<%-- 댓글이 존재한다면 반복해서 뿌려주기 --%>
  	<%-- 댓글이 없는 경우 --%>
  	<c:if test="${empty COMM}">
  		<table align="center" width="70%">
  			<tr>
  				<td align="center"><h4><b>"첫번째 댓글을 작성해주세요"</b></h4>
  			</tr>
  		</table>
  	</c:if>
  	<%-- 댓글이 존재하는 경우 => 댓글수만큼 반복출력 --%>
  	<c:if test="${not empty COMM}">
  		<c:forEach var="temp" items="${COMM}">
  			<table align="center" width="70%"  id="${temp.bcidx }" class="style2">
  				<tr>
  					<td width="20%"><b>${temp.nick}</b></td>
  					<td width="60%"><b>${temp.comm}</b></td>
  					<td width="20%" align="right">
  					<%-- 관리자는 모든 댓글도 수정/삭제 권한을 가지고 있어야 함 --%>
  						<input type="button" class="mCBtn btn2" value="수정">
  						<input type="button" class="dCBtn btn2" value="삭제">
  						&nbsp;${temp.createdt}
  					</td>
  				</tr>
  		 	</table>
  		 	<%-- 댓글 수정을 위한 임시폼 --%>
  		 	<form id="${temp.bcidx}frm" method="post" action="../board/replyModify.yo" style="display:none;">
  		 		<input type="hidden" name="reNo" value="${temp.bcidx}"/>
  		 		<input type="hidden" name="oriNo" value="${temp.bidx}"/>
  		 		<input type="hidden" name="nowPage" value="${nowPage}"/>
  		 		<table align="center" width="70%" class="style2">
  		 			<tr>
  		 				<td width="20%"><b>${temp.nick}</b></td>
  		 				<td width="50%">
  		 					<textarea name="comm" id="mComm" placeholder="댓글 수정란">
  		 					${temp.getCommNbr()}
  		 					</textarea>
  		 				</td>
  		 				<td align="right" width="30%">
  		 					<input type="button" class="sCbtn btn2" value="저장">
  		 					<input type="button" class="dCBtn btn2" value="취소">
  		 					&nbsp;${temp.createdt}
  		 				</td>
  		 			</tr>
  		 		</table>
  		 	</form>
  		 </c:forEach>
  	</c:if>
  		
  		<table aling="center" width="70%">
  			<tr align="center">
  				<td>
  					<input type="button" id="lBtn" value="목록보기" class="button" 
  					onclick="location.href='/board/boardList.yo?oriNo=${oriNo}&nowPage=${nowPage}'"/>
  				</td>
  			</tr>
  		</table>
</body>
</html>