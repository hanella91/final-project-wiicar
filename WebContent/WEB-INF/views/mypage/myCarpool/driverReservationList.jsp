<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<link rel="stylesheet" type="text/css"  href="/wiicar/resources/css/reset.css">
	<style>
		#content {
		  width: 100%;
		  height: 100%;
		  background-color: #fff;
		  background-image: none;
		  display: flex;
		}
				
		#driver, #passenger {
		  padding: 2% 3%;
		  width: 49%;
		  border-radius: 30px;
		  font-size: 18px;
		  font-weight: 900;
		  color: #fff;
		}
		
		#driver {
		  float: left;
		  background-color:cornflowerblue;
		}
		
		#passenger {
		  float:right;
		  background-color: cadetblue;
		}
		
		.carpool_list {
		  clear:both;
		  width: 100%;
		  padding-top: 20px;
		  margin: 0 auto;
		  position:relative;
		  text-align: center;
		}
		.list_btn {
		  display: inline-block;
		  margin: 0 auto;
		}
		.list_btn button {
		  background-color: transparent;
		  border: 1px solid #eee;
		  width: 200px;
		  margin: 0 auto;
		  padding:15px;
		  border-radius: 20px;
		}
		.list_btn button:hover {
		  background-color: #eee;
		}
		.list_content {
		  padding-top: 30px;
		}
	</style>
</head>
<body>
	<div class="body">
	  <div>헤더</div>
		 <div class="mypageContent">
	    	<!--임포트부분-->
	    	<div class="content">
	      		<button id="driver" onclick="location.href='/wiicar/member/DriverReserv.do?id=wiiwii'">운전자</button>
	      		<button id="passenger" onclick="location.href='/wiicar/member/passangerMyCarpool.do?id=wiiwii&sort=reservation'">탑승자</button>
				<div class="carpool_list">
					<div class="list_btn">
		          		<button class="waiting" onclick="location.href='/wiicar/member/DriverReserv.do?id=wiiwii'">매칭 대기중</button>
		          		<button class="schedule" onclick="location.href='/wiicar/member/DriverUpComming.do?id=wiiwii'">예정된 카풀</button>
		          		<button class="past"onclick="location.href='/wiicar/member/DriverPast.do?id=wiiwii'">지난 카풀</button>
					</div>
					<div>
						<c:if test="${count <= 0}">
						현재 예약 요청이 없습니다.
						</c:if>
						<c:if test="${count > 0}">
							<c:forEach var="i" begin="0" end="${count-1}">
								<div style="margin-top:20px;">
									<div style="margin:auto;width:600px;background-color:#ffffff;border-radius:10px;box-shadow:5px 5px 1px 1px gray;">
										<div style="padding-top:20px;">
											<div style="margin-left:20px;font-size:20px;">
												<span>출발지 : ${reservationList[i].depart}  <br/></span>
												<span>도착지 : ${reservationList[i].destination}</span>
											</div>
											<div style="margin-left:20px;margin-top:10px;font-size:15px;">
												<div>${reservationList[i].time}</div>
												<div style="margin-left:auto;margin-right:20px;">인당 : ${reservationList[i].price}원</div>
											</div>
											<div style="display:flex;margin-left:20px;margin-top:10px;">
												<div style="margin-right:20px;margin-left:auto;">
													<button class="requestBtn" style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:#3498DB;" >수락</button>
													<button class="requestBtn" style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:#3498DB;" >거절</button>
												</div> 
											</div>
											<div style="display:flex;margin:auto;margin-top:20px;">
												<div style="text-align:center;margin-left:20px;">
													<div style="margin-bottom:5px;color:#3498D8;font-weight:700;">예약 탑승자 정보</div>
													<div>
														<c:if test="${reservationList[i].profileImage == null}" >
															<img class="userImg" src="/wiicar/resources/imgs/profile_default.png" alt="${reservationList[i].passenger}" style="width:100%;max-width:75px;border-radius:50%;">
														</c:if>
														<c:if test="${reservationLis[i].profileImage != null}" >
															<img class="userImg" src="/wiicar/resources/imgs/${reservationList[i].profileImage}" alt="${reservationList[i].passenger}"  style="width:100%;max-width:75px;border-radius:50%;">
														</c:if>
													</div>
												</div>
												<div style="width:120;margin-left:10px;margin-bottom:0px;margin-top:5%;">
													<div>${reservationList[i].passenger}</div>
													<div style="display:flex;vertical-align:middle;height:30px;">
														<div style="margin-top:2px;">평점&nbsp;&nbsp;</div>
														<div>
															<c:forEach begin="1" end="${reservationList[i].passengerRate / 1}">
																<img src="/wiicar/resources/imgs/star.png" style="width:20px" />
															</c:forEach>
															<c:if test="${(reservationList[i].passengerRate % 1) == 0.5}">
																<img src="/wiicar/resources/imgs/halfstar.png" style="width:20px" />
															</c:if>
														</div>
													</div>
												</div>
												<div style="margin-left:auto;width:50%;">
													<div style="margin-bottom:5px;color:#3498D8;font-weight:700;">예약요청 메세지</div>
													<div style="display:flex;">
														<div>${reservationList[i].message}</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
	   		</div>
	   </div>
	</div>
</body>
</html>