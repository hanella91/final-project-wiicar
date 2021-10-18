<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WIICAR - 너도나도우리모두카풀!</title>
<link href="/wiicar/resources/css/chat.css" rel="stylesheet"
	type="text/css" />
<link href="/wiicar/resources/css/reset.css" rel="stylesheet"
	type="text/css" />
<link href="/wiicar/resources/css/main.css" rel="stylesheet"
	type="text/css" />
<style>
body {font-family: Arial, Helvetica, sans-serif;}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  animation: animatetop 0.4s;
  position: relative;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
</style>

<title>Insert title here</title>
</head>
<script src="https://cdn.jsdelivr.net/npm/geolib@3.3.1/lib/index.min.js"></script>
<!-- geolib 라이브러리설치 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<!-- 캘린더 css -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<!-- 캘린더 다운로드 -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		console.log($("#filters input[type=checkbox]"));
		// Each time any of checkbox is checked,
		// my function will have the value of whcih is checked?
		$("#filters input[type=checkbox]").click(function(){
			const checkedValue={};
			$("#filters input:checked").each(function() {
				checkedValue[$(this).attr("name")] = $(this).attr("value")
			});
			
			myFunction(checkedValue);
		})
			
		// 이 펑션은 체크가 안되어있는것들에 대해서 하나하나 다 ajax콜을 해줄것이다.
		
		var myFunction = function (checkedValue) {
			var unCheckedCheckBoxes = $("#filters input:not(:checked)") // = Array (체크안되어있는것들의 리스트)
				unCheckedCheckBoxes.each(function(){ //item = uncheckedCheckBoxes[i]
				//array.forEach => one time the fucntion for each element for the array			
				// 먼저 메인검색하고 => 필터로 넘어온다
				// 내 필터는 각 주제마다 count 보여줌.
				
						
				console.log($(this))
				const inputName = $(this).attr("name");
				console.log(inputName)
				let data = { 
					[inputName] : $(this).attr("value")
				} //data
				if (checkedValue) {
					data = {
							...data, 
							...checkedValue
					} 
				}
				
				$("#searchForm input[type=hidden]").each(function(){
					const name = $(this).attr("name");
					const value = $(this).attr("value");
					
					data[name] = value;
				})
				
				data.time = $("#searchForm input[name=time]").attr("value");
				
				console.log(data);
				
				$.ajax({
					method : "POST",
					url : "count.do",
					async : false,
					data,
					success : function(response){
						$(`#count_\${inputName}`).html(response.count);
					}
				})
				
			})
		}

		myFunction(); //페이지 로드 될 때 바로 실행됨 / 첫 숫자들 다 보여줄거임
		

		// Get the modal
		var modal = document.getElementById("myModal");

		// Get the button that opens the modal
		var btn = document.getElementById("myBtn");

		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];

		// When the user clicks the button, open the modal 
		btn.onclick = function() {
		  modal.style.display = "block";
		}

		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
		  modal.style.display = "none";
		}

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
		  if (event.target == modal) {
		    modal.style.display = "none";
		  }
		}
		
		
		
		//캘린더 오픈소스
		flatpickr("input[name=time]", {
		enableTime : false,
		dateFormat : "Y-m-d",
	});

	//검색 결과 ajax로 보내서 위도/경도 구해오는 함수
		$("#searchFormSubmit").click(function(event) {
			event.preventDefault();
			//input결과 티맵API로 보내기
			$.ajax({
				method : "GET",
				url : "https://apis.openapi.sk.com/tmap/geo/fullAddrGeo?version=1&format=json&callback=result",
				async : false,
				data : {	
						"appKey" : "l7xxcbda6a9d9b9241f699b4eacec5b60cf1",
						"coordType" : "WGS84GEO",
						"fullAddr" : $("input[name=depart]").val()
				},
				//전송 성공하면 받아올 데이터 : 위도, 경도 -> 검색물안넣었을 땐 아무것도 안돌려줌
				success : function(response) {
					const lat = response.coordinateInfo.coordinate[0].lat.length ? response.coordinateInfo.coordinate[0].lat : response.coordinateInfo.coordinate[0].newLat;
					const lon = response.coordinateInfo.coordinate[0].lon.length ? response.coordinateInfo.coordinate[0].lon : response.coordinateInfo.coordinate[0].newLon;
					//지정된 지구표면 경계선에 있는 경도/위도 구해주는 함수					
					const departBounds = geolib.getBoundsOfDistance({	
						latitude : lat,
						longitude : lon},
						3000);
					const departSwBounds = departBounds[0];
					const departNeBounds = departBounds[1];

					$("input[name=depart_lat]").val(lat);
					$("input[name=depart_lon]").val(lon);
					$("input[name=depart_sw_bound_lat]").val(departSwBounds.latitude);
					$("input[name=depart_sw_bound_lon]").val(departSwBounds.longitude);
					$("input[name=depart_ne_bound_lat]").val(departNeBounds.latitude);
					$("input[name=depart_ne_bound_lon]").val(departNeBounds.longitude);
					}
				})
				
				$.ajax({
					method : "GET",
					url : "https://apis.openapi.sk.com/tmap/geo/fullAddrGeo?version=1&format=json&callback=result",
					async : false,
					data : {
							"appKey" : "l7xxcbda6a9d9b9241f699b4eacec5b60cf1",
							"coordType" : "WGS84GEO",
							"fullAddr" : $("input[name=destination]").val()
					},
					success : function(response) {
						const lat = response.coordinateInfo.coordinate[0].lat.length ? response.coordinateInfo.coordinate[0].lat : response.coordinateInfo.coordinate[0].newLat;
						const lon = response.coordinateInfo.coordinate[0].lon.length ? response.coordinateInfo.coordinate[0].lon : response.coordinateInfo.coordinate[0].newLon;
						const destinationBounds = geolib.getBoundsOfDistance({	
							latitude : lat,
						 	longitude : lon},
							3000);
															
						const destinationSwBounds = destinationBounds[0];
						const destinationNeBounds = destinationBounds[1];

						$("input[name=destination_lat]").val(lat);
						$("input[name=destination_lon]").val(lon);
						$("input[name=destination_sw_bound_lat]").val(destinationSwBounds.latitude);
						$("input[name=destination_sw_bound_lon]").val(destinationSwBounds.longitude);
						$("input[name=destination_ne_bound_lat]").val(destinationNeBounds.latitude);
						$("input[name=destination_ne_bound_lon]").val(destinationNeBounds.longitude);
						}
					});
				$("#searchForm").submit();
				});
			});
</script>


<body>
	<div id="search-bar" class="page-start">
		<form id="searchForm" action="search.do" method="post">
			<div class="input-field start">
				<input name="depart_sw_bound_lat" type="hidden" value="${(input.depart_sw_bound_lat != null)? input.depart_sw_bound_lat : ''}" />
				<input name="depart_sw_bound_lon" type="hidden" value="${(input.depart_sw_bound_lon != null)? input.depart_sw_bound_lon : ''}"/>
				<input name="depart_ne_bound_lat" type="hidden" value="${(input.depart_ne_bound_lat != null)? input.depart_ne_bound_lat : ''}"/> 
				<input name="depart_ne_bound_lon" type="hidden" value="${(input.depart_ne_bound_lon != null)? input.depart_ne_bound_lon : ''}"/> 
				<input name="depart" type="text" placeholder="출발지"
					value=" ${(input.depart != null)? input.depart : ''}" /> 
				<input class="clear" type="text" placeholder="출발지" />
			</div>
			<div class="input-field end">
				<input name="destination_sw_bound_lat" type="hidden" value="${(input.destination_sw_bound_lat != null)? input.destination_sw_bound_lat : ''}" /> 
				<input name="destination_sw_bound_lon" type="hidden" value="${(input.destination_sw_bound_lon != null)? input.destination_sw_bound_lon : ''}" /> 
				<input name="destination_ne_bound_lat" type="hidden" value="${(input.destination_ne_bound_lat != null)? input.destination_ne_bound_lat : ''}" /> 
				<input name="destination_ne_bound_lon" type="hidden" value="${(input.destination_ne_bound_lon != null)? input.destination_ne_bound_lon : ''}"  /> 
				<input name="destination" type="text"  placeholder="도착지" 
					value="${(input.destination != null)? input.destination : ''}">
				<input class="clear" type="text" placeholder="도착지">
			</div>
			<div class="input-field date">
				<input name="time" type="text" placeholder="날짜"
					value="${(input.time != null)? input.time: ''}">
				<input class="clear" type="text" placeholder="날짜">
			</div>
				<input id="searchFormSubmit" type="submit" class="search-btn"
					value="검색" style="width: 12.5%" />
					
						<!-- The Modal -->
	<div id="myModal" class="modal">
	
		<!-- Modal content -->
		<div class="modal-content">
			 <span class="close">&times;
			 </span>
			 <div id="filters">
				<h1>FILTER</h1>
					<div id="sorting">
						<h2>정렬</h2>
							<input type="radio" name="orderby" value="datetime_ASC" checked>시간순<br />
							<input type="radio" name="orderby" value="datetime_DESC">역시간순<br />
							<input type="radio" name="orderby" value="price_ASC">낮은가격순<br />
							<input type="radio" name="orderby" value="price_DESC">높은가격순<br />
							<br />
						</div> <!-- 정렬 -->
				------------------------------------ <br />
						<br />
						<div id="timeRange">
							<h2>시간대</h2>
							<span id="count_before_six_am"></span>
							<input type="checkbox" name="before_six_am" value="true">
							오전 00:00 ~ 오전 6:00 <br /> 
							<input type="checkbox" name="six_to_noon" value="true"> 
							오전 6:00 ~ 오후 12:00<br />
							<input type="checkbox" name="noon_to_six" value="true">
							오후 12:00 ~ 오후 6:00<br /> 
							<input type="checkbox" name="after_six" value="true"> 오후 6:00 ~ 오후 11:59<br />
						</div> <!-- 시간대 -->
					------------------------------------ <br />
						<br />
						<h2>운전자 정보</h2>
						<div id="carModel">
							</br> 차종 : </br>
							<input type="checkbox" name="carMode1" value="true">소형 
							<input type="checkbox" name="carMode2" value="true">중형 
							<input type="checkbox" name="carMode3" value="true">대형
						</div> <!--  카모델 -->
				
						<div id="ageGroup">	
							</br> 연령대 : </br>
							<input type="checkbox" name="twenties" value="true">20대 
							<input type="checkbox" name="thirties" value="true">30대 
							<input type="checkbox" name="forties" value="true">40대 
							<input type="checkbox" name="fifties" value="true">50대 
							<input type="checkbox" name="sixties" value="true">60대 
							<input type="checkbox" name="seventies" value="true">70대
						</div><!-- 연령대 -->
						<div id="gender">
							</br> 성별:</br>
							<input type="checkbox" name="female" value="true">여성 
							<input type="checkbox" name="male" value="true">남성
						</div> <!-- 성별 -->
					
						<div id="maxPassanger">
							</br> 최대 탑승 수용 인원 : </br>
							<input type="checkbox" name="seat1" value="true"> 1명 
							<input type="checkbox" name="seat2" value="true"> 2명 
							<input type="checkbox" name="seat3" value="true"> 3명 
							<input type="checkbox" name="seat4" value="true"> 4명
							<input type="checkbox" name="seat5" value="true"> 5인 이상
						</div> <!-- 최대탑승수용인원 -->
						</br>
						<input id="searchFormSubmit" type="submit" class="search-btn"
							value="검색" style="width: 12.5%" />
				</div>
			</div>
		</div>
			</form>
		</div>


	<!-- Trigger/Open The Modal -->
	<button id="myBtn">Filter</button>


	<div name="searchList">
		<h1>SEARCH TEST</h1>
		SearchResult : 검색결과가 없습니다.
		<c:if test="${searchCount != 0}">
			<table>
				<tr>
					<td>No.</td>
					<td>출발지</td>
					<td>도착지</td>
					<td>출발시간</td>
				</tr>
				<c:forEach var="searchList" items="${searchList}">
					<tr>
						<td>${searchList.carpoolNum}</td>
						<td>${searchList.depart}</td>
						<td>${searchList.destination}</td>
						<td>${searchList.time}</td>
					</tr>

				</c:forEach>
			</table>
		</c:if>
	</div>

</body>
</html>