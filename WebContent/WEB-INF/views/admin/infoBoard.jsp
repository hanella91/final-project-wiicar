<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WIICAR | 공지사항</title>
	<link href="/wiicar/resources/css/board.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/admin.css" rel="stylesheet"type="text/css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

	<style>
		a {
			cursor: pointer;
		}
	</style>


</head>
<body>

<!-- CONTAINER -->
<div id="container">
	<!-- HEADER -->
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<!-- CONTENT -->
	<div id="content">
		<p class="m_menu"><button id="m_exit"></button>공지사항</p>

		 <div class="board-header">
			<div class="mid">No.</div>
			<div class="lar">제목</div>
			<div class="mid">작성자</div>
			<div class="mid">등록일</div>
			<div class="mi">조회수</div>
	    </div>

		<c:if test="${count == 0}">
			<div>게시글이 없습니다.</div>>
		</c:if>
		<c:if test="${count != 0}">
			<ul class="list-group">
				  <c:forEach var="info" items="${infodto}">
			      <c:set var="i" value="${i+1 }"></c:set>

					<li class="board-item" onclick="window.location='/wiicar/admin/infoContent.do?num=${info.num}&pageNum=${pageNum }'">
						<div class="board-info" style="width: 100%;">
							<div class="number mid" style="flex-basis: 13%">
								<c:if test="${pageNum == null || pageNum.equals('') }">${i }</c:if>
				     			<c:if test="${pageNum >0 }">${(pageNum-1)*(pageSize)+i }</c:if>
							</div>
							<div class="contents">
								<div class="subject lar" >
									${info.title }
								</div>
								<div class="info">
									<div class="writer mid">
										${info.writer }
									</div>
									<div class="date mid" style="font-size:normal;">
										<fmt:formatDate value="${info.reg }" pattern="yyyy-MM-dd"/>
									</div>
									<div class="hit mi">
										${info.hit}
									</div>
								</div>
							</div>
						</div>
					</li>

				</c:forEach>
			</ul>
			<div class="pagenum">
				<!-- 페이지 번호 -->
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
							<ul class="pagination" style="display:inline-flex">
								<!-- 왼쪽페이지 이동 : startPage > pageBlock보다 크면 보여줘! -->
								<c:if test="${startPage > pageBlock}">
									<a href="/wiicar/admin/infoBoard.do?pageNum=${startPage-pageBlock}" aria-label="Previous" style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-right: 10px;">
									<span aria-hidden="true">&lt;</span>
									</a>
								</c:if>
								<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
									<li>
							    		<a href="/wiicar/admin/infoBoard.do?pageNum=${i}">
							    			<span aria-hidden="true">${i}</span>
							    		</a>
							    	</li>
								</c:forEach>
								<c:if test="${endPage < pageCount }">
									<a href="/wiicar/admin/infoBoard.do?pageNum=${startPage+pageBlock}" aria-label="Next" style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-left: 10px;">
									<span aria-hidden="true">&gt;</span>
									</a>
								</c:if>
							</ul>
						</nav>
						</c:if>
			</div>
			<c:if test="${sessionScope.sid == 'admin' }">
			<div class="btn-wrap">
				<div class="btn1">
					<button onclick="window.location='/wiicar/admin/infoWriteForm.do'">글쓰기</button>
				</div>
			</div>
			</c:if>

					</c:if>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</div>
</body>
</html>



