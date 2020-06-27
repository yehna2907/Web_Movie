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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/home/main.css">
	</head>
	<body>
	 	<c:if test="${sessionMember == null}">
			${sessionMid = null}
			${sessionMember = null} 
		</c:if>
	 	
		<div class="header">
		  <h1><a href="${pageContext.request.contextPath}/home/main.do"><img width="700px" height="100px" src="${pageContext.request.contextPath}/resource/img/gildong.png"></a></h1>
		</div>
		<div class="topnav">
		  	<a href="${pageContext.request.contextPath}/home/main.do">Home</a>
			<a href="${pageContext.request.contextPath}/reserve/reservePage.do?fno=1">영화 예매</a>
		  	<a href="allreview.do?pageNo=1">평점 리뷰</a>
			<c:if test="${sessionMember.mid != null}">
				<a href="${pageContext.request.contextPath}/reserve/showTicket.do">예매 확인</a>
			</c:if>
		</div>
		
		
	 	<div class="row" style="margin-left: 5%; flex: 95%">
		 	<div class="column">
		 		<div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel" style="width:1450px; height:400px;">
				  <ol class="carousel-indicators">
				    <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
				    <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
				    <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
				    <li data-target="#carouselExampleCaptions" data-slide-to="3"></li>
				    <li data-target="#carouselExampleCaptions" data-slide-to="4"></li>
				    <li data-target="#carouselExampleCaptions" data-slide-to="5"></li>
				    <li data-target="#carouselExampleCaptions" data-slide-to="6"></li>
				  </ol>
				  
				  <div class="carousel-inner" >
				    <div class="carousel-item active" >
				      <a href="movieDetail.do?pageNo=1&fno=1">
				      <img style="width:1450px; height:400px;" src="${pageContext.request.contextPath}/resource/img/home_img/home_img1.jpg" class="d-block w-100" ></a>
				      <div class="carousel-caption d-none d-md-block" >
				        <h5>언 더 워 터</h5>
				        <p>해저 11km, 한 번도 경험하지 못한 무언가 깨어났다!</p>
				      </div>
				    </div>
				    <div class="carousel-item">
				    <a href="movieDetail.do?pageNo=1&fno=2">
				      <img style="width:1500px; height:400px;" src="${pageContext.request.contextPath}/resource/img/home_img/home_img3.jpg" class="d-block w-100"></a>
				      <div class="carousel-caption d-none d-md-block">
				        <h5>위대한 쇼맨</h5>
				        <p>불가능한 꿈, 그 이상의 쇼!</p>
				      </div>
				    </div>
				    <div class="carousel-item">
				    <a href="movieDetail.do?pageNo=1&fno=3">
				      <img style="width:1500px; height:400px;" src="${pageContext.request.contextPath}/resource/img/home_img/home_img2.jpg" class="d-block w-100"></a>
				      <div class="carousel-caption d-none d-md-block">
				        <h5>프리즌 이스케이프</h5>
				        <p>404일의 감금, 나가야 할 문은 15개! 성공률 0%의 탈옥이 시작된다!</p>
				      </div>
				    </div>
				    <div class="carousel-item">
				    <a href="movieDetail.do?pageNo=1&fno=4">
				      <img style="width:1500px; height:400px;" src="${pageContext.request.contextPath}/resource/img/home_img/home_img4.jpg" class="d-block w-100"></a>
				      <div class="carousel-caption d-none d-md-block">
				        <h5>카페 벨에포크</h5>
				        <p>1분 1초 설레며, 24시간 사랑했던 내인생 가장 찬란했던 순간으로 돌아갈 수 있다면?</p>
				      </div>
				    </div>
				    <div class="carousel-item">
				    <a href="movieDetail.do?pageNo=1&fno=5">
				      <img style="width:1500px; height:400px;" src="${pageContext.request.contextPath}/resource/img/home_img/home_img5.jpg" class="d-block w-100"></a>
				      <div class="carousel-caption d-none d-md-block">
				        <h5>미스비헤이비어</h5>
				        <p>“왕관을 거부한 유쾌한 반란” 우리는 예쁘지도 추하지도 않다! 우리는 화가 났을 뿐!</p>
				      </div>
				    </div>
				    <div class="carousel-item">
				    <a href="movieDetail.do?pageNo=1&fno=6">
				      <img style="width:1500px; height:400px;" src="${pageContext.request.contextPath}/resource/img/home_img/home_img6.jpg" class="d-block w-100"></a>
				      <div class="carousel-caption d-none d-md-block">
				        <h5>그집</h5>
				        <p>한 번 보면 잊히지 않는 충격 실화!</p>
				      </div>
				    </div>
				    <div class="carousel-item">
				    <a href="movieDetail.do?pageNo=1&fno=7">
				      <img style="width:1500px; height:400px;" src="${pageContext.request.contextPath}/resource/img/home_img/home_img7.jpg" class="d-block w-100"></a>
				      <div class="carousel-caption d-none d-md-block">
				        <h5>초미의 관심사</h5>
				        <p>“친한 척 하지마!” vs “너나 엄마라고 부르지마!”</p>
				      </div>
				    </div>
				  </div>
				  
				  <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="sr-only">Next</span>
				  </a>
				</div>
				
		 	</div>
		 	
		 	<div class="column side" style="flex : 5%; margin-top: 8%; margin-right: 5%; margin-bottom: 10%;  border: 1.5px solid gray; text-align: center;">
		  		<c:if test="${sessionMid == null}">
		  			<h2><a href="${pageContext.request.contextPath}/member/login.do" class="btn btn-primary" style="width: 85%;">로그인</a></h2>
			    	<p style="font-size: 14px;">
			    		<a href="${pageContext.request.contextPath}/member/forgot.do" style="padding-right: 10px;">아이디 비밀번호 찾기</a><br/>
			    		<a href="${pageContext.request.contextPath}/member/join.do" style="padding-right: 10px;">회원가입</a>
			    	</p>
			  	</c:if>
		    	<c:if test="${sessionMid != null}">
		  			<h2><a href="${pageContext.request.contextPath}/mypage/mypageMain.do" class="btn btn-primary" style="width: 85%;">마이페이지</a></h2>
			    	<p style="font-size: 14px; margin-left: 5px;">
			    		<a href="${pageContext.request.contextPath}/member/logout.do" style="padding-right: 10px;">로그아웃</a>
			    	</p>
			  	</c:if>
		  </div>
	 	</div>
	 	
	 	
		<div class="row">
			
			<div class="column" style="text-align: center; margin-bottom: 10px">
		    	<h2 style="margin-bottom: 20px; font-weight: bold;">현재 상영작</h2>
		    	<c:forEach var="film" items="${filmlist}">
		    		<a href="movieDetail.do?pageNo=1&fno=${film.fno}"><img style="display:inline-block;width:260px;height:450px;" src="${pageContext.request.contextPath}/resource/img/poster/film${film.fno}.jpg"/></a>
		    	</c:forEach>
		    	
			</div>
		  
			
		</div>
		 
		<div class="footer">
		  <p>이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 영화 고객센터</p>
		  <p>사업자등록번호 : 0000-00-000 | 대표이사 : 호정맨 | 최고기술자: 바닐라 멘사맨</p>
		</div>
		
	</body>
</html>