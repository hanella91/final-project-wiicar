<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WIICAR - 탑승자 승인 페이지</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
	<script>
		$(document).ready(function(){
			$('#accept').click(function(){
				$.ajax({
					url: '/wiicar/admin/acceptDriver.do',
					type: 'post',
					data: {nickname : '${nickname}'},
					success: function(data) {
						alert("승인 완료.");
					    opener.location.reload();
					    window.close();
					},
					error: function(e) {
						alert("승인 실패");
					}
				});
			});
			$('#deny').click(function(){
				$.ajax({
					url: '/wiicar/admin/denyDriver.do',
					type: 'post',
					data: {nickname : '${nickname}'},
					success: function(data) {
						alert("보류 완료.");
					    opener.location.reload();
					    window.close();
					},
					error: function(e) {
						alert("보류 실패");
					}
				});
			});
		});
	</script>
	<style>
		.btn {
			transition: all .3s cubic-bezier(0.67, 0.17, 0.40, 0.83);
		    box-sizing: border-box;
		    width: 60%;
		    padding: 1em;
		    border: 2px solid #00bafa;
		    border-radius: 1.5em;
		    background: transparent;
		    resize: none;
		    outline: none;
		    color: #00bafa;
		    font-weight: 900;
		    font-size: initial;
		    margin-top: 30px;
		}
		.deny {
		    border: 2px solid #A5A5A5;
		    color: #A5A5A5;
		}
		.accept:hover {
			background: #00bafa;
		    color: #fff;
		}
		.deny:hover {
			background: #A5A5A5;
		    color: #fff;
		}
	</style>
<body>
	<div class='container' style="text-align:center;">
		<div class='content' >
			<div class='profile'>
				<img src="/wiicar/resources/imgs/${profileImage}" width="300px"/> 
			</div>
			<div>
				<button class='btn accept' id="accept" style="width:40%">승인</button>
				<button class='btn deny' id="deny" style="width:40%">반려</button>		
			</div>		
		</div>
	</div>
</body>
</html>