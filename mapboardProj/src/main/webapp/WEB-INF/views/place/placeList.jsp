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
	
		.area {
		    position: absolute;
		    background: #fff;
		    border: 5px solid skyblue;
		    border-radius: 30px;
		    font-size: 12px;
		    top: -5px;
		    left: 15px;
		    padding:2px;
		}
		 
		.info {font-size: 12px; padding: 5px;}
		.info .title {font-weight: bold;}
		
		 .map_wrap {position:relative;width:1200px;height:700px;}
	    .title {font-weight:bold;display:block;}
	    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
	    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
	    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	    
	    .hover:hover {
			background-color: #ebf6f9;
			font-weight:bold;
		    color:black;
		} 
		
		
	/*********************** 은비 스타일 start *************************/
	#top_content {
	width:1900px;
	height:50px;
	text-align:center;
	padding:10px;
	background-color:#ebf6f9;
	}
	#left_content {
	width:500px;
	height:750px;
	float:left;
	text-align:left;
	background-color:white;
	}
	#right_content {
	width:1900px;
	height:750px;
	text-align:center;
	}
	.placeResult_jo,.boardResult_jo{
	overflow-y:scroll;
	height:600px;
	border:1px solid #444444;
	}
	.placeResult_jo td,.placeResult_jo th,
	.boardResult_jo td,.boardResult_jo th{
	border-bottom: 1px solid #444444;
	padding:10px;
	}
	/*********************** 은비 스타일 end *************************/
		
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	

	
	
	// 쿠키 설정 함수
	var setCookie = function(name, value, exp) {
		var date = new Date();
		date.setTime(date.getTime() + exp*24*60*60*1000);
		document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
	};
	
	// 쿠키 얻기 함수
	var getCookie = function(name) {
		var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
		return value? value[2] : null;
	};
	
	// 쿠키 삭제 함수
	var deleteCookie = function(name) {
		setCookie(name,'',-1);
	};
	
	//행정구역 구분
	
	$(function(){		
		
		// 삭제 쿠키 되는지 확인 중입니다. 꼭 삭제해야한다
		//deleteCookie('guname');
		//console.log('guname 될까?'+getCookie('guname'));
		// 중심좌표 구해주기
		function centroid (points) {
		    var i, j, len, p1, p2, f, area, x, y;
		 
		    area = x = y = 0;
		 
		    for (i = 0, len = points.length, j = len - 1; i < len; j = i++) {
		            p1 = points[i];
		            p2 = points[j];
		 
		            f = p1.y * p2.x - p2.y * p1.x;
		            x += (p1.x + p2.x) * f;
		            y += (p1.y + p2.y) * f;
		            area += f * 3;
		    }
		    return new daum.maps.LatLng((x/area), (y/area));
		}
		
		// 지도를 표시할 div 
		var mapContainer = document.getElementById('map'), 
	    mapOption = { 
	        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 9 // 지도의 확대 레벨
	    };

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new daum.maps.Map(mapContainer, mapOption),
	    customOverlay = new daum.maps.CustomOverlay({}),
	    infowindow = new daum.maps.InfoWindow({removable: true});
		
		//	json 데이터를 불러와서 폴리곤 생성하기
		$.getJSON("/resources/json/abc.json", function(json) {
		 
		    var data = json.features;
		    var coordinates = [];    //좌표 저장할 배열
		    var name = '';            //행정 구 이름
		 
		    $.each(data, function(index, val) {
		 
		        coordinates = val.geometry.coordinates;
		        name = val.properties.SIG_KOR_NM;
		        // 폴리곤 생성
		        // 쿠키를 얻어서 guname이 없다면 서울시 전체를 있다면 해당 구화면을 보여준다
		        guname=getCookie('guname');
		        console.log('guname='+guname);
		        if(guname==null){
		        	displayArea(coordinates, name);	
		        }else if(guname==name){
		        	displayArea(coordinates, name);	
		        	
		        }
		        
		    })
		})
		 
		// 전역 변수 모음-------------------------------------시작
		var polygons=[];                //function 안 쪽에 지역변수로 넣으니깐 폴리곤 하나 생성할 때마다 배열이 비어서 클릭했을 때 전체를 못 없애줌.  그래서 전역변수로 만듦.
		var gupath=[];    	//	gupath 전역변수
		var guname='';		//	guname 전역변수		
		var mouseLat=0;		//mouseLat 위도 전역변수
		var mouseLng=0;		//mouseLng 경도 전역변수
		
		// 전역 변수 모음-------------------------------------끝
		
		//행정구역 폴리곤 생성 함수
		function displayArea(coordinates, name) {
		 
		    var path = [];           //폴리곤 그려줄 path
		    var points = [];        //중심좌표 구하기 위한 지역구 좌표들
		    
		    //	반복
		    $.each(coordinates[0], function(index, coordinate) {        
		    	//console.log(coordinates)를 확인해보면 보면 [0]번째에 배열이 주로 저장이 됨.  그래서 [0]번째 배열에서 꺼내줌.
		        var point = new Object();
		        
		        point.x = coordinate[1];
		        point.y = coordinate[0];
		        points.push(point);
		        // path 넣어주기
		        path.push(new daum.maps.LatLng(coordinate[1], coordinate[0]));            
		        //new daum.maps.LatLng가 없으면 인식을 못해서 path 배열에 추가
		    })
		    
		    // 다각형을 생성합니다 
		     var polygon = new daum.maps.Polygon({
		        map : map, // 다각형을 표시할 지도 객체
		        path : path,
		        strokeWeight : 2,
		        strokeColor : '#0c5d94',
		        strokeOpacity : 0.7,
		        fillColor : '#fff',
		        fillOpacity : 0.7
		    });
		    
		    polygons.push(polygon);            //폴리곤 제거하기 위한 배열
		 
		    // 다각형에 mouseover 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 변경합니다 
		    // 지역명을 표시하는 커스텀오버레이를 지도위에 표시합니다
		    daum.maps.event.addListener(polygon, 'mouseover', function(mouseEvent) {
		        polygon.setOptions({
		            fillColor : '#09f'
		        });
		 
		        customOverlay.setContent('<div class="area">' + name + '</div>');
		 
		        customOverlay.setPosition(mouseEvent.latLng);
		        customOverlay.setMap(map);
		    });
		 
		    // 다각형에 mousemove 이벤트를 등록하고 이벤트가 발생하면 커스텀 오버레이의 위치를 변경합니다 
		    daum.maps.event.addListener(polygon, 'mousemove', function(mouseEvent) {
		 
		        customOverlay.setPosition(mouseEvent.latLng);
		    });
		 
		    // 다각형에 mouseout 이벤트를 등록하고 이벤트가 발생하면 폴리곤의 채움색을 원래색으로 변경합니다
		    // 커스텀 오버레이를 지도에서 제거합니다 
		    daum.maps.event.addListener(polygon, 'mouseout', function() {
		        polygon.setOptions({
		            fillColor : '#fff'
		        });
		        customOverlay.setMap(null);
		    });
		 
		    // 클릭시 해당구 표현 하는 것을 함수로 만들고 이곳에 함수실행 함수는 전역으로
		    //-------함수로 만들자-----------------------------------------------------끝
		    daum.maps.event.addListener(polygon, 'click', function() {		       		    
		    	
		    	// 클릭한 곳에 클릭한 좌표를 전역변수 clickpath를 담는다.	
		    	//console.log(path)
		    	
		    	// 개발자 모드에서 지도 정보에 대해 console로 출력했다
		    	 getInfo();
		    	
		        // 현재 지도 레벨에서 3레벨 확대한 레벨
		        var level = map.getLevel()-3;
		        
		        // 지도를 클릭된 폴리곤의 중앙 위치를 기준으로 확대합니다
		        map.setLevel(level, {anchor: centroid(points), animate: {
		            duration: 350            //확대 애니메이션 시간
		        }});            
		        
		        deletePolygon(polygons);                    //폴리곤 제거 
		        customOverlay.setContent('<div class="area"></div>');
		     	
		        // 해당 구의 path를 기억한다
		        
		        gupath = path;
		        guname = name;
	        	$("#sigungu_name").val(guname);
	        	
	        	
	        	
	        	//$("#guname1").html('<span>'+guname+'</span>');
		     	// 폴리건 클릭한 곳에서 생성
		        var polygon = new daum.maps.Polygon({
			        map : map, // 다각형을 표시할 지도 객체
			        path : gupath,
			        strokeWeight : 4,
			        strokeColor : 'red',
			        strokeOpacity : 0.8,
			        fillColor : 'white',
			        fillOpacity : 0.3
			    });
		     //console.log(gupath);
		        
		     // ----------------------------------------------------
		     // 주소-좌표 변환 객체를 생성합니다
			var geocoder = new daum.maps.services.Geocoder();
			
			var marker = new daum.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
			    infowindow = new daum.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
			    
			// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			
		    // 처음 클릭시 정보창이 
			    
			    
			// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니
			daum.maps.event.addListener(map, 'rightclick', function(mouseEvent) {
			    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
			        if (status === daum.maps.services.Status.OK) {
			            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
			            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
			            
			            var content = '<div class="bAddr" style="width:340px;">' + 
			                            '<span class="title">법정동 주소정보</span>' + 
			                            detailAddr + 
			                            '<span>'+'<input type="button" class="btn2" id="newBtn" style="width:110px;background-color: rgba(174, 218, 232, 1);"  value="신규장소등록" onclick="location.href=\'../place/newPlaceForm.yo\'"/>'+'</span>'+
			                            '<span>'+'<input type="button" class="btn2" id="myBtn" style="width:110px;background-color: rgba(174, 218, 232, 1);"  value="내 기준지 등록" onclick="location.href=\'../place/myPlaceForm.yo\'"/>'+'</span>'+'<br/>'+
			                        '</div>';
                         
                        deleteCookie('mouseLat');
            			deleteCookie('mouseLng');
            			

            			daum.maps.event.addListener(marker, 'custom_action', function(data){
            				console.log(data + '가 발생했습니다.');
            			});            	
                        var latlng = mouseEvent.latLng;
                        mouseLat = latlng.getLat();		//mouseLat 위도 전역변수
                		mouseLng = latlng.getLng();		//mouseLng 경도 전역변수
                		setCookie('mouseLat',mouseLat, 1); 
            			setCookie('mouseLng',mouseLng, 1); 
            			setCookie('detailAddr',result[0].address.address_name , 1);
            			console.log('detailAddr'+result[0].address.address_name );
                		console.log('위도=',mouseLat,'경도=',mouseLng);
			
			            // 마커를 클릭한 위치에 표시합니다 
			            marker.setPosition(mouseEvent.latLng);
			            marker.setMap(map);
			
			            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
			            infowindow.setContent(content);
			            infowindow.open(map, marker);
			            
                  	// 마커 위에 인포윈도우를 삭제합니다
	            	daum.maps.event.addListener(marker, 'click', makeOutListener2(infowindow));	 			            	
			            
			        }   
			    });
			});
			
			// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
			daum.maps.event.addListener(map, 'idle', function() {
			    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			    // 중심좌표 표시
			    getInfo()
			});

			function searchAddrFromCoords(coords, callback) {
			    // 좌표로 행정동 주소 정보를 요청합니다
			    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
			}

			function searchDetailAddrFromCoords(coords, callback) {
			    // 좌표로 법정동 상세 주소 정보를 요청합니다
			    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
			}

			// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
			function displayCenterInfo(result, status) {
			    if (status === daum.maps.services.Status.OK) {
			        var infoDiv = document.getElementById('centerAddr');

			        for(var i = 0; i < result.length; i++) {
			            // 행정동의 region_type 값은 'H' 이므로
			            if (result[i].region_type === 'H') {
			                infoDiv.innerHTML = result[i].address_name;
			                break;
			            }
			        }
			    }    
			}
		     
		     // -----------------------------------------------
		     	//게시글보기 이동
			/* function  boardList() {
				$(location).attr('href', '../board/boardList1.yo')
				/place/boardListProc
			}
			
			// 새글쓰기 이동
			function  newWrite() {
				$(location).attr('href', '../board/writeForm1.yo')
				/place/writeFormProc
			}  */
			// 마커를 표시할 위치와 title 객체 배열입니다 			
			
			var positions = [
				<c:forEach var="m" items="${TLIST}" varStatus="status">
			    {
			        title: "${m.place_name}",
			        content: "<div style='width:270px;'>"+
			        "<div  class='title'>상가명: ${m.place_name}</div>"+
			        "<div>지번주소: ${m.juso}</div><div>도로주소: ${m.doro_juso}</div>"+
			        "<div>평균평점: ${m.avgpoint}</div>"+
			        "<div>good:${m.goodcnt} soso:${m.sosocnt} bad:${m.badcnt}</div>"+
			        "<input type='button' class='btn2' id='boardListBtn' name='boardListBtn' "+
			        " style='width:100px;background-color: rgba(174, 218, 232, 1);'  value='게시글 보기' "+
			        " onclick=\"location.href=\'../place/boardListProc.yo?place_name=${m.place_name}&juso=${m.juso}\'\"/>"+
			        "<input type='button' class='btn2' id='newBoardBtn'  name='newBoardBtn' "+
			        " style='width:100px;background-color: rgba(174, 218, 232, 1);'  value='새글쓰기' "+
			        " onclick=\"location.href=\'../place/writeFormProc.yo?place_name=${m.place_name}&juso=${m.juso}\'\"/>"+
			        "</div>",
			        juso: "<div>${m.juso}</div>",
			        good:"<div>good:${m.goodcnt}</div>",
			        soso:"<div>soso:${m.sosocnt}</div>",
			        bad:"<div>bad:${m.badcnt}</div>",
			        latlng: new daum.maps.LatLng(${m.latitude}, ${m.longitude})
			    }
			    <c:if test="${status.count < fn:length(TLIST)}">,</c:if>
			    </c:forEach>
			    
			];
		     
			// 마커 이미지의 이미지 주소입니다
			var imageSrc_good = "../resources/img/dot_good.png"; 
			var imageSrc_soso = "../resources/img/dot_green.png";
			var imageSrc_bad = "../resources/img/dot_bad.png";
			var imageSrc_0 = "../resources/img/dot_0.png";
						    
			<c:forEach var="m" items="${TLIST}"  varStatus="status">
			//for (var i = 0; i < positions.length; i ++) {
			    
			    // 마커 이미지의 이미지 크기 입니다 reviewcnt
			    var imageSize = new daum.maps.Size(8+${m.reviewcnt}*10, 8+${m.reviewcnt}*10); 
			    
			    // 마커 이미지를 생성합니다    			 imageSrc_0    imageSrc_soso imageSrc_good
			    if(${m.avgpoint}==0){
			    	var markerImage = new daum.maps.MarkerImage(imageSrc_0, imageSize); 
			    } else if (${m.avgpoint}>=1&& ${m.avgpoint}<2.4 ){
			    	var markerImage = new daum.maps.MarkerImage(imageSrc_bad, imageSize); 
			    } else if (${m.avgpoint}>=2.4 && ${m.avgpoint}<3.7 ){
			    	var markerImage = new daum.maps.MarkerImage(imageSrc_soso, imageSize); 
			    } else {
			    	var markerImage = new daum.maps.MarkerImage(imageSrc_good, imageSize); 
			    } 			    
			    
			    // 마커를 생성합니다
			    var marker5 = new daum.maps.Marker({
			        map: map, // 마커를 표시할 지도
			        position: positions[${status.index}].latlng, // 마커를 표시할 위치
			        title : positions[${status.index}].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			        image : markerImage // 마커 이미지 
			    });
			    
			 	// 마커에 표시할 인포윈도우를 생성합니다 
			    var infowindow_s = new daum.maps.InfoWindow({
			        content: positions[${status.index}].content, // 인포윈도우에 표시할 내용
			    });
			    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
			    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
			    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
			    daum.maps.event.addListener(marker5, 'click', makeOverListener(map, marker5, infowindow_s));
			    daum.maps.event.addListener(map, 'click', makeOutListener(infowindow_s));
			    
			    
			//}
			</c:forEach>
			
			// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
			function makeOverListener(map, marker5, infowindow_s) {
			    return function() {
			    	infowindow_s.open(map, marker5);
			    };
			}

			// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
			function makeOutListener(infowindow_s) {
			    return function() {
			    	infowindow_s.close();
			    };
			}
			
			// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
			function makeOutListener2(infowindow) {
			    return function() {
			    	infowindow.close();
	            	marker.setMap(null);
			    };
			}
			
			//==============송 승환 클릭시  좌표 클릭!=================
			<c:forEach var="m" items="${PLIST}" varStatus="status">
				 $("#click_name_${m.place_no}").click(function(){
					 var position_c = [
						    {
						        title_c: "${m.place_name}",
						        content_c: "<div style='width:270px;'>"+
						        "<div  class='title'>상가명: ${m.place_name}</div>"+
						        "<div>지번주소: ${m.juso}</div><div>도로주소: ${m.doro_juso}</div>"+
						        "<div>평균평점: ${m.avgpoint}</div>"+
						        "<div>good:${m.goodcnt} soso:${m.sosocnt} bad:${m.badcnt}</div>"+
						        "<input type='button' class='btn2' id='boardListBtn' name='boardListBtn' "+
						        " style='width:100px;background-color: rgba(174, 218, 232, 1);'  value='게시글 보기' "+
						        " onclick=\"location.href=\'../place/boardListProc.yo?place_name=${m.place_name}&juso=${m.juso}\'\"/>"+
						        "<input type='button' class='btn2' id='newBoardBtn'  name='newBoardBtn' "+
						        " style='width:100px;background-color: rgba(174, 218, 232, 1);'  value='새글쓰기' "+
						        " onclick=\"location.href=\'../place/writeFormProc.yo?place_name=${m.place_name}&juso=${m.juso}\'\"/>"+
						        "</div>",
						        juso: "<div>${m.juso}</div>",
						        good:"<div>good:${m.goodcnt}</div>",
						        soso:"<div>soso:${m.sosocnt}</div>",
						        bad:"<div>bad:${m.badcnt}</div>",
						        latlng_c: new daum.maps.LatLng(${m.latitude}, ${m.longitude})
						    }
						    
						];
					 	
					 	var imageSrc_c = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";		   
						for (var i = 0; i < position_c.length; i ++) {
							var imageSize_c = new daum.maps.Size(24, 35);

							var markerImage_c = new daum.maps.MarkerImage(imageSrc_c, imageSize_c);
							// 마커를 생성합니다
						    var marker_c = new daum.maps.Marker({
						        map: map, // 마커를 표시할 지도
						        position: position_c[i].latlng_c, // 마커를 표시할 위치
						        title : position_c[i].title_c, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
						        image : markerImage_c // 마커 이미지 
						    });
						    
						 	// 마커에 표시할 인포윈도우를 생성합니다 
						    var infowindow_c = new daum.maps.InfoWindow({
						        content: position_c[i].content_c, // 인포윈도우에 표시할 내용
						    });
						    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
						    daum.maps.event.addListener(marker_c, 'mouseover', makeOverListener3(map, marker_c, infowindow_c));
						    daum.maps.event.addListener(marker_c, 'click', makeOutListener3(infowindow_c));
						}
					 
					 
				 });
			 </c:forEach>
			// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
				function makeOverListener3(map, marker_c, infowindow_c) {
				    return function() {
				    	infowindow_c.open(map, marker_c);
				    };
				}

				// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
				function makeOutListener3(infowindow_c) {
				    return function() {
				    	infowindow_c.close();
				    };
				}				
			
			//"click_board_${data.BIDX}" 게시글!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			<c:forEach var="b" items="${BLIST}" >
				 $("#click_board_${b.bidx}").click(function(){
					 <c:forEach var="m" items="${TLIST}" >
					 	<c:if test="${m.place_no==b.place_no }">
							var position_b = [
							    {
							        title_b: "${m.place_name}",
							        content_b: "<div style='width:270px;'>"+
							        "<div  class='title'>상가명: ${m.place_name}</div>"+
							        "<div>지번주소: ${m.juso}</div><div>도로주소: ${m.doro_juso}</div>"+
							        "<div>평균평점: ${m.avgpoint}</div>"+
							        "<div>good:${m.goodcnt} soso:${m.sosocnt} bad:${m.badcnt}</div>"+
							        "<input type='button' class='btn2' id='boardListBtn' name='boardListBtn' "+
							        " style='width:100px;background-color: rgba(174, 218, 232, 1);'  value='게시글 보기' "+
							        " onclick=\"location.href=\'../place/boardListProc.yo?place_name=${m.place_name}&juso=${m.juso}\'\"/>"+
							        "<input type='button' class='btn2' id='newBoardBtn'  name='newBoardBtn' "+
							        " style='width:100px;background-color: rgba(174, 218, 232, 1);'  value='새글쓰기' "+
							        " onclick=\"location.href=\'../place/writeFormProc.yo?place_name=${m.place_name}&juso=${m.juso}\'\"/>"+
							        "</div>",
							        juso: "<div>${m.juso}</div>",
							        good:"<div>good:${m.goodcnt}</div>",
							        soso:"<div>soso:${m.sosocnt}</div>",
							        bad:"<div>bad:${m.badcnt}</div>",
							        latlng_b: new daum.maps.LatLng(${m.latitude}, ${m.longitude})
							    }
							    
							];
					</c:if>
				</c:forEach>
						 	
						 	var imageSrc_b = "../resources/img/google2.png";		   
							for (var i = 0; i < position_b.length; i ++) {
								var imageSize_b = new daum.maps.Size(35, 35);
	
								var markerImage_b = new daum.maps.MarkerImage(imageSrc_b, imageSize_b);
								// 마커를 생성합니다
							    var marker_b = new daum.maps.Marker({
							        map: map, // 마커를 표시할 지도
							        position: position_b[i].latlng_b, // 마커를 표시할 위치
							        title : position_b[i].title_b, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
							        image : markerImage_b // 마커 이미지 
							    });
							    
							 	// 마커에 표시할 인포윈도우를 생성합니다 
							    var infowindow_b = new daum.maps.InfoWindow({
							        content: position_b[i].content_b, // 인포윈도우에 표시할 내용
							    });
							    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
							    daum.maps.event.addListener(marker_b, 'mouseover', makeOverListener4(map, marker_b, infowindow_b));
							    daum.maps.event.addListener(marker_b, 'click', makeOutListener4(infowindow_b));
							}

				 });
			 </c:forEach>
			// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
				function makeOverListener4(map, marker_b, infowindow_b) {
				    return function() {
				    	infowindow_b.open(map, marker_b);
				    };
				}

				// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
				function makeOutListener4(infowindow_b) {
				    return function() {
				    	infowindow_b.close();
				    };
				}
			//"click_board_${data.BIDX}" 게시글!!!!!!!!!!!!!!!!!!!!!!!!!!!!		
			
			//==============송 승환 클릭시  좌표 클릭!=================
			
		        
	    	});// 구 클릭 끝
	    	//-------함수로 만들자-----------------------------------------------------끝
	    	
		  //지도 위 표시되고 있는 폴리곤 제거
			function deletePolygon(polygons) {
			    for (var i = 0; i < polygons.length; i++) {
			        polygons[i].setMap(null);
			    }
			    polygons = [];
			}
		    
		} // display함수 끝
		
		
		
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new daum.maps.MapTypeControl();

		// 지도 타입 컨트롤을 지도에 표시합니다
		map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
		
		function getInfo() {
		    // 지도의 현재 중심좌표를 얻어옵니다 
		    var center = map.getCenter(); 
		    // 지도의 현재 레벨을 얻어옵니다
		    var level = map.getLevel();
		    // 지도타입을 얻어옵니다
		    var mapTypeId = map.getMapTypeId(); 
		    // 지도의 현재 영역을 얻어옵니다 
		    var bounds = map.getBounds();
		    // 영역의 남서쪽 좌표를 얻어옵니다 
		    var swLatLng = bounds.getSouthWest(); 
		    // 영역의 북동쪽 좌표를 얻어옵니다 
		    var neLatLng = bounds.getNorthEast(); 
		    // 영역정보를 문자열로 얻어옵니다. ((남,서), (북,동)) 형식입니다
		    var boundsStr = bounds.toString();
		    
		    var message = '지도 중심좌표는 위도 ' + center.getLat() + ', <br>';
		    message += '경도 ' + center.getLng() + ' 이고 <br>';
		    message += '지도 레벨은 ' + level + ' 입니다 <br> <br>';
		    message += '지도 타입은 ' + mapTypeId + ' 이고 <br> ';
		    message += '지도의 남서쪽 좌표는 ' + swLatLng.getLat() + ', ' + swLatLng.getLng() + ' 이고 <br>';
		    message += '북동쪽 좌표는 ' + neLatLng.getLat() + ', ' + neLatLng.getLng() + ' 입니다';
		    
		    // 개발자도구를 통해 직접 message 내용을 확인해 보세요.
		}
		
		// 서울시 전체보기를 클릭시 place/placeList.yo로 다시 요청
		$('#seoul').click(function(){			
			deleteCookie('gupath');
			deleteCookie('guname');
			deleteCookie('mouseLat');
			deleteCookie('mouseLng');
			console.log(getCookie('guname'));
			$(location).attr('href', '../place/placeList.yo')
		});
		


		
		
		// 쿠키를 set하는 과정
		function placeSetCookie(){
			deleteCookie('gupath');
			deleteCookie('guname');
			deleteCookie('mouseLat');
			deleteCookie('mouseLng');
			// 쿠키에다가 gupath랑 guname저장-----------------------        	
			setCookie('gupath', gupath, 5); /* gupath=gupath, 5일 뒤 만료됨 */
			setCookie('guname',guname, 5); 
			setCookie('mouseLat',mouseLat, 5); 
			setCookie('mouseLng',mouseLng, 5); 
	    	// 쿠키에다가 gupath랑 guname 마우스 위도경도 도 넘겼다 -----------------------
		}
		
		
		
		
		
		
		// *********************** 은비 스크립트 start *************************/
		//파라미터 정보 확인하기
		category_no="${DATA.category_no}";
		sigungu_name="${DATA.sigungu_name}";
		place_name="${DATA.place_name}";
		searchType="${searchType}";

		/**********************************기본세팅부분*************************************/
		//구이름,장소이름,카테고리 정보가 넘어온게 있다면 
		//그 값을 화면에 세팅해놓기
		if(category_no!=0){
			if(category_no!=10){
				$('input[name="category_no"]:eq('+category_no+')').attr('checked','checked')			
			}
			if(category_no==10){
				$('input[name="category_no"]:eq(0)').attr('checked','checked')
			}
		}	
		if(sigungu_name.length!=0){
			$("#sigungu_name").val(sigungu_name)
		}
		if(place_name.length!=0){
			$("#place_name").val(place_name)
		}
		
		//searchType 정보가  placeSearch인 경우
		//=>장소검색결과 보여주기,form에 hidden으로 placeSearch넣기
		if(searchType=="placeSearch"){
			$("#boardSearch").hide();
			$("#searchType").val("placeSearch");
			$("#placeSearchBtn").css("background-color","#AEDAE8");
			$("#boardSearchBtn").css("background-color","#ededed");
		}
		//searchType 정보가 boardSearch인 경우
		//=>게시물검색결과 보여주기,form에 hidden으로 boardSearch넣기
		if(searchType=="boardSearch"){
			$("#placeSearch").hide();
			$("#searchType").val("boardSearch");
			$("#boardSearchBtn").css("background-color","#AEDAE8");
			$("#placeSearchBtn").css("background-color","#ededed");
		}
		
		/**********************************이벤트적용부분*************************************/
		//카테고리에서 클릭이벤트 발생할 때
		$(".category_no").click(function(){
			placeSetCookie();
			$("#searchFrm_j").submit()
		})
		//검색버튼 클릭이벤트 발생했을 때
		$("#sBtn_j").click(function(){
			placeSetCookie();
			$("#searchFrm_j").submit()
		})
		
		//장소검색결과 버튼 클릭시
		$("#placeSearchBtn").click(function(){
			$("#placeSearchBtn").css("background-color","#AEDAE8")
			$("#boardSearchBtn").css("background-color","#ededed");
			$("#boardSearch").hide();
			$("#placeSearch").show();
			$("#searchType").val("placeSearch")
		})
		//게시물검색결과 버튼 클릭시
		$("#boardSearchBtn").click(function(){
			$("#boardSearchBtn").css("background-color","#AEDAE8")
			$("#placeSearchBtn").css("background-color","#ededed");
			$("#placeSearch").hide();
			$("#boardSearch").show();
			$("#searchType").val("boardSearch")
		})
		// *********************** 은비 스크립트 end *************************/
	}); // function 끝	
	</script>
	
</head>
<body>

	<div id="div_root">
		<div id="top_content">
		<form id="searchFrm_j" method="get" action="../place/placeList.yo">
		<input type="hidden" name="searchType" id="searchType">
			<table>
				<tr>
					<td><input type="text" id="sigungu_name" name="sigungu_name" placeholder="서울특별시" readonly/><div id="guname1"></div></td>
					<td><input type="text" id="place_name" name="place_name" placeholder="장소이름을 입력해주세요"></td>
					<td><input type="button" id="sBtn_j" name="sBtn_j" value="검색"></td>
					<td>
						<input type="radio" name="category_no" value=10 class="category_no"> 전체
						<input type="radio" name="category_no" value=1 class="category_no"> 관광/여가/오락
						<input type="radio" name="category_no" value=2 class="category_no"> 숙박
						<input type="radio" name="category_no" value=3 class="category_no"> 의료
						<input type="radio" name="category_no" value=4 class="category_no"> 한식/중식/양식
						<input type="radio" name="category_no" value=5 class="category_no"> 커피점/카페
						<input type="radio" name="category_no" value=6 class="category_no"> 기타
					</td>
				</tr>
			</table>
		</form>
		</div><!-- top_content닫음 -->
		
		<div id="left_content">
		
			<table border="1px" width="500px" height="70px">
				<tr>
					<td width="250px" id="placeSearchBtn" align="center" value="placeSearch">장소검색결과</td>
					<td width="250px" id="boardSearchBtn" align="center" value="boardSearch">게시글검색결과</td>
				</tr>
			</table>
		
			<div id="placeSearch" >
				<table border="1px" width="500px" height="30px">
					<tr>
						<td colspan="2" style="padding:10px;">검색결과(${placecnt_total}건)</td>
					</tr>
				</table>
				
				<div  class="placeResult_jo">
					<c:if test="${empty PLIST }">
					<table width="500px" height="600px">
						<tr align="center">
							<td>검색결과가 없습니다</td>
						</tr>
					</table>
					</c:if>
					<table width="500px" >
						<c:forEach var="data" items="${PLIST}" varStatus="status">
							<tr height="100px" class="hover" id="click_name_${data.place_no}">
								<td width="350px">
								${data.place_name}<br/>
								${data.juso}<br/>
								관련글:${data.reviewcnt}건
								</td>
								<td>
								good:${data.goodcnt}<br/>
								soso:${data.sosocnt}<br/>
								bad:${data.badcnt}
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				
				<table border="1px" width="500px" height="50px">	
					<tr>
						<td align="center">
				  		<%-- 완성예시 : [<][1][2][3][4][5][>] --%>
				  		<%-- 이전페이지 --%>
				  		<%-- 현재 보고있는 페이지가 첫번째 페이지라면 --%>
				  		<c:if test="${PINFO_P.nowPage eq 1}">
				  			이전
				  		</c:if>
				  		<c:if test="${PINFO_P.nowPage ne 1}">
				  			<a href="../place/placeList.yo?nowPage=${PINFO_P.nowPage-1}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}&searchType=placeSearch">이전</a>
				  		</c:if>
				  		
				  		<%-- [1][2][3][4][5] --%>
				  		<c:forEach var="page" begin="${PINFO_P.startPage }" end="${PINFO_P.endPage}">
				  			<c:if test="${PINFO_P.nowPage eq page }">
				  			<a href="../place/placeList.yo?nowPage=${page}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}&searchType=placeSearch"><font color="blue">[${page}]</font></a>
				  			</c:if>
				  			<c:if test="${PINFO_P.nowPage ne page }">
				  			<a href="../place/placeList.yo?nowPage=${page}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}&searchType=placeSearch">${page}</a>
				  			</c:if>
				  		</c:forEach>
				  		
				  		<%-- 다음페이지 --%>
				  		<%-- 현재 보고있는 페이지가 마지막 페이지까지 갔으면 --%>
				  		<c:if test="${PINFO_P.nowPage eq PINFO_P.totalPage}">
				  			다음
				  		</c:if>
				  		<c:if test="${PINFO_P.nowPage ne PINFO_P.totalPage}">
				  			<a href="../place/placeList.yo?nowPage=${PINFO_P.nowPage+1}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}&searchType=placeSearch">다음</a>
				  		</c:if>
				  		</td>
					</tr>
				</table>
			</div><!-- placeSearch닫음 -->
		
			<div id="boardSearch">
				<table border="1px" width="500px" height="30px">
					<tr>
						<td colspan="2" style="padding:10px;">검색결과(${reviewcnt_total}건)</td>
					</tr>
				</table>
				
				<div  class="boardResult_jo">
					<c:if test="${empty BLIST }">
					<table width="500px" height="600px">
						<tr align="center">
							<td>검색결과가 없습니다</td>
						</tr>
					</table>
					</c:if>
					<table width="500px" >
						<c:forEach var="data" items="${BLIST}">
							<tr height="100px" class="hover" id="click_board_${data.bidx}">
								<td width="350px">
								${data.subject}<br/>								
								${data.comm}<br/>
								${data.createdt}
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<table border="1px" width="500px" height="50px">	
					<tr>
						<td align="center">
				  		<%-- 완성예시 : [<][1][2][3][4][5][>] --%>
				  		<%-- 이전페이지 --%>
				  		<%-- 현재 보고있는 페이지가 첫번째 페이지라면 --%>
				  		<c:if test="${PINFO_B.nowPage eq 1}">
				  			이전
				  		</c:if>
				  		<c:if test="${PINFO_B.nowPage ne 1}">
				  			<a href="../place/placeList.yo?nowPage=${PINFO_B.nowPage-1}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}&searchType=boardSearch">이전</a>
				  		</c:if>
				  		
				  		<%-- [1][2][3][4][5] --%>
				  		<c:forEach var="page" begin="${PINFO_B.startPage }" end="${PINFO_B.endPage}">
				  			<c:if test="${PINFO_P.nowPage eq page }">
				  			<a href="../place/placeList.yo?nowPage=${page}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}&searchType=boardSearch"><font color="blue">[${page}]</font></a>
				  			</c:if>
				  			<c:if test="${PINFO_P.nowPage ne page }">
				  			<a href="../place/placeList.yo?nowPage=${page}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}&searchType=boardSearch">${page}</a>
				  			</c:if>
				  		</c:forEach>
				  		
				  		<%-- 다음페이지 --%>
				  		<%-- 현재 보고있는 페이지가 마지막 페이지까지 갔으면 --%>
				  		<c:if test="${PINFO_B.nowPage eq PINFO_B.totalPage}">
				  			다음
				  		</c:if>
				  		<c:if test="${PINFO_B.nowPage ne PINFO_B.totalPage}">
				  			<a href="../place/placeList.yo?nowPage=${PINFO_B.nowPage+1}&sigungu_name=${DATA.sigungu_name}&place_name=${DATA.place_name}&category_no=${DATA.category_no}&searchType=boardSearch">다음</a>
				  		</c:if>
				  		</td>
					</tr>
				</table>
					
			</div><!-- boardSearch닫음 -->
			
		</div><!-- left_content닫음 -->
		
		<div id="right_content">
			<table>
				<tr>
					<td>
						<div class="map_wrap">
						    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
						    <div class="hAddr">
						        <span class="title">지도중심기준 행정동 주소정보</span>
						        <span id="centerAddr"></span>
						    </div>
						</div>
					</td>
				</tr>
				<tr>
					<td align="center">
						<input type="button" id="seoul" value="서울시 전체지도보기"/>
					</td>
				</tr>
				<tr>
					<td >
						<div id="clickLatlng"></div>
					</td>
				</tr>
			</table>
		</div>
	</div>



	
</body>
</html>
