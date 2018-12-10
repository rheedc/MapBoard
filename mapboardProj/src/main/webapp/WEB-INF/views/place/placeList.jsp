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
	    border: 1px solid #888;
	    border-radius: 3px;
	    font-size: 12px;
	    top: -5px;
	    left: 15px;
	    padding:2px;
		}
		
		.info {font-size: 12px; padding: 5px;}
		.info .title {font-weight: bold;}
		
		 .map_wrap {position:relative;width:1000px;height:800px;}
	    .title {font-weight:bold;display:block;}
	    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
	    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
	    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
		
	</style>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d122d716888da016ee859c0430722a86&libraries=services,clusterer,drawing"></script>
	<script>
	
	
	
	//행정구역 구분
	
	$(function(){		
		
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
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 9 // 지도의 확대 레벨
	    };

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new daum.maps.Map(mapContainer, mapOption),
	    customOverlay = new daum.maps.CustomOverlay({}),
	    infowindow = new daum.maps.InfoWindow({removable: true});
	
		$.getJSON("/resources/json/abcd.json", function(json) {
		 
		    var data = json.features;
		    var coordinates = [];    //좌표 저장할 배열
		    var name = '';            //행정 구 이름
		 
		 
		    $.each(data, function(index, val) {
		 
		        coordinates = val.geometry.coordinates;
		        name = val.properties.SIG_KOR_NM;
		        //console.log(coordinates)
		       	//console.log(name)
		        //displayArea(coordinates, name);
		        console.log(index)
		        displayArea(coordinates, name);
		    })
		})
		 
		 
		var polygons=[];                //function 안 쪽에 지역변수로 넣으니깐 폴리곤 하나 생성할 때마다 배열이 비어서 클릭했을 때 전체를 못 없애줌.  그래서 전역변수로 만듦.
		    
		//행정구역 폴리곤
		function displayArea(coordinates, name) {
		 
		    var path = [];            //폴리곤 그려줄 path
		    var points = [];        //중심좌표 구하기 위한 지역구 좌표들
		    
		    $.each(coordinates[0], function(index, coordinate) {        //console.log(coordinates)를 확인해보면 보면 [0]번째에 배열이 주로 저장이 됨.  그래서 [0]번째 배열에서 꺼내줌.

		        var point = new Object();
		        
		        point.x = coordinate[1];
		        point.y = coordinate[0];
		        points.push(point);
		        path.push(new daum.maps.LatLng(coordinate[1], coordinate[0]));            //new daum.maps.LatLng가 없으면 인식을 못해서 path 배열에 추가
		    })
		    
		    // 다각형을 생성합니다 
		     var polygon = new daum.maps.Polygon({
		        map : map, // 다각형을 표시할 지도 객체
		        path : path,
		        strokeWeight : 2,
		        strokeColor : '#004c80',
		        strokeOpacity : 0.8,
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
		 
		    daum.maps.event.addListener(polygon, 'click', function() {		       		    
		    	
		    	// 클릭한 곳에 클릭한 좌표를 전역변수 clickpath를 담는다.	
		    	//console.log(path)
		    	
		    	// 개발자 모드에서 지도 정보에 대해 console로 출력했다
		    	 getInfo();
		    	
		        // 현재 지도 레벨에서 2레벨 확대한 레벨
		        var level = map.getLevel()-3;
		        
		        // 지도를 클릭된 폴리곤의 중앙 위치를 기준으로 확대합니다
		        map.setLevel(level, {anchor: centroid(points), animate: {
		            duration: 350            //확대 애니메이션 시간
		        }});            
		        
		        deletePolygon(polygons);                    //폴리곤 제거 
		        customOverlay.setContent('<div class="area"></div>');
		     
		     // 폴리건 클릭한 곳에서 생성
		        var polygon = new daum.maps.Polygon({
			        map : map, // 다각형을 표시할 지도 객체
			        path : path,
			        strokeWeight : 4,
			        strokeColor : 'red',
			        strokeOpacity : 0.8,
			        fillColor : 'white',
			        fillOpacity : 0.3
			    });
		     
		     
		     // ----------------------------------------------------
		     // 주소-좌표 변환 객체를 생성합니다
			var geocoder = new daum.maps.services.Geocoder();
			
			var marker = new daum.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
			    infowindow = new daum.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
			
			// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			
			// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
			daum.maps.event.addListener(map, 'click', function(mouseEvent) {
			    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
			        if (status === daum.maps.services.Status.OK) {
			            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
			            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
			            
			            var content = '<div class="bAddr">' +
			                            '<span class="title">법정동 주소정보</span>' + 
			                            detailAddr + 
			                        '</div>';
			
			            // 마커를 클릭한 위치에 표시합니다 
			            marker.setPosition(mouseEvent.latLng);
			            marker.setMap(map);
			
			            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
			            infowindow.setContent(content);
			            infowindow.open(map, marker);
			        }   
			    });
			});
			

			// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
			daum.maps.event.addListener(map, 'idle', function() {
			    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
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
		      
		     
			// 마커를 표시할 위치와 title 객체 배열입니다 
			var positions = [
				<c:forEach var="m" items="${PLACELIST}" varStatus="status">
			    {
			        title: "${m.place_name}",
			        latlng: new daum.maps.LatLng(${m.latitude}, ${m.longitude})
			    }
			    <c:if test="${status.count < fn:length(PLACELIST)}">,</c:if>
			    </c:forEach>
			];
		     
			// 마커 이미지의 이미지 주소입니다
			var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
			    
			for (var i = 0; i < positions.length; i ++) {
			    
			    // 마커 이미지의 이미지 크기 입니다
			    var imageSize = new daum.maps.Size(10, 17); 
			    
			    // 마커 이미지를 생성합니다    
			    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize); 
			    
			    // 마커를 생성합니다
			    var marker5 = new daum.maps.Marker({
			        map: map, // 마커를 표시할 지도
			        position: positions[i].latlng, // 마커를 표시할 위치
			        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			        image : markerImage // 마커 이미지 
			    });
			}
		    
		     
		        
	    	});// 구 클릭 끝
		    
		  //지도 위 표시되고 있는 폴리곤 제거
			function deletePolygon(polygons) {
			    for (var i = 0; i < polygons.length; i++) {
			        polygons[i].setMap(null);
			    }
			    polygons = [];
			}
		    
		}
		
		$('#seoul').click(function(){
			$(location).attr('href', '../place/placeList.yo')
		});
		
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
		    console.log(message);
		}
		
		
		
		
		
		
	});	
	
	</script>
</head>
<body>
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
</body>
</html>
