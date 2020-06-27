<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script
			src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script
			src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script
			src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<title>Main Page Layout</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/resource/css/layout.css" />
		<link rel="stylesheet"
			href="${pageContext.request.contextPath}/resource/css/mypage/ticketlist.css" />
		<script>
			/* $(document).ready(function(){
			    var check = sessionStorage.getItem("sessionMid");
			    if(check == null){
			        alert("로그인 후 이용하세요.");
			        location.href="${pageContext.request.contextPath}/home/main.do";
			    } 
			}); */
			
			function checkTicketDrop(tno,smovie,tseatno) {
				if(confirm("예매를 취소하시겠습니까?")){
					$("#"+tno).attr("href","${pageContext.request.contextPath}/reserve/dropTicket.do?tno="+tno+"&smovie="+smovie+"&tseatno="+tseatno);
				}
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
			<h1>
				<a href="${pageContext.request.contextPath}/home/main.do"><img
					width="700px" height="100px"
					src="${pageContext.request.contextPath}/resource/img/gildong.png"></a>
			</h1>
		</div>
	
		<div class="topnav">
			<a href="${pageContext.request.contextPath}/home/main.do">Home</a> 
			<a href="${pageContext.request.contextPath}/reserve/reservePage.do?fno=1">영화 예매</a>
			<a href="${pageContext.request.contextPath}/home/allreview.do?pageNo=1">평점 리뷰</a>
			<a href="${pageContext.request.contextPath}/mypage/mypageMain.do">마이페이지</a>
		</div>
		<div class="container">
			<div class="page-header">
				<h1 class="h2">&nbsp; 예매 확인</h1>
				<hr>
			</div>
		</div>
		<div class="mypageList">
			<table class="table table-stripped">
				<thead>
					<tr>
						<th>영화</th>
						<th>날짜</th>
						<th>상영관</th>
						<th>상영시간</th>
						<th>좌석</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="ticket" items="${ticketlist}">
						<tr>
							<td>${ticket.tmoviename}</td>
							<td>${ticket.tdate}</td>
							<td>${ticket.tplace}</td>
							<td>${ticket.ttime}</td>
							<td>${ticket.tseatno}</td>
							<td style="text-align: center;"><a class="btn btn-danger btn-sm" id="${ticket.tno}"
								onclick="return checkTicketDrop(${ticket.tno},${ticket.smovie},${ticket.tseatno})"
								href="">예매 취소</a>
							</td>
					</c:forEach>
				</tbody>
			</table>
		</div>
	
		<div class="footer" style="margin-top: 5%;">
		  <p>이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 영화 고객센터</p>
		  <p>사업자등록번호 : 0000-00-000 | 대표이사 : 호정맨 | 최고기술자: 바닐라 멘사맨</p>
		</div>
	
	</body>
</html>