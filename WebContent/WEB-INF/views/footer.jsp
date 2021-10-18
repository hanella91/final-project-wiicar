<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
$(document).ready(function(){
	$("#adminlog").click(function(){
		const url = "/wiicar/adminLoginPopup.do";
		const name = "WIICAR - 환급 페이지";
		var popupWidth = 1000;
		var popupHeight = 700;
		var popupX = (window.screen.width/2) - (popupWidth/2);
		var popupY= (window.screen.height/2) - (popupHeight/2);
		var option = 'height =' + popupHeight + ', width=' + popupWidth + ', top =' + popupY + ', left =' + popupY + ', location = no';
		window.open(url, name, option);
	});	
})
</script>
<!-- Footer-->
<div id="footer">
    <a href="/wiicar/admin/infoBoard.do">공지사항</a>
    <a href="/wiicar/qnaboard/qnaList.do">사이트 이용 관련 문의</a>
    <a id="adminlog">관리자 로그인</a>
  </div>
    