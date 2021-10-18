<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> WIICAR || 공지사항</title>
<link href="/wiicar/resources/css/board.css" rel="stylesheet"type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>

</head>
<script>
	$(document).ready(function() {
		$('#infoDelete').click(function() {
			var select = confirm("정말 삭제하시겠습니까 ?");
			var num = '${infodto.num}';
			console.log("num ==>> " + num);
			if (select == true) {
				$.ajax({
					url : "infoDelete.do",
					type : "POST",
					data : num,
					contentType : 'application/json;charset=UTF-8',
					success : function(data) {
						alert("삭제 성공");
						window.location = "/wiicar/admin/infoBoard.do";
					},
					error : function() {
						alert("삭제 실패 다시시도해주세요.");
					}
				});// ajax
			} else if (select == false) {
				alert("현위치로 돌아갑니다.");
			}
		}); //infoDelete

		// 목록으로
		$("#toList").click(function(){
			window.location='/wiicar/admin/infoBoard.do?pageNum=${pageNum}';
		});

		$("#infoWrite").click(function(){
			window.location="/wiicar/admin/infoWriteForm.do";
		});
		$("#infoModify").click(function(){
			window.location="/wiicar/admin/infoModifyForm.do?num=${infodto.num}";
		});
	});
</script>
<body>
<style>
body {
	overflow: auto !important;
}

#footer {
	position: absolute !important;
}
</style>
	<div id="container">
		<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
		<div id="content" style="width: 80%; margin: 0 auto;">
			<div class="title">제목 : ${infodto.title }</div>
			<div class="date">등록일 : ${infodto.reg }</div>
			<div class="writer">작성자 : ${infodto.writer}</div>
			<div>
				<hr style="height: 3px;">
			</div>
			<div class="form-group">
				${infodto.content }
			</div>
			<div class="row" style="float: right; margin-right: 50px;">
				<button type="button" class="btn"
					style="background-color: #D9D9D6; margin-left: 20px;" id="toList">목록으로</button>
				<c:if test="${sessionScope.sid == 'admin'}">
					<button type="button" class="btn"
						style="background-color: #D9D9D6; margin-left: 20px;" id="infoWrite">글쓰기</button>
					<button type="button" class="btn"
						style="background-color: #D9D9D6; margin-left: 20px;"
						id="infoModify">수정</button>
					<button type="button" class="btn"
						style="background-color: #333333; margin-left: 20px; color: white;"
						id="infoDelete">삭제</button>
				</c:if>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	</div>

	<!-- qna 삭제 모달 -->
	<div class="modal" id="deleteModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" style="text-align: center;">공지사항 삭제를
						원하시면 비밀번호를 입력하세요.</h5>
					<button type="button" class="close deleteCloseModal"
						data-dismiss="deleteModal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="text-align: center">
					<input type="password" id="deletePassword" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="deleteCheckPw"
						style="line-height: .7; color: #FFFFFF; background-color: #0096c6;">삭제</button>
					<button type="button" class="btn btn-secondary deleteCloseModal"
						data-dismiss="modal"
						style="line-height: .7; color: #FFFFFF; background-color: #0096c6;">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
