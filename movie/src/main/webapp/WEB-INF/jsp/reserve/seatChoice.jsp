<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mypage/mypageMain.css"/>
		<script>
			var select = [];

			function mouseclick_handler(sno,smovie) {
				var seatno = $("#" + sno);
				var daum = $("#daum");
				
				
				if(select[sno] == true){	// 선택해제
					select[sno] = false;
					console.log("클릭됨");
					seatno.css("background-color","#FFFF33");
					daum.hide();
					return;

				} else {					// 선택
					if(select.includes(true)) {
						window.alert("한 좌석만 선택가능합니다.");
						return;
					}
					if(confirm(sno+'번 좌석으로 예매하시겠습니까?')){
						select[sno] = true;
						$("#daum #a1").attr("href","purchase.do?sno="+sno+"&smovie="+smovie);
						daum.show();
						console.log("클릭됨");
						seatno.css("background-color","#66CCFF");

					}
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
		
		
		<% int cnt=0;%>
		<br/>
		<br/>
		<div style="margin-left: 20%; border: solid black; padding: 20px; width: 1090px">
			<div style="text-align: center; background-color: #E6E6E6"><h4>SCREEN</h4></div>
			<c:forEach var="seat" items="${seatList}">
				<%if(cnt %10 ==0) {%>
					<br/>
				<%}%>
				<button id="${seat.sno}"  
					<c:if test="${seat.sselect == false}">
						onclick="mouseclick_handler(${seat.sno},${smovie})"
						style="width: 100px; height: 100px; background-color: #FFFF33;"
					</c:if>
					<c:if test="${seat.sselect == true}">
						style="width: 100px; height: 100px; background-color: gray;"
						disabled
					</c:if>
					>${seat.sno}</button>
				<% cnt++; %>
			</c:forEach>
		</div>
		<div id="daum" style="margin-left: 45%; margin-top: 20px">			
			<a id="a1" href="" class="btn btn-primary" style="width: 150px;">다음 단계</a>
		</div>
		
		<script>
			$("#daum").hide();
		</script>	
					
	</body>
</html>