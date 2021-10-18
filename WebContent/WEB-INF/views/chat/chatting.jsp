<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"">
  <title>WIICAR | chatting</title>
  <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/css/bootstrap.no-icons.min.css" rel="stylesheet">
  <link href="//netdna.bootstrapcdn.com/font-awesome/3.0/css/font-awesome.css" rel="stylesheet">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <link href="/wiicar/resources/css/reset.css" rel="stylesheet" type="text/css" />
  <link href="/wiicar/resources/css/chatting.css" rel="stylesheet" type="text/css" />
  <link href="/wiicar/resources/css/popup.css" rel="stylesheet" type="text/css" />
  <!-- Core theme JS-->
  <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
  <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
  <script type="text/javascript" src="/wiicar/resources/js/chat.js"></script>
  
</head>
<style>
.selector-for-some-widget {
  box-sizing: content-box;
}
</style>
<script>
// 채팅창 height 100% 유지, 모바일 width 100% 유지
$(window).resize(function() {
   $("#content").css({"height" : window.innerHeight});
   //console.log("width값!" + window.innerWidth)
   if(window.innerWidth <= 767) {
      $("#content").css({"min-width" : window.innerWidth});   
   }
});
$(document).ready(function() {
   
   $("#content").css({"height" : window.innerHeight});
   
   notiDisplayTest(); // 채팅 알림

   var nickname = '${sid}';
   var user_roomnum = '${roomnum}';
   var carpoolnum = '${carpoolnum}';
   var chatId = '${chatId}';
   
$(document).ready(function() {
   
   $("#profileBtn").click(function() {
      console.log("헤더 메뉴 클릭");
        if($("#profileMenu").hasClass("open")){
           $()
            $("#profileMenu").removeClass('open');
        } else {
           $("#profileMenu").addClass("open");
        }
   });
   
   $("#content").css({"height" : window.innerHeight}); 
   
   if(user_roomnum == null){
      chatRoom(nickname);
      //chatRoomInterval(nickname);
   }
   if(user_roomnum != null){
      chatRoom(nickname);
      //chatRoomInterval(nickname);
   }

        $("#chat-cover").hide();
        if($(this).hasClass("not-read")){
           $(this).removeClass('not-read');
           $(this).find("span.circle").remove();
        }
      
      var idx = $("#chatListWrap li."+carpoolnum).index();
      if(window.innerWidth <= 767) {
           $('#content .list_wrap span.selected').css({'display':'block','top': (idx * 90)});
        } else {
           $('#content .list_wrap span.selected').css({'display':'block','top':112 + (idx * 90)});
        }

    $('.room_wrap').animate({left:0},500);
      
   });
   
   // 입력창에서 엔터키 누르면 메세지 보내기
   $("#message-input").keyup(function(event) {
       if (event.keyCode === 13) {
           $("#send").click();
       }
   });
   // 팝업 연결
   // 프로필 연결
   $('.modal').click(function(event){
       $(event.target).modal('hide');
   });
});


//채팅방 나가기
function deleteRoomCheck() {
   var result = confirm("채팅방을 나가시겠습니까?");
   console.log("result =====> "+ result);
   if(result == true){ // 확인 눌렀을때
      var roomnum = $('li.chat_list').children('.user_roomnum').val();
      var nickname ='${sid}';
      console.log("삭제시 nickname =" + nickname);
      console.log("삭제시 roomnum ="+roomnum); 
      $('.m_chat_room').animate({left:"100%"},500);
      deleteRoom(nickname, roomnum);
   }else if(result == false){ // 취소 눌렀을 때 
      alert("현 페이지를 유지합니다.");
   }
}

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
                      <c:when test="${memdto.subAdmin == 0 }">
                      <li><a href="/wiicar/member/personalInformation.do" class="dropdown-item">마이페이지</a></li></c:when>
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
              <a class="btn-noti trigger-drop" style="text-align:left;" href="/wiicar/carpool/chatting.do">
                <span class="hidden">알림</span>
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notiCnt"></span>    <!-- 알림 -->
              </a>
              <ul class="drop chat-list" style="width: 250px;">
              <!-- ajax append -->
              </ul>
            </li>
           </ul>
        </div>
      </div>
    </div>
    <!-- 채팅 -->
    <div id="content">
      <!-- 채팅 리스트 부분 -->
      <div class="list_wrap m_cart m_chat_list">
          <span class="selected"></span>
        <ul id="chatListWrap" class="chat_wrap">
          <!-- 대화방 1개 (li) -->
          <!-- chat_list는 공통적으로 모든 대화방이 가지고 있는 class
              not-read는 읽지않은 메세지가 왔을 경우 추가해주어야하는 class
              selected는 li를 선택하는 경우 주어야하는 class
          -->
         
        </ul>
      </div>
      <!-- 채팅 내용 부분 -->
      <div class="room_wrap">
        <!-- 모바일에서 사용하는 채팅 내용에서 리스트로 돌아가는 버튼 -->
        <div class="m_chat_room">
           <h3>채팅</h3>
           <button id="m_exit" onclick="$('.room_wrap').animate({left:'100%'},500);"></button>
        </div>
        <div class="room-exit-wrap">
          <button id="deleteRoom" onclick="deleteRoomCheck();"></button>
        </div>
        <hr class="m"/>
        <div class="scroll-box">

           <!-- 채팅 내용 -->
           <!-- 신고하기 버튼 (팝업 연결 필요) 
           <button id="user-report"><img src="/wiicar/resources/imgs/exclamation-mark.png" alt="신고하기 아이콘" />신고</button> -->
           <div class="room">
             <!-- 채팅 유저 정보 표시 -->
             <div class="user-wrap">
               <!-- 유저 프로필 -->
               <!-- 유저 닉네임 / 평점 / 카풀완료횟수 표시
                   운전자일 경우 운전자평점 / 탑승자일 경우 탑승자 평점 표시
               -->
             </div>
             <hr class="line"/>
             <div class="carpool-wrap"></div>      
           </div>
           <hr />
   
           <div class="chat-content" id="chatListView">
                <div id="cover">채팅방을 선택해주세요.</div>
   
               <!-- Sender Message-->
       
               <!-- Reciever Message-->
   
           </div>
        </div>
        <!-- input -->
        <div class="input-wrap">
          <input type="textarea" id="message-input" placeholder="Type a message" />
          <div class="send-btn">
            <button id="send" onclick="insertMessage()" autofocus></button>
          </div>
        </div>

       </div>
    </div>
    <jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
  </div>
<jsp:include page="/WEB-INF/views/popup/requestInfoPopup.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/popup/reserveInfoPopup.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/popup/reportPopup.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/popup/userProfilePopup.jsp"></jsp:include>
</body>
</html>