<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<link rel="stylesheet" type="text/css"  href="/wiicar/resources/css/reset.css">
	<style>
		
		#content {
		  width: 100%;
		  height: 100%;
		  background-color: #fff;
		  background-image: none;
		  display: flex;
		}
		
		
		#sidebar {
		  width: 25%;
		  height: 100%;
		  background-color: aquamarine;
		}
		.carpool_list_wrap {
		  width: 75%;
		  height: 100%;
		  padding:0 5%;
		}
		
		#driver, #passenger {
		  padding: 2% 3%;
		  width: 49%;
		  border-radius: 30px;
		  font-size: 18px;
		  font-weight: 900;
		  color: #fff;
		}
		
		#driver {
		  float: left;
		  background-color:cornflowerblue;
		}
		
		#passenger {
		  float:right;
		  background-color: cadetblue;
		}
		.carpool_list {
		  clear:both;
		  width: 100%;
		  padding-top: 20px;
		  margin: 0 auto;
		  position:relative;
		  text-align: center;
		}
		.list_btn {
		  display: inline-block;
		  margin: 0 auto;
		}
		.list_btn button {
		  background-color: transparent;
		  border: 1px solid #eee;
		  width: 200px;
		  margin: 0 auto;
		  padding:15px;
		  border-radius: 20px;
		}
		.list_btn button:hover {
		  background-color: #eee;
		}
		.list_content {
		  padding-top: 30px;
		}

	</style>
</head>
<body>
<div id="container" class="memberContainer">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div id="content">
		<div id="sidebar">
			<jsp:include page="memberMenu.jsp" />
		</div>
		<div id="mypage">
		    <div class="carpool_list_wrap">
		      <button id="driver">운전자</button>
		      <button id="passenger">탑승자</button>
		      <div class="carpool_list">
		        <div class="list_btn">
		          <button class="waiting">매칭 대기중</button>
		          <button class="schedule">예정된 카풀</button>
		          <button class="past">지난 카풀</button>
		        </div>
		        <div class="list_content">
		          <ul>
		            <!-- li : 카풀 카드 하나 -->
		            <li>
		              <div style="margin:auto;width:600px;background-color:#ffffff;border-radius:10px;box-shadow:5px 5px 1px 1px gray;">
		                        <div style="padding-top:20px;">
		                           <div style="margin-left:20px;font-size:20px;">
		                              <span>${carpoolList[i].depart}</span>
		                              <span class="glyphicon glyphicon-menu-right"></span>
		                              <span>${carpoolList[i].destination}</span>
		                           </div>
		                           <div style="margin-left:20px;margin-top:10px;font-size:15px;">
		                              <div>${carpoolList[i].time}</div>
		                              <div style="margin-left:auto;margin-right:20px;">인당 : ${carpoolList[i].price}원</div>
		                           </div>
		                           <div style="display:flex;margin-left:20px;margin-top:10px;">
		                              <div>
		                                 <c:forEach var="tag" items="${tagList[i]}" >
		                                    <span class="label label-default">${tag}</span>
		                                 </c:forEach>
		                              </div>
		                              <div style="margin-right:20px;margin-left:auto;">
		                                 <button class="requestBtn"
		                                  style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:#3498DB;" value="${i}">수락</button>
		                                  <button class="requestBtn"
		                                  style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:#3498DB;" value="${i}">거절</button>
		                              </div> 
		                           </div>
		                           <div style="display:flex;margin:auto;margin-top:20px;">
		                              <div style="text-align:center;margin-left:20px;">
		                                 <div style="margin-bottom:5px;color:#3498D8;font-weight:700;">운전자</div>
		                                 <div>
		                                    <c:if test="${driverIamge[i] == null}" >
		                                       <img class="userImg" src="/wiicar/resources/imgs/profile_default.png" alt="${carpoolList[i].driverId}" style="width:100%;max-width:75px;border-radius:50%;">
		                                    </c:if>
		                                    <c:if test="${driverIamge[i] != null}" >
		                                       <img class="userImg" src="/wiicar/resources/imgs/${driverIamge[i]}" alt="${carpoolList[i].driverId}"  style="width:100%;max-width:75px;border-radius:50%;">
		                                    </c:if>
		                                 </div>
		                              </div>
		                              <div style="width:120;margin-left:10px;margin-bottom:0px;margin-top:5%;">
		                                 <div>${nickname[i]}</div>
		                                 <div style="display:flex;vertical-align:middle;height:30px;">
		                                    <div style="margin-top:2px;">평점&nbsp;&nbsp;</div>
		                                    <div>
		                                       <c:forEach begin="1" end="${rate[i] / 1}">
		                                          <img src="/wiicar/resources/imgs/star.png" style="width:20px" />
		                                       </c:forEach>
		                                       <c:if test="${(rate[i] % 1) == 0.5}">
		                                          <img src="/wiicar/resources/imgs/halfstar.png" style="width:20px" />
		                                       </c:if>
		                                    </div>
		                                 </div>
		                              </div>
		                              <div style="margin-left:auto;width:50%;">
		                                 <div style="margin-bottom:5px;color:#3498D8;font-weight:700;">매칭된 탑승자</div>
		                                 <div style="display:flex;">
		                                    <c:if test="${passengerIamges[i] != null}">
		                                       <c:forEach var="j" begin="0" end="${passengercount[i]}">
		                                          <c:if test="${imgs == null}" >
		                                             <div style="margin-right:10px;">
		                                                <img class="userImg" value="${passengerId[j]}" src="/wiicar/resources/imgs/profile_default.png" style="width:100%;max-width:50px;border-radius:50%;">
		                                             </div>
		                                          </c:if>
		                                          <c:if test="${imgs != null}" >
		                                             <div style="margin-right:10px;">
		                                                <img class="userImg" value="${passengerId[j]}" src="/wiicar/resources/imgs/${passengerIamges[j]}" style="width:100%;max-width:50px;border-radius:50%;">
		                                             </div>
		                                          </c:if>
		                                       </c:forEach>
		                                    </c:if>
		                                    <c:if test="${passengerIamges[i] == null}">
		                                       <div>
		                                          아직 매칭된 탑승자가 없습니다. 
		                                       </div>
		                                    </c:if>
		                                 </div>
		                              </div>
		                           </div>
		                           <div>
		                              <div style="display:flex;padding-bottom:10px;align-items:center;">
		                                 <div style="margin-left:auto;margin-right:5px;">
		                                    <c:if test="${like[i] == 1}">
		                                       <button class="glyphicon glyphicon-heart likeBtn" style="font-size:30px;color:#ee3333;border:none;background-color:#ffffff;" value="${carpoolList[i].carpoolNum}"></button>
		                                    </c:if>
		                                    <c:if test="${like[i] == 0}">
		                                       <button class="glyphicon glyphicon-heart likeBtn" style="font-size:30px;color:gray;border:none;background-color:#ffffff;" value="${carpoolList[i].carpoolNum}"></button>
		                                    </c:if>
		                                 </div>
		                                 <div style="margin-right:20px;">
		                                    관심카풀등록
		                                 </div>
		                              </div>
		                           </div>
		                        </div>
		                     </div>              
		            </li>
		          </ul>
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