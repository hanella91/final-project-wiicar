<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link href="/wiicar/resources/css/reset.css" rel="stylesheet"type="text/css" />
    <link href="/wiicar/resources/css/chatting.css" rel="stylesheet"type="text/css" />
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/css/bootstrap.no-icons.min.css" rel="stylesheet">
	<link href="//netdna.bootstrapcdn.com/font-awesome/3.0/css/font-awesome.css" rel="stylesheet">
    
	<!-- Bootstrap core JS-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/wiicar/resources/js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
  $(document).ready(function(){
    var header = $('#header'); //헤더를 변수에 넣기
    var page = $('.page-start'); //색상이 변할 부분
    var pageOffsetTop = page.offset().top;//색상 변할 부분의 top값 구하기
    
    $(window).resize(function(){ //반응형을 대비하여 리사이즈시 top값을 다시 계산
      console.log('aa');
      pageOffsetTop = page.offset().top;
    });
    
    //캘린더 오픈소스
    flatpickr("input[name=time]", {
    	enableTime: false,
    	dateFormat: "Y-m-d",
    });
    
    $(window).on('scroll', function(){ //스크롤시
      var scrolled = $(window).scrollTop() >= pageOffsetTop; //스크롤된 상태; true or false
      header.toggleClass('down', scrolled); //클래스 토글
    });

    function Utils() {}
    Utils.prototype = {
        constructor: Utils,
        isElementInView: function (element, fullyInView) {
          var pageTop = $(window).scrollTop();
          var pageBottom = pageTop + $(window).height();
          var elementTop = $(element).offset().top;
          var elementBottom = elementTop + $(element).height();

          if (fullyInView === true) {
              return ((pageTop < elementTop) && (pageBottom > elementBottom));
          } else {
              return ((elementTop <= pageBottom) && (elementBottom >= pageTop));
          }
        }
    };

    var Utils = new Utils();
    $(window).on('load', addFadeIn());
    
    $(window).scroll(function() {
        addFadeIn(true);
    });

    function addFadeIn(repeat) {
      var classToFadeIn = ".will-fadeIn";
        
      $(classToFadeIn).each(function( index ) {
        var isElementInView = Utils.isElementInView($(this), false);
        if (isElementInView) {
          if(!($(this).hasClass('fadeInRight')) && !($(this).hasClass('fadeInLeft'))) {
            if(index % 2 == 0) $(this).addClass('fadeInRight');
            else $(this).addClass('fadeInLeft');
          }
        } else if(repeat) {
          $(this).removeClass('fadeInRight');
          $(this).removeClass('fadeInLeft');
        }
      });
    }
    
    
  });
</script>

<script>
	//SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('c261eec144799d44fa2eff2eaa350aec');
	// SDK 초기화 여부를 판단합니다.
	console.log(Kakao.isInitialized());
	
	$(document).ready(function(){
		
		MemberCheck();
		
		// 알림 
		notiShow();
		
		// 로그인 팝업
		$("#loginBtn").click(function(){
			const url = "/wiicar/loginPopup.do";
			const name = "로그인";
			var popupWidth = 700;
			var popupHeight = 500;
			var popupX = (window.screen.width/2) - (popupWidth/2);
			
			var popupY= (window.screen.height/2) - (popupHeight/2);
			var option = 'height =' + popupHeight + ', width=' + popupWidth + ', top =' + popupY + ', left =' + popupY + ', location = no';
			window.open(url, name, option);
		});
		
		// 로그아웃
		$("#logoutBtn").click(function(){
			if (!Kakao.Auth.getAccessToken()) {

			} else{
				Kakao.Auth.logout(function() {
					
				})	
			}
			$.ajax({
				url: "/wiicar/logout.do",
				type: "post"
			});
			alert("로그아웃 성공");
			
			window.location="/wiicar/home.do";
		});
		
	})
	
	function MemberCheck(){
		console.log("sid ==> " + '${sessionScope.sid}');
		$.ajax({
			url : '/wiicar/member/memberCheck.do',
			type : 'POST',
			success:function(data){
				console.log("data ==> "+data);
                <!-- 일반회원, 관리자회원 구분하기 -->
                if('${sid}' == null || '${sid}' == ''){
	                <!-- 로그인 안했을 경우 -->
                	$('#myPageBtn').hide();
                	$('#logoutBtn').hide();
                	$('#adminBtn').hide();
	            } else {
                	if(data.subAdmin == 0 ){
                    	$('#adminBtn').hide();
               	 	}
                	$('#loginBtn').hide();
                }
			},
			error:function(){
				alert("다시시도해 주세요.");
			}
			
		}); // ajax
	} // MemberCheck;	
		
	// 알림 갯수 확인 후 출력
	function notiShow() {
		$.ajax({
			url : "/wiicar/alerts/countAllNoti.do",
			type : "POST",
			success : function(data) {
				 $('#notiCnt').text(data.alertCnt);
				 console.log("총 개수 !! ==> "+ data.alertCnt);
				 console.log("size !! ==> "+ data.qSize);
				 console.log("List.length !! ==> "+ data.alertList.length);
				 for(var i=0;i<data.qSize;i++){
				 var html="";
				 html+="<li class='chat-room'>";
				 html+="<input class='carpoolnum' name='carpoolnum' type='hidden' value='"+data.alertList[i].carpoolnum+"'>"
				 html+="<input class='user_roomnum' name='user_roomnum' type='hidden' value='"+data.alertList[i].chatRoom+"'>"
				 html+="<input class='chatId' name='chatId' type='hidden' value='"+data.alertList[i].opp+"'>"
				 html+="<div class='img'><div class='user_img'><img src=''/wiicar/resources/imgs/profile.png' alt='' width='10px' height='10px'></div></div>"
				 html+=" <div class='txt chatRoomList'><div class='user_name'>"+data.alertList[i].opp+"</div>";
				 html+="<div class='message'>"+data.alertList[i].lastChat+"<span class='position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger alertNotiBadge'>"+data.alertList[i].unreadMsg+"</span>"
				 html+="<div class='time'>"+new Date(data.alertList[i].reg).toLocaleString().substring(0, 15)+"</div></div>";
                 html+="</li>";
                 
                 $('.chat-list').append(html);
				 }
				 $('.chat-room').click(function(){
					 var carpoolnum = $(this).find('.carpoolnum').val();
					 var user_roomnum = $(this).find('.user_roomnum').val();
					 var chatId = $(this).find('.chatId').val();
					 window.location="/wiicar/carpool/chatting.do?roomnum="+user_roomnum+"&chatId="+chatId+"&carpoolnum="+carpoolnum+"";
				 });// chat-room'
			}			
		}); // ajax	
	}
</script> 
<style>
	#notiCnt {
		padding-right: 6px;
		padding-left: 5px;
	    justify-content: space-between;
	    align-items: center;
	    background-color: red;
	}
	
	.alertNotiBadge {
		padding-right: 6px;
		padding-left: 5px;
	    justify-content: space-between;
	    align-items: center;
	    background-color: red;
	}
</style>

<!-- Header -->
<div id="header">
  <div class="wrapper">
    <div class="logo_wrap">
      <div class="logo"><a href="/wiicar/home.do"></a></div>
    </div>
    <div class="menu">
      <ul class="btn_wrap">      
        <li class="btn-item dropdown profile">
	        <button class="btn-profile dropdown-toggle" id="dropdown-menu1" data-bs-toggle="dropdown" aria-expanded="false">
	        	<span class="hidden">프로필</span><i class="arrow"></i>
	        </button>
	        <ul class="drop" aria-labelledby="dropdown-menu1">
		      <li id="myPageBtn"><a href="/wiicar/member/personalInformation.do" class="dropdown-item">마이페이지</a></li>
		      <!-- 관리자 일 경우 -->
		      <li id ="adminBtn" ><a href="/wiicar/admin/memberInfo.do" class="dropdown-item">관리자페이지</a></li>
		      <li id="logoutBtn"><a class="dropdown-item">로그아웃</a></li>
		      <!-- 로그인 안했을 경우 -->
		      <li id="loginBtn"><a class="dropdown-item">로그인</a></li>
	        </ul>
       	</li>
        <li class="btn-item dropdown">
       			<c:if test="${sid != null  }">  
                 <a class="btn-noti trigger-drop" style="text-align:left;" href="/wiicar/carpool/chatting.do">
                    <span class="hidden">알림</span>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notiCnt"></span>    <!-- 알림 -->
                 </a>
                </c:if>
                 <ul class="drop chat-list" style="width: 250px;">
                 		<!-- ajax append 추가부분 -->
                 </ul>
        </li>
      </ul>
    </div>
  </div>
  
</div>


	


		
   