<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> 로그인 </title>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
        // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('c261eec144799d44fa2eff2eaa350aec');

        // SDK 초기화 여부를 판단합니다.
        console.log(Kakao.isInitialized());
    </script>
</head>
  
<body>
	<!-- 로그인1 버튼 -->
	<a id="custom-login-btn" href="javascript:loginWithKakao()">
	  <img
	    src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg"
	    width="222"
	  />
	</a>
	<p id="token-result"></p>
	


	<!-- 로그아웃 버튼 -->
	<button class="api-btn" onclick="kakaoLogout()">로그아웃</button>
	
	<!-- 탈퇴 -->
	<button class="api-btn" onclick="unlinkApp()">앱 탈퇴하기</button>
	
	<!-- 메인으로 -->
	<button class="api-btn" onclick="window.location='/wiicar/kakaoLogin.do'">카카오 로그인</button>
	
	
	<!-- 로그인1 -->
	<script type="text/javascript">
	  function loginWithKakao() {
	    Kakao.Auth.login({
	      success: function(authObj) {
	        alert(JSON.stringify(authObj))
	      },
	      fail: function(err) {
	        alert(JSON.stringify(err))
	      },
	    })
	  }
	</script>
	  
	
	<!-- 로그아웃 -->
	<script type="text/javascript">
	  function kakaoLogout() {
	    if (!Kakao.Auth.getAccessToken()) {
	      alert('Not logged in.')
	      return
	    }
	    Kakao.Auth.logout(function() {
	      alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken())
	    })
	  }
	</script>
	
	<!-- 탈퇴 -->
	<script type="text/javascript">
	  function unlinkApp() {
	    Kakao.API.request({
	      url: '/v1/user/unlink',
	      success: function(res) {
	        alert('success: ' + JSON.stringify(res))
	        kakaoLogout();
	      },
	      fail: function(err) {
	        alert('fail: ' + JSON.stringify(err))
	      },
	    })
	  }
	</script>

</body>
</html>

<%-- 
	<!-- 카카오 다른 계정 로그인 버튼 -->
	<a id="reauthenticate-popup-btn" href="javascript:loginFormWithKakao()">
	  <img
	    src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg"
	    width="222"
	  />
	</a>
	<p id="reauthenticate-popup-result"></p>

	<!-- 카카오 다른 계정 로그인 스크립트 -->
	<script type="text/javascript">
	  function loginFormWithKakao() {
	    Kakao.Auth.loginForm({
	      success: function(authObj) {
	        showResult(JSON.stringify(authObj))
	      },
	      fail: function(err) {
	        showResult(JSON.stringify(err))
	      },
	    })
	  }
	  function showResult(result) {
	    document.getElementById('reauthenticate-popup-result').innerText = result
	  }
	</script>

 --%>









