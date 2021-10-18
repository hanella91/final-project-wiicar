<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WIICAR - 개인정보 조회</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/memberMenu.css?after" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/modal.css" rel="stylesheet"type="text/css" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	
	<script>
		// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
	    Kakao.init('c261eec144799d44fa2eff2eaa350aec');
	
	    // SDK 초기화 여부를 판단합니다.
	    console.log(Kakao.isInitialized());
	
	$(document).ready(function(){
		
		// 프로필 사진
		if(!("${member.profileImage}" == null || "${member.profileImage}" == "")) {
			$("#profileImageMRPreview").attr('src', "/wiicar/resources/imgs/${member.profileImage}")
		} 
		
		$("#myPersonalInfo").addClass("clickMenu");
		
		// 이미지 등록하면 보여지게 - 프로필
		$("#profileImageMR").change(function(){
			imagePreview(this, "#profileImageMR")
			if("${sessionScope.sid}" != null && "${sessionScope.sid}" != "") {
				modifyImage("profileImageMR");
			}
		})
		
		// 성별
		if("${member.gender}" == 'male') {
			$("#gender").text("남성")
		} else if("${member.gender}" == 'female') {
			$("#gender").text("여성")
		}  
		
		// 운전자 등록 여부
		if("${member.permit}" == 2) {
			$("#permit").text("승인 완료")
		} else if("${member.permit}" == 0) {
			$("#permit").text("승인 대기")
		} else if("${member.permit}" == 1){
			$("#permit").text("승인 거절")
		}else {
			$("#permit").css('text-decoration', 'underline').css('cursor', 'pointer');
		}
		
		// 개인정보 수정 모달
		$('#modifyBtn').on('click', function(){
			document.getElementById("modifyModal").style.display = "block";			
		});
		$('.modifyCloseModal').on('click', function() {
			document.getElementById("modifyModal").style.display = "none";
		});
		
		// 비밀번호 확인
		// 개인정보 모달 비밀번호 확인
		$("#modifyCheckPw").click(function(){
			if($("#modifyPassword").val() == "${member.pw}") {
				window.location = "/wiicar/member/modifyPersonalInformation.do";
			} else {
				alert("비밀번호가 틀렸습니다.")
			}
		});
		// 회원탈퇴 모달
		$('#deleteBtn').on('click', function(){
			document.getElementById("deleteModal").style.display = "block";			
		});
		$('.deleteCloseModal').on('click', function() {
			document.getElementById("deleteModal").style.display = "none";
		});
		
		// 회원탈퇴 모달 비밀번호 확인
		$("#deleteCheckPw").click(function(){
			if($("#deletePassword").val() == "${member.pw}") {
				
				// 카카오 탈퇴(프로젝트에 등록된 정보 삭제 - 진짜 카카오 탈퇴 아님)
				
				Kakao.API.request({
				      url: '/v1/user/unlink',
				      success: function(res) {
				        // alert('success: ' + JSON.stringify(res))
				        kakaoLogout();
				      },
				      fail: function(err) {
				        // alert('fail: ' + JSON.stringify(err))
				      },
				})
				
				// db에서 삭제
				$.ajax({
					url: "deleteMember.do",
					type: "post",
					complete :function(){
						alert("정상적으로 탈퇴되었습니다.");
						window.location="/wiicar/home.do";
					}
				})
			} else {
				alert("비밀번호가 틀렸습니다.")
			}
		});
		
		// 운전자 등록 모달
		$('#permit').on('click', function(){
			if("${member.permit}" == 0) {
				$('#permitModal').modal('show');			
			}
		});
		$('.permitCloseModal').on('click', function() {
			$('#permitModal').modal('hide');
		});
		
		$(document).click(function (e) {
		    if ($(e.target).is('#modifyModal')) {
		        $('#modifyModal').fadeOut(500);
		    }
		    if ($(e.target).is('#deleteModal')) {
		        $('#deleteModal').fadeOut(500);
		    }
		    if ($(e.target).is('#permitModal')) {
		        $('#permitModal').fadeOut(500);
		    }
		});
	})
	
		function imagePreview(input, expression) {
		    if (input.files && input.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		            $(expression + "Preview").attr('src', e.target.result);
		        }
			reader.readAsDataURL(input.files[0]);
   			}
		}
	
		// 수정 - 사진
		function modifyImage(type) {
			var formData = new FormData();
			formData.append(type, $("#" + type)[0].files[0]);
			$.ajax({  
				url: "ajaxUpdateImage.do",
				type: "post",
				data: formData,
				enctype: 'multipart/form-data',
			    processData: false,    
			    contentType: false,
			    cache: false,
				complete : function() {
					if(type == "profileImageMR") {
						alert("프로필 사진이 수정되었습니다.")
					} else {
						alert("면허증이 수정되었습니다.")
					}
				}
			})
		}
		
		
	</script>
	<style>
		.memberContainer {
			padding-top:5rem;
			text-align: center;
		}
		#modifyBtn {
		    padding: 6px 25px;
		    background-color: #0096c6;
		    border-radius: 4px;
		    color: white;
		    cursor: pointer;
			display: inline-block;
		}
		
		#deleteBtn {
			line-height: .3;
			color: #FFFFFF;
			background-color: gray;
			padding-top: 0.8rem;
		    padding-right: 1rem;
		    padding-bottom: 0.8rem;
		    padding-left: 1rem;
		}
		.itemsInfo {
			padding-top: 0.7rem;
			padding-bottom: 0.7rem;
		}
		.modalClose {
			line-height: .3;
			color: #FFFFFF;
			background-color: #0096c6;
		}
		#profileImageMR {
			cursor: pointer;
		}
		.personalInfo{
			text-align:center;
			width:auto;
			max-width:500px;
			margin:auto;
			
		}			
		.modal2-content {
			margin-top: 200px ;
			padding: 10px;
			border-radius:7px;
			max-width:400px;
			width:100%;
		}
		.footerDiv {

    	}
		
		
</style>

</head>
<body style="overflow-y:auto;">
<div id="container" class="memberContainer">
	
	<jsp:include page="/WEB-INF/views/header.jsp" />
	
	
	
	
	<div id="content">
		<div id="sidebar">
			<jsp:include page="memberMenu.jsp" />
		</div>
		<div id="mypage">
			<div class="row1">
				<div class="mypageContent">
					<div class="row col-sm-9 personalInfo">
					
						<div class="col-sm-12 itemsInfo">
							<img src="/wiicar/resources/imgs/profile_default.png" id="profileImageMRPreview" class="rounded" width="150px" height="100px">
						</div> 
						<div class="col-sm-12 itemsInfo">
							<div style="padding: 10px">
								<label class="input-file-button" for="profileImageMR"> 사진 수정 </label>
								<input type="file" id="profileImageMR" name="profileImageMR" style="display:none;"/>
							</div>
						</div>
						
						<div class="col-sm-5 itemsInfo" style="font-weight: bold;">닉네임</div> 
						<div class="col-sm-7 itemsInfo">${member.nickname}</div> 
						<div class="col-sm-5 itemsInfo" style="font-weight: bold;">이름</div> 
						<div class="col-sm-7 itemsInfo">${member.name}</div> 
						<div class="col-sm-5 itemsInfo" style="font-weight: bold;">성별</div> 
						<div class="col-sm-7 itemsInfo" id="gender"></div> 					
						<div class="col-sm-5 itemsInfo" style="font-weight: bold;">생년월일</div> 
						<div class="col-sm-7 itemsInfo">${fn:substring(member.birth, 0, 10)}</div> 
						<div class="col-sm-5 itemsInfo" style="font-weight: bold;">이메일주소</div> 
						<div class="col-sm-7 itemsInfo">${member.id}</div> 
						<div class="col-sm-5 itemsInfo" style="font-weight: bold;">연락처</div> 
						<div class="col-sm-7 itemsInfo">0${fn:substring(member.phone, 0, 2)}-${fn:substring(member.phone, 2, 6)}-${fn:substring(member.phone, 6, 11)}</div>  
						<div class="col-sm-5 itemsInfo" style="font-weight: bold;">계좌번호</div> 
						<div class="col-sm-7 itemsInfo">${member.bankNo}</div> 
						<div class="col-sm-5 itemsInfo" style="font-weight: bold;">운전자 등록여부</div> 
						<div class="col-sm-7 itemsInfo" style="text-align:center">
							<div style="display:inline-block" id="permit">승인 보류</div>
						</div> 
						<div class="col-sm-12 itemsInfo">
							<button type="button" style="border:none;border-radius:5px;width:200px;height:30px;color:white;background-color:#3498DB;" id="modifyBtn">개인정보 수정</button>
						</div>
						<div class="col-sm-12 itemsInfo">
							<button type="button" style="border:none;border-radius:5px;width:200px;height:30px;color:white;background-color:gray;" id="deleteBtn">회원탈퇴</button>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	
		
		<!-- 개인정보 수정 모달 -->
		<div class="modal2" id="modifyModal">
				<div class="modal2-content">
					<div class="modal2-header">
						<h5 class="modal2-title" style="text-align: center;">정보 수정을 원하시면 비밀전호를 입력하세요.</h5>
						<button type="button" class="close modifyCloseModal" data-dismiss="permitModal" aria-label="Close">
						</button>
					</div>
					<div class="modal2-body" style="text-align:center;margin-top:10px;">
						<input type="password" id="modifyPassword"/>
					</div>
					<div class="modal2-footer">
						<button type="button" style="border:none;border-radius:5px;width:100px;height:30px;color:white;background-color:#3498DB;line-height: .3;" id="modifyCheckPw">수정</button>
						<button type="button" style="border:none;border-radius:5px;width:100px;height:30px;color:white;background-color:gray;line-height: .3;" class="modifyCloseModal" data-dismiss="modal">닫기</button>
					</div>
			</div>
		</div>
		
		<!-- 회원탈퇴 수정 모달 -->
		<div class="modal2" id="deleteModal">
				<div class="modal2-content">
					<div class="modal2-header">
						<h5 class="modal-title" style="text-align: center;">회원탈퇴를 원하시면 비밀전호를 입력하세요.</h5>
						<button type="button" class="close deleteCloseModal" data-dismiss="deleteModal" aria-label="Close">
						</button>
					</div>
					<div class="modal2-body" style="text-align:center;margin-top:10px;">
						<input type="password" id="deletePassword"/>
					</div>
					<div class="modal2-footer">
						<button type="button" id="deleteCheckPw" style="border:none;border-radius:5px;width:100px;height:30px;color:white;background-color:#3498DB;line-height: .3;">확인</button>
						<button type="button" class="deleteCloseModal" data-dismiss="modal" style="border:none;border-radius:5px;width:100px;height:30px;color:white;background-color:gray;line-height: .3;">닫기</button>
					</div>
			</div>
		</div>
	
		<!-- Permit Modal -->
		<div class="modal2" id="permitModal">
				<div class="modal2-content">
					<div class="modal2-header">
						<h5 class="modal2-title" style="text-align: center;"><b>승인 보류 사유</b></h5>
						<button type="button" class="close permitCloseModal" data-dismiss="permitModal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal2-body">
						<p>관리자 승인 전</p>
					</div>
					<div class="modal2-footer">
						<button type="button" class="permitCloseModal" data-dismiss="permitModal" style="border:none;border-radius:5px;width:100px;height:30px;color:white;background-color:#3498DB;line-height: .3;">확인</button>
					</div>
			</div>
		</div>
	</div>
</div>
	<!-- FOOTER -->
	<div class="footerDiv" style="position: relative; width: 100%;">
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	</div>
	
	
</body>
</html>