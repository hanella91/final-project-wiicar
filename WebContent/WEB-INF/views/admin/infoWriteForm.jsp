<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항 작성하기</title>
	<link href="/wiicar/resources/css/board.css" rel="stylesheet"type="text/css" />
	<link href="https://cdn.jsdelivr.net/gh/alphardex/aqua.css/dist/aqua.min.css" rel="stylesheet"type="text/css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script>
	function checkSubmit(){
		var title = inputForm.title.value;
		var content = inputForm.content.value;
		console.log("title ==> "+title);
		console.log("content ==> "+content);
		
		if(title =="" || title==null){
			alert("제목을 입력해주세요.");
			return false;
		}
		if(content =="" || content == null){
			alert("내용을 입력해주세요.");
			return false;
		}
	}; // 유효성 검사
	</script>
</head>
<body>
<div id="container">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div id="content">
		<form method="post" onSubmit="return checkSubmit();" action="infoWritePro.do">
			<input type="hidden" id="closed" name="closed" value=0 />
			
			<div class="select-wrap" style="margin-top:30px;">
				<div class="input-group">
					<input type="text" name="title" class="form-control" id="title" required="" style="border: 1px solid #ddd;border-radius: 1em;">
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
					<button type="button" class="btn" onclick="window.location='/wiicar/admin/infoBoard.do'">취소</button>
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