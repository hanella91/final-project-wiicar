<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>월정액</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/memberMenu.css" rel="stylesheet"type="text/css" />
</head>
<style>

	.subscriptionHeader {
		font-size:30px;
		font-weight:700;
		text-align:center;
		padding-bottom:20px;
	}
	.subscriptionHeader span {
		color:#3498DB;
	}
	.content{
		text-align: center;
	    max-width: 500px;
	    margin: auto;
	    width: 400px;
	}
	#footer{
		position: fixed;
		bottom: 0;
	}
</style>
<script>
	$(document).ready(function() {
		
		$("#mySubscription").addClass("clickMenu");
		
		$("#kakao").click(function() {
			var val = $('input:radio[name="radio"]:checked').val();
			if(val != null) {
				$.ajax({
					url : '/wiicar/carpoolPay/checkKakaoPay.do',
					dataType : 'json',
					data : {
						price : val					
					},
					success : function(data) {
						var box = data.next_redirect_pc_url;
						window.open(box);
					}, 
					error : function(error) {
						alert("에러")
					}	
				});
			} else {
				alert("상품을 선택하고 결제해주세요.");
			}	
		});
		
	});
</script>
<body>
<div id="container" class="memberContainer">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div id="content">
		<div id="sidebar">
			<jsp:include page="memberMenu.jsp" />
		</div>
		<div id="mypage">
			<div class="row1">
				<div class="mypageContent">
					<div class="content">
						<div class="subscriptionHeader">
							<c:if test="${subscription == null}" >
								현재 구독중이 아닙니다.
							</c:if>
							<c:if test="${subscription != null}">
								남은 구독 기간은 <span><fmt:formatDate value="${subscription}" pattern="yyyy년 MM월 dd일"/></span> 입니다.
							</c:if>
						</div>
						<div>
							<div style="width:300px;margin:auto;font-size:30px;">
								<div style="padding-bottom:10px;"><input type="radio" style="width:20px;height:20px;" name="radio" value="1" /> 1일&emsp;&emsp;1,000원</div>
								<div style="padding-bottom:10px;"><input type="radio" style="width:20px;height:20px;" name="radio" value="2" /> 1개월&emsp;9,800원</div>
								<div style="padding-bottom:10px;"><input type="radio" style="width:20px;height:20px;" name="radio" value="3" /> 3개월&emsp;27,000원</div>
								<div style="padding-bottom:10px;"><input type="radio" style="width:20px;height:20px;" name="radio" value="4" /> 6개월&emsp;52,000원</div>
								<div style="padding-bottom:20px;"><input type="radio" style="width:20px;height:20px;" name="radio" value="5" /> 1년&emsp;&emsp;98,000원</div>
							</div>
							<div style="width:300px;margin:auto;text-align:center;">
								<button id="kakao" style="border:none;border-radius:5px;width:200px;height:30px;color:white;background-color:#3498DB;">결제하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- FOOTER -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</div>
</body>
</html>