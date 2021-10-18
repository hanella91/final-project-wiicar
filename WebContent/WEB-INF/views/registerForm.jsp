<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head> 
    <!-- Required meta tags -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>WIICAR | registerForm</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz"
        crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
    <link href="/wiicar/resources/css/carpool_register.css" rel="stylesheet"type="text/css" />
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
	
	<script	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxcbda6a9d9b9241f699b4eacec5b60cf1"></script>
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script> <!-- 캘린더 다운로드 --> 
	<script type="text/javascript">
	const tickMark = "<svg width=\"20\" height=\"20\" viewBox=\"0 0 58 45\" xmlns=\"http://www.w3.org/2000/svg\"><path fill=\"#fff\" fill-rule=\"nonzero\" d=\"M19.11 44.64L.27 25.81l5.66-5.66 13.18 13.18L52.07.38l5.65 5.65\"/></svg>";
	
	$(document).ready(function(){
		let buttons = document.querySelectorAll('.button');
		let buttonsText = document.querySelectorAll('.tick');
		const inputTime = document.getElementById("exampleInputEmail1");
		
		document.getElementById("starting-point-searching-button").innerHTML = "검색";
		document.getElementById("btn_select2").innerHTML = "검색";
		
		$("#exampleInputEmail1, #fullAddr1, #fullAddr2").on("change", function(){
			var time = this.value;
			if(time != "") {
				$(this).next().before().css({
				    "transition-duration": "0.2s",
			    	"transform": "translate(0, -1.5em) scale(0.9, 0.9)"
				})
			}
		});
	});
	</script>	

	<script type="text/javascript">
		
	
	
		var startingPoint = {};
			var endingPoint = {};
			
			// 경로탐색 변수 시작
			var markerInfo;
			//출발지,도착지 마커
			var marker_s, marker_e, marker_p;
			//경로그림정보
			var drawInfoArr = [];
			var drawInfoArr2 = [];
		
			var chktraffic = [];
			var resultdrawArr = [];
			var resultMarkerArr = [];
			// 경로탐색 변수 끝
			
			var map, marker1;
			function initTmap() {
		
				// 1. 지도 띄우기
				map = new Tmapv2.Map("map_div", {
					center : new Tmapv2.LatLng(37.570028, 126.986072),
					width : "100%",
					height : "400px",
					zoom : 15,
					zoomControl : true,
					scrollwheel : true
		
				});
			
				
				// 마커 초기화
				marker1 = new Tmapv2.Marker(
					{
						icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_a.png",
						iconSize : new Tmapv2.Size(24, 38),
						map : map
					}); 
		
				$("#starting-point-searching-button").click(function() {
					let startingPointInputAddress = $("#fullAddr1").val();
					startingPoint = apiRequest(startingPointInputAddress);
					// 최종 출발지 주소
					var startingPointAddress;
					var startingPointLatitude;
					var startingPointLongitude;
					// 스타팅포인트에서 주소만 꺼내온다.
					// 꺼내온 주소를 임의의 변수에 담는다.
					startingPointAddress = startingPoint.address;
					startingPointLatitude = startingPoint.lat;
					startingPointLongitude = startingPoint.lon;
					
					$("#start-point-address").attr('value',startingPointAddress)
					// 검색된 출발지점의 위도와 경도의 데이터를 대입한다
					$("#starting-point-longitude").attr('value',startingPointLongitude)
					$("#starting-point-latitude").attr('value',startingPointLatitude)
					
					console.log("starting point");
					console.log(startingPoint);
					
					// 출발지 입력했을 때
					if($("#fullAddr1").val() == null) {
						alert("출발지를 입력하세요!");
					} else {
						
						if($("#start-point-address").val() != "") {
							if (this.innerHTML != "검색") {
							  	this.innerHTML = "검색";
								this.classList.toggle('button__circle');
							} else if (this.innerHTML == "검색") {
								this.innerHTML = tickMark;
								this.classList.toggle('button__circle');
							}
						}
					}
				});
				$("#btn_select2").click(function() {
					let endingPointInputAddress = $("#fullAddr2").val();
					endingPoint = apiRequest(endingPointInputAddress);
					var endingPointAddress; // 검색된 도착지 주소
					var endingPointLatitude;
					var endingPointLongitude;
					endingPointAddress = endingPoint.address;
					endingPointLatitude = endingPoint.lat;
					endingPointLongitude = endingPoint.lon;
					// 검색된 도착지 주소를 도착지 주소표에 대입시킨다.
					// 도착지 주소표 요소의 value 속성에 검색된 도착지 주소를 대입한다.
					$("#end-point-address").attr('value',endingPointAddress);
					$("#ending-point-longitude").attr('value',endingPointLongitude)
					$("#ending-point-latitude").attr('value',endingPointLatitude)
					
					console.log("ending point");
					console.log(endingPoint);
					
					// 도착지 입력했을 때
					if($("#fullAddr2").val() == null) {
						alert("도착지를 입력하세요!");
					} else {
						if($("#end-point-address").val() != "") {
							if (this.innerHTML != "검색") {
							  	this.innerHTML = "검색";
								this.classList.toggle('button__circle');
							} else if (this.innerHTML == "검색") {
								this.innerHTML = tickMark;
								this.classList.toggle('button__circle');
							}
						}
					}
				})	
				
				function apiRequest(fullAddr) {
					// 2. API 사용요청
					let point = {};
					
					$.ajax({
						method : "GET",
						url : "https://apis.openapi.sk.com/tmap/geo/fullAddrGeo?version=1&format=json&callback=result",
						async : false,
						data : {
							"appKey" : "l7xxcbda6a9d9b9241f699b4eacec5b60cf1",
							"coordType" : "WGS84GEO",
							"fullAddr" : fullAddr
						},
						success : function(response) {
							// 위경도 좌표 (중심점)
							var lon, lat;
							// 위경도좌표(입구점)
							var lonEntr, latEntr;
							var resultInfo = response.coordinateInfo; // .coordinate[0];
							console.log(resultInfo);
							
							// 기존 마커 삭제
							marker1.setMap(null);
							
							// 3.마커 찍기
							// 검색 결과 정보가 없을 때 처리
							if (resultInfo.coordinate.length == 0) {
								$("#result").text(
								"요청 데이터가 올바르지 않습니다.");
							} else {
								// 위경도 좌표 (중심점)
								var resultCoordinate = resultInfo.coordinate[0];
								if (resultCoordinate.lon.length > 0) {
									// 구주소
									lon = resultCoordinate.lon;
									lat = resultCoordinate.lat;
								} else { 
									// 신주소
									lon = resultCoordinate.newLon;
									lat = resultCoordinate.newLat
								}
								// 위경도좌표(입구점)
								
								if (resultCoordinate.lonEntr == undefined && resultCoordinate.newLonEntr == undefined) {
									lonEntr = 0;
									latEntr = 0;
								} else {
									if (resultCoordinate.lonEntr.length > 0) {
										lonEntr = resultCoordinate.lonEntr;
										latEntr = resultCoordinate.latEntr;
									} else {
										lonEntr = resultCoordinate.newLonEntr;
										latEntr = resultCoordinate.newLatEntr;
									}
								}
									
								var markerPosition = new Tmapv2.LatLng(Number(lat),Number(lon));
								
								// 마커 올리기
								marker1 = new Tmapv2.Marker(
									{
										position : markerPosition,
										//icon : "http://tmapapi.sktelecom.com/resources/images/common/pin_car.png",
										iconSize : new Tmapv2.Size(
										24, 38),
										map : map
									});
								map.setCenter(markerPosition);
								
								// 검색 결과 표출
								var matchFlag, newMatchFlag;
								// 검색 결과 주소를 담을 변수
								var address = '', newAddress = '';
								var city, gu_gun, eup_myun, legalDong, adminDong, ri, bunji;
								var buildingName, buildingDong, newRoadName, newBuildingIndex, newBuildingName, newBuildingDong;
								
								// 새주소일 때 검색 결과 표출
								// 새주소인 경우 matchFlag가 아닌
								// newMatchFlag가 응답값으로
								// 온다
								if (resultCoordinate.newMatchFlag.length > 0) {
									// 새(도로명) 주소 좌표 매칭
									// 구분 코드
									newMatchFlag = resultCoordinate.newMatchFlag;
									
									// 시/도 명칭
									if (resultCoordinate.city_do.length > 0) {
										city = resultCoordinate.city_do;
										newAddress += city + "\n";
									}
									
									// 군/구 명칭
									if (resultCoordinate.gu_gun.length > 0) {
										gu_gun = resultCoordinate.gu_gun;
										newAddress += gu_gun + "\n";
									}
									
									// 읍면동 명칭
									if (resultCoordinate.eup_myun.length > 0) {
										eup_myun = resultCoordinate.eup_myun;
										newAddress += eup_myun + "\n";
									} else {
										// 출력 좌표에 해당하는
										// 법정동 명칭
										if (resultCoordinate.legalDong.length > 0) {
											legalDong = resultCoordinate.legalDong;
											newAddress += legalDong + "\n";
										}
										// 출력 좌표에 해당하는
										// 행정동 명칭
										if (resultCoordinate.adminDong.length > 0) {
											adminDong = resultCoordinate.adminDong;
											newAddress += adminDong + "\n";
										}
									}
									// 출력 좌표에 해당하는 리 명칭
									if (resultCoordinate.ri.length > 0) {
										ri = resultCoordinate.ri;
										newAddress += ri + "\n";
									}
									// 출력 좌표에 해당하는 지번 명칭
									if (resultCoordinate.bunji.length > 0) {
										bunji = resultCoordinate.bunji;
										newAddress += bunji + "\n";
									}
									// 새(도로명)주소 매칭을 한
									// 경우, 길 이름을 반환
									if (resultCoordinate.newRoadName.length > 0) {
										newRoadName = resultCoordinate.newRoadName;
										newAddress += newRoadName + "\n";
									}
									// 새(도로명)주소 매칭을 한
									// 경우, 건물 번호를 반환
									if (resultCoordinate.newBuildingIndex.length > 0) {
										newBuildingIndex = resultCoordinate.newBuildingIndex;
										newAddress += newBuildingIndex + "\n";
									}
									// 새(도로명)주소 매칭을 한
									// 경우, 건물 이름를 반환
									if (resultCoordinate.newBuildingName.length > 0) {
										newBuildingName = resultCoordinate.newBuildingName;
										newAddress += newBuildingName + "\n";
									}
									// 새주소 건물을 매칭한 경우
									// 새주소 건물 동을 반환
									if (resultCoordinate.newBuildingDong.length > 0) {
										newBuildingDong = resultCoordinate.newBuildingDong;
										newAddress += newBuildingDong + "\n";
									}
									// 검색 결과 표출
									if (lonEntr > 0) {
										var docs = "<a style='color:orange' href='#webservice/docs/fullTextGeocoding'>Docs</a>"
										var text = newAddress;
										$("#result").html(text);
									} else {
										var docs = "<a style='color:orange' href='#webservice/docs/fullTextGeocoding'>Docs</a>"
										var text = newAddress;
										$("#result").html(text);
									}
								}
								
								// 구주소일 때 검색 결과 표출
								// 구주소인 경우 newMatchFlag가
								// 아닌 MatchFlag가 응닶값으로
								// 온다
								if (resultCoordinate.matchFlag.length > 0) {
									// 매칭 구분 코드
									matchFlag = resultCoordinate.matchFlag;
								
									// 시/도 명칭
									if (resultCoordinate.city_do.length > 0) {
										city = resultCoordinate.city_do;
										address += city + "\n";
									}
									// 군/구 명칭
									if (resultCoordinate.gu_gun.length > 0) {
										gu_gun = resultCoordinate.gu_gun;
										address += gu_gun+ "\n";
									}
									// 읍면동 명칭
									if (resultCoordinate.eup_myun.length > 0) {
										eup_myun = resultCoordinate.eup_myun;
										address += eup_myun + "\n";
									}
									// 출력 좌표에 해당하는 법정동
									// 명칭
									if (resultCoordinate.legalDong.length > 0) {
										legalDong = resultCoordinate.legalDong;
										address += legalDong + "\n";
									}
									// 출력 좌표에 해당하는 행정동
									// 명칭
									if (resultCoordinate.adminDong.length > 0) {
										adminDong = resultCoordinate.adminDong;
										address += adminDong + "\n";
									}
									// 출력 좌표에 해당하는 리 명칭
									if (resultCoordinate.ri.length > 0) {
										ri = resultCoordinate.ri;
										address += ri + "\n";
									}
									// 출력 좌표에 해당하는 지번 명칭
									if (resultCoordinate.bunji.length > 0) {
										bunji = resultCoordinate.bunji;
										address += bunji + "\n";
									}
									// 출력 좌표에 해당하는 건물 이름
									// 명칭
									if (resultCoordinate.buildingName.length > 0) {
										buildingName = resultCoordinate.buildingName;
										address += buildingName + "\n";
									}
									// 출력 좌표에 해당하는 건물 동을
									// 명칭
									if (resultCoordinate.buildingDong.length > 0) {
										buildingDong = resultCoordinate.buildingDong;
										address += buildingDong + "\n";
									}
									// 검색 결과 표출
									if (lonEntr > 0) {
										var docs = "<a style='color:orange' href='#webservice/docs/fullTextGeocoding'>Docs</a>";
										var text = address;
										$("#result").html(text);
									} else {
										var docs = "<a style='color:orange' href='#webservice/docs/fullTextGeocoding'>Docs</a>";
										var text = address;
										$("#result").html(text);
									}
								}
							}
							
							let resultAddress = '';
							if (address.length > 0) {
								resultAddress = address;
							}
							if (newAddress.length > 0) {
								resultAddress = newAddress;
							}
							// 검색된 지점의 좌표 및 주소
							point = {
									address: resultAddress,
									lat: latEntr,
									lon: lonEntr
							}
							
						},
						error : function(request, status, error) {
							alert("좌표 입력에 실패했습니다! 정확한 주소를 입력해주세요!");
							console.log(request);
							console.log("code:"+request.status + "\n message:" + request.responseText +"\n error:" + error);
							// 에러가 발생하면 맵을 초기화함
							// markerStartLayer.clearMarkers();
							// 마커초기화
							map.setCenter(new Tmapv2.LatLng(37.570028, 126.986072));
							$("#result").html("");
						
						}
					});
					console.log("좌표 검색 API 호출됨");
					console.log(point);
					return point;
				};
			}

		//마커 생성하기
		function addMarkers(infoObj) {
			var size = new Tmapv2.Size(24, 38);//아이콘 크기 설정합니다.
	
			if (infoObj.pointType == "P") { //포인트점일때는 아이콘 크기를 줄입니다.
				size = new Tmapv2.Size(8, 8);
			}
	
			marker_p = new Tmapv2.Marker({
				position : new Tmapv2.LatLng(infoObj.lat, infoObj.lng),
				icon : infoObj.markerImage,
				iconSize : size,
				map : map
			});
	
			resultMarkerArr.push(marker_p);
		}
			
			function addComma(num) {
				var regexp = /\B(?=(\d{3})+(?!\d))/g;
				return num.toString().replace(regexp, ',');
			}
		
			
		
			//라인그리기
			function drawLine(arrPoint, traffic) {
				var polyline_;
		
				if (chktraffic.length != 0) {
		
					// 교통정보 혼잡도를 체크
					// strokeColor는 교통 정보상황에 다라서 변화
					// traffic :  0-정보없음, 1-원활, 2-서행, 3-지체, 4-정체  (black, green, yellow, orange, red)
		
					var lineColor = "";
		
					if (traffic != "0") {
						if (traffic.length == 0) { //length가 0인것은 교통정보가 없으므로 검은색으로 표시
		
							lineColor = "#06050D";
							//라인그리기[S]
							polyline_ = new Tmapv2.Polyline({
								path : arrPoint,
								strokeColor : lineColor,
								strokeWeight : 6,
								map : map
							});
							resultdrawArr.push(polyline_);
							//라인그리기[E]
						} else { //교통정보가 있음
		
							if (traffic[0][0] != 0) { //교통정보 시작인덱스가 0이 아닌경우
								var trafficObject = "";
								var tInfo = [];
		
								for (var z = 0; z < traffic.length; z++) {
									trafficObject = {
										"startIndex" : traffic[z][0],
										"endIndex" : traffic[z][1],
										"trafficIndex" : traffic[z][2],
									};
									tInfo.push(trafficObject)
								}
		
								var noInfomationPoint = [];
		
								for (var p = 0; p < tInfo[0].startIndex; p++) {
									noInfomationPoint.push(arrPoint[p]);
								}
		
								//라인그리기[S]
								polyline_ = new Tmapv2.Polyline({
									path : noInfomationPoint,
									strokeColor : "#06050D",
									strokeWeight : 6,
									map : map
								});
								//라인그리기[E]
								resultdrawArr.push(polyline_);
		
								for (var x = 0; x < tInfo.length; x++) {
									var sectionPoint = []; //구간선언
		
									for (var y = tInfo[x].startIndex; y <= tInfo[x].endIndex; y++) {
										sectionPoint.push(arrPoint[y]);
									}
		
									if (tInfo[x].trafficIndex == 0) {
										lineColor = "#00008B";
									} else if (tInfo[x].trafficIndex == 1) {
										lineColor = "#32CD32";
									} else if (tInfo[x].trafficIndex == 2) {
										lineColor = "#FFFF00";
									} else if (tInfo[x].trafficIndex == 3) {
										lineColor = "#FFA500";
									} else if (tInfo[x].trafficIndex == 4) {
										lineColor = "#D61125";
									}
		
									//라인그리기[S]
									polyline_ = new Tmapv2.Polyline({
										path : sectionPoint,
										strokeColor : lineColor,
										strokeWeight : 6,
										map : map
									});
									//라인그리기[E]
									resultdrawArr.push(polyline_);
								}
							} else { //0부터 시작하는 경우
		
								var trafficObject = "";
								var tInfo = [];
		
								for (var z = 0; z < traffic.length; z++) {
									trafficObject = {
										"startIndex" : traffic[z][0],
										"endIndex" : traffic[z][1],
										"trafficIndex" : traffic[z][2],
									};
									tInfo.push(trafficObject)
								}
		
								for (var x = 0; x < tInfo.length; x++) {
									var sectionPoint = []; //구간선언
		
									for (var y = tInfo[x].startIndex; y <= tInfo[x].endIndex; y++) {
										sectionPoint.push(arrPoint[y]);
									}
		
									if (tInfo[x].trafficIndex == 0) {
										lineColor = "#00008B";
									} else if (tInfo[x].trafficIndex == 1) {
										lineColor = "#32CD32";
									} else if (tInfo[x].trafficIndex == 2) {
										lineColor = "#FFFF00";
									} else if (tInfo[x].trafficIndex == 3) {
										lineColor = "#FFA500";
									} else if (tInfo[x].trafficIndex == 4) {
										lineColor = "#D61125";
									}
		
									//라인그리기[S]
									polyline_ = new Tmapv2.Polyline({
										path : sectionPoint,
										strokeColor : lineColor,
										strokeWeight : 6,
										map : map
									});
									//라인그리기[E]
									resultdrawArr.push(polyline_);
								}
							}
						}
					} else {
		
					}
				} else {
					polyline_ = new Tmapv2.Polyline({
						path : arrPoint,
						strokeColor : "#DD0000",
						strokeWeight : 6,
						map : map
					});
					resultdrawArr.push(polyline_);
				}
		
			}
			
			//초기화 기능
			function resettingMap() {
				//기존마커는 삭제
				marker_s.setMap(null);
				marker_e.setMap(null);
		
				if (resultMarkerArr.length > 0) {
					for (var i = 0; i < resultMarkerArr.length; i++) {
						resultMarkerArr[i].setMap(null);
					}
				}
		
				if (resultdrawArr.length > 0) {
					for (var i = 0; i < resultdrawArr.length; i++) {
						resultdrawArr[i].setMap(null);
					}
				}
		
				chktraffic = [];
				drawInfoArr = [];
				resultMarkerArr = [];
				resultdrawArr = [];
			}
		// 경로탐색 함수들 끝
		//캘린더함수
		$(document).ready(function(){
		flatpickr("input[name=time]", {
		       enableTime: true,
		       minDate: "today",
		       dateFormat: "Y-m-d H:i"
		    });

		// 금액설정 디폴트 안보여주기
		$('#showprice').hide();
		$("#fullAddr1").click(function(){
			var time = $("input[name=time]").val();
			var hour = time.substring(11,16);
			console.log("time === > "+ time);
			console.log("hour === > "+ hour);
			if(hour>='07:00' && hour<='08:59' || hour>='18:00' && hour<='19:59'){
				$('#showprice').show();
			}else{
				$('#showprice').hide();
			}
		});// fullAddr1
		
		
		}); // document
		</script>
</head>

<body onload="initTmap();">
<div id="container">
<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
<div id="content">
<form action="/wiicar/carpool/registerPro.do" method="post" name="inputCarpool" >
	<div class="wrap">
        <h3>카풀 등록</h3>
        <div class="input-field date">
			<input name="time" type="text" class="form-control " id="exampleInputEmail1" required="" >
      		<label for="exampleInputEmail1" alt='Date & Time' placeholder='Date & Time'></label>
      	</div>
		<!-- 출발지 검색 -->
		<div class="input-field start">
			<input type="text" class="form-control" id="fullAddr1" required="">
			<label for="fullAddr1" alt='출발지' placeholder='출발지'></label>
			<div class="button" id="starting-point-searching-button" >
				<div class="container">
					<div class="tick"></div>
				</div>
			</div>
		</div>		
			
		<!-- 도착지 검색 -->		
		<div class="input-field end">
			<input type="text" class="form-control" id="fullAddr2" required="">
			<label for="fullAddr2" alt='도착지' placeholder='도착지'></label>
			<div class="button" id="btn_select2" >
				<div class="container">
					<div class="tick"></div>
				</div>
			</div>
		</div>		
		<!-- 탑승가능인원 -->
			<div class="form-group">
			    <div class="select-box passenger-select">
		   		  <div class="passenger">탑승 가능 인원</div>
				  <div class="select-box__current" tabindex="1">
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="0" value="1" name="maxPassenger" checked="checked"/>
				      <p class="select-box__input-text">1</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="1" value="2" name="maxPassenger"/>
				      <p class="select-box__input-text">2</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="2" value="3" name="maxPassenger"/>
				      <p class="select-box__input-text">3</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="3" value="4" name="maxPassenger"/>
				      <p class="select-box__input-text">4</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="4" value="5" name="maxPassenger"/>
				      <p class="select-box__input-text">5</p>
				    </div>
   				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="5" value="6" name="maxPassenger"/>
				      <p class="select-box__input-text">6</p>
				    </div>
   				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="6" value="7" name="maxPassenger"/>
				      <p class="select-box__input-text">7</p>
				    </div>
   				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="7" value="8" name="maxPassenger"/>
				      <p class="select-box__input-text">8</p>
				    </div>
				    <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
				  </div>
				  <ul class="select-box__list">
				    <li>
				      <label class="select-box__option" for="0" aria-hidden="aria-hidden">1</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="1" aria-hidden="aria-hidden">2</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="2" aria-hidden="aria-hidden">3</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="3" aria-hidden="aria-hidden">4</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="4" aria-hidden="aria-hidden">5</label>
				    </li>
   				    <li>
				      <label class="select-box__option" for="5" aria-hidden="aria-hidden">6</label>
				    </li>
   				    <li>
				      <label class="select-box__option" for="6" aria-hidden="aria-hidden">7</label>
				    </li>
   				    <li>
				      <label class="select-box__option" for="7" aria-hidden="aria-hidden">8</label>
				    </li>
				  </ul>
				</div>
		<!-- 태그 -->  
		<div class="tags_container">
		  <ul class="ks-cboxtags">
		    <li><input type="checkbox" name="tags" id="checkboxOne" value="금연"><label for="checkboxOne">금연</label></li>
		    <li><input type="checkbox" name="tags" id="checkboxTwo" value="여성전용"><label for="checkboxTwo">여성전용</label></li>
		    <li><input type="checkbox" name="tags" id="checkboxThree" value="뒷자리탑승"><label for="checkboxThree">뒷자리탑승</label></li>
		    <li><input type="checkbox" name="tags" id="checkboxFour" value="반려동물 동반"><label for="checkboxFour">반려동물 동반</label></li>
		    <li><input type="checkbox" name="tags" id="checkboxFive" value="짐 수용 가능"><label for="checkboxFive">짐 수용 가능</label></li>
		    <li><input type="checkbox" name="tags" id="checkboxSix" value="마스크 착용"><label for="checkboxSix">마스크착용</label></li>
		  </ul>
		</div>
        <hr class="my-4">
		
		<br />
		<div class="route-input">
		  <div class="input-group-prepend">
		    <span class="input-group-text" id="basic-addon1">출발지</span>
		  </div>
		  <input type="text" class="form-control" id="start-point-address" name="depart" readonly>
		  <input type="hidden" id="starting-point-latitude" name="depart_lat">
		  <input type="hidden" id="starting-point-longitude" name="depart_lon">
		</div>
		<div class="route-input">
		  <div class="input-group-prepend">
		    <span class="input-group-text" id="basic-addon1">도착지</span>
		  </div>
		  <input type="text" class="form-control" id="end-point-address" name="destination" readonly>
		  <input type="hidden" id="ending-point-latitude" name="destination_lat">
		  <input type="hidden" id="ending-point-longitude" " name="destination_lon">
		</div>
        
		<!-- 지도 -->		
        <div class="ft_area">
		  <div class="ft_select_wrap">
		    <div class="select-box ft_select">			    
			  <div class="select-box__current" tabindex="1">
			    <div class="select-box__value">
			      <input class="select-box__input" type="radio" id="selectLevel0" value="0" name="selectLevel" checked="checked"/>
			      <p class="select-box__input-text">교통최적+추천</p>
			    </div>
			    <div class="select-box__value">
			      <input class="select-box__input" type="radio" id="selectLevel1" value="1" name="selectLevel"/>
			      <p class="select-box__input-text">교통최적+무료우선</p>
			    </div>
			    <div class="select-box__value">
			      <input class="select-box__input" type="radio" id="selectLevel2" value="2" name="selectLevel"/>
			      <p class="select-box__input-text">교통최적+최소시간</p>
			    </div>
			    <div class="select-box__value">
			      <input class="select-box__input" type="radio" id="selectLevel3" value="3" name="selectLevel"/>
			      <p class="select-box__input-text">교통최적+초보</p>
			    </div>
			    <div class="select-box__value">
			      <input class="select-box__input" type="radio" id="selectLevel4" value="4" name="selectLevel"/>
			      <p class="select-box__input-text">교통최적+고속도로우선</p>
			    </div>
  				    <div class="select-box__value">
			      <input class="select-box__input" type="radio" id="selectLevel5" value="10" name="selectLevel"/>
			      <p class="select-box__input-text">최단거리+유/무료</p>
			    </div>
  				    <div class="select-box__value">
			      <input class="select-box__input" type="radio" id="selectLevel6" value="12" name="selectLevel"/>
			      <p class="select-box__input-text">이륜차도로우선</p>
			    </div>
  				    <div class="select-box__value">
			      <input class="select-box__input" type="radio" id="selectLevel7" value="19" name="selectLevel"/>
			      <p class="select-box__input-text">교통최적+어린이보호구역 회피</p>
			    </div>
			    <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
			  </div>
			  <ul class="select-box__list">
			    <li>
			      <label class="select-box__option" for="selectLevel0" aria-hidden="aria-hidden">교통최적+추천</label>
			    </li>
			    <li>
			      <label class="select-box__option" for="selectLevel1" aria-hidden="aria-hidden">교통최적+무료우선</label>
			    </li>
			    <li>
			      <label class="select-box__option" for="selectLevel2" aria-hidden="aria-hidden">교통최적+최소시간</label>
			    </li>
			    <li>
			      <label class="select-box__option" for="selectLevel3" aria-hidden="aria-hidden">교통최적+초보</label>
			    </li>
			    <li>
			      <label class="select-box__option" for="selectLevel4" aria-hidden="aria-hidden">교통최적+고속도로우선</label>
			    </li>
  				    <li>
			      <label class="select-box__option" for="selectLevel5" aria-hidden="aria-hidden">최단거리+유/무료</label>
			    </li>
  				    <li>
			      <label class="select-box__option" for="selectLevel6" aria-hidden="aria-hidden">이륜차도로우선</label>
			    </li>
  				    <li>
			      <label class="select-box__option" for="selectLevel7" aria-hidden="aria-hidden">교통최적+어린이보호구역 회피</label>
			    </li>
			  </ul>
			  <div class="traffic_options">
			  	<h4>교통정보 표출 옵션</h4>
				<div class="inputGroup">
				  <input id="radio1" name="year" type="radio" value="Y"/>
				  <label for="radio1">Yes</label>
				</div>
				<div class="inputGroup">
				  <input id="radio2" name="year" type="radio" value="N"/>
				  <label for="radio2">No</label>
				</div>
			  </div>
				<button type="button" id="searching-route">경로탐색</button>
					<script>
					// 경로탐색 함수들 시작
					$("#searching-route")
						.click(
								function() {
									marker_s = new Tmapv2.Marker(
											{
												position : new Tmapv2.LatLng(startingPointLatitude,
														startingPointLongitude),
												icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png",
												iconSize : new Tmapv2.Size(24, 38),
												map : map
											});
							
									//도착
									marker_e = new Tmapv2.Marker(
											{
												position : new Tmapv2.LatLng(endingPointLatitude,
														endingPointLongitude),
												icon : "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png",
												iconSize : new Tmapv2.Size(24, 38),
												map : map
											});
									
									console.log("test");
									// 출발지점 및 도착지점의 위도와 경도 정보를 요소들로부터 가져온다.
									var startingPointLatitude = document.querySelector("#starting-point-latitude").value; // StartY
									var startingPointLongitude = document.querySelector("#starting-point-longitude").value; // StartX
									var endingPointLatitude = document.querySelector("#ending-point-latitude").value; // EndY
									var endingPointLongitude = document.querySelector("#ending-point-longitude").value; // EndX
									
									//기존 맵에 있던 정보들 초기화
									resettingMap();
									var searchOption = $("#selectLevel").val();
									var trafficInfochk = $("input:radio[name='year']:checked").val();
									//JSON TYPE EDIT [S]
									$.ajax({
												type : "POST",
												url : "https://apis.openapi.sk.com/tmap/routes?version=1&format=json&callback=result",
												async : false,
												data : {
													"appKey" : "l7xxcbda6a9d9b9241f699b4eacec5b60cf1",
													"startX" : startingPointLongitude,
													"startY" : startingPointLatitude,
													"endX" : endingPointLongitude,
													"endY" : endingPointLatitude,
													"reqCoordType" : "WGS84GEO",
													"resCoordType" : "EPSG3857",
													"searchOption" : searchOption,
													"trafficInfo" : trafficInfochk
												},
												success : function(response) {
													var resultData = response.features;
													var tDistance =
															(resultData[0].properties.totalDistance / 1000)
																	.toFixed(1);
													var tTime =
															(resultData[0].properties.totalTime / 60)
																	.toFixed(0);
													var tFare = 
															(resultData[0].properties.totalDistance / 1000)
															.toFixed(1)*150//resultData[0].properties.totalFare
															;
													/* var taxiFare = " 예상 택시 요금 : "
															+ resultData[0].properties.taxiFare
															+ "원"; */
													$("#result").text(
															tDistance + "\n" +
															tTime + "\n"+
															tFare 
																	);
													$("#total-distance").attr('value',tDistance)
													$("#expect-time").attr('value',tTime)
													$("#expect-gasprice").attr('value',tFare)
													
													//교통정보 표출 옵션값을 체크
													if (trafficInfochk == "Y") {
														for ( var i in resultData) { //for문 [S]
															var geometry = resultData[i].geometry;
															var properties = resultData[i].properties;
															if (geometry.type == "LineString") {
																//교통 정보도 담음
																chktraffic
																		.push(geometry.traffic);
																var sectionInfos = [];
																var trafficArr = geometry.traffic;
																for ( var j in geometry.coordinates) {
																	// 경로들의 결과값들을 포인트 객체로 변환 
																	var latlng = new Tmapv2.Point(
																			geometry.coordinates[j][0],
																			geometry.coordinates[j][1]);
																	// 포인트 객체를 받아 좌표값으로 변환
																	var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
																			latlng);
																	sectionInfos
																			.push(convertPoint);
																}
																drawLine(sectionInfos,
																		trafficArr);
															} else {
																var markerImg = "";
																var pType = "";
																if (properties.pointType == "S") { //출발지 마커
																	markerImg = "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png";
																	pType = "S";
																} else if (properties.pointType == "E") { //도착지 마커
																	markerImg = "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png";
																	pType = "E";
																} else { //각 포인트 마커
																	markerImg = "http://topopen.tmap.co.kr/imgs/point.png";
																	pType = "P"
																}
																// 경로들의 결과값들을 포인트 객체로 변환 
																var latlon = new Tmapv2.Point(
																		geometry.coordinates[0],
																		geometry.coordinates[1]);
																// 포인트 객체를 받아 좌표값으로 다시 변환
																var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
																		latlon);
																var routeInfoObj = {
																	markerImage : markerImg,
																	lng : convertPoint._lng,
																	lat : convertPoint._lat,
																	pointType : pType
																};
																// 마커 추가
																addMarkers(routeInfoObj);
															}
														}//for문 [E]
													} else {
														for ( var i in resultData) { //for문 [S]
															var geometry = resultData[i].geometry;
															var properties = resultData[i].properties;
															if (geometry.type == "LineString") {
																for ( var j in geometry.coordinates) {
																	// 경로들의 결과값들을 포인트 객체로 변환 
																	var latlng = new Tmapv2.Point(
																			geometry.coordinates[j][0],
																			geometry.coordinates[j][1]);
																	// 포인트 객체를 받아 좌표값으로 변환
																	var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
																			latlng);
																	// 포인트객체의 정보로 좌표값 변환 객체로 저장
																	var convertChange = new Tmapv2.LatLng(
																			convertPoint._lat,
																			convertPoint._lng);
																	// 배열에 담기
																	drawInfoArr
																			.push(convertChange);
																}
																drawLine(drawInfoArr,
																		"0");
															} else {
																var markerImg = "";
																var pType = "";
																if (properties.pointType == "S") { //출발지 마커
																	markerImg = "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_s.png";
																	pType = "S";
																} else if (properties.pointType == "E") { //도착지 마커
																	markerImg = "http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_e.png";
																	pType = "E";
																} else { //각 포인트 마커
																	markerImg = "http://topopen.tmap.co.kr/imgs/point.png";
																	pType = "P"
																}
																// 경로들의 결과값들을 포인트 객체로 변환 
																var latlon = new Tmapv2.Point(
																		geometry.coordinates[0],
																		geometry.coordinates[1]);
																// 포인트 객체를 받아 좌표값으로 다시 변환
																var convertPoint = new Tmapv2.Projection.convertEPSG3857ToWGS84GEO(
																		latlon);
																var routeInfoObj = {
																	markerImage : markerImg,
																	lng : convertPoint._lng,
																	lat : convertPoint._lat,
																	pointType : pType
																};
																// Marker 추가
																addMarkers(routeInfoObj);
															}
														}//for문 [E]
													}
												},
												error : function(request, status, error) {
													console.log("code:"
															+ request.status + "\n"
															+ "message:"
															+ request.responseText
															+ "\n" + "error:" + error);
												}
											});
									//JSON TYPE EDIT [E]
								});
					</script>
				</div>
			</div>
			<br/>
			<div class="map_act_btn_wrap clear_box"></div>
			<div class="clear"></div>
		</div>
	
		<div id="map_wrap" class="map_wrap" align="center">
			<div id="map_div" align="center"></div>
		</div>
		<div class="map_act_btn_wrap clear_box" align="center"></div>
		</br>
		<!-- 지도 밑에 총거리 예상시간 예상주유비 나타내주는 결과값 -->
		<!-- <h5><p id="result" align="center"></p></h5> -->
		
		<div id="total-result" align="right">
			<div>
				<h5>총 거리</h5>
				<input type="text" id="total-distance" name="distance" readonly>
				<label for="total-distance">/km</label>
			</div>
			<div>
				<h5>예상 시간</h5>
				<input type="text" id="expect-time" name="distance" readonly>
				<label for="expect-time">/분</label>
			</div>
			<div>
				<h5>예상 주유비</h5>
				<input type="text" id="expect-gasprice" name="distance" readonly>
				<label for="expect-gasprice">/원</label>
			</div>
			<div id="showprice">
				<h5>인당 금액</h5>
				<input type="text" id="price" name="price">
				<label for="price">/원</label>
			</div>
		</div>
		<!-- 등록 버튼 -->
        <p class="lead" align="center">
            <input type="submit" value="등록" class="register-btn" align="center"></button>
        </p>
	</div>
	</div>
</form>
</div>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</div>
</body>
</html>