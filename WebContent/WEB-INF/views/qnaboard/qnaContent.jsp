<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>QNA</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	
</head>
	<meta charset="UTF-8">
	<title>QNA 내용</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	
<script>
	$(document).ready(function(){
		$("#qnaContentTextArea").val("${qna.content}");
		
		if("${qna.reply_content}" != null || "${qna.reply_content}" != "") {
			$("#qnaReplyTextArea").val("${qna.reply_content}");		
		}
		
		// qna 삭제 모달
		$('#deleteQna').on('click', function(){
			$('#deleteModal').modal('show');			
		});
		$('.deleteCloseModal').on('click', function() {
			$('#deleteModal').modal('hide');
		});
		
		// qna 삭제 모달 비밀번호 확인
		$("#deleteCheckPw").click(function(){
			$.ajax({
				url: "/wiicar/qnaboard/deleteQna.do",
				type: "post",
				data: {pw : $("#deletePassword").val(), num : '${qna.num}'},
				success : function(data){
					if(data == 1) {
						alert("정상적으로 삭제되었습니다.");	
						var url = "/wiicar/qnaboard/qnaList.do";
						window.location="/wiicar/qnaboard/qnaList.do";
					} else {
						alert("비밀번호가 틀렸습니다.");						
					}
				}
			})
		});
		
		// 목록으로
		$("#toList").click(function(){
			var form = $('<form></form>');
			var input = "";
			$(form).hide().attr('id', 'listForm').attr('method','post').attr('action','/wiicar/qnaboard/qnaList.do');
			if("${pageNum}" != null && "${pageNum}" != "") {
			 	input = $('<input type="hidden" />').attr('name','pageNum').val('${pageNum}');
			 	$(form).append(input);
			}
			if("${filter}" != null && "${filter}" != "") {
			 	input = $('<input type="hidden" />').attr('name','filter').val('${filter}');
			 	$(form).append(input);
			}
			if("${search}" != null && "${search}" != "") {
			 	input = $('<input type="hidden" />').attr('name','search').val('${search}');
			 	$(form).append(input);
			}
			if("${myQna}" != null && "${myQna}" != "") {
			 	input = $('<input type="hidden" />').attr('name','myQna').val('${myQna}');
			 	$(form).append(input);
			}
			$(form).appendTo('body');
			/*
			console.log($("body").html());
			var data = JSON.stringify($("#listForm").serialize());
			input = $('<input type="hidden" />').attr('name','data').val(data);
			$("#listForm").remove();
		 	$(form).append(input);
			$(form).appendTo('body');
			alert(data);
			*/
			$(form).submit();
		});
		
		/*
		// 목록으로
		$("#toList").click(function(){
			var form = $('<form></form>');
			var returnObject = new Object();
			$(form).hide().attr('method','post').attr('action','/wiicar/qnaboard/qnaList.do');
			if("${pageNum}" != null && "${pageNum}" != "") {
				returnObject.pageNum = '${pageNum}';
			}
			if("${filter}" != null && "${filter}" != "") {
				returnObject.filter = '${filter}';
			}
			if("${search}" != null && "${search}" != "") {
				returnObject.search = '${search}';
			}
			if("${myQna}" != null && "${myQna}" != "") {
				returnObject.myQna = '${myQna}';
			}
			alert(returnObject);
			$(form).append(returnObject);
			$(form).appendTo('body').submit();
		});
		*/
		
		$("#writeQna").click(function(){
			window.location="/wiicar/qnaboard/writeQna.do";
		});
		
		$("#modifyQna").click(function(){
			window.location="/wiicar/qnaboard/writeQna.do?qnaNum=${qna.num}";
		});
		
		
		$("#writeQna").click(function(){
			window.location="/wiicar/qnaboard/writeQna.do";
		});
		
		$("#modifyQna").click(function(){
			window.location="/wiicar/qnaboard/writeQna.do?qnaNum=${qna.num}";
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
		<div class="title">${qna.title}</div>
		<div class="date">등록일 : ${fn:substring(qna.reg, 0, 10)}</div>
		<div class="writer">작성자 : ${qna.writer}</div>
		<div><hr style="height:3px;"></div>
		<div class="form-group">
			<textarea class="form-control" id="qnaContentTextArea" rows="8" style="resize:none;" readonly></textarea>
		</div>
		<c:if test="${qna.reply_content != null}">
		<div class="reply-wrap">
			<img src="/wiicar/resources/imgs/qnaReply.png" width="20px"/>
			<p class="answer">관리자 답변</p>
			<div class="replydate">
				등록일 : ${fn:substring(qna.reply_date, 0, 10)}
			</div>
			<div class="admin">
				작성자 : ${qna.reply_writer}
			</div>
			<hr style="height:3px;">
			<div class="form-group">
				<textarea class="form-control" id="qnaReplyTextArea" rows="8" style="resize:none;" readonly></textarea>
			</div>
		</div>
		</c:if>
		<div class="row" style="float:right; margin-right:50px;">
			<button type="button" class="btn" style="background-color: #D9D9D6; margin-left:20px;" id="toList">목록으로</button>
			<c:if test="${sessionScope.sid == qna.writer}">
				<button type="button" class="btn" style="background-color: #D9D9D6; margin-left:20px;" id="modifyQna">수정</button>
				<button type="button" class="btn" style="background-color: #333333; margin-left:20px; color: white;" id="deleteQna">삭제</button>
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
					<h5 class="modal-title" style="text-align: center;">QNA 삭제를 원하시면 비밀전호를 입력하세요.</h5>
					<button type="button" class="close deleteCloseModal" data-dismiss="deleteModal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="text-align:center">
					<input type="password" id="deletePassword"/>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="deleteCheckPw" style="line-height: .7; color: #FFFFFF; background-color: #0096c6;">삭제</button>
					<button type="button" class="btn btn-secondary deleteCloseModal" data-dismiss="modal" style="line-height: .7; color: #FFFFFF; background-color: #0096c6;">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
