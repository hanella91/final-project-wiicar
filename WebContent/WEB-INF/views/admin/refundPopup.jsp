<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
</head>
<script>
	$(document).ready(function(){
		if('${refund.refundcheck}' == '0') {
			$("#afterRefund").hide();
			$("#afterRefundDiv").hide();
		} else if('${refund.refundcheck}' == '1') {
			$("#beforeRefund").hide();
			$("#beforeRefundDiv").hide();
		}
		
		$(".backBtn").click(function(){
			window.close();
		});
		
		$("#refundBtn").click(function(){
			var carpoolnum = '${refund.carpoolnum}';
			$.ajax({
				url: '/wiicar/admin/refundCarpool.do',
				type: 'POST',
				data: {carpoolnum : carpoolnum},
				success: function(data) {
					alert("환급 완료.");
					opener.location.reload();
					location.reload();
				},
				error: function(e) {
					alert("환급 실패");
				}
			})
		})
	})


</script>
<style>
	.row {
		text-align: center;
	}
</style>
<body>
	<div class="container" style="padding-top:20px">
		<div class="row mb-3"> 
			<div class="col-sm-12" id="beforeRefund"><b>환급 내역</b></div>
			<div class="col-sm-12" id="afterRefund"><b>환급 완료</b></div>
		</div>
		<div class="row mb-3">
			<div class="col-sm-6">일정</div>
			<div class="col-sm-6">${refund.time}</div>
		</div>
		<div class="row mb-3">
			<div class="col-sm-6">운전자</div>
			<div class="col-sm-6">${refund.driverid}</div>
		</div>
		<div class="row mb-3">
			<div class="col-sm-6">계좌번호</div>
			<div class="col-sm-6">${refund.bankno}</div>
		</div>
		<div class="row mb-3">
			<div class="col-sm-6">최대탑승 인원</div>
			<div class="col-sm-6">${refund.maxpassenger}</div>
		</div>
		<div class="row mb-3">
			<div class="col-sm-6">실탑승인원</div>
			<div class="col-sm-6">${refund.passengercount}</div>
		</div>
		<div class="row mb-3">
			<div class="col-sm-6">1인당 가격</div>
			<div class="col-sm-6">${refund.price}</div>
		</div>
		<div class="row mb-3">
			<div class="col-sm-6">총 환급 금액</div>
			<div class="col-sm-6">${refund.refund}</div>
		</div>
		<div class="row mb-3">
			<div class="col-sm-6">출발지</div>
			<div class="col-sm-6">${refund.depart}</div>
		</div>
		<div class="row mb-3">
			<div class="col-sm-6">도착지</div>
			<div class="col-sm-6">${refund.destination}</div>
		</div>
		<div class="row mb-3" style="text-align: center;" id="beforeRefundDiv">
			<div class="col-sm-3"></div>
			<div class="col-sm-3" id="refundDiv"><button type="button" style="border:none;border-radius:5px;width:150px;height:30px;color:white;background-color:#3498DB;" id="refundBtn">환급하기</button></div>
			<div class="col-sm-3"><button type="button" style="border:none;border-radius:5px;width:150px;height:30px;color:white;background-color:gray;" class="backBtn">돌아가기</button></div>
			<div class="col-sm-3"></div>
		</div>
		<div class="row mb-3" style="text-align: center;" id="afterRefundDiv">
			<div class="col-sm-4"></div>
			<div class="col-sm-3"><button type="button" style="border:none;border-radius:5px;width:150px;height:30px;color:white;background-color:gray;" class="backBtn">돌아가기</button></div>
			<div class="col-sm-4"></div>
		</div>
	</div>
</body>
</html>