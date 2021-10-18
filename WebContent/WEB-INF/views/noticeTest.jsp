<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/css/bootstrap.no-icons.min.css" rel="stylesheet">
<!-- Header -->
<script>
	$(document).ready(function(){
		
		notiDisplayTest();
	})
	// **********************************
	function notiDisplayTest() {
		$.ajax({
			url : "alerts/countAllNoti.do",
			type : "post",
			success : function(data) {
				 $('#notiCnt').text(data);
				 console.log("NotiData ==> "+ data);
			}			
		})
		
		var val = parseInt($(".badge").text());		
	}
	// **********************************

</script>

<style>
	#notiCnt {
		padding-right: 6px;
		padding-left: 5px;
	    justify-content: space-between;
	    align-items: center;
	    background-color: red;
	}
</style>
<div id="header">
  <div class="wrapper">
    <div class="logo_wrap">
      <div class="logo"></div>
    </div>
    <div class="menu">
      <ul class="btn_wrap">
        <li class="btn-item dropdown profile">
	        <a class="btn-profile trigger-drop" href="#">
	        <span class="hidden">프로필</span><i class="arrow"></i>
	        </a>
	        <ul class="drop">
		      <li><a href="#">마이페이지</a></li>
		      <li><a href="#">로그아웃</a></li>
		      <!-- 관리자 일 경우 -->
		      <li><a href="#">관리자페이지</a></li>
		      <!-- 로그인 안했을 경우 -->
		      <li><a href="#">로그인</a></li>
	        </ul>
       	</li>
        <li class="btn-item"><a class="btn-search" href="#"><span class="hidden">검색</span></a></li>
        <li class="btn-item dropdown">
        	<a class="btn-noti trigger-drop " style="text-align:left;" href="#">
        		<span class="hidden">알림</span>
        		<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notiCnt"></span>
        	</a>
        	<ul class="drop">
		      <li><a href="#">새로운 메시지 없음<!-- 새로운 메시지 알람 --></a></li>
	        </ul>
        </li>
      </ul>
    </div>
  </div>
</div>

	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/wiicar/WebContent/resources/js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>

	