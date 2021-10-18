<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
var message = "";
var modal1 = document.getElementById("requestModal");
var modal2 = document.getElementById("requestModal2");
$(".modalCancel").click(function() {
	modal1.style.display = "none";
	modal2.style.display = "none";
});
$(".modal2btn").click(function() {
	var txt = $(".requestInput").val();
	message = txt;
	$(".requestText").text(txt);
	$(".requestInput").val("");
	modal1.style.display = "none";
	modal2.style.display = "block";
});
$(".kakao").click(function() {
	modal2.style.display = "none";
	var value = $(this).val();
	$.ajax({
		url : '/wiicar/carpoolPay/checkKakaoPay.do',
		dataType : 'json',
		data : {
			carpoolNum : value,
			message : message
		},
		success : function(data) {
			var box = data.next_redirect_pc_url;
			window.open(box);
		}, 
		error : function(error) {
			alert("에러");
		}
	});	
});
</script>
<div id="requestModal" class="modal2" tabindex="-1">
	<div class="modal2-dialog">
		<div class="modal2-content" style="max-width:500px;">
			<div class="modal2-body" >
				<div style="display:flex;">
					<div>
						<img class="img-responsive" src="/wiicar/resources/imgs/profile_default.png" width="200px"/>
					</div>
					<div style="padding-left:20px;width:100%">
						<h3>${dto.driverId}</h3>
						<div>${dto.time}</div>
						<div>${dto.depart} - ${dto.destination}</div>
						<div style="color:#cccccc;text-align:center;">약 <span>${dto.distance}</span>km </div>
						<div>
							<c:forEach var="tag" items="${tags}" >
								<span class="label label-default">${tag}</span>
							</c:forEach>
						</div>
					</div>
				</div>
				<div style="">
					<div>
						<div class="label label-success">내 요청사항</div>
					</div>
					<div style="margin-top:10px;">
						<textarea class="requestInput" style="width:100%;height:150px;resize: none;" placeholder="내용을 입력해주세요"></textarea>
					</div>
					<div style="text-align:right;">
						<button class="modalCancel" style="border:none;border-radius:5px;width:100px;height:30px;">취소</button>
						<button class="modal2btn"  style="border:none;border-radius:5px;width:100px;height:30px;color:white;background-color:#3498DB;">예약하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="requestModal2" class="modal2"  tabindex="-1">
	<div class="modal2-dialog">
		<div class="modal2-content" style="max-width:500px;">
			<div class="modal2-body" >
				<div style="display:flex;">
					<div style="width:100%">
						<h3>예약 정보</h3>
						<div style="padding-left:20px;padding-bottom:20px;">
							<div>${dto.depart} - ${dto.destination}</div>
							<div>${dto.time}</div>
						<div>
							<c:forEach var="tag" items="${tags}" >
								<span class="label label-default">${tag}</span>
							</c:forEach>
						</div>
						</div>
					</div>
				</div>
				<div>
					<div>
						<div class="label label-success">내 요청사항</div>
					</div>
					<div style="margin-top:10px;">
						<p class="requestText"></p>
					</div>
					<div style="text-align:right;font-size:20px;padding-bottom:10px;">
						<span>결제 금액 : </span>
						<span>${dto.price}</span>
					</div>
					<div style="text-align:right;">
						<button class="modalCancel" style="border:none;border-radius:5px;width:100px;height:30px;">취소</button>
						<button class="kakao" value="${dto.carpoolNum}" style="border:none;border-radius:5px;width:100px;height:30px;color:white;background-color:#3498DB;">예약하기</button>
					</div> 
				</div>
			</div>
		</div>
	</div>
</div>