<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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
		
		<div style="text-align: center;"><font size="11" face="맑은 고딕" >회원가입</font><br/></div>
		
		<hr size="7" width="50%" color="black">
		<div style="text-align: center; background-color: #AFE0FF">	
			<form:form method="post" modelAttribute="member">
			
				<font size="5" face="맑은 고딕">아이디</font><br/>
				<font> <form:input path="mid" style="width:15%"/> </font><br/>
				<form:errors path="mid" style="color: red"></form:errors>
				<hr size="3" width="20%" color="gray">
				<p></p>
				
				<font size="5" face="맑은 고딕">비밀번호</font><br/>
				<form:password path="mpassword" style="width:15%" /><br/>
				<form:errors path="mpassword" style="color: red"></form:errors>
				<hr size="3" width="20%" color="gray">
				<p></p>
				
				<font size="5" face="맑은 고딕">이름</font><br/>
				<form:input path="mname" style="width:15%" /><br/>
				<form:errors path="mname" style="color: red"></form:errors>
				<hr size="3" width="20%" color="gray">
				<p></p>
				
				<font size="5" face="맑은 고딕">전화번호</font><br/>
				<form:input type="tel" path="mtel" style="width:15%" /><br/>
				<form:errors path="mtel" style="color: red"></form:errors>
				<hr size="3" width="20%" color="gray">
				<p></p>
				
				<font size="5" face="맑은 고딕">이메일</font><br/>
				<form:input type="email" path="memail" style="width:15%" /><br/>
				<form:errors path="memail" style="color: red"></form:errors>
				<hr size="3" width="20%" color="gray">
				<p></p>
				
				<font size="5" face="맑은 고딕">생년월일</font><br/>
				<form:input path="mbirth" style="width:15%" /><br/>
				<form:errors path="mbirth" style="color: red"></form:errors>
				<hr size="3" width="20%" color="gray">
				<p></p>
				
				<input class="btn btn-primary" type="submit" value="회원가입"
				style="width:200px; height: 75px;"/>		
			</form:form>
		</div>
		<hr size="7" width="50%" color="black">
		
		<br/>
		<div class="footer">
		  <p>이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 영화 고객센터</p>
		  <p>사업자등록번호 : 0000-00-000 | 대표이사 : 호정맨 | 최고기술자: 바닐라 멘사맨</p>
		</div>
	</body>
</html>