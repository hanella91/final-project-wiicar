<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<script type="text/javascript">
	$(document).ready(function() {
		$("#kakao").click(function() {
			var priceVal = $("#price").text();
			$.ajax({
				url : '/wiicar/carpool/KakaoPay.do',
				dataType : 'json',
				data : {
					price : priceVal					
				},
				success : function(data) {
					var box = data.next_redirect_pc_url;
					window.open(box);
				}, 
				error : function(error) {
					alert("에러")
				}
			});
		});
		$("#modal2btn").click(function() {
			$("#requestText").val = $("#requestInput").val
			var txt = $("#requestInput").val();
			$("#requestText").text(txt);
			$("#requestInput").val("");
		});
		$(".modalCancel").click(function(){
			$("#requestInput").val("");
		});
	});
	
</script>

<body background-color="gray">
	<button class="btn btn-default" data-target="#modal" data-toggle="modal">modal</button>
	<div class="row">
		<div class="modal" id="modal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-body" >
						<div style="display:flex;">
							<div>
								<img class="img-responsive" src="/wiicar/resources/images/default.png" width="200px"/>
							</div>
							<div style="padding-left:20px;width:100%">
								<h3>운전자 닉네임</h3>
								<div>날짜</div>
								<div>출발지 - 도착지</div>
								<div>예상 시간</div>
								<div style="color:#cccccc;text-align:center;">약 10km 예상 주유비 14,000원</div>
								<div>태그</div>
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
								<button id="modal2btn" data-dismiss="modal" data-target="#modal2" data-toggle="modal" style="border:none;border-radius:5px;width:100px;height:30px;color:white;background-color:#3498DB;">예약하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="modal" id="modal2" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-body" >
						<div style="display:flex;">
							<div style="width:100%">
								<h3>예약 정보</h3>
								<div style="padding-left:20px;padding-bottom:20px;">
									<div>출발지 - 도착지</div>
									<div>날짜</div>
									<div>태그</div>
								</div>
							</div>
						</div>
						<div style="">
							<div>
								<div class="label label-success">내 요청사항</div>
							</div>
							<div style="margin-top:10px;">
								<p id="requestText"></p>
							</div>
							<div style="text-align:right;font-size:20px;padding-bottom:10px;">
								<span>결제 금액 : </span>
								<span name="price" id="price">15000</span>
							</div>
							<div style="text-align:right;">
								<button data-dismiss="modal" style="border:none;border-radius:5px;width:100px;height:30px;">취소</button>
								<button id="kakao" style="border:none;border-radius:5px;width:100px;height:30px;color:white;background-color:#3498DB;">예약하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>