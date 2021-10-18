<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WIICAR - 개인정보 수정</title>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link href="/wiicar/resources/css/memberMenu.css?after" rel="stylesheet"type="text/css" />
	<script>
		
	</script>
	<style>
		.memberContainer {
			padding-top:5rem;
			text-align: center;
		}
		#footer{
			position: relative !important;
			bottom: 0;
		}
	</style>
</head>
<body>
<!-- HEADER -->
		
	
			<jsp:include page="../signupForm.jsp">
				<jsp:param name="member" value="${member}"/>
			</jsp:include>			
</body>
</html>