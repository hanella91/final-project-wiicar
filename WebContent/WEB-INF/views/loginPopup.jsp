<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WIICAR - 로그인</title>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
        // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('c261eec144799d44fa2eff2eaa350aec');
		
/*         Kakao.Auth.authorize({
        	redirectUri: 'http://localhost:8080/wiicar/kakaoLogin.do'
        })
 */        // SDK 초기화 여부를 판단합니다.
        console.log(Kakao.isInitialized());
    </script>
    
    <style>
    	.container {
	    	position: relative;
		    margin: 40px auto;
		    padding: 58px 69px 139px;
		    border: 1px solid #e5e5e5;
		    border-radius: 2px;
		    box-sizing: border-box;
		    display: block;
    	}
    	.content {
    		display: block;
		    padding-top: 20px;
		    color: #252525;
		    font-weight: normal;
		    text-align: center;
    	}
    	.loginButton {
    		padding: 30px;
    	}
    	hr {
    	    border:0;
   		 	margin:0;
	    	width:100%;
	    	height:2px;
    		background-color: #e5e5e5;
    	}
    </style>
</head>
<body>
	<div class=container>
		<div class=content>
			<div style="font-size: 28px;"> 로그인 </div>
			<div style="padding: 10px"><hr></div>
			<div class="loginButton">
				<a id="custom-login-btn" href="/wiicar/kakaoLogin.do"> 
					<img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222" />
				</a>
			</div>
			<div style="font-size: 18px;">
				<div class="col-sm-3"><button type="button" style="border:none;border-radius:5px;width:150px;height:30px;color:white;background-color:#3498DB;" onclick="window.location='/wiicar/loginPage.do'">일반 로그인</button></div>
				<div> <a href="https://accounts.kakao.com/weblogin/create_account#selectVerifyMethod">카카오 회원가입하기</a></div>
			</div>
		</div>
	</div>


	<!-- 로그인1 
	<script type="text/javascript">
		function loginWithKakao() {
			Kakao.Auth.login({
				success : function(authObj) {
					alert(JSON.stringify(authObj))
					Kakao.API.request({
						url : '/v2/user/me',
						success : function(res) {
							alert(JSON.stringify(res))
						},
						fail : function(error) {
							alert('login success, but failed to request user information: '
									+ JSON.stringify(error))
						},
					})
				},
				fail : function(err) {
					alert(JSON.stringify(err))
				},
			})
		}
	</script>-->
</body>
</html>