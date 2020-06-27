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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mypage/mypageMain.css"/>
		<script>
			function onchange_handler() {
				var fno = $("#selectBox").val();
				console.log(fno);
				location.href = "${pageContext.request.contextPath}/home/movieDetail.do?fno="+fno;
			}
		</script>
		
		<style>
		a {
			display:inline-block;
		}
		
		</style>
		
	</head>
	<body>
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

		<div style="text-align: center; margin-top: 20px">
			<font face="맑은 고딕 " size="10">리뷰</font>
			<font face="맑은 고딕 " size="4">Review</font>
		</div>
		
		<select class="form-control" id="selectBox" onchange="onchange_handler()" style="margin-left: 20%; width: 10%; text-align: left;">
			<optgroup>
				<option>현재상영작</option>
				<c:forEach var="film" items="${filmlist}">
					<option value="${film.fno}">${film.ftitle}</option>
				</c:forEach>
			</optgroup>
		</select>
		<br/>
		
		<table class="table" style="margin-left: 15%; width: 70%; text-align: center;">
			<thead class="thead-dark">
				<tr>
					<th>번호</th>
					<th>영화제목</th>
					<th style="width: 450px;">감상평</th>
					<th>글쓴이</th>
					<th>날짜</th>
					<th>평점</th>
				</tr>
			</thead>
			<c:forEach var="review" items="${reviewlist}" varStatus="status">
				<tr>
					<td>${review.rno}</td>
					<td>${filmnamelist[status.index]}</td>
					<td style="text-align: left;">${review.rcontent}</td>
					<td>${review.rid}</td>
					<td><fmt:formatDate value="${review.rdate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
					<td>${review.rscore}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="6" style="text-align: center;">
					<a class="btn btn-primary" href="${pageContext.request.contextPath}/home/allreview.do?pageNo=1"
					<c:if test="${pager.pageNo == 1}">style="display:none"</c:if>
					>처음</a>
					
					<a class="btn btn-secondary" href="${pageContext.request.contextPath}/home/allreview.do?pageNo=${pager.startPageNo-1}"
					<c:if test="${pager.groupNo == 1}">style="display:none"</c:if>
					>이전</a>
					<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
						<c:if test="${i == pager.pageNo}">
							<a class="btn btn-outline-dark" href="${pageContext.request.contextPath}/home/allreview.do?pageNo=${i}">${i}</a>
						</c:if>
						
						<c:if test="${i != pager.pageNo}">
							<a class="btn btn-dark" href="${pageContext.request.contextPath}/home/allreview.do?pageNo=${i}">${i}</a>
						</c:if>
					</c:forEach>
					<a class="btn btn-secondary" href="${pageContext.request.contextPath}/home/allreview.do?pageNo=${pager.endPageNo+1}"
					<c:if test="${pager.groupNo == pager.totalGroupNo}">style="display:none"</c:if>
					>다음</a>
					
					<a class="btn btn-primary" href="${pageContext.request.contextPath}/home/allreview.do?pageNo=${pager.totalPageNo}"
					<c:if test="${pager.pageNo == pager.totalPageNo}">style="display:none"</c:if>
					>끝</a>
				</td>
			</tr>			
		</table>

		<div class="footer">
		  <p>이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 영화 고객센터</p>
		  <p>사업자등록번호 : 0000-00-000 | 대표이사 : 호정맨 | 최고기술자: 바닐라 멘사맨</p>
		</div>
	</body>
</html>