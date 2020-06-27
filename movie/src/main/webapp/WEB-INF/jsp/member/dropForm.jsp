<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<title>Main Page Layout</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mypage/mypageMain.css"/>
	</head>
	<body>
	 
		<div class="header">
		  <h1><a href="${pageContext.request.contextPath}/home/main.do"><img width="700px" height="100px" src="${pageContext.request.contextPath}/resource/img/gildong.png"></a></h1>
		</div>
		 
		<div class="topnav">
		  	<a href="${pageContext.request.contextPath}/home/main.do">Home</a>
			<a href="${pageContext.request.contextPath}/reserve/reservePage.do?fno=1">영화 예매</a> 
		  	<a href="${pageContext.request.contextPath}/home/allreview.do?pageNo=1">평점 리뷰</a>
		</div>
		
	 	<div class="container">
			<div class="page-header">
		    	<h1 class="h2">&nbsp; 회원 탈퇴</h1><hr>
		    </div>
	    </div>
		<div class="container" style="margin: 30px; align-self: center;">			
			<p style="margin-left: 400px; margin-bottom: 200px">
				회원 탈퇴가 성공적으로 완료되었습니다. 이용해주셔서 감사합니다.
			</p>
		</div>
	
	 	<br/>
		<div class="footer">
		  <p>이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 영화 고객센터</p>
		  <p>사업자등록번호 : 0000-00-000 | 대표이사 : 호정맨 | 최고기술자: 바닐라 멘사맨</p>
		</div>
		
	</body>
</html>