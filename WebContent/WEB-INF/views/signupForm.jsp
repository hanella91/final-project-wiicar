<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WIICAR - 회원가입</title>
  	<link href="/wiicar/resources/css/reset.css" rel="stylesheet"type="text/css" />
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  	<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
	<script>
		// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('c261eec144799d44fa2eff2eaa350aec');
		
		var verifyCode = '0000'
		var pwCheck = false;
		var birthCheck = false;
		var verifyCheck = false;
		var nicknameCheck = false;
		var preferences = 1
		
		$(document).ready(function(){
			
			notiDisplayTest();
			MemberCheck();
			
			
		    $("#loginBtn").click(function(){
		    	const url = "/wiicar/loginPopup.do";
				const name = "로그인";
				var popupWidth = 700;
				var popupHeight = 500;
				var popupX = (window.screen.width/2) - (popupWidth/2);				
				var popupY= (window.screen.height/2) - (popupHeight/2);
				var option = 'height =' + popupHeight + ', width=' + popupWidth + ', top =' + popupY + ', left =' + popupY + ', location = no';
				window.open(url, name, option);    	
		    }) 
		    
			// 로그아웃
			$("#logoutBtn").click(function(){
				if (!Kakao.Auth.getAccessToken()) {
					alert('Not logged in.');
				return
				}
				Kakao.Auth.logout(function() {
					$.ajax({
						url: "/wiicar/logout.do",
						type: "post"
					});
					alert("로그아웃 성공");
					window.location='/wiicar/home.do';
				})
			});
			
			// 정보 수정으로 왔으면 필요 없는 입력창들 숨기고 db에 저장된 정보들 입력해주기
			if("${sessionScope.sid}" != null && "${sessionScope.sid}" != "") {
				// 입력칸 숨기기
				$("#pw").val("${member.pw}");
				$("#pw").val("${member.pw}");
				$("#phone").val("${member.phone}");
				
				$("#pwDiv").hide();
				$("#pwConfirmDiv").hide();
				$("#phoneDiv").hide();
				$("#verifyDiv").hide();
				// 정보 입력 - 필수 기입
				$("#id").val("${member.id}");
				$("#nickname").val("${member.nickname}");
				$("#name").val("${member.name}");
				$("#birth").val("${fn:substring(member.birth, 0, 10)}");
				
				if(checkBirthRE($("#birth").val())) {
					birthCheck = true;
				} else {
					birthCheck = false;
				}
				if("${member.gender}" == 'male') {
					$("#gender1").prop("checked", true);
				} else {
					$("#gender2").prop("checked", true);
				}
				// 정보 입력 - 선택 기입
				
				if(!("${member.profileImage}" == null || "${member.profileImage}" == "")) {
					$("#profileImageMRPreview").attr('src', "/wiicar/resources/imgs/${member.profileImage}")
				} 
				if(!("${member.preference}" == null || "${member.preference}" == "")) {
					var pref = "${member.preference}";
					preferences = pref.length
					for(var i = 0 ; i < pref.length ; i++) {
						if(i > 0) {
							addPreference(i + 1);
						}						
					}
					for(var i = 0 ; i < pref.length ; i++) {
						$("#inputPreference" + (i + 1) + " option:eq(" + pref[i] + ")").prop("selected", true);
					}
				} 
				
				// 운전자 정보 기입
				if(!("${member.licenseImage}" == null || "${member.licenseImage}" == "")) {
					$("#licenseImageMRPreview").attr('src', "/wiicar/resources/imgs/${member.licenseImage}")
				} 
				if(!("${member.carModel}" == null || "${member.carModel}" == "")) {
					if("${member.carModel}" == "1") $("#carModel option:eq(1)").prop("selected", true);
					else if("${member.carModel}" == "2") $("#carModel option:eq(2)").prop("selected", true);
					else if("${member.carModel}" == "3") $("#carModel option:eq(3)").prop("selected", true);
				} 
				
				$("#signupButtons").hide();
			} else {
				// 카카오 정보 조회
				Kakao.API.request({
			    	url: '/v2/user/me',
			        success: function(res) {
			        	var id = res.kakao_account.email
						var name = res.kakao_account.profile.nickname
						var gender = res.kakao_account.gender
						
							$("#id").val(id);
						
			        	
			        		$("#name").val(name);
			        	
			        	
			        		if(gender == 'male') {
			        			$("#gender1").prop("checked", true);
			        		} else {
			        			$("#gender2").prop("checked", true);
			        		}
			        	
			        	// alert(JSON.stringify(res))
			        },
			        fail: function(error) {
			        	// alert('login success, but failed to request user information: ' + JSON.stringify(error))
			        },
				})
				$("#modifyButtons").hide();
			}
			
			// 성향 추가
			$("#add_btn").click(function(){
				preferences = preferences + 1;
				addPreference(preferences);
			})
			
			// 성향 삭제
			$("#minus_btn").click(function(){
				if(preferences == 1) {
					alert("더 이상 삭제할 수 없습니다.")
					return
				}
				var pref_id = "selector_number" + preferences
				$("#" + pref_id).remove()
				preferences = preferences - 1
			})
			
			// 이미지 등록하면 보여지게 - 프로필
			$("#profileImageMR").change(function(){
				imagePreview(this, "#profileImageMR")
				if("${sessionScope.sid}" != null && "${sessionScope.sid}" != "") {
					modifyImage("profileImageMR");
				}
			})
			
			// 이미지 등록하면 보여지게 - 면허
			$("#licenseImageMR").change(function(){
				imagePreview(this, "#licenseImageMR")
				if("${sessionScope.sid}" != null && "${sessionScope.sid}" != "") {
					modifyImage("licenseImageMR");
				}
			})
			
			// 이미지 뛰우기
			function imagePreview(input, expression) {
			    if (input.files && input.files[0]) {
			        var reader = new FileReader();
			        reader.onload = function (e) {
			            $(expression + "Preview").attr('src', e.target.result);
			        }
				reader.readAsDataURL(input.files[0]);
    			}
			}
			
			// 전화번호 인증
			$("#sendVerifyBtn").click(function(){
				if(checkPhoneRE($("#phone").val())) {
					$.ajax({
						url : "/wiicar/verifyPhone.do",
						type : "post",
						data : {phone : $("#phone").val()},
						success : function(data) {
							verifyCode = data
							$("#phone").attr("readonly", true);
						},
						error : function(e) {
							alert("인증번호 전송 실패")
						}
					})									
				} else {
					alert("전화번호를 정확하게 입력해주세요.")
				}
			})
			
			// 닉네임 중복확인
			$("#nicknameCheckBtn").click(function(){
				if($("#nickname").val() == "") {
					alert("닉네임을 입력해주세요.");
				} else {
					if('${sessionScope.sid}' != null && '${sessionScope.sid}' != '') {
						if($("#nickname").val() == '${sessionScope.sid}') {
							$("#nicknameRE").text("사용 가능한 닉네임입니다.");
							$("#nicknameRE").css("color","blue");
							nicknameCheck = true;	
							return;
						}
					}
					$.ajax({
						url : "/wiicar/checkNickname.do",
						type : "post",
						data : {nickname : $("#nickname").val()},
						success : function(data) {
							if(data == 1) {
								alert("이미 사용중인 닉네임입니다.");
								$("#nicknameRE").text("이미 사용중인 닉네임입니다.");
								$("#nicknameRE").css("color","red");
							} else {
								alert("사용가능한 닉네임입니다.");
								$("#nicknameRE").text("사용 가능한 닉네임입니다.");
								$("#nicknameRE").css("color","blue");
								nicknameCheck = true;
							}
						},
						error : function(e) {
							alert("닉네임 중복확인 실패");
						}
					})														
				}
			})
			
			// 닉네임 상태 변경
			$("#nickname").on("propertychange change keyup paste input", function() { 
				$("#nicknameRE").text("닉네임 중복확인 해주세요.");
				$("#nicknameRE").css("color","purple");
				nicknameCheck = false;
				
			});
			
			// ********* 정규식 검사 *********
			// 비밀번호
			$("#pw").on("propertychange change keyup paste input", function() {
				if(checkPwRE($("#pw").val())) {
					$("#pwRE").text("사용가능한 비밀번호입니다.")
					$("#pwRE").css("color","blue");
					pwCheck = true;
				} else {
					$("#pwRE").text("영어, 숫자, 특수문자를 포함하여 8글자 이상.")
					pwCheck = false;
				}
			})
			// 비밀번호 확인
			$("#pwConfirm").on("propertychange change keyup paste input", function(){
				if($("#pw").val() == $("#pwConfirm").val()) {
					$("#pwConfirmRE").text("비밀번호가 일치합니다.")
					$("#pwConfirmRE").css("color", "blue")
				} else {
					$("#pwConfirmRE").text("비밀번호가 일치하지 않습니다.")
				}
			})
			// 생년월일
			$("#birth").on("propertychange change keyup paste input", function(){
				if(checkBirthRE($("#birth").val())) {
					birthCheck = true;
				} else {
					birthCheck = false;
				}
			})
			//***********************************
			// 인증번호
			$("#verifyBtn").click(function(){
				if($("#verifyCode").val() == verifyCode) {
					$("#verifyRE").text("인증 성공")
					$("#verifyRE").css("color", "blue")
					$("#verifyCode").attr("readonly", true);
					$("#phone").attr("readonly", true);
					verifyCheck = true;
				} else {
					alert("인증번호가 틀렸습니다.")
				}
			})
			// 다시 인증하기
			$("#reVerifyBtn").click(function(){
				$("#verifyCode").removeAttr("readonly");
				$("#phone").removeAttr("readonly");
				verifyCheck = false;
			})
			
			// 수정 - 돌아가기
			$("#modifyReturnBtn").click(function(){
				window.location = "/wiicar/member/personalInformation.do";
			})
	
			// 수정 - 수정하기
			$("#modifyConfirmBtn").click(function(){	
				var formData = new FormData(); 
				var genderModify = null;
				
				if($("#name").val() == "") {
					return returnfalse("이름을 입력해주세요.")
				} else if($("#birth").val() == "") {
					return returnfalse("생년월일을 입력해주세요.")
				} else if($("#gender").val() == "") {
					return returnfalse("성별을 선택해주세요.")
				} else if(birthCheck == false) {
					return returnfalse("생년월일을 형식에 맞게 입력해주세요.")
				} else if(nicknameCheck == false) {
					return returnfalse("닉네임을 입력/중복확인 해주세요.")
				} 
				
				formData.append("id", $("#id").val()); 
				formData.append("name", $("#name").val()); 
				formData.append("birth", $("#birth").val() + " 00:01:01"); 
				formData.append("carModel", $("#carModel").val()); 
				formData.append("bankNo", $("#bankNo").val()); 
				formData.append("nickname", $("#nickname").val()); 
				
				if($("#gender1").is(":checked")) {
					genderModify = "male";
				} else if($("#gender2").is(":checked")) {
					genderModify = "female";
				} else {
					genderModify = null;
				}
				formData.append("gender", genderModify); 
				
				$("#preference").val("");
				if(preferences > 1) {
					for(let i = 1 ; i <= preferences ; i++) {
						let id = "inputPreference" + i
						$("#preference").val($("#preference").val() + $("#"+id).val())
					}
				} else {
					$("#preference").val($("#inputPreference1").val())
				}
				formData.append("preference", $("#preference").val()); 
				
				$.ajax({  
					url: "/wiicar/member/ajaxUpdateMember.do",
					type: "post",
					data: formData,
					enctype: 'multipart/form-data',
				    processData: false,    
				    contentType: false,
				    cache: false,
					complete : function() {
						alert("개인정보가 수정되었습니다.")
					}
				})
			})
		})
		
		function notiDisplayTest() {
			$.ajax({
				url : "/wiicar/alerts/countAllNoti.do",
				type : "post",
				success : function(data) {
					 $('#notiCnt').text(data.alertCnt);
					 console.log("총 개수 !! ==> "+ data.alertCnt);
					 console.log("size !! ==> "+ data.qSize);
					 console.log("List.length !! ==> "+ data.alertList.length);
					 for(var i=0;i<data.qSize;i++){
					 var html="";
					 html+="<li class='chat-room'>";
					 html+="<input class='carpoolnum' name='carpoolnum' type='hidden' value='"+data.alertList[i].carpoolnum+"'>"
					 html+="<input class='user_roomnum' name='user_roomnum' type='hidden' value='"+data.alertList[i].chatRoom+"'>"
					 html+="<input class='chatId' name='chatId' type='hidden' value='"+data.alertList[i].opp+"'>"
					 html+="<div class='img'><div class='user_img'><img src=''/wiicar/resources/imgs/profile.png' alt='' width='10px' height='10px'></div></div>"
					 html+=" <div class='txt chatRoomList'><div class='user_name'>"+data.alertList[i].opp+"</div>";
					 html+="<div class='message'>"+data.alertList[i].lastChat+"<span class='position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger alertNotiBadge'>"+data.alertList[i].unreadMsg+"</span>"
					 html+="<div class='time'>"+new Date(data.alertList[i].reg).toLocaleString().substring(0, 15)+"</div></div>";
	                 html+="</li>";
	                 
	                 $('.chat-list').append(html);
					 }
					 $('.chat-room').click(function(){
						 var carpoolnum = $(this).find('.carpoolnum').val();
						 var user_roomnum = $(this).find('.user_roomnum').val();
						 var chatId = $(this).find('.chatId').val();
						 window.location="/wiicar/carpool/chatting.do?roomnum="+user_roomnum+"&chatId="+chatId+"&carpoolnum="+carpoolnum+"";
					 });// chat-room'
				}			
			}); // ajax	
		} //notiDisplayTest
	
		function addPreference(preferences) {
			var add_selector_html = "<div class=\"row mb-3\" id=\"selector_number" + preferences +"\">" + 
			"<div class=\"col-sm-3\">" + 
				"<div class=\"col-sm-3 col-form-label\"></div>" + 
			"</div>" + 
			"<div class=\"col-sm-4 selector align=\"left\">" +
				"<select class=\"form-select\" id=\"inputPreference" + preferences +"\">" +
					"<option value=\"0\" selected>성향을 선택해주세요</option>" +
					"<option value=\"1\">대화가 없는 걸 선호해요.</option>" +
					"<option value=\"2\">사적인 질문은 피해주세요.</option>" +
					"<option value=\"3\">적당한 대화가 좋아요.</option>" +
					"<option value=\"4\">음악 듣는 걸 좋아해요.</option>" +
					"<option value=\"5\">반려동물과 같이 가도 괜찮아요.</option>" +
					"<option value=\"6\">반려동물과 같이 가도 싶지 않아요.</option>" +
				"</select>" +
			"</div>" + 
			"</div>"
			document.getElementById('add_selector').innerHTML += add_selector_html
		}
		
		// 필수기입 입력 검사
		function checkVal() {

			if($("#pw").val() == "") {
				$("#pw").focus();
				return returnfalse("비밀번호를 입력해주세요.")
			} else if($("#pwConfirm").val() == "") {
				$("#pwConfirm").focus();
				return returnfalse("확인 비밀번호를 입력해주세요.")
			} else if($("#pw").val() != $("#pwConfirm").val()) {
				$("#pwConfirm").focus();
				return returnfalse("비밀번호와 비밀번호 확인이 일치하지 않습니다.")
			} else if($("#nickname").val() == "") {
				$("#nickname").focus();
				return returnfalse("닉네임을 입력해주세요.")
			} else if($("#name").val() == "") {
				$("#name").focus();
				return returnfalse("이름을 입력해주세요.")
			} else if($("#birth").val() == "") {
				$("#birth").focus();
				return returnfalse("생년월일을 입력해주세요.")
			} else if($("#phone").val() == "") {
				$("#phone").focus();
				return returnfalse("전화번호를 입력해주세요.")
			} else if($("#gender").val() == "") {
				$("#gender1").focus();
				return returnfalse("성별을 선택해주세요.")
			} else if(pwCheck == false) {
				$("#pw").focus();
				return returnfalse("비밀번호를 형식에 맞게 입력해주세요")
			} else if(birthCheck == false) {
				$("#birth").focus();
				return returnfalse("생년월일을 형식에 맞게 입력해주세요.")
			} else if(verifyCheck == false) {
				$("#verifyDiv").focus();
				return returnfalse("핸드폰을 인증해주세요.")
			} else if(nicknameCheck == false) {
				$("#nicknameCheckBtn").focus();
				return returnfalse("닉네임을 입력/중복확인 해주세요.")
			}
			
			// 성향 sum
			$("#preference").val("");
			if(preferences > 1) {
				for(let i = 1 ; i <= preferences ; i++) {
					let id = "inputPreference" + i
					$("#preference").val($("#preference").val() + $("#"+id).val())
				}
			} else {
				$("#preference").val($("#inputPreference1").val())
			}			
			
			// 생년월일 timestamp 형식에 맞게
			$("#birth").val($("#birth").val() + " 00:01:01");
			return true;
		}
		
		
		// alert + return false
		function returnfalse(msg) {
			alert(msg)
			return false;
		}
		
		// 영어 + 숫자 + 특수문자 포함
		function checkPwRE(text) {
			const reg = /^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[~#?!@$%^&*-]).{8,}$/;
			if(reg.test(text) === false) {
				return false;
			} else {
				return true;
			}
		}
		
		function checkBirthRE(text) {
			const reg = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
			if(reg.test(text) == false) {
				return false;
			} else {
				return true;
			}
		}
		
		function checkPhoneRE(text) {
			const reg =/^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$/
			if(reg.test(text) == false) {
				return false;
			} else {
				return true;
			}
		}
		
		// 수정 - 사진
		function modifyImage(type) {
			var formData = new FormData();
			formData.append(type, $("#" + type)[0].files[0]);
			$.ajax({  
				url: "/wiicar/member/ajaxUpdateImage.do",
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
		
		function MemberCheck(){
			console.log("sid ==> " + '${sessionScope.sid}');
			$.ajax({
				url : '/wiicar/member/memberCheck.do',
				type : 'POST',
				success:function(data){
					console.log("data ==> "+data);
	                <!-- 일반회원, 관리자회원 구분하기 -->
	                if('${sid}' == null || '${sid}' == ''){
		                <!-- 로그인 안했을 경우 -->
	                	$('#myPageBtn').hide();
	                	$('#logoutBtn').hide();
	                	$('#adminBtn').hide();
		            } else {
	                	if(data.subAdmin == 0 ){
	                    	$('#adminBtn').hide();
	               	 	}
	                	$('#loginBtn').hide();
	                }
				},
				error:function(){
					alert("다시시도해 주세요.");
				}
				
			}); // ajax
		} // MemberCheck;	
	</script>
	<style>
		
		.signupContainer {
			text-align: center;
		}
		.signupBtn {
			line-height: .3;
		}
		.categories {
			padding-top: 30px;
			font-size: 1.25rem;
			text-align: left;
		}
		form {
			display: inline-block;
			padding: 40px;
			width: 70%;
			text-align: center;
		}
		hr {
    	    border:0;
   		 	margin:0;
   		 	margin-bottom: 10px;
	    	width:100%;
    		background-color: #808080;
    	}
		.input-file-button{
			 padding: 6px 25px;
			 background-color:#0096c6;
			 border-radius: 4px;
			 color: white;
			 cursor: pointer;
		}
		.verifyBtn {
			background-color: #0096c6;
			padding-top: 0.5rem;
		    padding-right: 0.5rem;
		    padding-bottom: 0.5rem;
		    padding-left: 0.5rem;
		    letter-spacing: 0.1rem;
		}
		
	</style>
</head>
<body>
	<div class="container signupContainer">
	<!-- HEADER -->
	<div id="header">
		<div class="wrapper">
			<div class="logo_wrap">
				<div class="logo">
					<a href="/wiicar/home.do"></a>
				</div>
			</div>
			<div class="menu">
				<ul class="btn_wrap">
					<li class="btn-item dropdown profile">
						<button class="btn-profile dropdown-toggle" id="dropdown-menu1"	data-bs-toggle="dropdown" aria-expanded="false">
							<span class="hidden">프로필</span><i class="arrow"></i>
						</button>
						<ul class="drop" aria-labelledby="dropdown-menu1" style="width: 100px;">
							<li><a id="myPageBtn" href="/wiicar/member/personalInformation.do" class="dropdown-item">마이페이지</a></li>
							<li><a id="logoutBtn" class="dropdown-item">로그아웃</a></li>
							<!-- 관리자 일 경우 -->
							<li><a id="adminBtn" href="#" class="dropdown-item">관리자페이지</a></li>
							<!-- 로그인 안했을 경우 -->
							<li><a id="loginBtn" class="dropdown-item">로그인</a></li>
						</ul>
					</li>
					<li class="btn-item dropdown">
						<a class="btn-noti trigger-drop" style="text-align: left;" href="/wiicar/carpool/chatting.do">
							<span class="hidden">알림</span>
							<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
							id="notiCnt"></span> <!-- 알림 -->
						</a>
						<ul class="drop chat-list" style="width: 250px;">
							<!-- ajax append추가 -->
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- CONTENT -->
	<div id="content">
		<form action="/wiicar/signupPro.do" method="post" onSubmit="return checkVal();" name="inputForm" enctype="multipart/form-data">
			<input type="hidden" name="preference" id="preference"/>
			<!-- ********** 필수 기입 ********** -->
			<div class="row mb">
				<div class="col-form-label categories"><b>필수 기입</b></div>
			</div>
			<div><hr style="height:3px;"></div>
			
			<!-- 아이디 -->
			<div class="row mb-3">
				<label for="id" class="col-sm-3 col-form-label">아이디</label>
				<div class="col-sm-7">
					<input type="email" class="form-control" name="id" id="id" readonly=true>
				</div>
			</div>
			
			<!-- 비밀번호 -->
			<div class="row mb-3" id="pwDiv">
				<label for="pw" class="col-sm-3 col-form-label">비밀번호</label>
				<div class="col-sm-7">
					<input type="password" class="form-control" name="pw" id="pw">
				</div>
				<div>
					<small id="pwRE" style="color:gray;">영어, 숫자, 특수문자를 포함하여 8글자 이상.</small>
				</div>
			</div>

			<!-- 비밀번호 확인 -->
			<div class="row mb-3" id="pwConfirmDiv">
				<label for="pwConfirm" class="col-sm-3 col-form-label">비밀번호 확인</label>
				<div class="col-sm-7">
					<input type="password" class="form-control" id="pwConfirm">
				</div>
				<div>
					<small id="pwConfirmRE" style="color:gray;"></small>			
				</div>
			</div>
			
			<!-- 닉네임 -->
			<div class="row mb-3" id="nicknameDiv">
				<label for="nickname" class="col-sm-3 col-form-label">닉네임</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="nickname" id="nickname" placeholder="닉네임 입력">
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-primary verifyBtn" id="nicknameCheckBtn">중복확인</button>
				</div>
				<div>
					<small id="nicknameRE" style="color:gray;"></small>			
				</div>
			</div>
			
			<!-- 이름 -->
			<div class="row mb-3">
				<label for="name" class="col-sm-3 col-form-label">이름</label>
				<div class="col-sm-7">
					<input type="text" class="form-control" name="name" id="name" placeholder="이름 입력">
				</div>
			</div>
			
			<!-- 생년월일 -->
			<div class="row mb-3" id="birthDiv">
				<label for="birth" class="col-sm-3 col-form-label">생년월일</label>
				<div class="col-sm-7">
					<input type="text" class="form-control" name="birth" id="birth" placeholder="생년월일 입력">
				</div>
				<div>
					<small id="birthRE" style="color:gray;">형식) 2001-01-01</small>			
				</div>
			</div>
			
			<!-- 전화번호 -->
			<div class="row mb-3" id="phoneDiv">
				<label for="phone" class="col-sm-3 col-form-label">전화번호</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" name="phone" id="phone" placeholder="'-'를 제외한 번호만 입력">
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-primary verifyBtn" id="sendVerifyBtn">인증번호 전송</button>
				</div>
				<div>
					<small id="phoneRE" style="color:gray;">'-'를 제외하고 입력해주세요</small>			
				</div>
			</div>
			<div class="row mb-3" id="verifyDiv">
				<label for="phone" class="col-sm-3 col-form-label"></label>
				
				<div class="col-sm-2">
					<input type="text" class="form-control" name="verifyCode" id="verifyCode" placeholder="인증번호">
				</div>
				<div class="col-sm-3">
					<button type="button" class="btn btn-primary verifyBtn" id="verifyBtn">인증하기</button>
				</div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-primary verifyBtn" id="reVerifyBtn">다시 입력</button>
				</div>
				<div>
					<small id="verifyRE" style="color:gray;"></small>			
				</div>
			</div>
			
			<!-- 성별 -->
			<fieldset class="row mb-3">
				<legend class="col-form-label col-sm-3 pt-0">성별</legend>
				<div class="col-sm-7">
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="gender" id="gender1" value="male">
						<label class="form-check-label" for="inlineRadio1">남자</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="gender" id="gender2" value="female">
						<label class="form-check-label" for="inlineRadio2">여자</label>
					</div>
				</div>
			</fieldset>
			
			<!-- ********** 선택 기입 ********** -->
			<div class="row mb">
				<div class="col-form-label categories"><b>선택 기입(선택)</b></div>
			</div>
			
			<div><hr style="height:3px;"></div>
			<div class="row mb-3">
				<div class="col-sm-3 col-form-label">프로필 사진</div>
			</div>

			<!-- 프로필 사진 -->
			<div class="row mb-3">
				<div class="col-sm-3">
					<img src="/wiicar/resources/imgs/profile_default.png" id="profileImageMRPreview" class="rounded float-left" width="150px" height="100px">
				</div>
				<!-- 사진 업로드 -->
				<div class="col-sm-7" align="left">
					<div style="padding: 10px">
						<label class="input-file-button" for="profileImageMR"> 찾아보기 </label>
						<input type="file" id="profileImageMR" name="profileImageMR" style="display:none;"/>
					</div>
					<!-- 
					<div style="padding: 10px">
						<input type="text" class="file_path" id="file_path" placeholder="사진 경로"> <b style="color:red;"><small>보안상의 문제로 파일경로는 가져올수 없다고 하네요..</small></b>
					</div>
					 -->
				</div>
			</div>
			
			<!-- 계좌번호 -->
			<div class="row mb-3">
				<label for="birth" class="col-sm-3 col-form-label">계좌번호</label>
				<div class="col-sm-7">
					<input type="text" class="form-control" name="bankNo" id="bankNo" placeholder="계좌번호 입력">
				</div>
			</div>
			
			<!-- 성향 -->
			<div class="row mb-3" id="selector_number1">
				<div class="col-sm-3">
					<div class="col-sm-3 col-form-label">성향</div>
				</div>
				
				<!-- 셀렉트 -->
				<div class="col-sm-4 selector" align="left">
					<select class="form-select" id="inputPreference1">
						<option value="0" selected>성향을 선택해주세요</option>
						<option value="1">대화가 없는 걸 선호해요.</option>
						<option value="2">사적인 질문은 피해주세요.</option>
					  	<option value="3">적당한 대화가 좋아요.</option>
					  	<option value="4">음악 듣는 걸 좋아해요.</option>
					  	<option value="5">반려동물과 같이 가도 괜찮아요.</option>
					  	<option value="6">반려동물과 같이 가고 싶지 않아요.</option>
					</select>
				</div>
				
				<!-- 플러스, 마이너스 -->
				<div class="col-sm-3" align="left">
					&nbsp;&nbsp;
					<img src="/wiicar/resources/imgs/circle_plus.png" class="rounded float-left" id="add_btn" width="40px" >
					&nbsp;&nbsp;
					<img src="/wiicar/resources/imgs/circle_minus.png" class="rounded float-right" id="minus_btn" width="40px">
				</div>
			</div>
			
			<!-- 성향 추가 목록 -->
			<div id="add_selector"></div>
			
			
			<!-- ********** 운전자 정보 기입(선택) ********** -->
			<div class="row mb">
				<div class="col-form-label categories"><b>운전면허 정보 기입(선택)</b></div>
			</div>
			<div><hr style="height:3px;"></div>
			
			<!-- 운전면허 사진 -->
			<div class="row mb-3">
				<div class="col-sm-3">
					<img src="/wiicar/resources/imgs/license_default.svg" class="rounded float-left" id="licenseImageMRPreview" width="150px" height="100px">
				</div>
				<!-- 사진 업로드 -->
				<div class="col-sm-7" align="left">
					<div style="padding: 10px">
						<label class="input-file-button" for="licenseImageMR"> 찾아보기 </label> <small style="color:red;"><b>※주민번호는 가리고 올려주세요!</b></small>
						<input type="file" id="licenseImageMR" name="licenseImageMR" style="display:none;"/>
					</div>
					<!-- 
					<div style="padding: 10px">
						<input type="text" class="file_path" id="file_path" placeholder="사진 경로"> <b style="color:red;"><small>보안상의 문제로 파일경로는 가져올수 없다고 하네요..</small></b>
					</div>
					 -->
				</div>
			</div>
			
			<!-- 차종-->
			<div class="row mb-3" id="selector_number1">
				<div class="col-sm-3">
					<div class="col-sm-3 col-form-label">차종</div>
				</div>
				
				<!-- 셀렉트 -->
				<div class="col-sm-4 selector" align="left">
					<select class="form-select" name="carModel" id="carModel">
						<option value="0" selected>차종 선택</option>
						<option value="1">소형</option>
					  	<option value="2">중형</option>
					  	<option value="3">대형</option>
					</select>
				</div>
			</div>
			
			<div><hr style="height:3px;"></div>
			<div id="signupButtons">
				<button type="button" class="btn signupBtn" style="background-color: #D9D9D6;" onclick="window.location='/wiicar/home.do'">취소</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="submit" class="btn btn-primary signupBtn" style="background-color: #0096c6;">회원가입</button>
			</div>
			<div id="modifyButtons"> 
				<button type="button" class="btn signupBtn" id="modifyReturnBtn" style="background-color: #D9D9D6;">돌아가기</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="button" class="btn btn-primary signupBtn" id="modifyConfirmBtn" style="background-color: #0096c6;">수정하기</button>
			</div>
		</form>
	</div>
		
	</div>
	<div id="footer" style="position:relative;width:100%">
	    <a href="/wiicar/admin/infoBoard.do">공지사항</a>
	    <a href="/wiicar/qnaboard/qnaList.do">사이트 이용 관련 문의</a>
	</div>
</body>
</html>