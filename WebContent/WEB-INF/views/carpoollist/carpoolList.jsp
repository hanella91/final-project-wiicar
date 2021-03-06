<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!-- geolib 라이브러리설치 -->
	<script src="https://cdn.jsdelivr.net/npm/geolib@3.3.1/lib/index.min.js"></script>
	<!-- 캘린더 css -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<!-- 캘린더 다운로드 -->
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
	<!--테스트 -->
	<link href="/wiicar/resources/css/reset.css" rel="stylesheet" type="text/css" />
	
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css"  href="/wiicar/resources/css/filterModal.css">
</head>
<script>
 $(document).ready(function(){
 	  	$(".kakao").click(function() {
			var priceVal = $(this).val();
			$.ajax({
				url : '/wiicar/carpoolPay/checkKakaoPay.do',
				dataType : 'json',
				data : {
					price : priceVal					
				},
				success : function(data) {
					var box = data.next_redirect_pc_url;
					window.open(box);
				}, 
				error : function(error) {
					alert("에러");
				}
			});	
		});
		
		$(".likeBtn").click(function() {
			console.log($(this).val());
			if(${empty sessionScope.sid}) {
				alert("로그인 후 사용가능합니다.");
			} else {
				$.ajax({
					url : '/wiicar/carpool/checkLike.do',
					data : {
						carpoolNum : $(this).val()
					}
				});
				location.reload();
			}
		});
		
		$("#timeDropdown a").click(function () {
			$("#timeBtn").text($(this).text());
		});
		
		$(".modal2btn").click(function() {
			$("#requestText").val = $("#requestInput").val
			var txt = $("#requestInput").val();
			$("#requestText").text(txt);
			$("#requestInput").val("");
		});
		$(".modalCancel").click(function(){
			$("#requestInput").val("");
		});
		
		$(".requestBtn").click(function(){
			if(${empty sessionScope.sid}) {
				alert("로그인 후 사용가능합니다.");
			} else {
				var num = $(this).val();
				$(".m1" + num).modal();
			}
			
		});
		
		$(".userImg").click(function() {
			var id = $(this).attr("alt");
			$(".popup").empty();
			$(".popup").load("/wiicar/carpool/profilePopup.do?id=" + id);
			setTimeout(popup, 300);
		});
		function popup() {
			$(".popup .modal").modal();
		};
		
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
							5000);
															
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
	
		//캘린더 오픈소스
	    flatpickr("input[name=time]", {
	    	enableTime: false,
	    	dateFormat: "Y-m-d",
	    });
 	});
</script>
<body>
	<div>
	</div>
	<div class="popup"></div>
	<div style="background-color:#f2f2f2;margin:auto;padding-top:20px;">
		<div style="width:100%;max-width:1400px;margin:auto;">
			<div style="width:80%;display:flex;margin:auto;">
				<div style="width:100px;">
					<label style="font-size:30px;color:#3498D8;">카풀</label>
				</div>
				<div style="width:200px;margin-left:auto;padding-top:5px;">
					<button style="border:none;border-radius:5px;background-color:#5e5e5e;color:#ffffff;width:150px;height:30px;font-size:15px;">카풀등록하기</button>
				</div>
			</div>
			<div> <!-- div 정체 확인 -->
			
			<!-- 검색 밑 content -->
			<!--  검색바 -->
				<div id="search-bar" class="page-start">
					<form id="searchForm" action="carpoolList.do" method="post">
						<div class="input-field start">
							<input name="depart_sw_bound_lat" type="hidden" value="${(input.depart_sw_bound_lat != null)? input.depart_sw_bound_lat : ''}" />
							<input name="depart_sw_bound_lon" type="hidden" value="${(input.depart_sw_bound_lon != null)? input.depart_sw_bound_lon : ''}"/>
							<input name="depart_ne_bound_lat" type="hidden" value="${(input.depart_ne_bound_lat != null)? input.depart_ne_bound_lat : ''}"/> 
							<input name="depart_ne_bound_lon" type="hidden" value="${(input.depart_ne_bound_lon != null)? input.depart_ne_bound_lon : ''}"/> 
							<input name="depart" type="text" placeholder="출발지" value=" ${(input.depart != null)? input.depart : ''}" /> 
						</div>
						
						<div class="input-field end">
							<input name="destination_sw_bound_lat" type="hidden" value="${(input.destination_sw_bound_lat != null)? input.destination_sw_bound_lat : ''}" /> 
							<input name="destination_sw_bound_lon" type="hidden" value="${(input.destination_sw_bound_lon != null)? input.destination_sw_bound_lon : ''}" /> 
							<input name="destination_ne_bound_lat" type="hidden" value="${(input.destination_ne_bound_lat != null)? input.destination_ne_bound_lat : ''}" /> 
							<input name="destination_ne_bound_lon" type="hidden" value="${(input.destination_ne_bound_lon != null)? input.destination_ne_bound_lon : ''}"  /> 
							<input name="destination" type="text"  placeholder="도착지" value="${(input.destination != null)? input.destination : ''}">
						
						</div>
						<div class="input-field date">
							<input name="time" type="text" placeholder="날짜" value="${(input.time != null)? input.time: ''}">
							<input class="clear" type="text" placeholder="날짜">
						</div>
						<input id="searchFormSubmit" type="submit" class="search-btn" value="검색" style="width: 12.5%" />
						<!-- Modal content -->
						<div id="myModal" class="modal">
						
							<div class="modal-content">
					 			<span class="close">&times; </span>
								 <div id="filters">
									<h1>FILTER</h1>
									<div id="sorting">
										<h2>정렬</h2>
										<input type="radio" name="orderby" value="datetime_ASC" checked>시간순<br />
										<input type="radio" name="orderby" value="datetime_DESC">역시간순<br />
										<input type="radio" name="orderby" value="price_ASC">낮은가격순<br />
										<input type="radio" name="orderby" value="price_DESC">높은가격순<br /><br />
									</div> <!-- 정렬 -->
									------------------------------------ <br /><br />
									<div id="timeRange">
										<h2>시간대</h2>
										<span id="count_before_six_am"></span>
										<input type="checkbox" name="before_six_am" value="true"> 오전 00:00 ~ 오전 6:00 <br /> 
										<span id="count_six_to_noon"></span>
										<input type="checkbox" name="six_to_noon" value="true"> 오전 6:00 ~ 오후 12:00<br />
										<span id="count_noon_to_six"></span>
										<input type="checkbox" name="noon_to_six" value="true"> 오후 12:00 ~ 오후 6:00<br /> 
										<span id="count_after_six"></span>
										<input type="checkbox" name="after_six" value="true"> 오후 6:00 ~ 오후 11:59<br />
									</div> <!-- 시간대 -->
									------------------------------------ <br /><br />
									<div id="carModel">
										<h2>운전자 정보</h2>
										</br> 차종 : </br>
										<span id="count_carModel1"></span>
										<input type="checkbox" name="carModel1" value="true">소형 
										<span id="count_carModel2"></span>
										<input type="checkbox" name="carModel2" value="true">중형 
										<span id="count_carModel3"></span>
										<input type="checkbox" name="carModel3" value="true">대형
									</div> <!--  카모델 -->
						
									<div id="ageGroup">	
										</br> 연령대 : </br>
										<span id="count_twenties"></span>
										<input type="checkbox" name="twenties" value="true">20대 
										<span id="count_thirties"></span>
										<input type="checkbox" name="thirties" value="true">30대 
										<span id="count_forties"></span>
										<input type="checkbox" name="forties" value="true">40대 
										<span id="count_fifties"></span>
										<input type="checkbox" name="fifties" value="true">50대 
										<span id="count_sixties"></span>
										<input type="checkbox" name="sixties" value="true">60대 
										<span id="count_seventies"></span>
										<input type="checkbox" name="seventies" value="true">70대
									</div><!-- 연령대 -->
									
									<div id="gender">
										</br> 성별:</br>
										<span id="count_female"></span>
										<input type="checkbox" name="female" value="true">여성 
										<span id="count_male"></span>
										<input type="checkbox" name="male" value="true">남성
									</div> <!-- 성별 -->
							
									<div id="maxPassanger">
										</br> 최대 탑승 수용 인원 : </br>
										<span id="count_seat1"></span>
										<input type="checkbox" name="seat1" value="true"> 1명 
										<span id="count_seat2"></span>
										<input type="checkbox" name="seat2" value="true"> 2명 
										<span id="count_seat3"></span>
										<input type="checkbox" name="seat3" value="true"> 3명 
										<span id="count_seat4"></span>
										<input type="checkbox" name="seat4" value="true"> 4명
										<span id="count_seat5"></span>
										<input type="checkbox" name="seat5" value="true"> 5인 이상
									</div> <!-- 최대탑승수용인원 --> </br>
									
									<input id="searchFormSubmit" type="submit" class="search-btn" value="검색" style="width: 12.5%" />
								</div>
							</div>
						</div>
					</form>
				</div> <!-- 검색 form -->
	
	
				<div style="margin:auto;width:300px;">
					<button id="myBtn" style="border:none;border-radius:5px;width:100%;height:30px;color:white;background-color:#3498DB;">세부 검색</button>
				</div>
				<div style="margin:auto;width:70%;text-align:right;">
					<div class="btn-group">
						<button id="sortBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="width:130px;">정렬 기준&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="caret"></span></button>
						<ul id="sortDropdown" class="dropdown-menu" role="menu">
							<li><a href="/wiicar/carpool/CarpoolList.do?pageNum=${pageNum}&orderby=reg_desc">최신 순</a></li>
							<li><a href="/wiicar/carpool/CarpoolList.do?pageNum=${pageNum}&orderby=reg_asc">오래된 순</a></li>
						    <li><a href="/wiicar/carpool/CarpoolList.do?pageNum=${pageNum}&orderby=driverrate_desc">평점 높은 순</a></li>
						    <li><a href="/wiicar/carpool/CarpoolList.do?pageNum=${pageNum}&orderby=driverrate_asc">평점 낮은 순</a></li>						    
						    <li><a href="/wiicar/carpool/CarpoolList.do?pageNum=${pageNum}&orderby=price_desc">높은 요금 순</a></li>
						    <li><a href="/wiicar/carpool/CarpoolList.do?pageNum=${pageNum}&orderby=price_asc">낮은 요금 순</a></li>
						</ul>
					</div>
				</div>
				
				<div>
				<c:if test="${count == 0}">
				원하시는 검색 결과가 없습니다.
				</c:if>
					<c:forEach var="i" begin="0" end="${listSize-1}">
						<div style="margin-top:20px;">
							<div style="margin:auto;width:600px;background-color:#ffffff;border-radius:10px;box-shadow:5px 5px 1px 1px gray;">
								<div style="padding-top:20px;">
									<div style="margin-left:20px;font-size:20px;">
										<span>${carpoolList[i].depart}</span>
										<span class="glyphicon glyphicon-menu-right"></span>
										<span>${carpoolList[i].destination}</span>
									</div>
									<div style="margin-left:20px;margin-top:10px;font-size:15px;">
										<div>${carpoolList[i].time}</div>
										<div style="margin-left:auto;margin-right:20px;">인당 : ${carpoolList[i].price}원</div>
									</div>
									<div style="display:flex;margin-left:20px;margin-top:10px;">
										<div>
											<c:forEach var="tag" items="${tagList[i]}" >
												<span class="label label-default">${tag}</span>
											</c:forEach>
										</div>
										<div style="margin-right:20px;margin-left:auto;">
											<button class="requestBtn"
											 style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:#3498DB;" value="${i}">예약요청</button>
										</div> 
									</div>
									<div style="display:flex;margin:auto;margin-top:20px;">
										<div style="text-align:center;margin-left:20px;">
											<div style="margin-bottom:5px;color:#3498D8;font-weight:700;">운전자</div>
											<div>
												<c:if test="${driverIamge[i] == null}" >
													<img class="userImg" src="/wiicar/resources/imgs/profile_default.png" alt="${carpoolList[i].driverId}" style="width:100%;max-width:75px;border-radius:50%;">
												</c:if>
												<c:if test="${driverIamge[i] != null}" >
													<img class="userImg" src="/wiicar/resources/imgs/${driverIamge[i]}" alt="${carpoolList[i].driverId}"  style="width:100%;max-width:75px;border-radius:50%;">
												</c:if>
											</div>
										</div>
										<div style="width:120;margin-left:10px;margin-bottom:0px;margin-top:5%;">
											<div>${nickname[i]}</div>
											<div style="display:flex;vertical-align:middle;height:30px;">
												<div style="margin-top:2px;">평점&nbsp;&nbsp;</div>
												<div>
													<c:forEach begin="1" end="${rate[i] / 1}">
														<img src="/wiicar/resources/imgs/star.png" style="width:20px" />
													</c:forEach>
													<c:if test="${(rate[i] % 1) == 0.5}">
														<img src="/wiicar/resources/imgs/halfstar.png" style="width:20px" />
													</c:if>
												</div>
											</div>
										</div>
										<div style="margin-left:auto;width:50%;">
											<div style="margin-bottom:5px;color:#3498D8;font-weight:700;">매칭된 탑승자</div>
											<div style="display:flex;">
												<c:if test="${passengerIamges[i] != null}">
													<c:forEach var="j" begin="0" end="${passengercount[i]}">
														<c:if test="${imgs == null}" >
															<div style="margin-right:10px;">
																<img class="userImg" value="${passengerId[j]}" src="/wiicar/resources/imgs/profile_default.png" style="width:100%;max-width:50px;border-radius:50%;">
															</div>
														</c:if>
														<c:if test="${imgs != null}" >
															<div style="margin-right:10px;">
																<img class="userImg" value="${passengerId[j]}" src="/wiicar/resources/imgs/${passengerIamges[j]}" style="width:100%;max-width:50px;border-radius:50%;">
															</div>
														</c:if>
													</c:forEach>
												</c:if>
												<c:if test="${passengerIamges[i] == null}">
													<div>
														아직 매칭된 탑승자가 없습니다. 
													</div>
												</c:if>
											</div>
										</div>
									</div>
									<div>
										<div style="display:flex;padding-bottom:10px;align-items:center;">
											<div style="margin-left:auto;margin-right:5px;">
												<c:if test="${like[i] == 1}">
													<button class="glyphicon glyphicon-heart likeBtn" style="font-size:30px;color:#ee3333;border:none;background-color:#ffffff;" value="${carpoolList[i].carpoolNum}"></button>
												</c:if>
												<c:if test="${like[i] == 0}">
													<button class="glyphicon glyphicon-heart likeBtn" style="font-size:30px;color:gray;border:none;background-color:#ffffff;" value="${carpoolList[i].carpoolNum}"></button>
												</c:if>
											</div>
											<div style="margin-right:20px;">
												관심카풀등록
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="modal fade m1${i}" tabindex="-1">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-body" >
										<div style="display:flex;">
											<div>
												<img class="img-responsive" src="/wiicar/resources/imgs/profile_default.png" width="200px"/>
											</div>
											<div style="padding-left:20px;width:100%">
												<h3>${modalDriverNickname}</h3>
												<div>${carpoolList[i].time}</div>
												<div>${carpoolList[i].depart} - ${carpoolList[i].destination}</div>
												<div style="color:#cccccc;text-align:center;">약 <span>${carpoolList[i].distance}</span>km </div>
												<div>
													<c:forEach var="tag" items="${tagList[i]}" >
														<span class="label label-default">${tag}</span>
													</c:forEach>
												</div>
											</div>
										</div>
										<div style="">
											<div>
												<div class="label label-success">내 요청사항</div>
											</div>
											<div style="margin-top:10px;">
												<textarea id="requestInput" style="width:100%;height:150px;resize: none;" placeholder="내용을 입력해주세요"></textarea>
											</div>
											<div style="text-align:right;">
												<button class="modalCancel" data-dismiss="modal" style="border:none;border-radius:5px;width:100px;height:30px;">취소</button>
												<button class="modal2btn" data-dismiss="modal" data-target=".m2${i}" data-toggle="modal" style="border:none;border-radius:5px;width:100px;height:30px;color:white;background-color:#3498DB;">예약하기</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="modal fade m2${i}"  tabindex="-1">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-body" >
										<div style="display:flex;">
											<div style="width:100%">
												<h3>예약 정보</h3>
												<div style="padding-left:20px;padding-bottom:20px;">
													<div>${carpoolList[i].depart} - ${carpoolList[i].destination}</div>
													<div>${carpoolList[i].time}</div>
												<div>
													<c:forEach var="tag" items="${tagList[i]}" >
														<span class="label label-default">${tag}</span>
													</c:forEach>
												</div>
												</div>
											</div>
										</div>
										<div>
											<div>
												<div class="label label-success">내 요청사항</div>
											</div>
											<div style="margin-top:10px;">
												<p id="requestText"></p>
											</div>
											<div style="text-align:right;font-size:20px;padding-bottom:10px;">
												<span>결제 금액 : </span>
												<span>${carpoolList[i].price}</span>
											</div>
											<div style="text-align:right;">
												<button data-dismiss="modal" style="border:none;border-radius:5px;width:100px;height:30px;">취소</button>
												<button class="kakao" value="${carpoolList[i].price}" style="border:none;border-radius:5px;width:100px;height:30px;color:white;background-color:#3498DB;">예약하기</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div align="center">
					<c:if test="${count > 0}">
						<c:set var="pageBlock" value="3" />
						<fmt:parseNumber var="res" value="${count / pageSize}" integerOnly="true" />
						<c:set var="pageCount" value="${res + (count % pageSize == 0 ? 0 : 1)}" />
						<fmt:parseNumber var="result" value="${(currentPage-1)/pageBlock}" integerOnly="true" />
						<fmt:parseNumber var="startPage" value="${result * pageBlock + 1}"/>
						<fmt:parseNumber var="endPage" value="${startPage + pageBlock -1}" />
						<c:if test="${endPage > pageCount}">
							<c:set var="endPage" value="${pageCount}" /> 
						</c:if>
						<nav>
							<ul class="pagination">
								<c:if test="${startPage > pageBlock}">
									<a href="/wiicar/carpool/carpoolList.do?pageNum=${startPage-pageBlock}&orderby=${sel}_${sort}" aria-label="Previous">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</c:if>
								<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
									<li>
							    		<a href="/wiicar/carpool/carpoolList.do?pageNum=${i}&orderby=${sel}_${sort}">
							    			<span aria-hidden="true">${i}</span>
							    		</a>
							    	</li>
								</c:forEach>
								<c:if test="${startPage > pageBlock}">
									<a href="/wiicar/carpool/carpoolList.do?pageNum=${startPage+pageBlock}&orderby=${sel}_${sort}" aria-label="Next">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</c:if>
							</ul>
						</nav>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>