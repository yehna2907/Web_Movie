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
		
		<script>
			function validationFindMid() {
				var mname = $("#findIdForm #mname").val()
				var mbirth = $("#findIdForm #mbirth").val()
				var mtel = $("#findIdForm #mtel").val()
				
				$("#errorMname").html("");
				$("#errorMbirth").html("*8자리로 입력해주세요. ex)19990101");
				$("#errorMtel").html("*숫자만 입력해주세요. ex)01012341234");
				
				if(mname != "" && mbirth != "" && mtel != "") {
					$.ajax({
						type:"POST",
						url:"forgotMid.do",
						data:{mname:mname, mbirth:mbirth, mtel:mtel},
						success: function(data) {
							if(data.result == "NoID") {
								window.alert("아이디가 존재하지 않습니다.");
							} else {
								window.alert("ID:" + data.result);
							}
						}
						
					});
					return true;
				}
				
				if(mname == "") {
					$("#errorMname").html(" *이름은 필수 입력값입니다.");
				}
				if(mbirth == "") {
					$("#errorMbirth").html(" *생년월일은 필수 입력값입니다.");
				}
				if(mtel == "") {
					$("#errorMtel").html(" *전화번호는 필수 입력값입니다.");
				}
				
				return false;
			}
			
	         function validationFindMpassword() {
	             console.log("실행");
	              var mid = $("#findPasswordForm #mid").val()
	              var mbirth = $("#findPasswordForm #mbirth").val()
	              var mtel = $("#findPasswordForm #mtel").val()
	              
	              $("#errorMid").html("");
	              $("#errorMbirth").html("*8자리로 입력해주세요. ex)19990101");
	              $("#errorMtel").html("*숫자만 입력해주세요. ex)01012341234");
	              
	              if(mid != "" && mbirth != "" && mtel != "") {
	                 $.ajax({
	                    type:"POST",
	                    url:"forgotMpassword.do",
	                    data:{mid:mid, mbirth:mbirth, mtel:mtel},
	                    success: function(data) {
	                      console.log(data.result);
	                       if(data.result == "NoID") {
	                          window.alert("아이디가 존재하지 않습니다.");
	                       } else {
	                          window.alert("PW:" + data.result);
	                       }
	                    }
	                    
	                 });
	                 return true;
	              }
	              
	              if(mid == "") {
	                 $("#findPasswordForm #errorMid").html(" *아이디는 필수 입력값입니다.");
	              }
	              if(mbirth == "") {
	                 $("#findPasswordForm #errorMbirth").html(" *생년월일은 필수 입력값입니다.");
	              }
	              if(mtel == "") {
	                 $("#findPasswordForm #errorMtel").html(" *전화번호는 필수 입력값입니다.");
	              }
	              
	              return false;
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
		</div>
		
      <br/>
		<div style="text-align: center;"><font size="11" face="맑은 고딕">아이디 찾기</font><br/></div>
		<div style="text-align: center; background-color: #AFE0FF">	
			<hr size="7" width="50%" color="black">
				<form method="post" id="findIdForm" onsubmit="return validationFindMid()" action="${pageContext.request.contextPath}/home/main.do">
				
				<font size="5" face="맑은 고딕">이름</font><br/>
				<input type="text" id="mname" name="mname"/><br/>
				<span id="errorMname" style="color:red;font-size:13px"></span><p></p>
				
				<font size="5" face="맑은 고딕">생년월일</font><br/>
				<input type="text" id="mbirth" name="mbirth"/><br/>
				<span id="errorMbirth" style="color:red;font-size:13px"> *8자리로 입력해주세요. ex)19990101</span><p></p>
				
				<font size="5" face="맑은 고딕">전화번호</font><br/>
				<input type="text" id="mtel" name="mtel"/><br/>
				<span id="errorMtel" style="color:red;font-size:13px"> *숫자만 입력해주세요. ex)01012341234</span><p></p>
				
				<input class="btn btn-primary" type="submit" value="아이디 찾기"/>
			</form>
		</div>
		<hr size="7" width="50%" color="black">
		
		<div style="text-align: center;"><font size="11" face="맑은 고딕">비밀번호 찾기</font><br/></div>	
		<div style="text-align: center; background-color: #AFE0FF">	
			<form method="post" id="findPasswordForm" onsubmit="return validationFindMpassword()" action="${pageContext.request.contextPath}/home/main.do">
	        <p></p>
	        <font size="5" face="맑은 고딕">아이디</font><br/>
	        <input type="text" id="mid" name="mid"/><br/>
	        <span id="errorMid" style="color:red;font-size:13px"></span><p></p>
	        
	        <font size="5" face="맑은 고딕">생년월일</font><br/>
	        <input type="text" id="mbirth" name="mbirth"/><br/>
	        <span id="errorMbirth" style="color:red;font-size:13px"> *8자리로 입력해주세요. ex)19990101</span><p></p>
	        
	        <font size="5" face="맑은 고딕">전화번호</font><br/>
	        <input type="text" id="mtel" name="mtel"/><br/>
	        <span id="errorMtel" style="color:red;font-size:13px"> *숫자만 입력해주세요. ex)01012341234</span><p></p>
	       
         <input class="btn btn-primary" type="submit" value="비밀번호 찾기"/>
      </form>
		</div>
		<hr size="7" width="50%" color="black">
		
		<br/>
		<div class="footer">
		  <p>이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 영화 고객센터</p>
		  <p>사업자등록번호 : 0000-00-000 | 대표이사 : 호정맨 | 최고기술자: 바닐라 멘사맨</p>
		</div>
	</body>
</html>