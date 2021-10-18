<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WIICAR | 관리자 - 신고목록</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css"  href="/wiicar/resources/css/popup.css">
	<link href="/wiicar/resources/css/board.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/reset.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/admin.css" rel="stylesheet"type="text/css" />

</head>
<style>
	.piece1 {width: 30px;}
	.piece2 {width: 250px;}
	.piece3 {width: 250px;}
	.piece4 {width: 100px;}
	.piece5 {width: 80px;}
	.piece6 {width: 300px;}
	.piece7 {width: 150px;}
	
	.select-box {
		width: 30% !important;
	}
	.input-group {
		width: 100% !important;
	}
	#search {
		width: 90% !important;
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
				<h1>신고 관리 페이지</h1>
				<ul class="responsive-table">
					<li class="board-header">
						<div class="piece piece1">No.</div>
						<div class="piece piece2">신고대상 ID(닉네임)</div>
						<div class="piece piece3">신고자 ID(닉네임)</div>
						<div class="piece piece4">누적신고횟수</div>
						<div class="piece piece5">경고횟수</div>
						<div class="piece piece6">신고사유</div>
						<div class="piece piece7">처리사항</div>
					</li>
					<c:forEach var="reports" items="${redto}">
					<c:set var="i" value="${i+1 }"></c:set>
						<li class="table-row info">
							<div class="piece piece1">
							<c:if test="${pageNum == null || pageNum.equals('') }">${i }</c:if>
				    		<c:if test="${pageNum >0 }">${(pageNum-1)*(pageSize)+i }</c:if>
				     	 	</div>						
							<div class="piece piece2 reportid1">${reports.id1 }(${reports.reportid})</div>
							<div class="piece piece3 userid1">${reports.id2 }(${reports.id})</div>
							<div class="piece piece4">${reports.reportCount}</div>
							<div class="piece piece5">${reports.resultCount}</div>
							<div class="piece piece6">
								<c:if test="${reports.result ==0 }">${reports.content}</c:if>
								<c:if test="${reports.result !=0 }">
									<a data-bs-toggle="modal" data-bs-target="#reportCheck${i}">${reports.content}</a>
								</c:if>
							</div>	
							<div class="piece piece7">
								<c:if test="${reports.result ==0 }">
									<button type="button" class="btn btn-primary"
										data-bs-toggle="modal" data-bs-target="#reportResult${i}">처리대기</button>
								</c:if>
								<c:if test="${reports.result !=0 }">
									<button type="button" class="btn btn-primary"
										data-bs-toggle="modal" data-bs-target="#reportResult${i}">처리완료</button>
								</c:if>
							</div>
						</li>

						<!-- Modal -->
						<div class="modal info" id="reportResult${i}" tabindex="-1"
							aria-labelledby="reportResultLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="reportResultLabel">사용자 신고</h5>
									</div>
									<div class="modal-body">
										<div class="report-user">
											<p class="con-title reportid">${reports.reportid}</p>
											<p class="userid ">${reports.id}</p>
											<p class="con-title">${reports.content}</p><br />
										</div>
										<div class="noti">신고 사유를 허위로 작성했을 시 신고 당사자에게 불이익이 갈 수
											있습니다.</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary btn-result" value="1">넘어가기</button>
										<button type="button" class="btn btn-primary btn-result" value="2">경고</button>
										<button type="button" class="btn btn-primary btn-result" value="3">회원탈퇴</button>
									</div>
								</div>
							</div>
						</div>
						<!-- Modal -->
						<div class="modal" id="reportCheck${i}" tabindex="-1"
							aria-labelledby="reportResultLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="reportResultLabel">사용자 신고</h5>
									</div>
									<div class="modal-body">
										<div class="report-user">
											<p class="con-title reportid">${reports.reportid}</p>
											<p class="userid">${reports.id}</p>
											<p class="con-title">${reports.content}</p><br />
										</div>
										<div class="noti">신고 사유를 허위로 작성했을 시 신고 당사자에게 불이익이 갈 수
											있습니다.</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary btn-result" value="1">넘어가기</button>
										<button type="button" class="btn btn-primary btn-result" value="2">경고</button>
										<button type="button" class="btn btn-primary btn-result" value="3">회원탈퇴</button>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					
				</ul>
			</div>
		
			 <form action="reportsLookup.do" method="post" onsubmit="return check1()">
				<!-- 검색 -->
				<div class="select-wrap">
				    <div class="select-box">
					  <div class="select-box__current" tabindex="1">
	  				    <div class="select-box__value">
					      <input class="select-box__input" type="radio" id="none" value="none" name="sel2" checked="checked"/>
					      <p class="select-box__input-text">검색 옵션 선택</p>
					    </div>
					    <div class="select-box__value">
					      <input class="select-box__input" type="radio" id="reportId" value="reportId" name="sel2"/>
					      <p class="select-box__input-text">신고대상 ID</p>
					    </div>
					    <div class="select-box__value">
					      <input class="select-box__input" type="radio" id="Id" value="Id" name="sel2"/>
					      <p class="select-box__input-text">신고자 ID</p>
					    </div>
					    <!-- id 값 중복되니까 신고사유 id 다른걸로 변경하기 -->
					    <div class="select-box__value">
					      <input class="select-box__input" type="radio" id="content1" value="content1" name="sel2"/>
					      <p class="select-box__input-text">신고사유</p>
					    </div>
					    <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
					  </div>
					  <ul class="select-box__list">
					    <li>
					      <label class="select-box__option" for="none" aria-hidden="aria-hidden">검색 옵션 선택</label>
					    </li>
					    <li>
					      <label class="select-box__option" for="reportId" aria-hidden="aria-hidden">신고대상 ID</label>
					    </li>
					    <li>
					      <label class="select-box__option" for="Id" aria-hidden="aria-hidden">신고자 ID</label>
					    </li>
					    <li>
					      <label class="select-box__option" for="content1" aria-hidden="aria-hidden">신고사유</label>
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
	
			<div style="margin:auto;width:70%;text-align:right;">
				<div class="btn-group">
					<button id="sortBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="width:130px;">정렬 기준&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="caret"></span></button>
					<ul id="sortDropdown" class="dropdown-menu" role="menu">
						<li><a href="/wiicar/admin/reportsLookup.do?pageNum=${pageNum}&sel=reg&sort=desc">최신 순</a></li>
						<li><a href="/wiicar/admin/reportsLookup.do?pageNum=${pageNum}&sel=reg&sort=asc">오래된 순</a></li>
					    <li><a href="/wiicar/admin/reportsLookup.do?pageNum=${pageNum}&sel=reportCount&sort=desc">누적신고 횟수</a></li>
					    <li><a href="/wiicar/admin/reportsLookup.do?pageNum=${pageNum}&sel=result&sort=asc">처리대기</a></li>						    
					    <li><a href="/wiicar/admin/reportsLookup.do?pageNum=${pageNum}&sel=result&sort=desc">처리완료</a></li>
					</ul>
				</div>
			</div>
		
			<div align="center">
				<c:if test="${count > 0}">
					<c:set var="pageBlock" value="5" />
					<fmt:parseNumber var="res" value="${count / pageSize}" integerOnly="true" />
					<c:set var="pageCount" value="${res + (count % pageSize == 0 ? 0 : 1)}" />
					<fmt:parseNumber var="result" value="${(currentPage-1)/pageBlock}" integerOnly="true" />
					<fmt:parseNumber var="startPage" value="${result * pageBlock + 1}"/>
					<fmt:parseNumber var="endPage" value="${startPage + pageBlock -1}" />
					<c:if test="${endPage > pageCount}">
						<c:set var="endPage" value="${pageCount}" /> 
					</c:if>
					<nav>
						<ul class="pagination" style="display: inline-flex;">
							<c:if test="${startPage > pageBlock}">
							<c:if test="${sel2 != null && search !=null }">
								<a href="/wiicar/admin/reportsLookup.do?pageNum=${startPage-pageBlock}&sel2=${sel2}&search=${search}" aria-label="Previous"
								style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-right: 10px;">
								<span aria-hidden="true">&lt;</span>
								</a>
							</c:if>
							<c:if test="${sel2 == null && search == null }">
								<a href="/wiicar/admin/reportsLookup.do?pageNum=${startPage-pageBlock}&sel=${sel}&sort=${sort}" aria-label="Previous"
								style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-right: 10px;">
								<span aria-hidden="true">&lt;</span>
								</a>
							</c:if>
							</c:if>
							<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
								<li>
								<c:if test="${sel2 != null && search !=null }">
									<a href="/wiicar/admin/reportsLookup.do?pageNum=${i}&sel2=${sel2}&search=${search}">
						    			<span aria-hidden="true">${i}</span>
						    		</a>
								</c:if>
								<c:if test="${sel2 == null && search == null }">
						    		<a href="/wiicar/admin/reportsLookup.do?pageNum=${i}&sel=${sel}&sort=${sort}">
						    			<span aria-hidden="true">${i}</span>
						    		</a>
						    	</c:if>
						    	</li>
							</c:forEach>
							<c:if test="${endPage < pageCount }">
							<c:if test="${sel2 != null && search !=null }">
								<a href="/wiicar/admin/reportsLookup.do?pageNum=${startPage+pageBlock}&sel2=${sel2}&search=${search}" aria-label="Next"
								style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-left: 10px;">
									<span aria-hidden="true">&gt;</span>
								</a>
							</c:if>
							<c:if test="${sel2 == null && search == null }">
								<a href="/wiicar/admin/reportsLookup.do?pageNum=${startPage+pageBlock}&sel=${sel}&sort=${sort}" aria-label="Next"
								style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-left: 10px;">
									<span aria-hidden="true">&gt;</span>
								</a>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
		crossorigin="anonymous">
	</script>
	<script type="text/javascript">
	$(document).ready(function() {
		$(".modal").hide();
		// 넘어가기 / 경고 / 회원탈퇴 택 1 처리
		$('.btn-result').click(function(){
			var value = $(this).val();
			var reportId = $(this).parents('.info').find('.reportid').text().trim();
			var Id = $(this).parents('.info').find('.userid').text().trim();
			console.log("Value == >> "+value);
			console.log("reportId == >> "+reportId);
			console.log("Id == >> "+Id);
			
			var ajaxJson = new Object;
			ajaxJson.value = value;
			ajaxJson.reportId = reportId,
			ajaxJson.Id = Id;
			
			var allData = JSON.stringify(ajaxJson);
			
			$.ajax({
				url : "reportResult.do",
				type : "POST",
				data : allData,
				contentType : 'application/json;charset=UTF-8',
				success:function(data){
					console.log("처리결과 : "+ data);
					location.reload();
				},
				error:function(){
					alert("다시 처리해주세요.");
				}		
			});// ajax
		});// btn-result
		
		function popup() {
			$(".popup .modal").modal();
		};
	});
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
