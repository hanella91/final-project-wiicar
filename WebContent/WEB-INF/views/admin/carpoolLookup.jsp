<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WIICAR | 관리자 - 카풀조회</title>
	<link href="/wiicar/resources/css/reset.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/board.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/admin.css" rel="stylesheet"type="text/css" />
</head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<style>
	.picec {
		height: 80px;
	}
	.piece1 {width: 40px;}
	.piece2 {width: 100px;}
	.piece3 {width: 200px;}
	.piece4 {width: 450px;}
	.piece5 {width: 450px;}
	.piece6 {width: 150px;}
	.piece7 {width: 150px;}
	.piece8 {width: 90px;}
	.piece9 {width: 90px;}
	.piece10 {width: 200px;}
	.piece11 {width: 500px;}
	.piece12 {width: 90px;}
	.piece13 {width: 200px;}
	.piece14 {width: 500px;}
	.piece15 {width: 80px;}
	.select-box {
		width: 30% !important;
	}
	.select-wrap {
		width: 100% !important;
	}
	.input-group {
		width: 70% !important;
	}
	#search {
		width: 95% !important;
	}
	#search_btn {
		width: 150px !important;
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
			  <h1>카풀 조회</h1>
			  <ul class="table-wrap">
				  <li class="board-header">	    
				      <div class="piece piece1">No.</div>
				      <div class="piece piece2">매칭여부</div>
				      <div class="piece piece3">일정</div>
				      <div class="piece piece4 route">출발지</div>
				      <div class="piece piece5 route">도착지</div>
				      <div class="piece piece6">운전자</div>
				      <div class="piece piece7">탑승자</div>
				      <div class="piece piece8">최대탑승인원</div>
				      <div class="piece piece9">현재탑승인원</div>
				      <div class="piece piece10">카풀등록날짜</div>
				      <div class="piece piece11 requ">탑승자요청사항</div>
				      <div class="piece piece12">수락/거절</div>
				      <div class="piece piece13">예약요청날짜</div>
				      <div class="piece piece14 requ">운전자요청사항(tags)</div>
				      <div class="piece piece15">인당가격</div>
			      </li>
			    <c:forEach var="carpool" items="${cardto}">
			    <c:set var="i" value="${i+1 }"></c:set>
					<li class="board-item">
				      <div class="piece piece1"> 
				      <c:if test="${pageNum == null || pageNum.equals('') }">${i }</c:if>
				      <c:if test="${pageNum >0 }">${(pageNum-1)*(pageSize)+i }</c:if></div>
				      <div class="piece piece2">
				      <c:if test="${carpool.carMatching == 0}">진행중</c:if>
				      <c:if test="${carpool.carMatching == 1}">진행중</c:if>
				      <c:if test="${carpool.carMatching == 2}">정원 초과</c:if>
				      <c:if test="${carpool.carMatching == 3}">취소</c:if>
				      </div>
				      <div class="piece piece3">${carpool.time}</div>
				      <div class="piece piece4">${carpool.depart}</div>
				      <div class="piece piece5">${carpool.destination}</div>
				      <div class="piece piece6">${carpool.driver}</div>
				      <div class="piece piece7">${carpool.passenger}</div>
				      <div class="piece piece8">${carpool.maxPassenger}</div>
				      <div class="piece piece9">${carpool.passengerCount}</div>
				      <div class="piece piece10">${carpool.carpoolreg}</div>
				      <div class="piece piece11">${carpool.message}</div>
				      <div class="piece piece12">
					      <c:if test="${carpool.acceptance ==0}">대기중</c:if>
					      <c:if test="${carpool.acceptance ==1}">수락</c:if>
					      <c:if test="${carpool.acceptance ==2}">거절</c:if>
				      </div>
				      <div class="piece piece13">${carpool.reservereg}</div>
				      <div class="piece piece14">${carpool.tags}</div>
				      <div class="piece piece15">${carpool.price}</div>
				    </li>	
				</c:forEach>
				</ul>
			</div>
			<form action="carpoolLookup.do" method="post" onsubmit="return check1()">
				<!-- 검색 -->
				<div class="select-wrap">
				    <div class="select-box">
					  <div class="select-box__current" tabindex="1">
	  				    <div class="select-box__value">
					      <input class="select-box__input" type="radio" id="none" value="none" name="sel2" checked="checked"/>
					      <p class="select-box__input-text">검색 옵션 선택</p>
					    </div>
					    <div class="select-box__value">
					      <input class="select-box__input" type="radio" id="depart" value="depart" name="sel2"/>
					      <p class="select-box__input-text">출발지</p>
					    </div>
					    <div class="select-box__value">
					      <input class="select-box__input" type="radio" id="destination" value="destination" name="sel2"/>
					      <p class="select-box__input-text">도착지</p>
					    </div>
					    <div class="select-box__value">
					      <input class="select-box__input" type="radio" id="driver" value="driver" name="sel2"/>
					      <p class="select-box__input-text">운전자</p>
					    </div>
					    <div class="select-box__value">
					      <input class="select-box__input" type="radio" id="passenger" value="passenger" name="sel2"/>
					      <p class="select-box__input-text">탑승자</p>
					    </div>
					    <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
					  </div>
					  <ul class="select-box__list">
					    <li>
					      <label class="select-box__option" for="none" aria-hidden="aria-hidden">검색 옵션 선택</label>
					    </li>
					    <li>
					      <label class="select-box__option" for="depart" aria-hidden="aria-hidden">출발지</label>
					    </li>
					    <li>
					      <label class="select-box__option" for="destination" aria-hidden="aria-hidden">도착지</label>
					    </li>
					    <li>
					      <label class="select-box__option" for="driver" aria-hidden="aria-hidden">운전자</label>
					    </li>
					    <li>
					      <label class="select-box__option" for="passenger" aria-hidden="aria-hidden">탑승자</label>
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
		 <button id="all" onclick="window.location='/wiicar/admin/carpoolLookup.do'">전체보기</button>
		 <div style="margin:auto;width:70%;text-align:right;">
			<div class="btn-group">
				<button id="sortBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="width:130px;">정렬 기준&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="caret"></span></button>
				<ul id="sortDropdown" class="dropdown-menu" role="menu">
					<li><a href="/wiicar/admin/carpoolLookup.do?pageNum=${pageNum}&sel=reg&sort=desc">최신 순</a></li>
					<li><a href="/wiicar/admin/carpoolLookup.do?pageNum=${pageNum}&sel=reg&sort=asc">오래된 순</a></li>
				    <li><a href="/wiicar/admin/carpoolLookup.do?pageNum=${pageNum}&sel=carmatching&result=0">매칭 진행중</a></li>
				    <li><a href="/wiicar/admin/carpoolLookup.do?pageNum=${pageNum}&sel=result&sort=asc">대기중</a></li>						    
				    <li><a href="/wiicar/admin/carpoolLookup.do?pageNum=${pageNum}&sel=result&sort=desc">처리완료</a></li>
				</ul>
			</div>
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
									<a href="/wiicar/admin/carpoolLookup.do?pageNum=${startPage-pageBlock}&sel2=${sel2}&search=${search}" aria-label="Previous"
									style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-right: 10px;">
									<span aria-hidden="true">&lt;</span></a>
								</c:if>
								<c:if test="${sel2 == null && search == null }">
									<a href="/wiicar/admin/carpoolLookup.do?pageNum=${startPage-pageBlock}&sel=${sel}&sort=${sort}" aria-label="Previous"
									style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-right: 10px;">
									<span aria-hidden="true">&lt;</span></a>
								</c:if>
								</c:if>
								<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
									<li>
									<c:if test="${sel2 != null && search !=null }">
										<a href="/wiicar/admin/carpoolLookup.do?pageNum=${i}&sel2=${sel2}&search=${search}">
							    			<span aria-hidden="true">${i}</span>
							    		</a>
									</c:if>
									<c:if test="${sel2 == null && search == null }">
							    		<a href="/wiicar/admin/carpoolLookup.do?pageNum=${i}&sel=${sel}&sort=${sort}">
							    			<span aria-hidden="true">${i}</span>
							    		</a>
							    	</c:if>
							    	</li>
								</c:forEach>
								<c:if test="${endPage < pageCount }">
								<c:if test="${sel2 != null && search !=null }">
									<a href="/wiicar/admin/carpoolLookup.do?pageNum=${startPage+pageBlock}&sel2=${sel2}&search=${search}" aria-label="Next"
									style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-left: 10px;">
										<span aria-hidden="true">&gt;</span></a>
								</c:if>
								<c:if test="${sel2 == null && search == null }">
									<a href="/wiicar/admin/carpoolLookup.do?pageNum=${startPage+pageBlock}&sel=${sel}&sort=${sort}" aria-label="Next"
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
	}; // checkForm
	</script>
</body>
</html>