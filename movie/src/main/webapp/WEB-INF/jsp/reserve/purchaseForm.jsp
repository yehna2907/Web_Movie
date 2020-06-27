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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mypage/mypageMain.css"/>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mypage/mypageMain.css"/>
		<script>
			function onClick_handler(mid,sno,smovie) {
				var mpoint = 5000;
				$.ajax({
					url:"point.do",
					data:{mid:mid, mpoint:mpoint, sno:sno, smovie:smovie},
					async:false,
					success: function(data){
						console.log(data.result);
						if(data.result == "No"){
							window.alert("잔액이 부족합니다. 포인트충전을 하고오세요");
							$("#purchaseFormTag").attr("action", "${pageContext.request.contextPath}/mypage/mypageMain.do");
						} else{
							window.alert("예매 완료");
						}
					}
				});					
			}
			
		
		</script>
	</head>
	<body>
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
		
		<div class="mypageList" >
			<table class="table table-stripped">  
		       <tr>  
		           <td>아이디</td>  
		           <td>${ticket.tid}</td>
			   </tr>  
			   <tr>
			    	<td>영화</td>
			    	<td>${ticket.tmoviename}</td>
			   </tr>
			   <tr>
			    	<td>날짜</td>
			    	<td>${ticket.tdate}</td>
			   </tr>
			   <tr>
			    	<td>상영관</td>
			    	<td>${ticket.tplace}</td>
			   </tr>
			   <tr>
			    	<td>상영시간</td>
			    	<td>${ticket.ttime}</td>
			   </tr>
			   <tr>
			    	<td>좌석번호</td>
			    	<td>${ticket.tseatno}</td>
			   </tr>
			</table>
		</div>
		<div style="margin-left: 730px">
			<form id="purchaseFormTag" action="${pageContext.request.contextPath}/reserve/showTicket.do" style="display: inline-block;"
				onclick="return onClick_handler('${ticket.tid}',${ticket.tseatno},${ticket.smovie})">
				<button style="width: 200px;height: 50px; background-color: #0099FF;">결제</button>
			</form>
			<form action="${pageContext.request.contextPath}/home/main.do" style="display: inline-block;">
				<button style="width: 200px;height: 50px; background-color: #DDDDDD;">취소</button>
			</form>
		</div>
	</body>
</html>