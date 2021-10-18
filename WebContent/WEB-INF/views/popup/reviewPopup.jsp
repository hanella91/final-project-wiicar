<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/wiicar/resources/css/popup.css" rel="stylesheet" type="text/css" />
<script>
	$(document).ready(function() {
		
		var rate = 1;
		$(".rate").css("display", "none");
		$(".star-group1").css("display", "block");
		$(".star1").click(function() {
			$(".rate").css("display", "none");
			$(".star-group1").css("display", "block");
			rate = 1;
		})
		$(".star2").click(function() {
			$(".rate").css("display", "none");
			$(".star-group2").css("display", "block");
			rate = 2;
		})
		$(".star3").click(function() {
			$(".rate").css("display", "none");
			$(".star-group3").css("display", "block");
			rate = 3;
		})
		$(".star4").click(function() {
			$(".rate").css("display", "none");
			$(".star-group4").css("display", "block");
			rate = 4;
		})
		$(".star5").click(function() {
			$(".rate").css("display", "none");
			$(".star-group5").css("display", "block");
			rate = 5;
		})
		
		$("#reviewSubmit").click(function() {
			var content = $("#contentText").val();
			$.post({
				url : '/wiicar/member/reviewInsert.do',
				data : {
					type : '${type}',
					id : '${id}',
					num : '${num}',
					rate : rate,
					content : content
				}
			});
			location.reload();
			
		});
		var span = document.getElementsByClassName("close")[0];
		var modal = document.getElementById("reviewPopup");
		$("#reviewCancel").click(function() {
			modal.style.display = "none";
		});
		span.onclick = function() {
			modal.style.display = "none";
		}
		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
		  if (event.target == modal) {
			  modal.style.display = "none";
		  }
		}
		
		
		$('#contentText').keyup(function (e){
	        var content = $(this).val();       
	        $('#counter').val(200-content.length);
	        console.log(content.length);
	        if(content.length > 200) {
	          $(this).val($(this).val().substring(0, 200));
	        }
      	});	
	});
	

</script>
<div class="modal2" id="reviewPopup">
    <div class="modal2-content">
        <div class="con">
          <p class="pop-title">유저 평점</p>
            <div class="star-group">
              <div class="star-group1 rate">
              	<img class="star1"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star2"  src="/wiicar/resources/imgs/emptystar.png"/>
              	<img class="star3"  src="/wiicar/resources/imgs/emptystar.png"/>
              	<img class="star4"  src="/wiicar/resources/imgs/emptystar.png"/>
              	<img class="star5"  src="/wiicar/resources/imgs/emptystar.png"/>
              </div>
              <div class="star-group2 rate">
              	<img class="star1"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star2"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star3"  src="/wiicar/resources/imgs/emptystar.png"/>
              	<img class="star4"  src="/wiicar/resources/imgs/emptystar.png"/>
              	<img class="star5"  src="/wiicar/resources/imgs/emptystar.png"/>
              </div>
              <div class="star-group3 rate">
              	<img class="star1"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star2"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star3"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star4"  src="/wiicar/resources/imgs/emptystar.png"/>
              	<img class="star5"  src="/wiicar/resources/imgs/emptystar.png"/>
              </div>
              <div class="star-group4 rate">
              	<img class="star1"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star2"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star3"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star4"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star5"  src="/wiicar/resources/imgs/emptystar.png"/>
              </div>
              <div class="star-group5 rate">
              	<img class="star1" src="/wiicar/resources/imgs/star.png"/>
              	<img class="star2"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star3"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star4"  src="/wiicar/resources/imgs/star.png"/>
              	<img class="star5"  src="/wiicar/resources/imgs/star.png"/>
            </div>
        </div>
        </div>
        <div class="con">
          <p class="pop-title">간단한 후기 작성(200자 제한)</p>
          <textarea id="contentText"></textarea>
        </div>
        <button id="reviewCancel" class="btn btn-secondary">취소</button>
        <button id="reviewSubmit" class="btn btn-primary">작성하기</button>
      </div>
</div> 


    