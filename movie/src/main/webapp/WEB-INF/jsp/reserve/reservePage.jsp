<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html>
<html>
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
		href="${pageContext.request.contextPath}/resource/css/layout.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resource/css/home/main.css">
	<script>
		selectedMovie = 0;
		selectedDate = 0;
		selectedTime = 0;
	
		function timeClick() {
			selectedTime = 1;
		}
		
		function movieClick(movie) {
			selectedMovie = movie;
			selectedDate = 0;
			selectedTime = 0;
			
			$.ajax({
				type : "POST",
				url : "getDateList.do",
				success : function(data) {
					reserveDate = document.getElementById("reserveDate");
					reserveDate.options.length = 0;
					var movie = null;
					for (var i = 0; i < Object.keys(data).length; i++) {
						var opt = document.createElement("option");
						opt.value = data["date" + i];
						opt.innerHTML = data["date" + i];
						reserveDate.appendChild(opt);

					}
					reserveTime = document.getElementById("reserveTime");
					reserveTime.options.length = 0;
				}

			});
		}
	
		function dateClick(date) {
			selectedDate = date.value;
			$.ajax({
				type : "POST",
				url : "getTimeTable.do",
				data : {
					mvfno : selectedMovie,
					mvdate : selectedDate
				},
				async:false,
				success : function(data) {
					target = document.getElementById("reserveTime");
					target.options.length = 0;
					var movie = null;
					for (var i = 0; i < Object.keys(data).length; i++) {
						movie = data["movie" + i];
						var opt = document.createElement("option");
						opt.value = movie["mvno"];
						opt.innerHTML = movie["mvplace"] + "관 "
								+ movie.mvstarttime;
						target.appendChild(opt);
					}
				}
			});
		}
				
		function checkReserve() {
			if(selectedMovie != 0 && selectedDate != 0 && selectedTime != 0) {
				return true;
			}
			console.log(selectedMovie);
			console.log(selectedDate);
			console.log(selectedTime);
			window.alert("선택 정보가 잘못되었습니다.");
			location.href = "${pageContext.request.contextPath}/reserve/reservePage.do?fno=1";
			return false;
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
		<c:if test="${sessionMember.mid != null}">
			<a href="${pageContext.request.contextPath}/reserve/showTicket.do">예매 확인</a>
		</c:if>
	</div>

	<!-- 영화 예매 본문 -->
	<form class="reserve" method="post" action="seat.do" 
		style="margin-top: 70px; text-align: center;">
		<!-- 영화 선택 박스 -->
		<div class="reserveBoxes" style="display: inline-block;">
			<h4 style="margin-bottom: 20px;">영화 선택</h4>
			<select class="form-control" id="reserveMovie" name="reserveMovie" size="10"
				onclick="movieClick(this.value)" style="width: 250px; height: 300px;">
				<optgroup label="영화선택">
					<c:forEach var="film" items="${filmlist}">
						<c:if test="${fno == film.fno}">
							<option id="selectFno" value="${film.fno}" selected="selected">${film.ftitle}</option>
						</c:if>
						<c:if test="${fno != film.fno}">
							<option value="${film.fno}">${film.ftitle}</option>
						</c:if>
					</c:forEach>
				</optgroup>
			</select>
		</div>
		
		<c:if test="${fno != null}">
			<script>
				movieClick($("#selectFno").val());
			</script>
		</c:if>
		
		<!-- 날짜 선택 박스 -->
		<div class="reserveBoxes" style="display: inline-block; margin-left: 30px;">
			<h4 style="margin-bottom: 20px;">날짜 선택</h4>
			<select class="form-control" id="reserveDate" name="reserveDate" size="5"
				onclick="dateClick(this)" style="width: 250px; height: 300px;">
				<optgroup id="options" label="날짜선택">
					
				</optgroup>
			</select>
		</div>
		<!-- 시간 선택 박스 -->
		<div class="reserveBoxes" style="display: inline-block; margin-left: 30px;">
			<h4 style="margin-bottom: 20px;">시간 선택</h4>
			<select class="form-control" id="reserveTime" name="reserveTime" size="10"
				style="width: 250px; height: 300px;" onchange="timeClick()">
				<optgroup label="시간선택">
				</optgroup>
			</select>
		</div>
		<div style="margin-top: 30px">
			<input class="btn btn-primary" onclick="return checkReserve()" style="width: 100px" type="submit" value="예매" />
		</div>
	</form>

</body>
</html>