<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>WIICAR - 너도나도우리모두카풀!</title>
  <link href="/wiicar/resources/css/reset.css" rel="stylesheet"type="text/css" />
  <link href="/wiicar/resources/css/main.css" rel="stylesheet"type="text/css" />
  <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/css/bootstrap.no-icons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"> <!-- 캘린더 css -->
  <link href="//netdna.bootstrapcdn.com/font-awesome/3.0/css/font-awesome.css" rel="stylesheet">
</head>
<style>
#container #footer a#adminlog {display:block !important; position: absolute; right: 50px; border: 1px solid;}
</style>
<script src="https://cdn.jsdelivr.net/npm/geolib@3.3.1/lib/index.min.js"></script> <!-- geolib 라이브러리설치 -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script> <!-- 캘린더 다운로드 -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('c261eec144799d44fa2eff2eaa350aec');
  $(document).ready(function(){
	$("#profileBtn").click(function() {
		console.log("헤더 메뉴 클릭");
        if($("#profileMenu").hasClass("open")){
        	$()
            $("#profileMenu").removeClass('open');
        } else {
        	$("#profileMenu").addClass("open");
        }
	});
	notiDisplayTest();
	
    //캘린더 오픈소스
    flatpickr("input[name=time]", {
       enableTime: false,
       minDate: "today",
       dateFormat: "Y-m-d",
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
    
    $("#loginBtn").click(function(){
    	const url = "/wiicar/loginPopup.do";
		const name = "로그인";
		var popupWidth = 700;
		var popupHeight = 500;
		var popupX = (window.screen.width/2) - (popupWidth/2);
		var popupY= (window.screen.height/2) - (popupHeight/2);
		var option = 'height =' + popupHeight + ', width=' + popupWidth + ', top =' + popupY + ', left =' + popupY + ', location = no';
		window.open(url, name, option);    	
    }) 
    
    
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
    
    //검색 결과 ajax로 보내서 위도/경도 구해오는 함수

    $("#searchFormSubmit").click(function(event){
     	event.preventDefault(); //도착지, 날짜도 입력 후 submit해야하니까 요청이 끝나도 페이지새로고침이 없도록 잡아줌
        $.ajax({
          method : "GET",
          url : "https://apis.openapi.sk.com/tmap/geo/fullAddrGeo?version=1&format=json&callback=result",
          async : false,
          data : {
             "appKey" : "l7xxcbda6a9d9b9241f699b4eacec5b60cf1",
             "coordType" : "WGS84GEO",
             "fullAddr" : $("input[name=depart]").val()
          },
          success : function(response) {
             const lat = response.coordinateInfo.coordinate[0].lat.length ? 
                response.coordinateInfo.coordinate[0].lat : response.coordinateInfo.coordinate[0].newLat;
             const lon = response.coordinateInfo.coordinate[0].lon.length ? 
                  response.coordinateInfo.coordinate[0].lon : response.coordinateInfo.coordinate[0].newLon;
             
             const departBounds = geolib.getBoundsOfDistance( 
                    { latitude: lat, longitude: lon },
                    5000
                );
             
             const departSwBounds = departBounds[0];
             const departNeBounds = departBounds[1];
             
           $("input[name=depart_lat]").val(lat);
           $("input[name=depart_lon]").val(lon);
           $("input[name=depart_sw_bound_lat]").val(departSwBounds.latitude);
           $("input[name=depart_sw_bound_lon]").val(departSwBounds.longitude);
           $("input[name=depart_ne_bound_lat]").val(departNeBounds.latitude);
           $("input[name=depart_ne_bound_lon]").val(departNeBounds.longitude);
           
          }
        })
		
       $.ajax({
        method : "GET",
        url : "https://apis.openapi.sk.com/tmap/geo/fullAddrGeo?version=1&format=json&callback=result",
        async : false,
        data : {
           "appKey" : "l7xxcbda6a9d9b9241f699b4eacec5b60cf1",
           "coordType" : "WGS84GEO",
           "fullAddr" : $("input[name=destination]").val()
        },
        success : function(response) {
             const lat = response.coordinateInfo.coordinate[0].lat.length ? 
				response.coordinateInfo.coordinate[0].lat : response.coordinateInfo.coordinate[0].newLat;
             const lon = response.coordinateInfo.coordinate[0].lon.length ? 
				response.coordinateInfo.coordinate[0].lon : response.coordinateInfo.coordinate[0].newLon;
                   
			 const destinationBounds = geolib.getBoundsOfDistance( 
				{latitude: lat, longitude: lon},
                 5000
			 );
                  
			 const destinationSwBounds = destinationBounds[0];
			 const destinationNeBounds = destinationBounds[1];
                  
			 $("input[name=destination_lat]").val(lat);
			 $("input[name=destination_lon]").val(lon);
			 $("input[name=destination_sw_bound_lat]").val(destinationSwBounds.latitude);
			 $("input[name=destination_sw_bound_lon]").val(destinationSwBounds.longitude);
			 $("input[name=destination_ne_bound_lat]").val(destinationNeBounds.latitude);
			 $("input[name=destination_ne_bound_lon]").val(destinationNeBounds.longitude);
        }         
      });
     		$("#searchForm").submit();
    });
    
	function notiDisplayTest() {
		$.ajax({
			url : "alerts/countAllNoti.do",
			type : "post",
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
	} //notiDisplayTest	
  }); // document
  
	//검색 유효성
	function check(){
		var depart = $('#depart').val();
		var destination = $('#destination').val();
		var time = $('#time').val();
		console.log("depart == > "+ depart);
		console.log("destination == > "+ destination);
		console.log("time == > "+ time);
		if(depart == ''){
			alert("출발지를 입력하세요.");
			return false;
		}
		if(destination ==''){
			alert("도착지를 입력해주세요.")
			return false;
		}
		if(time ==''){
			alert("날짜를 입력해주세요.")
			return false;
		}
	}; // checkForm


</script>
<body>
   <div id="container">
      <!-- Header -->
      <div id="header">
        <div class="wrapper">
          <div class="logo_wrap">
            <div class="logo"><a href="/wiicar/home.do"></a></div>
          </div>
          <div class="menu">
            <ul class="btn_wrap">      
              <li id="profileBtn" class="btn-item dropdown profile">
                 <button class="btn-profile dropdown-toggle">
                    <span class="hidden">프로필</span><i class="arrow"></i>
                 </button>
                 <ul id="profileMenu" class="drop">
                 <!-- 일반회원, 관리자회원 구분하기 -->
                  <c:if test="${sessionScope.sid != null }">
                  <c:choose>
                  	<c:when test="${memdto.subAdmin == 0 }"><li><a href="/wiicar/member/personalInformation.do" class="dropdown-item">마이페이지</a></li></c:when>
                  	<c:when test="${memdto.subAdmin == 1 }">
                  	<li><a href="/wiicar/member/personalInformation.do" class="dropdown-item">마이페이지</a></li>
                  	<li><a href="/wiicar/admin/memberInfo.do" class="dropdown-item">관리자페이지</a></li></c:when>
                  </c:choose>
                  <li><a id="logoutBtn" class="dropdown-item">로그아웃</a></li>
                  </c:if>
                  <c:if test="${sessionScope.sid == null }">
                  <!-- 로그인 안했을 경우 -->
                  <li><a id="loginBtn" class="dropdown-item">로그인</a></li>
                  </c:if>
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
                 		<!-- ajax append추가 -->
                 </ul>
              </li>
            </ul>
          </div>
        </div>
      </div>
   
      <!-- content -->
      <div id="content">


         <!-- 검색바 -->
         <div id="search-bar" class="page-start">
            <form id="searchForm" action="carpool/searchList.do" method="get" onsubmit="return check();">
               <div class="start">
                  <input name="depart_lat" type="hidden" /> 
                  <input name="depart_lon" type="hidden" /> 
                  <input name="depart_sw_bound_lat" type="hidden" /> 
                  <input name="depart_sw_bound_lon" type="hidden" /> 
                  <input name="depart_ne_bound_lat" type="hidden" /> 
                  <input name="depart_ne_bound_lon" type="hidden" /> 
                  <input id="depart" name="depart" type="text" placeholder="출발지"> 
               </div>
               <div class="end">
                  <input name="destination_lat" type="hidden" /> <input name="destination_lon" type="hidden" /> 
                  <input name="destination_sw_bound_lat" type="hidden" /> 
                  <input name="destination_sw_bound_lon" type="hidden" /> 
                  <input name="destination_ne_bound_lat" type="hidden" /> 
                  <input name="destination_ne_bound_lon" type="hidden" /> 
                  <input id="destination" name="destination" type="text" placeholder="도착지"> 
               </div>
               <div class="date">
                  <input id="time" name="time" type="text" placeholder="날짜"> 
               </div>               
               <input id="searchFormSubmit" type="submit" class="search-btn"
                  value="검색"/>
                  
            </form>
         </div>

         <!-- 메인이미지 -->
         <div id="main-img">
            <p class="title">
               <span class="txt1">함께 퇴근해요,</span>
               <br />
               <span class="txt2">WIICAR!</span>
            </p>
            <div class="main-btn">
            <!-- 운전자 승인 한 사람만 등록 가능하게 -->
             <c:if test="${memdto.permit == 2 }">
               <p class="txt">지금 손쉽게 카풀 등록하세요!</p>
               <div class="reg_btn">
                  <a href="/wiicar/carpool/registerForm.do" class="cta"> <span>카풀등록하러가기</span> <svg
                        width="20px" height="20px" viewBox="0 0 13 10">
              <path d="M1,5 L11,5"></path>
              <polyline points="8 1 12 5 8 9"></polyline>
            </svg>
                  </a>
               </div>
               </c:if>
            </div>
         </div>

         <!-- 추천 경로 -->
         <div id="route">
            <p class="txt">추천 경로</p>
            <ul class="articles">
            <c:forEach begin="1" end="3" items="${recomdto }" var="recomm">
               <li class="articles__article" style="-animation-order: 3"><a
                  class="articles__link">
                     <div class="articles__content articles__content--lhs">
                        <div class="articles__title">${recomm.depart}  >  ${recomm.destination }</div>
                        <div class="articles__footer">
                           <p>예상금액</p>
                           <time>${recomm.price }원</time>
                        </div>
                     </div>
                     <div class="articles__content articles__content--rhs"
                        aria-hidden="true">
                        <div class="articles__title">${recomm.depart}  >  ${recomm.destination }</div>
                        <div class="articles__footer">
                           <p>평균금액</p>
                           <time>${recomm.price }원</time>
                        </div>
                     </div>
               </a></li>
            </c:forEach>
            </ul>
         </div>
      </div>

      <!-- 푸터 -->
      <jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
   </div>
</body>

</html>
