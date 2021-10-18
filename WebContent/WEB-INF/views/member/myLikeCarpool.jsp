<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관심 카풀</title>
	<link rel="stylesheet" type="text/css"  href="/wiicar/resources/css/popup.css">
	<link href="/wiicar/resources/css/memberMenu.css" rel="stylesheet"type="text/css" />
		<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<style>
	#footer{
		position: fixed;
		bottom: 0;
	}
</style>
<script>
 $(document).ready(function(){
	 
	 $("#myLikeCarpool").addClass("clickMenu");
	 
 	  	$(".kakao").click(function() {
			var priceVal = $(this).val();
			$.ajax({
				url : '/wiicar/carpoolPay/CheckKakaoPay.do',
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
			$(".popup").load("/wiicar/carpool/ProfilePopup.do?id=" + id);
			setTimeout(popup, 300);
		});
		function popup() {
			$(".popup .modal").modal();
		};
	 });
</script>

<body>
<div id="container" class="memberContainer">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div id="content">
		<div id="sidebar">
			<jsp:include page="memberMenu.jsp" />
		</div>
		<div id="mypage">
			<div class="row1">
				<div class="mypageContent">
					<div class="content">
						<c:if test="${listSize == 0}" >
							<div class="noList">
								좋아요 누른 카풀이 없습니다.
							</div>
						</c:if>
						<c:if test="${listSize != 0}" >
							<div class="popup"></div>	
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
						</c:if>
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