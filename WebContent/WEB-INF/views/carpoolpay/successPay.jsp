<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>SuccessPay</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	var count = 3;
	function Timer() {
		$("h3").text("이 창은 " + count + "초 뒤에 닫힙니다.")
		if(count == 0) {
			self.close();
		} else {
			count--;
		}
	}

	$(document).ready(function() {
		time = setInterval(Timer, 1000);
	});
</script>
</head>
<body>
	<div>
		<h1>결제에 성공하셨습니다.</h1>
		<h3></h3>
	</div>
</body>
</html>