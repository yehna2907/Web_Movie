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
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/layout.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mypage/mypageMain.css"/>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/home/movieDetail.css"/>
		
		<script>
		
			$(function() {
				var rscore = $("#6").text();
				var form = document.getElementById('reviewForm');
				var input = document.createElement("input");
				
				$('#rscore').remove();
				input.id = 'rscore';
				input.type = "hidden";
				input.name = "rscore";
				input.value = rscore;
				form.appendChild(input);
			});
		
			function onclick_handler() {
				var e = window.event,
		          span = e.target || e.srcElement;
				
				var id = '#'+span.id;
				$(id).parent().children('span').removeClass('on');
				$(id).addClass('on').prevAll('span').addClass('on');
				
				var rscore = $(id).text();
				var form = document.getElementById('reviewForm');
				var input = document.createElement("input");
				
				$('#rscore').remove();
				input.id = 'rscore';
				input.type = "hidden";
				input.name = "rscore";
				input.value = rscore;
				form.appendChild(input);
				
				return false;
			}
			
			function checkduplicateid() {
				var rid = $("#rid").val();
				var rfno = $("#rfno").val();
				var returnBool = false;
				var sessionMid = '@Session["sessonMid"]';
				
				$.ajax({
					type:"POST",
					url:"checkDuplicateId.do",
					data:{rid:rid, rfno:rfno},
					async:false,
					success:function(data) {
						var result = data.result;
						if(result == "NotLogined") {
							window.alert("로그인이 필요합니다.");
							location.href = "${pageContext.request.contextPath}/member/login.do";
						} else if(result == "alreadyHave") {
							window.alert("이미 리뷰가 존재합니다.");
						} else if(result == "canWrite") {
							console.log("확인");
							returnBool = true;
						}
					}
				});
				
				return returnBool;
				
			}
			
			function updateForm(rno, rscore, rcontent) {
				var reviewForm = $('#reviewForm');
				var submit = $('#submit');
				reviewForm.attr("action" ,"updateReview.do");
				reviewForm.removeAttr("onsubmit");
				submit.attr("value", "수정");
				submit.attr("class", "btn btn-info");
				
				//수정할 리뷰의 내용 입력창에 넣기
				$('#reviewForm textarea').text(rcontent);
				
				//수정할 리뷰의 평점 반영하기
				var scoreId = "#" + (rscore*2);
				$(scoreId).parent().children('span').removeClass('on');
				$(scoreId).addClass('on').prevAll('span').addClass('on');
				
				//클릭을 안했으니, 원래 form태그에 rscore를 보낼 input 생길리 없다.
				//따라서 클릭을 한것처럼, 따로 input 태그 만들어 form태그에 추가
				var form = document.getElementById('reviewForm');
				var input = document.createElement('input');
				
				$('#rscore').remove();
				input.id = 'rscore';
				input.type = 'hidden';
				input.name = 'rscore';
				input.value = rscore;
				form.appendChild(input);
				
				//원래 평점까지 서버로 보낼 수 있게 또다른 input 태그 만들어 form태그에 추가
				var oldInput = document.createElement('input');
				
				$('#oldRscore').remove();
				oldInput.id = 'oldRscore';
				oldInput.type = 'hidden';
				oldInput.name = 'oldRscore';
				oldInput.value = rscore;
				form.appendChild(oldInput);
				
				//rno 넘겨주기
				var rnoInput = document.createElement('input');
				
				$('#rno').remove();
				rnoInput.id = 'rno';
				rnoInput.type = 'hidden';
				rnoInput.name = 'rno';
				rnoInput.value = rno;
				form.appendChild(rnoInput);
				
				
			}
			
			function loginPlease(){
				window.alert("로그인이 필요합니다.");
				location.href = "${pageContext.request.contextPath}/member/login.do";
			}
		</script>
		
		<style>
			.starR1{
			    background: url('${pageContext.request.contextPath}/resource/img/ico_review.png') no-repeat -52px 0;
			    background-size: auto 100%;
			    width: 15px;
			    height: 30px;
			    float:left;
			    text-indent: -9999px;
			    cursor: pointer;
			}
			.starR2{
			    background: url('${pageContext.request.contextPath}/resource/img/ico_review.png') no-repeat right 0;
			    background-size: auto 100%;
			    width: 15px;
			    height: 30px;
			    float:left;
			    text-indent: -9999px;
			    cursor: pointer;
			}
			.starR1.on {background-position:0 0;}
			.starR2.on {background-position:-15px 0;}
		</style>


		
		
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
		<br/>
		
		<img src="${pageContext.request.contextPath}/resource/img/poster/film${film.fno}.jpg"
		style="width:600px; height:800px; display:inline; margin-left: 21%; margin-top: 20px"/>
		
		<table class="film_table">
		    <thead>
		    <tr>
		        <th scope="col">영화정보</th>
		    </tr>
		    </thead>
		    <tbody>
		    <tr>
		        <th scope="row">영화 번호</th>
		        <td>${film.fno}</td>
		    </tr>
		    <tr>
		        <th scope="row">제목</th>
		        <td>${film.ftitle}</td>
		    </tr>
		    <tr>
		        <th scope="row">요약</th>
		        <td>${film.fsummary}</td>
		    </tr>
		    <tr>
		        <th scope="row">연령제한</th>
		        <td>${film.fagelimit}</td>
		    </tr>
		    <tr>
		        <th scope="row">평점</th>
		        <td>${film.fscore}</td>
		    </tr>
		    <tr>
		        <th scope="row">감독</th>
		        <td>${film.fdirector}</td>
		    </tr>
		    <tr>
		        <th scope="row">상영시간</th>
		        <td>${film.frunningtime}분</td>
		    </tr>
		    <tr>
		        <th scope="row">장르</th>
		        <td>${film.fgenre}</td>
		    </tr>
		    </tbody>
		</table>
		<br/>
	   	<div style="margin-top: 30px; text-align: center;">
			<form action="${pageContext.request.contextPath}/reserve/reservePage.do">
				<input type="hidden" id="fno" name="fno" value="${film.fno}">
				<input type="submit" class="btn btn-primary" style="width: 150px; height: 40px;" value="예매하기"/>
			</form>
		</div>
		
		<br/>
		<br/>
		<hr size="5" width="70%" color="black" style="margin-top: 10% ">
		<br/>
		
		<div style="text-align: center;">
			<font face="맑은 고딕 " size="10">리뷰</font>
			<font face="맑은 고딕 " size="4">Review</font>
		</div>
		
		<div style="margin-left: 25%;">
			<table class="table" style="width: 70%;">
				<thead class="thead-dark">
					<tr>
						<th scope="col">번호</th>
						<th scope="col">내용</th>
						<th scope="col">아이디</th>
						<th scope="col">날짜</th>
						<th scope="col">평점</th>
						<th scope="col"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="review" items="${reviewlist}">			
						<tr>	
							<td>${review.rno}</td>
							<td>${review.rcontent}</td>
							<td>${review.rid}</td>
							<td><fmt:formatDate value="${review.rdate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
							<td>${review.rscore}</td>
							<c:if test="${review.rid == sessionMid}">
								<td>
									<c:if test="${sessionMember != null}">
										<a class="btn btn-outline-info btn-sm" style="font-size: 8pt; width: 40px; height: 25px;" 
											onclick="updateForm(${review.rno} ,${review.rscore}, '${review.rcontent}')">수정</a>
										<a class="btn btn-outline-danger btn-sm" href="deleteReview.do?fno=${film.fno}&rno=${review.rno}&rscore=${review.rscore}" 
											style="font-size:8pt;width:40px;height:25px">삭제</a>
									</c:if>
								</td>
							</c:if>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="6" style="text-align:center;">
							<a class="btn btn-primary" href="movieDetail.do?pageNo=1&fno=${film.fno}">처음</a>
							
							<c:if test="${pager.groupNo > 1}">
								<a class="btn btn-primary" href="movieDetail.do?pageNo=${pager.startPageNo - pager.pagesPerGroup}&fno=${film.fno}">이전</a>
							</c:if>
							<c:forEach var="i" begin="${pager.startPageNo}" end="${pager.endPageNo}">
								
								<c:if test="${pager.pageNo != i}">
									<a class="btn btn-dark" href="movieDetail.do?pageNo=${i}&fno=${film.fno}">${i}</a>
								</c:if> 
								
								<c:if test="${pager.pageNo == i}">
									<a class="btn btn-outline-dark" href="movieDetail.do?pageNo=${i}&fno=${film.fno}">${i}</a>
								</c:if>
							</c:forEach>
							
							<c:if test="${pager.groupNo < pager.totalGroupNo}">
								<a class="btn btn-primary" href="movieDetail.do?pageNo=${pager.endPageNo+1}&fno=${film.fno}">다음</a>
							</c:if>
							<a class="btn btn-primary" href="movieDetail.do?pageNo=${pager.totalPageNo}&fno=${film.fno}">맨끝</a>	
						</td>
					</tr> 
				</tbody>
			</table>
		</div>
		<br/>
		<br/>
		<hr size="5" width="70%" color="black">
		
		<div style="text-align: center;">
			<font face="맑은 고딕 " size="10">한줄평</font>
			<font face="맑은 고딕 " size="4">Comment</font>
		</div>
		<br/>
		
		<div style="text-align: center;">
			<c:if test="${sessionMid == null}">
				<h5>※로그인을 해야 댓글을 쓸 수 있습니다.</h5>
			  	<a href="${pageContext.request.contextPath}/member/login.do" class="btn btn-success" style="width: 200px;">로그인</a></h2>
			</c:if>
			<c:if test="${sessionMid != null}">
			  	<form id="reviewForm" method="post" action="writeReview.do" onsubmit="return checkduplicateid()" style="text-align: center;">
			        <div class="starRev" style="margin-left: 45%;">
						<span id="1" class="starR1 on" onclick="onclick_handler()">0.5</span>
						<span id="2" class="starR2 on" onclick="onclick_handler()">1.0</span>
						<span id="3" class="starR1 on" onclick="onclick_handler()">1.5</span>
						<span id="4" class="starR2 on" onclick="onclick_handler()">2.0</span>
						<span id="5" class="starR1 on" onclick="onclick_handler()">2.5</span>
						<span id="6" class="starR2 on" onclick="onclick_handler()">3.0</span>
						<span id="7" class="starR1" onclick="onclick_handler()">3.5</span>
						<span id="8" class="starR2" onclick="onclick_handler()">4.0</span>
						<span id="9" class="starR1" onclick="onclick_handler()">4.5</span>
						<span id="10" class="starR2" onclick="onclick_handler()">5.0</span>
					</div>
					<br/>
					<br/>
						<div style="margin-bottom: 20px">
							아이디 :
							<input type="text" style="width:400px;" disabled value="${sessionMid}"/>
						</div>
						<div>
							<input type="hidden" id="rfno" name="rfno" value="${film.fno}"/>
							<input type="hidden" id="rid" name="rid" value="${sessionMid}"/>
							<input type="hidden" id="rscore"/>
							<textarea name="rcontent" rows="2" style="width:800px; margin-left: 550px; float: left;"></textarea>
							<input id="submit" type="submit" value="등록" 
									class="btn btn-dark"
									style="margin-top: 5px; margin-right: 470px; float: right;"/>
						</div>			
				</form>
			</c:if>
		</div>
		<br/>
		<br/>
		
		<br/>
		<div class="footer">
		  <p>이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 영화 고객센터</p>
		  <p>사업자등록번호 : 0000-00-000 | 대표이사 : 호정맨 | 최고기술자: 바닐라 멘사맨</p>
		</div>
	</body>
</html>