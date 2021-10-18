<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/wiicar/resources/css/reset.css" rel="stylesheet"type="text/css" />
<link href="/wiicar/resources/css/board.css" rel="stylesheet"type="text/css" />
<link href="/wiicar/resources/css/admin.css" rel="stylesheet"type="text/css" />
<script>
$(document).ready(function(){
	var links = document.getElementsByClassName('link')
	for(var i = 0; i <= links.length; i++)
	   addClass(i)
});


function addClass(id){
   setTimeout(function(){
      if(id > 0) links[id-1].classList.remove('hover')
      links[id].classList.add('hover')
   }, id*750) 
}
</script>
	<div class="adminmenu">
	 <div class="link txt-title" id="memberInfo">
	   <a href="/wiicar/admin/memberInfo.do">회원 정보</a>
	 </div>
	 <div class="link txt-title" id="reportsLookup">
	   <a href="/wiicar/admin/reportsLookup.do">신고 목록</a>
	 </div>
	 <div class="link txt-title" id="adminQna">
	   <a href="/wiicar/admin/adminQna.do">QnA 관리</a>
	 </div>
	 <div class="link txt-title" id="carpoolLookup">
	   <a href="/wiicar/admin/carpoolLookup.do">카풀 조회</a>
	 </div>
	 <div class="link txt-title" id="refund">
	   <a href="/wiicar/admin/refundLookup.do">운전자 환급</a>
	 </div>
	</div>
