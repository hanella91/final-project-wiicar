<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WIICAR | QNA</title>
	<link href="/wiicar/resources/css/board.css" rel="stylesheet"type="text/css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script>
		var filter = "";
		var search = "";
		var myQna = "";
		var pageNum = "";
		var qnaListData;
		$(document).ready(function(){
			if('${pageNum}' != null && '${pageNum}' != "") {
				pageNum = '${pageNum}';
			}
			if('${search}' != null && '${search}' != "") {
				search = '${search}';
			}
			if('${myQna}' != null && '${myQna}' != "") {
				myQna = '${myQna}';
			}
			if('${filter}' != null && '${filter}' != "") {
				filter = '${filter}';
				alert(filter);
				if(filter == '0') {
					$("#slide-item-0").val("0").prop("selected", true);
				} else if(filter == '1') {
					$("#slide-item-1").val("1").prop("selected", true);
				} else if(filter == '2') {
					$("#slide-item-2").val("2").prop("selected", true);
				} else if(filter == '3') {
					$("#slide-item-3").val("3").prop("selected", true);
				} else if(filter == '4') {
					$("#slide-item-4").val("4").prop("selected", true);
				} else if(filter == '5') {
					$("#slide-item-5").val("5").prop("selected", true);
				}
			}
			getQnaList();
			
			$("#writeQna").click(function(){
				window.location="/wiicar/qnaboard/writeQna.do";
			});
			
			$("#m_exit").click(function(){
				history.back();
			});
			
			$(".slidemenu input[type='radio'][name='slideItem']").click(function() {
				var id=$(this).attr('id');
				
				if(id == "slide-item-0") {
					$("input:radio[name='filter']:checked").val("0").prop("selected", true);
					filter = '0';
				} else if(id == "slide-item-1") {
					$("input:radio[name='filter']:checked").val("1").prop("selected", true);
					filter = '1';
				} else if(id == "slide-item-2") {
					$("input:radio[name='filter']:checked").val("2").prop("selected", true);
					filter = '2';
				} else if(id == "slide-item-3") {
					$("input:radio[name='filter']:checked").val("3").prop("selected", true);
					filter = '3';
				} else if(id == "slide-item-4") {
					$("input:radio[name='filter']:checked").val("4").prop("selected", true);
					filter = '4';
				} else if(id == "slide-item-5") {
					$("input:radio[name='filter']:checked").val("5").prop("selected", true);
					filter = '5';
				}
				
				getQnaList();
			});
			
			
			$("#myqna").click(function(){
				if('${sessionScope.sid}' != null && '${sessionScope.sid}' != "") {
					$("#filter").val("0").prop("selected", true);
					filter = "";
					search = "";
					pageNum = "1";
					myQna = "1";
					getQnaList();
				} else {
					alert("로그인 후 사용할 수 있습니다.");
					return false;
				}
			});
		});
		

		function getQnaList() {
			$.ajax({
				url : "/wiicar/qnaboard/getQnaList.do",
				type : "POST",
				data : {"filter" : filter, "search" : search, "myQna" : myQna, "pageNum" : pageNum},
				success : function(data){
					makeQnaList(data);
				}, 
				error : function(request, status, error) {
	        	    alert("list search fail :: error code: "
	                    + request.status + "\n" + "error message: "
	                    + error + "\n");
                }
			})
		}
		function getQnaCateString(qnaCateNum) {
			if(qnaCateNum == 1) {
				return '[ 운전자문의 ]';
			} else if(qnaCateNum == 2) {
				return '[ 탑승자문의 ]';
			} else if(qnaCateNum == 3) {
				return '[결제/환불문의 ]';
			} else if(qnaCateNum == 4) {
				return '[ 사이트 이용문의 ]';
			} else if(qnaCateNum == 5) {
				return '[ 기타 ]';
			}
		}
		
		function getDateString(qnaDateTime) {
			var dateDate = new Date(qnaDateTime);
			var dateToString = (dateDate.getMonth() + 1) + "월";
			dateToString += dateDate.getDate() + "일 ";
			dateToString += dateDate.getHours() + "시";
			dateToString += dateDate.getMinutes() + "분";
			return dateToString
		}
		
		function makeQnaList(data) {
			$( "#qnaList" ).empty();
			if(data['filter'] != null && data['filter'] != "") {
				filter = data['filter'];
			}
			if(data['search'] != null && data['search'] != "") {
				search = data['search'];
			}
			if(data['myQna'] != null && data['myQna'] != "") {
				myQna = data['myQna'];
			}
			if(data['pageNum'] != null && data['pageNum'] != "") {
				pageNum = data['pageNum'];
			}
			qnaListData = data["qnaList"];
			
			if(data['count'] == 0) {
				$("#qnaList").append("<div>게시글이 없습니다.</div>");
			} else if(data['count'] != 0) {
				var addHTML = '<ul class=\"list-group\">';
				
				for(let i = 0 ; i < qnaListData.length ; i++) {
					var qna = Object.values(qnaListData[i]);
					var qnaCateDATA = getQnaCateString(qna[8]);
					var dateDATE = getDateString(qna[7]);
					
					
					addHTML += '<li class=\"board-item\" onclick=\"viewQnaContent(' + qna[0] + ', \'' + qna[1] + '\', ' + qna[9] + ')\">';
					addHTML += '<div class=\"board-info\" style="width:100%"><div class=\"type\">' + qnaCateDATA + '</div><div class=\"contents\"><div class=\"subject\">';
					if(qna[9] == 0) {
						addHTML += qna[3];
					} else if(qna[9] == 1) {
						if('${sessionScope.sid}' == qna[1]) {
							addHTML += '<div class=\"lock-img\"><img src=\"/wiicar/resources/imgs/lock.png\" width=\"20px\"/></div><div class=\"title\">' + qna[3] + '</div>';
						} else if('${sessionScope.sid}' != qna[1]) {
							addHTML += '<div class=\"lock-img\"><img src=\"/wiicar/resources/imgs/lock.png\" width=\"15px\"/></div><div class=\"title\">비밀글입니다.</div>';
						}
					}
					addHTML += '</div><div class=\"info\"><div class=\"writer\">' + qna[1] + '</div><div class=\"date\">' + dateDATE + '</div><div class=\"hit\">' + qna[10] + '</div></div></div></li>';
				}
				addHTML += '</ul>';
				$("#qnaList").append(addHTML);
			} 
			makePageNumbers(data);
		} 		
		
		function makePageNumbers(data) {
			$( "#pagenum" ).empty();
			var addHTML = '<div class=\"pagenum\">';
			if(data["count"] > 0) {
				if(data["startPage"] > data["pageBlock"]) {
					addHTML += '<a id=\"previousPage\" onclick=\"selectPage(' + (data["startPage"] - 1) + ');\"> &lt; </a>&nbsp;';
				}
				
				for(let i = data["startPage"] ; i <= data["endPage"] ; i++) {
					addHTML += '&nbsp;<a id=\"selectPage\" onclick=\"selectPage(' + i + ');\">' + i + '</a>&nbsp;';
				}
				
				if(data["endPage"] < data["pageCount"]) {
					addHTML += '&nbsp;<a id=\"nextPage\" onclick=\"selectPage(' + (data["startPage"] + data["pageBlock"]) + ');\"> &gt; </a>';
				}
			}
			addHTML += '</div>';
			$("#pagenum").append(addHTML);
		}

		function selectPage(page) {
			if(page == pageNum) {
				return false;
			}
			pageNum = page;
			getQnaList();
		}
		
		function searchQnaList() {
			$("#filter").val("0").prop("selected", true);
			search = $("#search").val();
			pageNum = "1";
			myQna = "";
			if($(".select-box__input#0").is(":checked")) {
				filter = "0";
			} else if($(".select-box__input#1").is(":checked")) {
				filter = "1";
			} else if($(".select-box__input#2").is(":checked")) {
				filter = "2";
			} else if($(".select-box__input#3").is(":checked")) {
				filter = "3";
			} else if($(".select-box__input#4").is(":checked")) {
				filter = "4";
			} else if($(".select-box__input#5").is(":checked")) {
				filter = "5";
			}
			getQnaList();
		}
	
		function viewQnaContent(num, writer, closed) {
			var contentUrl = "/wiicar/qnaboard/qnaContent.do?qnaNum=" + num;
			if(pageNum != "") {
				contentUrl = contentUrl + "&pageNum=" + pageNum;
			}
			if(filter != "") {
				contentUrl = contentUrl + "&filter=" + filter;
			}
			if(search != "") {
				contentUrl = contentUrl + "&search=" + search;
			}
			if(myQna != "") {
				contentUrl = contentUrl + "&myQna=1";
			}
			if(closed == 0) {
				window.location = contentUrl;
			} else if(closed == 1) {
				if('${sessionScope.sid}' == writer) {
					window.location = contentUrl;					
				} else {
					alert("비공개 QNA입니다.");
				}
			}
		}
		
	</script>
	
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
		<h1 class="m_menu"><button id="m_exit" stlye="left:0 !important; top:10px !important;"></button>문의 게시판</h1>
		
		 <div class="board-header">
			<div class="mid">질문유형</div>
			<div class="lar">제목</div>
			<div class="mid">작성자</div>
			<div class="mid">작성일</div>
			<div class="mi">조회수</div>
	    </div>
		
		<nav class="slidemenu">
			<!-- Item 0 -->
			<input type="radio" name="slideItem" id="slide-item-0" class="slide-toggle" checked/>
			<label for="slide-item-0"><span>전체</span></label>
			<!-- Item 1 -->
			<input type="radio" name="slideItem" id="slide-item-1" class="slide-toggle"/>
			<label for="slide-item-1"><span>운전자문의</span></label>
			<!-- Item 2 -->
			<input type="radio" name="slideItem" id="slide-item-2" class="slide-toggle"/>
			<label for="slide-item-2"><span>탑승자문의</span></label>
			<!-- Item 3 -->
			<input type="radio" name="slideItem" id="slide-item-3" class="slide-toggle"/>
			<label for="slide-item-3"><span>결제/환불문의</span></label>
			<!-- Item 4 -->
			<input type="radio" name="slideItem" id="slide-item-4" class="slide-toggle"/>
			<label for="slide-item-4"><span>사이트 이용 문의</span></label>
			  <!-- Item 5 -->
			<input type="radio" name="slideItem" id="slide-item-5" class="slide-toggle"/>
			<label for="slide-item-5"><span>기타</span></label>
			<div class="clear"></div>
			<!-- Bar -->
			  <div class="slider">
			    <div class="bar"></div>
			  </div>
			</nav>
			<div id="qnaList">
			
			</div>
		<!-- 
			<c:if test="${map.count == 0}">
				<div>게시글이 없습니다.</div>>
			</c:if>
			<c:if test="${map.count != 0}">
			<div id="qnaList">
				<ul class="list-group">
					<c:forEach var="qna" items="${qnaList}">
						<li class="board-item" onclick="viewQnaContent(${qna.num}, '${qna.writer}', ${qna.closed})">			
							<div class="board-info">									
								<div class="type">
									<c:if test="${qna.qnaCate == 1}">
										[ 운전자문의 ]										
									</c:if>
									<c:if test="${qna.qnaCate == 2}">
										[ 탑승자문의 ]										
									</c:if>
									<c:if test="${qna.qnaCate == 3}">
										[ 결제/환불문의 ]										
									</c:if>
									<c:if test="${qna.qnaCate == 4}">
										[ 사이트 이용문의 ]										
									</c:if>
									<c:if test="${qna.qnaCate == 5}">
										[ 기타 ]										
									</c:if>
								</div>
								<div class="contents">
									<div class="subject">
									<c:if test="${qna.closed == 0}">
										${qna.title}									
									</c:if>
									<c:if test="${qna.closed == 1}">
										<c:if test="${sessionScope.sid == qna.writer}">
											<div class="lock-img">
												<img src="/wiicar/resources/imgs/lock.png" width="20px"/>
											</div>							
											<div class="title">
												${qna.title}	
											</div>							
										</c:if>		
										<c:if test="${sessionScope.sid != qna.writer}">
											<div class="lock-img">
												<img src="/wiicar/resources/imgs/lock.png" width="15px"/>
											</div>							
											<div class="title">
												비밀글입니다.
											</div>							
										</c:if>							
									</c:if>
									</div>
									<div class="info">
										<div class="writer">
											${qna.writer}
										</div>
										<div class="date">
											${fn:substring(qna.reg, 0, 10)}
										</div>
										<div class="hit">
											${qna.hit}
										</div>
									</div>
								</div>
							</div>
						</li>					
					</c:forEach>
				</ul>	
			</div>
			</c:if>
			 -->
			<div id="pagenum">
			
			</div>
			
			<!-- 
			<div class="pagenum">
				<!-- 페이지 번호 
				<c:if test="${map.count > 0}">
					<c:if test="${map.startPage > map.pageBlock}">
						<a id="previousPage" onclick="previousPage();"> &lt; </a>&nbsp;
					</c:if>
					<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}" step="1">
						&nbsp;<a id="selectPage" onclick="selectPage(${i});"> ${i} </a>&nbsp;
					</c:forEach>
					<c:if test="${endPage < pageCount}">
						&nbsp;<a id="nextPage" onclick="nextPage();"> &gt; </a>
					</c:if>
				</c:if> 
			</div>
			 -->
			<div class="btn-wrap">				
				<div class="btn1">
					<button type="button" class="myqna" id="myqna">내가 쓴 글보기</button>
				</div>
				<div class="btn2">
					<button type="button" id="writeQna">글쓰기</button>
				</div>
			</div>
				
			<!-- 검색 -->
			<div class="select-wrap">
			    <div class="select-box">
				  <div class="select-box__current" tabindex="1">
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="0" value="0" name="filter" checked="checked"/>
				      <p class="select-box__input-text">문의 유형 선택</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="1" value="1" name="filter"/>
				      <p class="select-box__input-text">운전자 문의</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="2" value="2" name="filter"/>
				      <p class="select-box__input-text">탑승자 문의</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="3" value="3" name="filter"/>
				      <p class="select-box__input-text">결제/환불 문의</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="4" value="4" name="filter"/>
				      <p class="select-box__input-text">사이트이용 문의</p>
				    </div>
				    <div class="select-box__value">
				      <input class="select-box__input" type="radio" id="5" value="5" name="filter"/>
				      <p class="select-box__input-text">기타</p>
				    </div>
				    <img class="select-box__icon" src="http://cdn.onlinewebfonts.com/svg/img_295694.svg" alt="Arrow Icon" aria-hidden="true"/>
				  </div>
				  <ul class="select-box__list">
				    <li>
				      <label class="select-box__option" for="0" aria-hidden="aria-hidden">문의 유형 선택</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="1" aria-hidden="aria-hidden">운전자 문의</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="2" aria-hidden="aria-hidden">탑승자 문의</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="3" aria-hidden="aria-hidden">결제/환불 문의</label>
				    </li>
				    <li>
				      <label class="select-box__option" for="4" aria-hidden="aria-hidden">사이트이용 문의</label>
				    </li>
   				    <li>
				      <label class="select-box__option" for="5" aria-hidden="aria-hidden">기타</label>
				    </li>
				  </ul>
				</div>
				<div class="input-group">
					<input type="text" name="search" class="form-control" id="search" required="">
				</div>
				<div class="sub-btn">
					<button type="button" class="btn" onclick="searchQnaList();">검색</button>
				</div>

				
			</div>	
	
			<%-- 작성자/내용 검색 --%>
			<div class="row mb-3">
			</div>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</div>
</body>
</html>
								
								
								
