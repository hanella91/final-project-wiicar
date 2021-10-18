<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WIICAR - 관리자 로그인</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
</head>
<script>
	$(document).ready(function(){
		$("#backBtn").click(function(){
			window.close();
		});
		
		$("#loginBtn").click(function(){
			if($("#nickname").val() == '') {
				alert("아이디를 입력해주세요.");
				return false;
			}
			if($("#pw").val() == '') {				
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			$.ajax({
				url: '/wiicar/loginPro.do',
				type: 'POST',
				data: {nickname : $("#nickname").val(), pw : $("#pw").val()},
				success: function(data) {
					alert("관리자 로그인 완료.");
					opener.location.reload();
					window.close();
				},
				error: function(e) {
					alert("관리자 로그인 실패");
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
	<h3 align="center" style="padding-top:20px"> 관리자 로그인 페이지 </h3>
	<div class="container" style="padding-top:20px">
		<div class="row mb-3"> 
			<div class="col-sm-6"><b>아이디</b></div>
			<div class="col-sm-6">
				<input type="text" id="nickname" placeholder="아이디"/>
			</div>
		</div>
		<div class="row mb-3">
			<div class="col-sm-6"><b>비밀번호</b></div>
			<div class="col-sm-6">
				<input type="password" id="pw" placeholder="비밀번호"/>			
			</div>
		</div>
		<div class="row mb-3" style="text-align: center;">
			<div class="col-sm-3"></div>
			<div class="col-sm-3"><button type="button" style="border:none;border-radius:5px;width:150px;height:30px;color:white;background-color:#3498DB;" id="loginBtn">로그인</button></div>
			<div class="col-sm-3"><button type="button" style="border:none;border-radius:5px;width:150px;height:30px;color:white;background-color:gray;" id="backBtn">취소</button></div>
			<div class="col-sm-3"></div>
		</div>
	</div>
</body>
</html>