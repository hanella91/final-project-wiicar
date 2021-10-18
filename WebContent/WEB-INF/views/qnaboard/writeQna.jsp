<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>QNA 작성하기</title>
	<link href="/wiicar/resources/css/board.css" rel="stylesheet"type="text/css" />
	<link href="https://cdn.jsdelivr.net/gh/alphardex/aqua.css/dist/aqua.min.css" rel="stylesheet"type="text/css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script>
		$(document).ready(function(){
			if('${qna.title}' != null && '${qna.title}' != "") {
				var qnaCategory = '${qna.qnaCate}';
				if(qnaCategory == 1) $("#qnaCate option:eq(1)").prop("selected", true);
				if(qnaCategory == 2) $("#qnaCate option:eq(2)").prop("selected", true);
				if(qnaCategory == 3) $("#qnaCate option:eq(3)").prop("selected", true);
				if(qnaCategory == 4) $("#qnaCate option:eq(4)").prop("selected", true);
				if(qnaCategory == 5) $("#qnaCate option:eq(5)").prop("selected", true);
				$("#title").val("${qna.title}");
				$("#contentTextArea").val("${qna.content}");
				if('${qna.closed}' == 1) {
					$("#closedCheckBox").attr("checked", "checked");					
				}
				$("#closedCheckBox").prop("disabled", true);
				$("#qnaCate").prop("disabled", true);
			}
			
			$("#modifyQnaBtn").click(function(){			
				if($("#title").val() == "") {
					alert("제목을 입력해주세요.")
				}
				if($("#qnaContentTextArea").val() == "") {
					alert("내용을 입력해주세요.")
				}
				$.ajax({
					url : "/wiicar/qnaboard/modifyQna.do",
					type : "post",
					data : {num : '${qna.num}', title : ("#title").val(), content : $("#contentTextArea").val()},
					complete : function(data) {
						alert("QNA가 수정되었습니다.");
						window.location='/wiicar/qnaboard/qnaContent.do?qnaNum=${qna.num}';
					}
				})
			});
		});
		
		function checkSubmit() {
			if($("#closedCheckBox").is(":checked")) {
				$("#closed").val("1");
			}
			if($("#title").val() == "") {
				alert("제목을 입력해주세요.");
				return false;
			}
			if($("#contentTextArea").val() == "") {
				alert("내용을 입력해주세요.")
				return false;
			}
			if($("input:radio[name='qnaCate']:checked").val() == 0) {
				alert("문의 유형을 선택해주세요.")
				return false;
			}
		}
	</script>
</head>
<body>
<div id="container">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div id="content">
		<form method="post" onSubmit="return checkSubmit();" action="/wiicar/qnaboard/writeQnaPro.do">
			<input type="hidden" id="closed" name="closed" value=0 />
			
			<div class="select-wrap" style="margin-top:30px;">
			    <div class="select-box">
				  <div class="select-box__current" tabindex="0">
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="0" value="0" name="qnaCate" checked="checked"/>
				      <p class="select-box__input-text">문의 유형 선택</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="1" value="1" name="qnaCate"/>
				      <p class="select-box__input-text">운전자 문의</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="2" value="2" name="qnaCate"/>
				      <p class="select-box__input-text">탑승자 문의</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="3" value="3" name="qnaCate"/>
				      <p class="select-box__input-text">결제/환불 문의</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="4" value="4" name="qnaCate"/>
				      <p class="select-box__input-text">사이트이용 문의</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="5" value="5" name="qnaCate"/>
				      <p class="select-box__input-text">기타</p>
				    </div>
				    <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
				  </div>
				  <ul class="select-box__list">
				    <li>
				      <label class="select-box__option" for="0" aria-hidden="aria-hidden">문의 유형 선택</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="1" aria-hidden="aria-hidden">운전자 문의</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="2" aria-hidden="aria-hidden">탑승자 문의</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="3" aria-hidden="aria-hidden">결제/환불 문의</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="4" aria-hidden="aria-hidden">사이트이용 문의</label>
				    </li>
   				    <li>
				      <label class="select-box__option" for="5" aria-hidden="aria-hidden">기타</label>
				    </li>
				  </ul>
				</div>
				<div class="input-group">
					<input type="text" name="title" class="form-control" id="title" required="" style="border: 1px solid #ddd;border-radius: 1em;">
				</div>
				<div class="form-check" style="display:flex !important;">
				  <input type="checkbox" class="form-check-input" id="closedCheckBox" name="secret" />
				  <label class="form-check-label" for="closedCheckBox" style="width:40px;">비밀글</label>
				</div>
			</div>

				<div><hr style="height:3px;"></div>
				<div class="form-group">
					<textarea class="form-control" name="content" id="contentTextArea" rows="8"></textarea>
				</div>
			</div>
			<div class="btn-wrap">
				<c:if test="${qna.title == null}">
					<input type="submit" class="btn" value="등록"/>				
					<button type="button" class="btn" onclick="window.location='/wiicar/qnaboard/qnaList.do'">취소</button>
				</c:if>
				<c:if test="${qna.title != null}">
					<input type="button" class="btn" id="modifyQnaBtn" value="수정"/>				
					<button type="button" class="btn" onclick="window.location='/wiicar/qnaboard/qnaContent.do?qnaNum=${qna.num}'">수정 취소</button>
				</c:if>
				
			</div>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</div>

</body>
</html>