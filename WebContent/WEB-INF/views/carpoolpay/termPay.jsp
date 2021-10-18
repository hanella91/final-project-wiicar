<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>기간제 결제</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script>
	$(document).ready(function() {
		$("#kakao").click(function() {
			var val = $('input:radio[name="radio"]:checked').val();
			if(val != null) {
				$.ajax({
					url : '/wiicar/carpool/KakaoPay.do',
					dataType : 'json',
					data : {
						price : val					
					},
					success : function(data) {
						var box = data.next_redirect_pc_url;
						window.open(box);
					}, 
					error : function(error) {
						alert("에러")
					}	
				});
			} else {
				alert("상품을 선택하고 결제해주세요.");
			}	
		});
		
	});
</script>
<body>
	<div>
		<div style="width:300px;margin:auto;font-size:30px;">
			<div style="padding-bottom:10px;"><input type="radio" style="width:20px;height:20px;" name="radio" value="1" /> 1일&emsp;&emsp;1,000원</div>
			<div style="padding-bottom:10px;"><input type="radio" style="width:20px;height:20px;" name="radio" value="2" /> 1개월&emsp;9,800원</div>
			<div style="padding-bottom:10px;"><input type="radio" style="width:20px;height:20px;" name="radio" value="3" /> 3개월&emsp;27,000원</div>
			<div style="padding-bottom:10px;"><input type="radio" style="width:20px;height:20px;" name="radio" value="4" /> 6개월&emsp;52,000원</div>
			<div style="padding-bottom:20px;"><input type="radio" style="width:20px;height:20px;" name="radio" value="5" /> 1년&emsp;&emsp;98,000원</div>
		</div>
		<div style="width:300px;margin:auto;text-align:center;">
			<button id="kakao" style="border:none;border-radius:5px;width:200px;height:30px;color:white;background-color:#3498DB;">결제하기</button>
		</div>
	</div>
</body>
</html>