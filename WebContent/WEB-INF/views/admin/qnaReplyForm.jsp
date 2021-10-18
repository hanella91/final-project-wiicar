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
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	
</head>


	</br>
	<div class="container">
		<form action="/wiicar/admin/qnaReplyPro.do" method="post">
			<input type="hidden" name="num" value="${qnaboard.num}" />
				<div class="table_wrap">
				  <ul class="responsive-table">
				  	<li class="table-header">
				      <div class="col col-1" style="flex-basis: 10.77%;">No. <b>${qnaboard.num}</b></div>  
				      <div class="col col-2" style="flex-basis: 10.77%;">작성일 <b>${qnaboard.reg}</b></div>
				      <div class="col col-3" style="flex-basis: 10.77%;">작성자 <b>${qnaboard.writer}</b></div>
				      <div class="col col-4" style="flex-basis: 10.77%;">문의유형 
				      	  <c:if test="${qnaboard.qnaCate == 1}">
							<b class="col col-4" style="flex-basis: 10.77%;">운전자 문의</b>				      
					      </c:if>				      
					      <c:if test="${qnaboard.qnaCate == 2}">
							<b class="col col-4" style="flex-basis: 10.77%;">탑승자 문의</b>				      
					      </c:if>				      
					      <c:if test="${qnaboard.qnaCate == 3}">
							<b class="col col-4" style="flex-basis: 10.77%;">결제/환불 문의</b>				      
					      </c:if>				      
					      <c:if test="${qnaboard.qnaCate == 4}">
							<b class="col col-4" style="flex-basis: 10.77%;">사이트이용 문의</b>				      
					      </c:if>				      
					      <c:if test="${qnaboard.qnaCate == 5}">
							<b class="col col-4" style="flex-basis: 10.77%;">기타 문의</b>				      
					      </c:if>				      
				      </div>
				      <div class="col col-5" style="flex-basis: 10.77%;">제목 <b>${qnaboard.title}</b></div>
				      <div class="col col-6" style="flex-basis: 10.77%;">내용 <b>${qnaboard.content}</b></div>
				    </li>  
				   </ul>  
				</div>
				<div><hr style="height:3px;"></div>
				<h3>Q&A 답변하기</h3>				
				<div class="form-group">
					<textarea class="form-control" rows="8" name="reply_content"></textarea>
				</div>
				<div class="row" style="float:right; margin-right:50px;">
					<button type="submit" class="btn" style="background-color: #333333; margin-left:20px; color: white;">확인</button>
					<button type="reset" class="btn" style="background-color: #333333; margin-left:20px; color: white;">재작성</button>
					<button type="button" class="btn" onclick="window.location='/wiicar/admin/adminQna.do'" style="background-color: #D9D9D6; margin-left:20px;">목록보기</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
