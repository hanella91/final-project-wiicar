<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>My Profile</title>
	<link rel="stylesheet" type="text/css"  href="/wiicar/resources/css/popup.css">
		<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/memberMenu.css" rel="stylesheet"type="text/css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<script>
	$(document).ready(function() {
		passengerBtn();
		$("#driver").click(function() {
			driverBtn();
		});
		$("#passenger").click(function() {
			passengerBtn();
		});
		
		$("#myProfile").addClass("clickMenu");
		
	});
	
	function driverBtn() {
		$("#driver").removeClass("btn-outline-primary");
		$("#driver").addClass("btn-primary");
		$("#passenger").removeClass("btn-primary");
		$("#passenger").add("btn-outline-primary");
		
		$("#driverDetail-info").show();
		$("#passengerDetail-info").hide();
	}
	
	function passengerBtn(){
		$("#passenger").removeClass("btn-outline-primary");
		$("#passenger").addClass("btn-primary");
		$("#driver").removeClass("btn-primary");
		$("#driver").add("btn-outline-primary");
		
		$("#driverDetail-info").hide();
		$("#passengerDetail-info").show();
	}
	
</script>
<style>
	#userProfilePopup {
		margin:auto;
	}
	.content{
		text-align: center;
	    max-width: 500px;
	    margin: auto;
	    width: 400px;
	}	
</style>
<body>
<div id="container">
	<!-- HEADER -->
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<!-- CONTENT -->
	<div id="content">
		<div id="sidebar">
			<jsp:include page="memberMenu.jsp" />
		</div>
		<div id="mypage">
		<div class="row1">
			<div class="mypageContent">
				<div class="content">
					<div id="userProfilePopup">
				        <!-- 유저 정보 -->
				        <div class="user-profile">
				        	<div class="user-info">
				            	<div class="user-img">
				            		<c:if test="${dto.profileImage != null}">
				            			<img src="/wiicar/resources/imgs/${dto.profileImage}" alt="프로필 이미지" width="65px" height="65px" />
				            		</c:if>
				            		<c:if test="${dto.profileImage == null}">
				            			<img src="/wiicar/resources/imgs/profile.png" alt="프로필 이미지" width="65px" height="65px" />
				            		</c:if>
				            	</div>
				            		<div class="user-name">
					              		<p>${dto.nickname}</p>
					            	</div>
					            	<div class="user-etc">
					              		<p>${dto.gender} / ${age} / ${carModel}</p>
					            	</div>
					          	</div>
					          	<div class="icon">
					            	<div class="auth">
					              		<c:if test="${dto.identify == 1}">
					              			<div class="identify small"><img src="/wiicar/resources/imgs/shield.png" alt="본인인증완료표시" />본인인증완료</div>
					              		</c:if>
					              		<c:if test="${dto.permit == 1}">
					              			<div class="permit small"><img src="/wiicar/resources/imgs/shield.png" alt="운전자인증완료표시"/>운전자인증완료</div>
					              		</c:if>
					            	</div>
					            	<div class="reportcount small"><img src="/wiicar/resources/imgs/exclamation-mark.png" alt="신고누적횟수아이콘">신고누적횟수 ${reportcount}회</div>
					          	</div>
				        	</div>
					        <hr />
					        <div class="user-type row">
					          	<!-- 클릭하면 btn-primary 추가하고 btn-outline-primary 삭제 -->
					          	<button id="passenger" type="button" class="btn-primary btn col-6">탑승자</button>
					          	<button id="driver" type="button" class="btn btn-outline-primary col-6">운전자</button>
					        </div>
					        <div>
						        <div id="driverDetail-info">
						          	<ul class="con1">
						            	<li class="reg">
						              		<p class="bold">가입날짜</p>
						              		<p class="txt">
												<fmt:formatDate value="${dto.reg}" pattern="yyyy-MM-dd"/>
											</p>
						            	</li>
						            	<div class="line"></div>
						            	<li class="rate">
						              		<p class="bold">평점</p>
						              		<div class="star txt">
						              			<div>
							              			<c:forEach begin="1" end="${dto.driverRate / 1}">
														<img src="/wiicar/resources/imgs/star.png" style="width:20px" />
													</c:forEach>
													<c:if test="${(dto.driverRate % 1) > 0}">
														<img src="/wiicar/resources/imgs/halfstar.png" style="width:20px" />
													</c:if>
												</div>
												<br/>
												<div><span>(${(dto.driverRate / 1) + (dto.driverRate % 1)})</span></div>
						              		</div>
						            	</li>
						            	<div class="line"></div>
						            	<li class="fin">
						              		<p class="bold">카풀운행횟수</p>
						              		<p class="txt">${carpoolrecord}회</p>
						            	</li>
						          	</ul>
						          	<div class="con2">
						            	<p class="bold">성향</p>
						            	<div class="preference">
						            		<c:if test="${preference != null}">
							            		<c:forEach var="item" items="${preference}">
							             			<p>${item}</p>
							            		</c:forEach>
						            		</c:if>
						            		<c:if test="${preference == null}">
						            			<p>설정된 성향이 없습니다.</p>
						            		</c:if>
						            	</div>
						          	</div>
						          	<div class="con3">
						           	 	<p class="bold">리뷰(${driverReviewCount})</p>
						            	<div class="review">
						              		<ul>
							              		<c:if test="${driverReviewCount != 0}">
								              		<c:forEach var="i" begin="0" end="${driverReviewCount}">
								              		 	<li>
								              		 		<c:if test="${driverReviewImgs[i] == null}">
									                 			<div class="re-img"><img src="/wiicar/resources/imgs/profile.png" alt="리뷰 프로필사진" /></div>
									                  		</c:if>
									                  		<c:if test="${driverReviewImgs[i] != null}">
									                 			<div class="re-img"><img src="/wiicar/resources/imgs/${driverReviewImgs[i]}" alt="리뷰 프로필사진" /></div>
									                  		</c:if>
									                  		<p>${driverReview[i].content}</p>
									                	</li>
								              		</c:forEach>
							              		</c:if>
							              		<c:if test="${driverReviewCount == 0}">
							              			<li>등록된 리뷰가 없습니다.</li>
							              		</c:if>
							              	</ul>
					            		</div>
						          	</div>
						        </div>
						        <div id="passengerDetail-info">
						          	<ul class="con1">
						            	<li class="reg">
						              		<p class="bold">가입날짜</p>
						              		<p class="txt">
												<fmt:formatDate value="${dto.reg}" pattern="yyyy-MM-dd"/>
											</p>
						            	</li>
						            	<div class="line"></div>
						            	<li class="rate">
						              		<p class="bold">평점</p>
						              		<div class="star txt">
						              		<div>
								              	<c:forEach begin="1" end="${dto.passengerRate / 1}">
													<img src="/wiicar/resources/imgs/star.png" style="width:20px" />
												</c:forEach>
												<c:if test="${(dto.passengerRate % 1) > 0}">
													<img src="/wiicar/resources/imgs/halfstar.png" style="width:20px" />
												</c:if>
											</div>
											<br/>
											<div><span>(${(dto.passengerRate / 1) + (dto.passengerRate % 1)})</span></div>
						              	</div>
						            	</li>
						            	<div class="line"></div>
						            	<li class="fin">
							            	<p class="bold">카풀이용횟수</p>
							              	<p class="txt">${carpoolused}회</p>
						            	</li>
						          	</ul>
						          	<div class="con2">
						            	<p class="bold">성향</p>
						            	<div class="preference">
						            		<c:if test="${preference != null}">
							            		<c:forEach var="item" items="${preference}">
							             			<p>${item}</p>
							            		</c:forEach>
						            		</c:if>
						            		<c:if test="${preference == null}">
						            			<p>설정된 성향이 없습니다.</p>
						            		</c:if>
						            	</div>
						          	</div>
						          	<div class="con3">
						            	<p class="bold">리뷰(${passengerReviewCount})</p>
						            	<div class="review">
						              		<ul>
						              			<c:if test="${passengerReviewCount != 0}">
							              			<c:forEach var="i" begin="0" end="${passengerReviewCount}">
							              		 		<li>
							              		 			<c:if test="${passengerReviewImgs[i] == null}">
								                 				<div class="re-img"><img src="/wiicar/resources/imgs/profile.png" alt="리뷰 프로필사진" /></div>
								                  			</c:if>
								                  			<c:if test="${passengerReviewImgs[i] != null}">
								                 				<div class="re-img"><img src="/wiicar/resources/imgs/${passengerReviewImgs[i]}" alt="리뷰 프로필사진" /></div>
								                  			</c:if>
								                  			<p>${passengerReview[i].content}</p>
								                		</li>
							              			</c:forEach>
						              			</c:if>
						              			<c:if test="${passengerReviewCount == 0}">
						              				<li>등록된 리뷰가 없습니다.</li>
						              			</c:if>
						              		</ul>
						            	</div>
						          	</div>
						        </div>
							</div>
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