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
		<script>
			var total = 0;
			
			function addPoint(point) {
				total = parseInt(total) + parseInt(point);
				$("#point").attr("value", total);
			}
			
			function refresh() {
				total = 0;
				$("#point").attr("value", total);
			}
			
			function checkCharge() {
				var point = $("#point").val(); 
				if(point == 0) {
					return false;
				} else
					return true;
			}
			
			function loginPlease(){
				window.alert("로그인이 필요합니다.");
				location.href = "${pageContext.request.contextPath}/member/login.do";
			}
		</script>
	</head>
	<body>
		<c:if test="${sessionMember == null}">
			<script>
				loginPlease();
			</script>
		</c:if>
		
		<div class="header">
		  <h1><a href="${pageContext.request.contextPath}/home/main.do"><img width="700px" height="100px" src="${pageContext.request.contextPath}/resource/img/gildong.png"></a></h1>
		</div>
		 
		<div class="topnav">
		  	<a href="${pageContext.request.contextPath}/home/main.do">Home</a>
			<a href="${pageContext.request.contextPath}/reserve/reservePage.do?fno=1">영화 예매</a>
		  	<a href="${pageContext.request.contextPath}/home/allreview.do?pageNo=1">평점 리뷰</a>
			<c:if test="${sessionMember.mid != null}">
				<a href="${pageContext.request.contextPath}/reserve/showTicket.do">예매 확인</a>
			</c:if>
		</div>
		
	 	<div class="container">
			<div class="page-header">
		    	<h1 class="h2">&nbsp; 포인트 충전</h1><hr>
		    </div>
	    </div>
		<div class="container" style="margin: 30px; align-self: center; margin-top: 50px">	
			<div style="margin-left: 55%;">
				<button onclick="addPoint(1000)" class="btn btn-warning" style="margin-left: 10px">1000</button>
				<button onclick="addPoint(5000)" class="btn btn-warning" style="margin-left: 10px;">5000</button>
				<button onclick="addPoint(10000)" class="btn btn-warning" style="margin-left: 10px;">10000</button>
				<button onclick="addPoint(20000)" class="btn btn-warning" style="margin-left: 10px;">20000</button>
				<button onclick="addPoint(50000)" class="btn btn-warning" style="margin-left: 10px;">50000</button>
			</div>
			<form action="chargePoint.do" style="margin-left: 35%; display: inline;">
				<input id="point" name="point" type="text" value="0" style="margin-top: 40px; margin-left: 25%; text-align: right;" readonly/>
				<input type="submit" onclick="return checkCharge()" class="btn btn-danger btn-sm" style="margin-left: 10px;" value="충전"/>
			</form>
			<button onclick="refresh()" class="btn btn-secondary btn-sm" style="margin-left: 10px; display: inline;">새로고침</button>
		</div>
	
	 
		<div class="footer" style="margin-top: 10%;">
		  <p>이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 영화 고객센터</p>
		  <p>사업자등록번호 : 0000-00-000 | 대표이사 : 호정맨 | 최고기술자: 바닐라 멘사맨</p>
		</div>
		
	</body>
</html>