<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>WIICAR | 관리자 - 회원목록조회</title>
	<link href="/wiicar/resources/css/board.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/reset.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/admin.css" rel="stylesheet"type="text/css" />
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
            
	<script	src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="/docs/5.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
	<script src="sidebars.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>	
</head>
<style>
	.piece1 {width: 40px;}
	.piece2 {width: 200px;}
	.piece3 {width: 150px;}
	.piece4 {width: 200px;}
	.piece5 {width: 60px;}
	.piece6 {width: 80px;}
	.piece7 {width: 90px;}
	.piece8 {width: 80px;}
	.piece9 {width: 80px;}
	.piece10 {width: 150px;}
	.piece11 {width: 90px;}
	.piece12 {width: 200px;}
</style>
<body>
	<script type="text/javascript">
		console.log("test");
	</script>
<div id="container">
	<div class="popup"></div>
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div id="content" style="width: 100% !important;">
		<div id="sidebar">
			<jsp:include page="adminMenu.jsp" />
		</div>
		<div id="admin">
			<div class="btn-group">
				<button id="sortBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="width:130px;">정렬 기준&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="caret"></span></button>
				<ul id="sortDropdown" class="dropdown-menu" role="menu">
					<li><a href="/wiicar/admin/memberInfo.do?pageNum=${pageNum}&sel=gender&sort=asc">성별</a></li>
					<li><a href="/wiicar/admin/memberInfo.do?pageNum=${pageNum}&sel=active&sort=asc">회원상태</a></li>
				    <li><a href="/wiicar/admin/memberInfo.do?pageNum=${pageNum}&sel=userType&sort=desc">월정액</a></li>
				    <li><a href="/wiicar/admin/memberInfo.do?pageNum=${pageNum}&sel=permit&sort=asc">운전자 승인여부</a></li>						    
				    <li><a href="/wiicar/admin/memberInfo.do?pageNum=${pageNum}&sel=subAdmin&sort=asc">회원등급</a></li>
				</ul>
			</div>

			<c:if test="${count != 0}">
			<div class="table_wrap">
			  <h1>회원정보조회</h1>
			  <ul class="responsive-table">
			  <li class="board-header">
				<div class="piece piece1">No.</div>
				<div class="piece piece2">아이디</div>
				<div class="piece piece3">이름</div>
				<div class="piece piece4">생년월일</div>
				<div class="piece piece5">성별</div>
				<div class="piece piece6">신고횟수</div>
				<div class="piece piece7">운전자 정보</div>
				<div class="piece piece8">회원상태</div>
				<div class="piece piece9">월정액</div> <!-- 회원유형 0:유료, 1:무료  -->
				<div class="piece piece10">운전자 승인여부</div>
				<div class="piece piece11">회원등급</div>
				<div class="piece piece12">관리자권한부여</div>
			  </li>
			  <c:forEach var="member" items="${redto}">
			    	<c:set var="i" value="${i+1 }"></c:set>
					<li class="table-row info">
					  <div class="piece piece1">
					  <c:if test="${pageNum == null || pageNum.equals('') }">${i }</c:if>
				      <c:if test="${pageNum > 0 }">${(pageNum-1)*(pageSize)+i }</c:if>
					  </div>
					  <input type="hidden" class="nickname" value="${member.nickname}"/>
				      <div class="piece piece2 userId">${member.id}</div>
				      <div class="piece piece3">${member.name}</div>
				      <div class="piece piece4">${member.birth}</div>
				      <div class="piece piece5">${member.gender}</div>
				      <div class="piece piece6">${member.reportCount}</div>
				      <div class="piece piece7 userInfo">프로필</div>
				      <div class="piece piece8">
				      <c:if test="${member.active == 1}">
							활동				      
				      </c:if>
				      <c:if test="${member.active == 0}">
							차단			      
				      </c:if>
				      </div>
				      <div class="piece piece9">
				      <c:if test="${member.userType == 0}">
							유료		      
				      </c:if>
				      <c:if test="${member.userType == 1}">
							무료		      
				      </c:if>	
				      </div>					      
				      <div class="piece piece10">
				      <c:if test="${member.permit == 0}">
				      		<button type="button" class="btn btn-warning" onclick="authorize('${member.nickname}')">승인대기</button>
				      </c:if>				      
				      <c:if test="${member.permit == 1}">
				      		<button type="button" class="btn btn-danger">미승인</button>
				      </c:if>				      
				      <c:if test="${member.permit == 2}">
				      		<button type="button" class="btn btn-info">승인완료</button>
				      </c:if>				   
				      <c:if test="${member.permit == 3}">
				      		<button type="button" class="btn btn-secondary">탑승자</button>
				      </c:if>	
				      </div>
				      <div class="piece piece11">			      
				      <c:if test="${member.subAdmin == 0}">
							일반회원			      
				      </c:if>				      
				      <c:if test="${member.subAdmin == 1}">
							관리자		      
				      </c:if>	
				      </div>			 
				      <div class="piece piece12">
				      <button type="button" name="access" class="btn btn-secondary AccessAdmin">
				   	  <input type="hidden" class="subAdmin" value="${member.subAdmin}" />
				      <c:if test="${member.subAdmin == 0}">
							권한부여			      
				      </c:if>				      
				      <c:if test="${member.subAdmin == 1}">
							권한해제		      
				      </c:if>
				      </button>
				      </div>				      
				    </li>	
				  </c:forEach>		
				</ul>
			</div>
		</c:if>

		<form action="memberInfo.do" method="post" onsubmit="return check1();">
			<!-- 검색 -->
			<div class="select-wrap">
			    <div class="select-box">
				  <div class="select-box__current" tabindex="1">
  				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="none" value="none" name="sel2" checked="checked"/>
				      <p class="select-box__input-text">검색 옵션 선택</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="u.id" value="u.id" name="sel2"/>
				      <p class="select-box__input-text">아이디</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="name" value="name" name="sel2"/>
				      <p class="select-box__input-text">이름</p>
				    </div>
				    <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
				  </div>
				  <ul class="select-box__list">
				    <li>
				      <label class="select-box__option" for="none" aria-hidden="aria-hidden">검색 옵션 선택</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="u.id" aria-hidden="aria-hidden">아이디</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="name" aria-hidden="aria-hidden">이름</label>
				    </li>
				  </ul>
				</div>
				<div class="input-group">
					<input type="text" name="search" class="form-control search" id="search" required="">
				</div>
				<div class="sub-btn">
					<input type="submit" id="search_btn" class="btn" value="검색"/>
				</div>
			</div>	
		 </form>
		 <button id="all" onclick="window.location='/wiicar/admin/memberInfo.do'">전체보기</button>
				<div align="center">
					<c:if test="${count > 0}">
						<c:set var="pageBlock" value="2" />
						<fmt:parseNumber var="res" value="${count / pageSize}" integerOnly="true" />
						<c:set var="pageCount" value="${res + (count % pageSize == 0 ? 0 : 1)}" />
						<fmt:parseNumber var="result" value="${(currentPage-1)/pageBlock}" integerOnly="true" />
						<fmt:parseNumber var="startPage" value="${result * pageBlock + 1}"/>
						<fmt:parseNumber var="endPage" value="${startPage + pageBlock -1}" />
						<c:if test="${endPage > pageCount}">
							<c:set var="endPage" value="${pageCount}" /> 
						</c:if>
						<nav>
							<ul class="pagination">
								<c:if test="${startPage > pageBlock}">
								<c:if test="${sel2 != null && search !=null }">
									<a href="/wiicar/admin/memberInfo.do?pageNum=${startPage-pageBlock}&sel2=${sel2}&search=${search}" aria-label="Previous"
									style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-right: 10px;">
									<span aria-hidden="true">&lt;</span></a>
								</c:if>
								<c:if test="${sel2 == null && search == null }">
									<a href="/wiicar/admin/memberInfo.do?pageNum=${startPage-pageBlock}&sel=${sel}&sort=${sort}" aria-label="Previous"
									style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-right: 10px;">
									<span aria-hidden="true">&lt;</span></a>
								</c:if>
								</c:if>
								<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
									<li>
									<c:if test="${sel2 != null && search !=null }">
										<a href="/wiicar/admin/memberInfo.do?pageNum=${i}&sel2=${sel2}&search=${search}">
							    			<span aria-hidden="true">${i}</span>
							    		</a>
									</c:if>
									<c:if test="${sel2 == null && search == null }">
							    		<a href="/wiicar/admin/memberInfo.do?pageNum=${i}&sel=${sel}&sort=${sort}">
							    			<span aria-hidden="true">${i}</span>
							    		</a>
							    	</c:if>
							    	</li>
								</c:forEach>
								<c:if test="${endPage < pageCount }">
								<c:if test="${sel2 != null && search !=null }">
									<a href="/wiicar/admin/memberInfo.do?pageNum=${startPage+pageBlock}&sel2=${sel2}&search=${search}" aria-label="Next"
									style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-left: 10px;">
										<span aria-hidden="true">&gt;</span></a>
								</c:if>
								<c:if test="${sel2 == null && search == null }">
									<a href="/wiicar/admin/memberInfo.do?pageNum=${startPage+pageBlock}&sel=${sel}&sort=${sort}" aria-label="Next"
									style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-left: 10px;">
										<span aria-hidden="true">&gt;</span></a>
								</c:if>
								</c:if>
							</ul>
						</nav>
					</c:if>
				</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</div>
<script>
	$(document).ready(function(){
		
		$('.AccessAdmin').click(function(){
			var userId = $(this).parents('.info').find('.userId').text().trim();
			var subAdmin = $(this).parents('.info').find('.subAdmin').val();
			
			var ajaxJson = new Object;
			ajaxJson.userId = userId;
			ajaxJson.subAdmin = subAdmin;
			
			var allData = JSON.stringify(ajaxJson);
			
			$.ajax({
				
				url : 'subAdminUpdate.do',
				type : 'POST',
				data : allData,
				contentType : 'application/json;charset=UTF-8',
				success:function(data){
					location.reload();
				},
				error:function(){
					alert("관리자 권한부여 실패.");
				}
				
			}); // ajax
			
		}); // AccessAdmin
		
	}); // document
</script>
<script>

	function check1(){
		var sel2 = $('select[name=sel2]').val();
		var search = $('.search').val();
		if(sel2 == 'none'){
			alert("검색대상을 선택해주세요");
			return false;
		}
		if(search =="" || search==null){
			alert("검색어 입력해주세요.")
			return false;
		}
	}; // check1	
	
	function authorize(nickname) {
		const url = "/wiicar/admin/authorizeDriverPopup.do?nickname=" + nickname;
		const name = "WIICAR - 탑승자 승인 페이지";
		var popupWidth = 700;
		var popupHeight = 500;
		var popupX = (window.screen.width/2) - (popupWidth/2);
		
		var popupY= (window.screen.height/2) - (popupHeight/2);
		var option = 'height =' + popupHeight + ', width=' + popupWidth + ', top =' + popupY + ', left =' + popupY + ', location = no';
		window.open(url, name, option);
	}
</script>
</body>
</html>
