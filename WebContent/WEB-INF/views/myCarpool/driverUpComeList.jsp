<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html>
<html>
	<head>
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
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
		<link href="/wiicar/resources/css/memberMenu.css" rel="stylesheet"type="text/css" />
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
		<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	</head>
<body>
<div id="container" class="memberContainer">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div id="content">
		<div id="sidebar">
			<jsp:include page="/WEB-INF/views/member/memberMenu.jsp" />
		</div>
		<div id="mypage">
		 <div class="mypageContent">
	    	<div class="content">
	      		<button id="driver" onclick="location.href='/wiicar/member/driverReserv.do'">운전자</button>
	      		<button id="passenger" onclick="location.href='/wiicar/member/passangerMyCarpool.do?sort=reservation'">탑승자</button>
				<div class="carpool_list">
					<div class="list_btn">
		          		<button class="waiting" onclick="location.href='/wiicar/member/driverReserv.do'">매칭 대기중</button>
		          		<button class="schedule" onclick="location.href='/wiicar/member/driverUpComming.do'">예정된 카풀</button>
		          		<button class="past"onclick="location.href='/wiicar/member/driverPast.do'">지난 카풀</button>
					</div>
					<div>
						<c:if test="${count <= 0}">
						원하시는 검색 결과가 없습니다.
						</c:if>
						<c:if test="${count > 0}">
							<c:forEach var="i" begin="0" end="${count-1}">
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
													 style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:#3498DB;" value="${i}"> 운전 취소 </button>
												</div> 
											</div>
											<div style="display:flex;margin:auto;margin-top:20px;">
												<div style="text-align:center;margin-left:20px;">
													<div style="margin-bottom:5px;color:#3498D8;font-weight:700;">운전자</div>
													<div>
														<c:if test="${driverImage[i] == null}" >
															<img class="userImg" src="/wiicar/resources/imgs/profile_default.png" alt="${carpoolList[i].driverId}" style="width:100%;max-width:75px;border-radius:50%;">
														</c:if>
														<c:if test="${driverImage[i] != null}" >
															<img class="userImg" src="/wiicar/resources/imgs/${driverImage[i]}" alt="${carpoolList[i].driverId}"  style="width:100%;max-width:75px;border-radius:50%;">
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
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>
					<div align="center">
						<c:if test="${listSize > 0}">
							<c:set var="pageBlock" value="5" />
							<fmt:parseNumber var="res" value="${listSize / pageSize}" integerOnly="true" />
							<c:set var="pageCount" value="${res + (listSize % pageSize == 0 ? 0 : 1)}" />
							<fmt:parseNumber var="result" value="${(currentPage-1)/pageBlock}" integerOnly="true" />
							<fmt:parseNumber var="startPage" value="${result * pageBlock + 1}"/>
							<fmt:parseNumber var="endPage" value="${startPage + pageBlock -1}" />
							<c:if test="${endPage > pageCount}">
								<c:set var="endPage" value="${pageCount}" /> 
							</c:if>
							<nav>
								<ul class="pagination">
									<c:if test="${startPage > pageBlock}">
										<a href="/wiicar/member/driverUpComming.do?pageNum=${startPage-pageBlock}" aria-label="Previous">
											<span aria-hidden="true">&laquo;</span>
										</a>
									</c:if>
									<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
										<li style="margin:10px;">
								    		<a href="/wiicar/member/driverUpComming.do?pageNum=${i}">
								    			<span aria-hidden="true"> ${i} </span>
								    		</a>
								    	</li>
									</c:forEach>
									<c:if test="${endPage < pageCount }">
										<a href="/wiicar/member/driverUpComming.do?pageNum=${startPage+pageBlock}" aria-label="Next">
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
		</div>
	</div>

	<!-- FOOTER -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</div>
</body>
</html>