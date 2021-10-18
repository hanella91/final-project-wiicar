<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>WIICAR | chatting</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
  <link href="/wiicar/resources/css/reset.css" rel="stylesheet" type="text/css" />
  <link href="/wiicar/resources/css/chatting.css" rel="stylesheet" type="text/css" />
  <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.2/css/bootstrap.no-icons.min.css" rel="stylesheet">
  <link href="//netdna.bootstrapcdn.com/font-awesome/3.0/css/font-awesome.css" rel="stylesheet">
   <!-- Core theme JS-->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
  <script type="text/javascript" src="/wiicar/resources/js/chat.js"></script>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <script src="/wiicar/resources/js/header.js"></script>
  <link href="/wiicar/resources/css/popup.css" rel="stylesheet" type="text/css" />
  
</head>
<script>
$(document).ready(function() {
   
   var memId = '${memId}';
   
   chatRoom(memId);
   // 시작과 동시에 chatRoomList 가져오기
   
   //chatRoomInterval(memId); 
   
   // 채팅방 나가기
   $('#deleteRoom').click(function(){
      $('.m_chat_room').animate({left:"100%"},500);
      var result = confirm("채팅방을 나가시겠습니까?");
      if(result == true){ // 확인 눌렀을때
            var roomnum = user_roomnum;
            console.log("삭제 시 roomnum ="+roomnum); 
         deleteRoom(memId, roomnum);
      }else if(result == false){ // 취소 눌렀을 때 
         alert("현 페이지를 유지합니다.");
      }
   });
   // 채팅창 height 100% 유지, 모바일 width 100% 유지
   $("#content").css({"height" : window.innerHeight});
   $(window).resize(function() {
      $("#content").css({"height" : window.innerHeight});
      console.log("width값!" + window.innerWidth)
      if(window.innerWidth <= 767) {
         $("#content").css({"min-width" : window.innerWidth});   
      }
   });
   // 입력창에서 엔터키 누르면 메세지 보내기
   $("#message-input").keyup(function(event) {
       if (event.keyCode === 13) {
           $("#send").click();
       }
   });
   // 모바일 채팅 목록 돌아가기
   $("#m_exit").click(function(){
      $('.room_wrap').animate({left:"100%"},500);
   });
   // 팝업 연결
   // 프로필 연결
   
});
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
           <li class="btn-item dropdown profile">
              <button class="btn-profile dropdown-toggle" id="dropdown-menu1" data-bs-toggle="dropdown" aria-expanded="false">
                 <span class="hidden">프로필</span><i class="arrow"></i>
              </button>
               <ul class="drop" aria-labelledby="dropdown-menu1" style="width:100px;">
                 <!-- 일반회원, 관리자회원 구분하기 -->
                  <c:if test="${sessionScope.sid != null }">
                  <c:choose>
                  	<c:when test="${memdto.subAdmin == 0 }"><li><a href="/wiicar/member/personalInformation.do" class="dropdown-item">마이페이지</a></li></c:when>
                  	<c:when test="${memdto.subAdmin == 1 }"><li><a href="#" class="dropdown-item">관리자페이지</a></li></c:when>
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
              <a class="btn-noti trigger-drop" style="text-align:left;" href="#">
                 <span class="hidden">알림</span>
                 <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notiCnt">0</span>    <!-- 알림 -->
              </a>
              <ul class="drop chat-list" style="width: 200px;">
               <li class="chat-room">
                  <input class="carpoolnum" name="carpoolnum" type="hidden" value="">
                  <input class="user_roomnum" name="user_roomnum" type="hidden" value="">
                  <input class="chatId" name="chatId" type="hidden" value="">
                  <div class="img"><div class="user_img"><img src="/wiicar/resources/imgs/profile.png" alt="" width="10px" height="10px"></div></div>
                  <div class="txt chatRoomList"><div class="user_name">driver</div><div class="message">[예약요청] 회원님이 등록하신 카풀에 새로운 예약 요청이 들어왔습니다!<br> 요청자 정보를 확인하고 수락 또는 거절을 눌러주세요! <button type="button" class="btn check_request" data-bs-toggle="modal" data-bs-target="#requestInfoPopup">예약 요청 확인하기</button></div><div class="time">오후 1:55</div></div>
               </li>
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
        <div class="m_menu m_chat_room"><button id="m_exit"></button>채팅</div>
        <div class="room-exit-wrap">
          <button id="deleteRoom">채팅방 나가기</button>
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
                <div id="chat-cover" style="position: absolute;top:0;left: 50%;transform: translateX(-50%);background-color: #fff;width: 100%;z-index: 1;line-height: 400px;">채팅방을 선택해주세요.</div>
   
               <!-- Sender Message-->
       
               <!-- Reciever Message-->
   
           </div>
        </div>
        <!-- input -->
        <div class="input-wrap">
          <input type="textarea" id="message-input" placeholder="Type a message" />
          <div class="send-btn">
            <button id="send" onclick="insertMessage()" autofocus>보내기</button>
          </div>
        </div>

       </div>
    </div>
    <jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
  </div>
</body>
</html>
   <jsp:include page="/WEB-INF/views/popup/reportPopup.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/views/popup/requestInfoPopup.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/views/popup/reserveInfoPopup.jsp"></jsp:include>
   <jsp:include page="/WEB-INF/views/popup/userProfilePopup.jsp"></jsp:include>