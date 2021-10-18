<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
  
<script>
	$(document).ready(function(){
		$(".backBtn").click(function(){
			window.close();
		});
		
		$("#reportBtn").click(function(){
			$.ajax({
				url: '/wiicar/admin/reportUser.do',
				type: 'POST',
				data: {reportContent : $("#reportContent").val()},
				success: function(data) {
					alert("신고 완료.");
					window.close();
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
  	
<div class="container" style="padding-top:20px">
	<div class="row mb-3"> 
		<div class="col-sm-12"><b>사용자 신고</b></div>
	</div>
	<div class="row mb-3">
		<div class="col-sm-6">신고할 사용자 닉네임</div>
		<div class="col-sm-6">${nickname}</div>
	</div>
	<div class="row mb-3">
		<div class="col-sm-6">사용자 닉네임</div>
		<div class="col-sm-6">${sessionScope.sid}</div>
	</div>
	<div class="row mb-3">
		<div class="col-sm-6">신고 사유</div>
	</div>
	<div class="row mb-3">
		<textarea id="reportContent"></textarea>
	</div>
	<div class="row mb-3">
		<div class="col-sm-12">신고 사유를 허위로 작성했을 시 신고 당사자에게 불이익이 갈 수 있습니다.</div>
	</div>
	
	<div class="row mb-3" style="text-align: center;">
		<div class="col-sm-3"></div>
		<div class="col-sm-3"><button type="button" style="border:none;border-radius:5px;width:150px;height:30px;color:white;background-color:#3498DB;" id="reportBtn">신고하기</button></div>
		<div class="col-sm-3"><button type="button" style="border:none;border-radius:5px;width:150px;height:30px;color:white;background-color:gray;" class="backBtn">돌아가기</button></div>
		<div class="col-sm-3"></div>
	</div>
</div>
