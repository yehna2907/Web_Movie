<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script	src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script	src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script	src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<title>Main Page Layout</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mypage/mypageMain.css" />
		<script>
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
		<div class="container">
			<div class="page-header">
				<h1 class="h2">&nbsp; 내 정보</h1>
				<hr>
			</div>
		</div>
		<div class="mypageList">
			<form:form method="post" modelAttribute="member">
				<table class="table table-stripped">
					<tr>
						<td>아이디</td>
						<td><form:input path="mid" value="${member.mid}" readonly="true"/></td>
						<td><form:errors path="mid" style="color:red" /></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><form:input path="mname" value="${member.mname}" /></td>
						<td><form:errors path="mname" style="color:red" /></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><form:password path="mpassword"
								value="${member.mpassword}" /></td>
						<td><form:errors path="mpassword" style="color:red" /></td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td><form:input path="mtel" value="${member.mtel}" /></td>
						<td><form:errors path="mtel" style="color:red" /></td>
					</tr>
					<tr>
						<td>Email</td>
						<td><form:input type="email" path="memail" value="${member.memail}" /></td>
						<td><form:errors path="memail" style="color:red" /></td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td><form:input path="mbirth" value="${member.mbirth}" /></td>
						<td><form:errors path="mbirth" style="color:red" /></td>
					</tr>
				</table>
				<div id="memChange" style="">
					<input type="submit" class="btn btn-success"
						style="margin-left: 30px;" value="수정" />
				</div>
			</form:form>
	
		</div>
	
	
		<div class="footer" style="margin-top: 3%;">
		  <p>이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 영화 고객센터</p>
		  <p>사업자등록번호 : 0000-00-000 | 대표이사 : 호정맨 | 최고기술자: 바닐라 멘사맨</p>
		</div>
	
	</body>
</html>