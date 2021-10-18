var toggle = false;
var handle = null;
var carpoolnum = "";

function appendList(data, nickname) {
    var html ="";
   for(var i =0;i<data.length;i++){
        console.log(data[i].unreadCnt);
      var date = setTime(data[i].reg);
      if(data[i].mes_check == '0'){
            html+="<li class='chat_list not-read "+data[i].carpoolnum+" "+data[i].roomnum+"'>";   
           html+="<span class='circle'></span>";
       }else if(data[i].mes_check != '0'){
          html+="<li class='chat_list "+data[i].carpoolnum+"'>";                          
       }
       
      html+="<input class=carpoolnum name='carpoolnum' type='hidden' value='"+data[i].carpoolnum+"'/>";
      html+="<input class=user_roomnum name='user_roomnum' type='hidden' value='"+data[i].roomnum+"'/>";
      html+="<input class=nickname name='nickname' type='hidden' value='"+nickname+"'/>";
      if(data[i].sender == nickname){
         html+="<input class=chatId name='chatId' type='hidden' value='"+data[i].receiver+"'/>";
      }else if(data[i].sender != nickname){
         html+="<input class=chatId name='chatId' type='hidden' value='"+data[i].sender+"'/>";
      }
   
      // <!-- 유저 이미지 -->
      html+="<div class='img'>";
      html+="</div>";
      // <!-- 내용(유저이름/내용/시간) -->
      html+="<div class='txt chatRoomList'>";
      html+="<div class='user_name'>";
      
      if(data[i].sender == nickname){
         html+=data[i].receiver;
      }else if(data[i].sender != nickname){
         html+=data[i].sender;
      }
      
      html+="</div>";
      html+="<div class='message'><div class='txt'>"+data[i].message+"</div></div>";
      html+="<div class='time'>"+date+"</div></div>";
    }
   return html;
}

// 채팅방 리스트
function chatRoom(nickname){
    //console.log("chatRoom 불러오기");
    $.ajax({
       url : "chatRoom.do",
       type : "POST",
       data : nickname,
       async: false,
       contentType : 'application/json;charset=UTF-8',
       success:function(data){
          var length = data.length;
          var html ="";
          if(length == 0 ){
             html+="<div style='width:60%; margin:0 auto; padding-top:200px; font-weight: 700; font-size: 2rem;'>존재하는채팅방이 없습니다.</div>";
             $('#content').empty();
             $("#content").append(html);
          }else if (length != 0){
             html = appendList(data, nickname);
               
             $('.chat_wrap').empty();
             $('.chat_wrap').append(html);
             
             $('#chatListWrap li.chat_list').click(function(e){
               console.log("클릭이벤트 " + handle);
               $("#chat-cover").hide();
               $(".input-wrap").css("display","inline-flex")
               if($(this).hasClass("not-read")){
                  $(this).removeClass('not-read');
                  $(this).find("span.circle").remove();
               }
               
              carpoolnum = $(this).children(".carpoolnum").val();
              var user_roomnum = $(this).children(".user_roomnum").val();
              var nickname = $(this).children(".nickname").val();
              var chatId = $(this).children(".chatId").val();
             // chatViewInterval(chatId, user_roomnum, nickname,carpoolnum);
              console.log("chatView 바로전 ");
              chatView(chatId,user_roomnum,nickname, carpoolnum);
              console.log("interval 후 " + handle);
              
              var idx = $(this).index();
              if(window.innerWidth <= 767) {
                 $('#content .list_wrap span.selected').css({'display':'block','top': (idx * 90)});
              } else {
                 $('#content .list_wrap span.selected').css({'display':'block','top':112 + (idx * 90)});
              }
               
               $('.room_wrap').animate({left:0},500);
             });
          }
       },
       error:function(){   
       }
    });
 } // chatRoom

//1초마다 db 불러오기(유찬)
function chatRoomInterval(nickname){
   setInterval(function() {
         chatRoom(nickname);
   },500);
}

function chatViewInterval(chatId, user_roomnum, nickname, carpoolnum) {
   console.log(user_roomnum + " / " + nickname + " / " + chatId + " / " + carpoolnum);
   if(handle == null) {
      //console.log("handle null!!!!!!!");
      handle = setInterval(function(){
         chatView(chatId,user_roomnum,nickname, carpoolnum);
      },500);
   } else {
      //console.log("stopInterval!!!!!!");
      stopInterval(handle);
      chatViewInterval(chatId, user_roomnum, nickname, carpoolnum);
   }
}
function stopInterval() {
   clearInterval(handle);
   handle=null;
}
//채팅내역 보여주기(유찬)
function chatView(chatId, user_roomnum, nickname, carpoolnum){
    
    $.ajax({
       url : 'chatListView.do',
       type: 'POST',
       data: user_roomnum,
       async: false,
       contentType: 'application/json;charset=UTF-8' ,
       success: function(data){
//           console.log("채팅내역 불러오기 성공")
           var length = data.length;
           var html ="";
           for(var i=0;i<length;i++){
                var date = setTime(data[i].reg);
             
                //<!-- Reciever Message-->
                //sender가 세션 ID가 아닐때 => receiver일때
                if(data[i].sender != nickname){   
                   html+="<input id='senderId' type='hidden' value='"+data[i].sender+"'/>";
                   html+="<input id='user_roomnum' type='hidden' value='"+data[i].roomnum+"'/>";
                   html+="<div class='message-wrap sender'>";
                   html+="<div class='message-box'>";
                   html+=" <p class='contents'>"+data[i].message+"</p>";
                   html+="</div>";
                   html+="<p class='time'>"+date+"</p>";
                   html+="</div>";
                }
                // <!-- Sender Message-->
                // sender가 세션 ID일때 => sender일때
                if(data[i].sender == nickname){
                   html+="<input id='receiverId' type='hidden' value='"+data[i].receiver+"'/>";
                   html+="<div class='message-wrap reciever'>";
                   html+="<div class='message-box'>";
                   html+="<p class='contents'>"+data[i].message+"</p>";
                   html+="</div>";
                   html+="<p class='time'>"+date+"</p>";
                   html+="</div>";
                }
           }
           $('#chatListView').empty();
           $('#chatListView').append(html);
           $('#chatListView').scrollTop($('#chatListView')[0].scrollHeight);
           
           requestCheck(chatId,carpoolnum,nickname,user_roomnum);
           
             $(".check_request").click(function() {
             console.log("예약요청하기버튼클릭!");
             $("#requestInfoPopup").show();
          });
           
          // 예약 요청 확인
          requestCheck(chatId,carpoolnum,nickname,user_roomnum);

          // 채팅방 유저 정보 가져오기
           chatUser(chatId, carpoolnum);
           getCarpool(carpoolnum);
           
           
       },
       error:function(request, status, error){
         console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       }
    });// ajax   
} // chatView

//날짜 비교
function isSameDay(today, setday) {
     return today.getFullYear() === setday.getFullYear() && today.getMonth() === setday.getMonth() && today.getDate() === setday.getDate();
}

//시간 설정
function setTime(date) {
     var dt = new Date(date);
     var hrs = dt.getHours();
     var hours = hrs % 12;
     var mins = '0' + dt.getMinutes();
     var minutes = mins.slice(-2);
     var secs = '0' + dt.getSeconds();
     var amPm = hrs< 12 ? '오전' : '오후';
     var time = amPm+ " " + hours + ":" + minutes; 

     if (isSameDay(new Date(), dt)) {
        return time;
     } else {        
        return dt.getFullYear().toString().slice(-2)+'년 '+(dt.getMonth() + 1)+'월 '+dt.getDate()+'일 ' + time;
     }
}

//chatId 정보 보여주기
function chatUser(chatId, carpoolnum){
   console.log("ChatUser 들어옴");
   console.log(carpoolnum);
   var ajaxJson = new Object;
    ajaxJson.chatId = chatId;
    ajaxJson.carpoolnum = carpoolnum;
    var allData = JSON.stringify(ajaxJson);
    $.ajax({
       url : "chatUser.do",
       type: "POST",
       data: allData,
       contentType : "application/json;charset=UTF-8",
       success:function(data){
//          carpoolRes(chatId, carpoolnum, driverRate, passengerRate);
          var imgsrc = "/wiicar/resources/imgs/" + data.profileimage;
          var html = "<img src=" + imgsrc +"/>"
             +"<div class='user-info'><p class='user-name'>" + data.nickname + "</p>";
         if(data.passengerrate != null){
            html+="<p class='user-sub'>평점 "+data.passengerrate+" / 카풀완료횟수 "+data.fincount+"</p>";
         }else if(data.driverrate != null){
            html+="<p class='user-sub'>평점 "+data.driverrate+" / 카풀완료횟수 "+data.fincount+"</p>";
         }
         html += "<span style=\"cursor:pointer; font: italic 1em/1em Georgia, serif ; color: red;\" onclick=\"reportUser(\'"+data.nickname+"\');\">신고하기</span>";
         $('.user-wrap').empty();
         $('.user-wrap').append(html);
       },
       error:function(){
          alert("정보 불러오기 실패!");
       }    
    }); // ajax
} // ChatUser

//진행중인 카풀 정보 가져오기
function getCarpool(carpoolnum){
    $.ajax({
       url : "getCarpool.do",
       type : "POST",
       data : carpoolnum,
       contentType : 'application/json;charset=UTF-8',
       success:function(data){ 
          console.log("datadata == >> "+ data);
          var html="";
          if(data ==null || data ==""){
             html+="<p class='carpool-status'>진행중인 카풀이 없습니다.</p>";
          }else if(data !=null){
             var schedule = data.time.split(' ');
             var date = schedule[0].split('-');
             var y = date[0], mm = date[1], d = date[2];
             var time = schedule[1].split(':');
             var h = time[0], m = time[1];
             var allTags = data.tags.split(',');
             
             
             html+="<p class='carpool-status'>진행중인 카풀일정</p>"
                + "<div class='carpool-info'>"
                + "<div class='carpool-route'><span class='date'>" 
                + y + "년 " + mm + "월 " + d + "일 " + "</span><span class='time'>"
                + h + "시 " + m + "분</span><br /><span class='route'>출발 : "
                + data.depart+" <br /> 도착 : "+data.destination+"</span></div>"
                 + "<div class='carpool-card'>"
             
             for(var i = 0; i < allTags.length; i++){
                html += "<div class='tag'>"+allTags[i]+"</div>";
             }
             
             
             html+="</div>";
          }
          $('.carpool-wrap').empty();
          $('.carpool-wrap').append(html);
       },
       error:function(request, status, error){

         alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

      }
    }); // ajax
}// getCarpoolList

function appendRequestPopup(data) {
   return '<div class="modal-header">'
      +'<h5 class="modal-title" id="requestInfoPopupLabel">예약 정보</h5>'
      +'<div class="count">'
      +'<p class="max">최대 탑승 인원 : '+data.maxpassenger+'명</p>'
      +'<p class="now">현재 예약 완료된 탑승자 : '+data.passengercount+'명</p></div>'
      +'<button type="button" class="close exit-btn" data-bs-dismiss="modal" aria-label="Close"></button></div>'
      +'<div class="modal-body"><div class="reserve-info"><div class="reserve-info"><div class="carpool-info">'
      +'<p class="time">'+data.time+'</p>'
      +'<p class="route">'+data.depart+' > '+data.destination+'</p>'
      +'<div class="tag">'+data.tags+'</div></div>'
      +'<div class="passenger">'
      +'<p class="passengerID">'+data.passenger+'님의 요청사항</p>'
      +'<p class="message">'+data.message+'</p>'
      +'</div></div></div>'
      +'<div class="modal-footer">'
      +'<button type="button" id="refuse-btn" class="btn btn-secondary">거절</button>'
      +'<button type="button" id="accept-btn" class="btn btn-primary">수락</button></div>';
}

//예약요청확인하기
function requestCheck(chatId,carpoolnum,nickname,user_roomnum) {
   var datajson = new Object;
   datajson.passenger = chatId;
   datajson.carpoolnum = carpoolnum;
   datajson.nickname = nickname;
   datajson.roomnum = user_roomnum;
   var alldata = JSON.stringify(datajson);
   console.log(alldata);
   $.ajax({
      url : "checkInfo.do",
      type : "POST",
      data : alldata,
      contentType: "application/json;charset=utf-8",
      success : function(data) {
         console.log("** 예약요청확인 **");
         console.log(data);
         var html = appendRequestPopup(data);
         $('#requestInfoPopup .modal-content').empty();
         $('#requestInfoPopup .modal-content').append(html);
         
         $('#requestInfoPopup #accept-btn').click(function(){
            accept(alldata);
            alert('예약 요청이 수락되었습니다!');
         });
         $('#requestInfoPopup #refuse-btn').click(function(){
            refuse(alldata);
            alert('예약 요청이 거절되었습니다!');
         });
         $('#requestInfoPopup button.exit-btn').unbind("click").on("click", function(){  
            $("#requestInfoPopup").hide();
         });
      }
   })
}
//수락했을 때
function accept(alldata) {
   console.log(alldata);
   // 카풀리스트 매칭상태(1) / 현재탑승인원 +1 / 
   // 카풀번호를 가지고 다닐거닉까~~~!
   // 예약요청테이블 수락(1) -> 탑승자에게 예약완료 메세지 보내기(ALERTS 테이블)
   $.ajax({
      url : "/wiicar/carpool/accept.do",
      type : "POST",
      data : alldata,
      contentType: "application/json;charset=utf-8",
      success : function(data) {
         console.log("** 수락 성공");
         console.log(alldata);
         location.replace('/wiicar/carpool/chatting.do');
      },
      error:function(request, status, error){
         console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      }
   })
}
// 거절했을 때
function refuse(alldata) {
   console.log(alldata);
   // 예약요청테이블 거절(2) -> 탑승자에게 거절 메세지 보내기(ALERTS 테이블)
   $.ajax({
      url : "/wiicar/carpool/refuse.do",
      type : "POST",
      data : alldata,
      contentType: "application/json;charset=utf-8",
      success : function(data) {
         console.log("** 거절 성공");
         console.log(alldata);
         location.replace('/wiicar/carpool/chatting.do');
      },
      error:function(request, status, error){
         console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      }
   })
}
// 채팅 입력
function insertMessage() {
   var message=$('#message-input').val();
   console.log("입력한 메시지 : "+message);
   if(message.trim() ==''){
      alert("채팅내용을 입력해주세요");
   }else{
      var chatId =$("#chatListView").find('#senderId').val();

      if(chatId == null){
         chatId = $("#chatListView").find('#receiverId').val();
      }
   
      var user_roomnum = $("#chatListView").find('#user_roomnum').val();
      console.log("send에서 chatId=> "+chatId);
      console.log("send에서 roomnum => "+user_roomnum);
      var ajaxJson = new Object;
      ajaxJson.message = message;
      ajaxJson.chatId = chatId; // == var allData ={'message' : message, 'chatId' : chatId} 
      ajaxJson.roomnum = user_roomnum;

      var allData = JSON.stringify(ajaxJson); // json 타입을 string 타입으로 변환, parser는 string 타입을 json으로
      $.ajax({
         url : "insertChat.do",
         type : "POST",
         
         data : allData,
         contentType : 'application/json;charset=UTF-8',
         success : function(data){
            console.log("채팅입력 성공 = "+data);
            $('#message-input').val('').focus();
            //chatRoom();
         },
         error:function(){
            alert("입력 실패 다시시도해주세요.");
         }            
      });// ajax   
   } // if-else
      
}

// 채팅방 삭제 (유찬)
function deleteRoom(nickname, user_roomnum){
   
       var ajaxJson = new Object;
        ajaxJson.nickname = nickname;
        ajaxJson.roomnum = user_roomnum;
        
        var allData = JSON.stringify(ajaxJson);
           
       $.ajax({ // 채팅방 삭제 로직
          url : "chatRoomDelete.do",
          type : "POST",
          data : allData,
          contentType : 'application/json;charset=UTF-8',
          success:function(data){
             console.log(data);
             alert("삭제되었습니다.");
             location.reload(true);
          },
          error:function(){
             alert("삭제실패 다시시도해주세요.");
          }
       });
  }  

function notiDisplayTest() {
	$.ajax({
		url : "/wiicar/alerts/countAllNoti.do",
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
   
function reportUser(nickname) {
	const url = "/wiicar/carpool/reportPopup.do?nickname=" + nickname;
	const name = "WIICAR - 신고 페이지";
	var popupWidth = 1000;
	var popupHeight = 700;
	var popupX = (window.screen.width/2) - (popupWidth/2);
	var popupY= (window.screen.height/2) - (popupHeight/2);
	var option = 'height =' + popupHeight + ', width=' + popupWidth + ', top =' + popupY + ', left =' + popupY + ', location = no';
	window.open(url, name, option);
}
    /*
    //현재 진행중인 카풀 확인 후 정보 가져오기
    function carpoolRes(chatId, carpoolnum, driverRate, passengerRate){
//        console.log("CarpoolRes 왓냐 !!!");
//        console.log("CarpoolRes 에서  chatId => "+chatId);
        console.log("CarpoolRes 에서  carpoolnum => "+carpoolnum);
        
       var ajaxJson = new Object;
       ajaxJson.chatId = chatId;
       ajaxJson.carpoolnum = carpoolnum;
        var allData = JSON.stringify(ajaxJson);
            $.ajax({
              url : "carpoolRes.do",
              type: "POST",
              data: allData,
              contentType : 'application/json;charset=UTF-8',
              success:function(data){
//                 console.log(data);
              var length = data.length;
              var html="";
              for(var i=0;i<length;i++){
                if(data[i].carpoolnum == carpoolnum){
                   console.log(data[i]);
                   html += "<img src='/wiicar/resources/imgs/'" + data.profileimage + "' alt='채팅 상대방 프로필' />" +
                         "<div class='user-info'>" +
                         "<p class='user-name'>" + chatId + "</p>";
//                         console.log("data.passengerrate>>>>>>> "+passengerRate);
//                         console.log("data.driverrate>>>>>> "+driverRate);
                   if(chatId == data[i].passenger){
                        html+="<p class='user-sub'>평점 "+passengerRate+" / 카풀완료횟수 "+length+"</p>";
                     }else if(chatId == data[i].driver){
                        html+="<p class='user-sub'>평점 "+driverRate+" / 카풀완료횟수 "+length+"</p>";
                     }
                     html+="<div id='button_delete'></div></div>"
                }
              }
             $('.user-wrap').empty();
             $('.user-wrap').append(html);
              },
              error:function(){
                 alert("정보 불러오기 실패!")
              }        
           
        }); // ajax
    } // CarpoolRes
    */
     
     
     
     
      