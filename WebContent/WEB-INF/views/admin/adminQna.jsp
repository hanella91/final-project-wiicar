<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <title>WIICAR | 관리자 - QNA</title>
   <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link href="/wiicar/resources/css/board.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/reset.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/admin.css" rel="stylesheet"type="text/css" />
   <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>

   <script   src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
   <script src="/docs/5.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
   <script src="sidebars.js"></script>
   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<style>
	.piece1 {width: 30px;}
	.piece2 {width: 150px;}
	.piece3 {width: 150px;}
	.piece4 {width: 100px;}
	.piece5 {width: 250px;}
	.piece6 {width: 100px;}
	.piece7 {width: 100px;}
</style>
<body>
<div id="container">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div id="content">
		<div id="sidebar">
			<jsp:include page="adminMenu.jsp" />
		</div>
		<div id="admin">
         <div class="btn-group">
            <button id="sortBtn" type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="width:130px;">정렬 기준&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="caret"></span></button>
            <ul id="sortDropdown" class="dropdown-menu" role="menu">
               <li><a href="/wiicar/admin/adminQna.do?pageNum=${pageNum}&sel=num&sort=desc">No.</a></li>
               <li><a href="/wiicar/admin/adminQna.do?pageNum=${pageNum}&sel=reg&sort=desc">작성일</a></li>
                <li><a href="/wiicar/admin/adminQna.do?pageNum=${pageNum}&sel=qnaCate&sort=asc">질문유형</a></li>
                <li><a href="/wiicar/admin/adminQna.do?pageNum=${pageNum}&sel=status&sort=asc">답변여부</a></li>
            </ul>
         </div>
   <c:if test="${count != 0}">
      <form>
         <div class="table_wrap">
           <h1>QnA 관리</h1>
           <ul class="responsive-table">
             <li class="board-header">
               <div class="piece piece1">No.</div>
               <div class="piece piece2">작성일</div>
               <div class="piece piece3">질문유형</div>
               <div class="piece piece4">작성자</div>
               <div class="piece piece5">제목</div>
               <div class="piece piece6">답변여부</div>
               <div class="piece piece7">답변자</div>
             </li>
             <c:forEach var="qnaboard" items="${redto}">
               <c:set var="i" value="${i+1 }"></c:set>
               <li class="table-row">
               <div class="piece piece1">
                     <c:if test="${pageNum == null || pageNum.equals('') }">${i }</c:if>
                      <c:if test="${pageNum >0 }">${(pageNum-1)*(pageSize)+i }</c:if>
                </div>
                  <div class="piece piece2">${qnaboard.reg}</div>
                  <c:if test="${qnaboard.qnaCate == 1}">
                     <div class="piece piece3">운전자 문의</div>
                  </c:if>
                  <c:if test="${qnaboard.qnaCate == 2}">
                     <div class="piece piece3">탑승자 문의</div>
                  </c:if>
                  <c:if test="${qnaboard.qnaCate == 3}">
                     <div class="piece piece3">결제/환불 문의</div>
                  </c:if>
                  <c:if test="${qnaboard.qnaCate == 4}">
                     <div class="piece piece3">사이트이용 문의</div>
                  </c:if>
                  <c:if test="${qnaboard.qnaCate == 5}">
                     <div class="piece piece3">기타 문의</div>
                  </c:if>
                  <div class="piece piece4">${qnaboard.writer}</div>
                  <div class="piece piece5">${qnaboard.title}</div>
                  <div class="piece piece6">
	                 <c:if test="${qnaboard.status == 0}">
	                       <a class="btn btn-primary" href="/wiicar/admin/qnaReplyForm.do?num=${qnaboard.num}" role="button">답변하기</a>
	                 </c:if>
	                 <c:if test="${qnaboard.status == 1}">
	                       <button type="button" class="btn btn-secondary btn-sm">답변완료</button>
	                 </c:if>
	              </div>
                  <div class="piece piece7">${qnaboard.reply_writer}</div>
                </li>
            </c:forEach>
            </ul>
         </div>
      </form>
      </c:if>

      <form action="adminQna.do" method="get" onsubmit="return check();">
      	<!-- 검색 -->
		<div class="select-wrap">
		    <div class="select-box">
			  <div class="select-box__current" tabindex="1">
 				    <div class="select-box__value">
			      <input class="select-box__input" type="radio" id="none" value="none" name="sel2" checked="checked"/>
			      <p class="select-box__input-text">검색 옵션 선택</p>
			    </div>
			    <div class="select-box__value">
			      <input class="select-box__input" type="radio" id="writer" value="writer" name="sel2"/>
			      <p class="select-box__input-text">작성자</p>
			    </div>
			    <div class="select-box__value">
			      <input class="select-box__input" type="radio" id="reply_writer" value="reply_writer" name="sel2"/>
			      <p class="select-box__input-text">답변자</p>
			    </div>
			    <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
			  </div>
			  <ul class="select-box__list">
			    <li>
			      <label class="select-box__option" for="none" aria-hidden="aria-hidden">검색 옵션 선택</label>
			    </li>
			    <li>
			      <label class="select-box__option" for="writer" aria-hidden="aria-hidden">작성자</label>
			    </li>
			    <li>
			      <label class="select-box__option" for="reply_writer" aria-hidden="aria-hidden">답변자</label>
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
      </div>

      <div align="center">
               <c:if test="${count > 0}">
                  <c:set var="pageBlock" value="3" />
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
                           <a href="/wiicar/admin/adminQna.do?pageNum=${startPage-pageBlock}&sel2=${sel2}&search=${search}" aria-label="Previous"
                           style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-right: 10px;">
                           <span aria-hidden="true">&lt;</span>
                           </a>
                        </c:if>
                        <c:if test="${sel2 == null && search == null }">
                           <a href="/wiicar/admin/adminQna.do?pageNum=${startPage-pageBlock}&sel=${sel}&sort=${sort}" aria-label="Previous"
                           style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-right: 10px;">
                           <span aria-hidden="true">&lt;</span>
                           </a>
                        </c:if>
                        </c:if>
                        <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
                           <li>
                           <c:if test="${sel2 != null && search !=null }">
                              <a href="/wiicar/admin/adminQna.do?pageNum=${i}&sel2=${sel2}&search=${search}">
                                  <span aria-hidden="true">${i}</span>
                               </a>
                           </c:if>
                           <c:if test="${sel2 == null && search == null }">
                               <a href="/wiicar/admin/adminQna.do?pageNum=${i}&sel=${sel}&sort=${sort}">
                                  <span aria-hidden="true">${i}</span>
                               </a>
                            </c:if>
                            </li>
                        </c:forEach>
                        <c:if test="${endPage < pageCount }">
                        <c:if test="${sel2 != null && search !=null }">
                           <a href="/wiicar/admin/adminQna.do?pageNum=${startPage+pageBlock}&sel2=${sel2}&search=${search}" aria-label="Next"
                           style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-left: 10px;">
                              <span aria-hidden="true">&gt;</span>
                           </a>
                        </c:if>
                        <c:if test="${sel2 == null && search == null }">
                           <a href="/wiicar/admin/adminQna.do?pageNum=${startPage+pageBlock}&sel=${sel}&sort=${sort}" aria-label="Next"
                           style="height: 20px;vertical-align: middle; margin-top: 7px; display: block;margin-left: 10px;">
                              <span aria-hidden="true">&gt;</span>
                           </a>
                        </c:if>
                        </c:if>
                     </ul>
                  </nav>
               </c:if>
         </div>
   <br />
   <c:if test="${sel != null && search != null}">
      <button onclick="window.location='/wiiwii/admin/adminQna.do'"> 전체 게시글 보기 </button> <br />
   </c:if>
   </div>
<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</div>
<script>
function check(){
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
   }; // check
</script>
</body>
</html>