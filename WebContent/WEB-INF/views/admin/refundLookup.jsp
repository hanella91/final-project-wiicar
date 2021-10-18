<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WIICAR | 관리자  - 환급금조회</title>
	<link href="/wiicar/resources/css/reset.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/board.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/admin.css" rel="stylesheet"type="text/css" />
	
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
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
	#admin {
		padding:30px 0 0 0 !important;
	}
	.table_wrap {
		padding-right: 20px;
	}
</style>
<body>
<div id="container">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div id="content">
		<div id="sidebar">
			<jsp:include page="adminMenu.jsp" />
		</div>
		<div id="admin">
			<div class="table_wrap">
			  <h1>운전자 환급 조회</h1>
			  <ul class="responsive-table">
			    <li class="board-header">
			      <div class="piece piece1">No.</div>
			      <div class="piece piece2">일정</div>
			      <div class="piece piece3">운전자</div>
			      <div class="piece piece4">계좌정보</div>
			      <div class="piece piece5">최대탑승인원</div>
			      <div class="piece piece6">실탑승인원</div>
			      <div class="piece piece7">1인당 가격</div>
			      <div class="piece piece8">총 환급 금액</div>
			      <div class="piece piece9">출발지</div>
			      <div class="piece piece10">도착지</div>
			      <div class="piece piece11">환급여부</div>
			    </li>
			    <c:if test="${count == 0 }">
			    	게시글이 없습니다.
			    </c:if>
			    <c:if test="${count > 0 }">
			    <c:forEach var="refund" items="${refdto}">
			      <c:set var="i" value="${i+1 }"></c:set>
					<li class="table-row info">
				      <div class="piece piece1">
					      <c:if test="${pageNum == null || pageNum.equals('') }">${i }</c:if>
					      <c:if test="${pageNum > 0 }">${(pageNum-1)*(pageSize)+i }</c:if>
				      </div>
				      <div class="piece piece2">${refund.time}</div>
				      <div class="piece piece3">${refund.driverid}</div>
				      <div class="piece piece4">${refund.bankno}</div>
				      <div class="piece piece5">${refund.maxpassenger}</div>
				      <div class="piece piece6">${refund.passengercount}</div>
				      <div class="piece piece7">${refund.price}</div>
				      <div class="piece piece8">${refund.refund}</div>
				      <div class="piece piece9">${refund.depart}</div>
				      <div class="piece piece10">${refund.destination}</div>
				      <div class="piece piece11">
					      <c:if test="${refund.refundcheck ==0 }">
							<button type="button" class="btn btn-primary" onclick="refundPopup('${refund.carpoolnum}');">환급대기</button>
		  				  </c:if>
						  <c:if test="${refund.refundcheck !=0 }">
						  	<button type="button" class="btn btn-primary" onclick="refundPopup('${refund.carpoolnum}');">환급완료</button>
						  </c:if>
					  </div>
				</li>	
				  </c:forEach>
				  </c:if>		
				</ul>
			</div>
				
				<form action="refundLookup.do" method="post" onsubmit="return check1()">
					<!-- 검색 -->
					<div class="select-wrap">
					    <div class="select-box">
						  <div class="select-box__current" tabindex="1">
		  				    <div class="select-box__value">
						      <input class="select-box__input" type="radio" id="none" value="none" name="sel2" checked="checked"/>
						      <p class="select-box__input-text">검색 옵션 선택</p>
						    </div>
						    <div class="select-box__value">
						      <input class="select-box__input" type="radio" id="driverid" value="driverid" name="sel2"/>
						      <p class="select-box__input-text">운전자</p>
						    </div>
						    <div class="select-box__value">
						      <input class="select-box__input" type="radio" id="bankno" value="bankno" name="sel2"/>
						      <p class="select-box__input-text">계좌번호</p>
						    </div>
						    <div class="select-box__value">
						      <input class="select-box__input" type="radio" id="depart" value="depart" name="sel2"/>
						      <p class="select-box__input-text">출발지</p>
						    </div>
						    <div class="select-box__value">
						      <input class="select-box__input" type="radio" id="destination" value="destination" name="sel2"/>
						      <p class="select-box__input-text">도착지</p>
						    </div>
						    <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
						  </div>
						  <ul class="select-box__list">
						    <li>
						      <label class="select-box__option" for="none" aria-hidden="aria-hidden">검색 옵션 선택</label>
						    </li>
						    <li>
						      <label class="select-box__option" for="driverid" aria-hidden="aria-hidden">운전자</label>
						    </li>
						    <li>
						      <label class="select-box__option" for="bankno" aria-hidden="aria-hidden">계좌번호</label>
						    </li>
						    <li>
						      <label class="select-box__option" for="depart" aria-hidden="aria-hidden">출발지</label>
						    </li>
						    <li>
						      <label class="select-box__option" for="destination" aria-hidden="aria-hidden">도착지</label>
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
				<button id="all" onclick="window.location='/wiicar/admin/refundLookup.do'">전체보기</button>
			<div class="btn-group">
				<button id="sortBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="width:130px;">정렬 기준&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="caret"></span></button>
				<ul id="sortDropdown" class="dropdown-menu" role="menu">
					<li><a href="/wiicar/admin/refundLookup.do?pageNum=${pageNum}&sel=time&sort=desc">최신 순</a></li>
					<li><a href="/wiicar/admin/refundLookup.do?pageNum=${pageNum}&sel=time&sort=asc">오래된 순</a></li>
				    <li><a href="/wiicar/admin/refundLookup.do?pageNum=${pageNum}&sel=refundcheck&sort=0">환급대기</a></li>						    
				    <li><a href="/wiicar/admin/refundLookup.do?pageNum=${pageNum}&sel=refundcheck&sort=1">환급완료</a></li>
				</ul>
			</div>
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
									<a href="/wiicar/admin/refundLookup.do?pageNum=${startPage-pageBlock}&sel2=${sel2}&search=${search}" aria-label="Previous"
									style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-right: 10px;">
									<span aria-hidden="true">&lt;</span></a>
								</c:if>
								<c:if test="${sel2 == null && search == null }">
									<a href="/wiicar/admin/refundLookup.do?pageNum=${startPage-pageBlock}&sel=${sel}&sort=${sort}" aria-label="Previous"
									style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-right: 10px;">
									<span aria-hidden="true">&lt;</span></a>
								</c:if>
								</c:if>
								<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
									<li>
									<c:if test="${sel2 != null && search !=null }">
										<a href="/wiicar/admin/refundLookup.do?pageNum=${i}&sel2=${sel2}&search=${search}">
							    			<span aria-hidden="true">${i}</span>
							    		</a>
									</c:if>
									<c:if test="${sel2 == null && search == null }">
							    		<a href="/wiicar/admin/refundLookup.do?pageNum=${i}&sel=${sel}&sort=${sort}">
							    			<span aria-hidden="true">${i}</span>
							    		</a>
							    	</c:if>
							    	</li>
								</c:forEach>
								<c:if test="${endPage < pageCount }">
								<c:if test="${sel2 != null && search !=null }">
									<a href="/wiicar/admin/refundLookup.do?pageNum=${startPage+pageBlock}&sel2=${sel2}&search=${search}" aria-label="Next"
									style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-left: 10px;">
										<span aria-hidden="true">&gt;</span></a>
								</c:if>
								<c:if test="${sel2 == null && search == null }">
									<a href="/wiicar/admin/refundLookup.do?pageNum=${startPage+pageBlock}&sel=${sel}&sort=${sort}" aria-label="Next"
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
</body>
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
	
	function refundPopup(carpoolnum) {		
		const url = "/wiicar/admin/refundPopup.do?carpoolnum=" + carpoolnum;
		const name = "WIICAR - 환급 페이지";
		var popupWidth = 1000;
		var popupHeight = 700;
		var popupX = (window.screen.width/2) - (popupWidth/2);
		var popupY= (window.screen.height/2) - (popupHeight/2);
		var option = 'height =' + popupHeight + ', width=' + popupWidth + ', top =' + popupY + ', left =' + popupY + ', location = no';
		window.open(url, name, option);
	}
</script>
</html>