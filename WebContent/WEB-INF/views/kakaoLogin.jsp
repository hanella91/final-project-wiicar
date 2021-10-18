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
		
		/* 
		***********기타 정보************
		생일O
		출생X
		전화번호X
		********************************
		*/
		
		// 카카오 로그인
		Kakao.Auth.login({
			// 성공
			success : function(authObj) {
				// 회원정보 조회
				Kakao.API.request({
					url : '/v2/user/me',
					// 성공
					success : function(res) {
						// alert(JSON.stringify(res))
						// 정보 저장
						var id = res.kakao_account.email
						var name = res.kakao_account.nickname
						var gender = res.kakao_account.gender
						// 처음 로그인하는 회원인지 확인
						$.ajax({
							url : "/wiicar/ajaxKakaoLoginIdPwCheck.do",
							type : "post",
							data : {id : id, name : name, gender : gender},
							success : function(data){
								if(data == 0) {			// 처음 로그인하는 회원
									//opener.window.href = "/wiicar/signupForm.do";
									opener.location.href='http://localhost:8080/wiicar/signupForm.do'; 
									window.close();
								} else {				// 이미 회원가입한 회원
									window.location = "/wiicar/login.do";
									// opener.location.href='http://localhost:8080/wiicar/login.do'; 
									// window.close();
								}
							},
							error : function(e){
								alert("회원 조회 실패")
								window.close();
								// console.log(e)
							}
						});
						console.log(res.kakao_account.profile)
						console.log(res.kakao_account.email)
						console.log(res.kakao_account.gender)
					},
					fail : function(error) {
						alert("카카오 회원정보 조회 실패")
						window.close();
						// alert('login success, but failed to request user information: ' + JSON.stringify(error))
					},
				})
			},
			// 실패
			fail : function(err) {
				alert("카카오 로그인 실패. 다시 시도해주세요.")
				window.close();
				// alert(JSON.stringify(err))
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