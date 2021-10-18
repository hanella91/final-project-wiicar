<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('c261eec144799d44fa2eff2eaa350aec');
		
		Kakao.API.request({
			url : '/v2/user/me',
			// 성공
			success : function(res) {
				// alert(JSON.stringify(res))
				// 정보 저장
				var id = res.kakao_account.email
				$.ajax({
						url : "/wiicar/sessionId.do",
						type : "post",
						data : {id : id},
						complete : function() {
							opener.location.reload();
							window.close();
						}
				})
			},		
			fail : function(error) {
				alert("카카오 정보 조회 실패")
				window.close();
				// alert('login success, but failed to request user information: ' + JSON.stringify(error))
			},
		})

		/*
		// 회원가입으로 정보 담아서 POST방식으로 보내기
		function signup_post(id, name, gender) {
			var form = document.createElement("form");
			var parm = new Array();
			var input = new Array();
			
			form.action = "wiicar/signup.do";
		    form.method = "post";
			
		    parm.push( ['id', id] );
	        parm.push( ['name', name] );
	        parm.push( ['gender', gender] );
		    
		    for (var i = 0; i < parm.length; i++) {
	            input[i] = document.createElement("input");
	            input[i].setAttribute("type", "hidden");
	            input[i].setAttribute('name', parm[i][0]);
	            input[i].setAttribute("value", parm[i][1]);
	            form.appendChild(input[i]);
	        }
			
		    document.body.appendChild(form);
		    form.submit();
		}
		*/
	</script>
</head>
<body>

</body>
</html>