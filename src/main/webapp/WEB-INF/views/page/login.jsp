<%@ page pageEncoding="utf-8"%>
<meta charset="utf-8">
<title>너의 18번을 들려줘</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:url var="R" value="/" />
<!-- 이게 원래 css코드임 
<link
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet" media="screen">
	-->
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="${R}res/common.js"></script>
<link rel="stylesheet" href="${R}res/common.css">


<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>

<body>
	<div id="wrap" style="background-image: url('${pageContext.request.contextPath}/res/images/loginImage.jpg'); background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">
		<!--헤더: 내비게이션 & 배너-->
		<header>
			<%@ include file="/WEB-INF/include/top.jsp"%>
		</header>


		<!--본문-->
		<section>
			<div id="content">
				<div class="container-fluid">

					<div style="margin: 300px 600px 200px; width: 700px;background-color:rgba( 255, 255, 255, 0.8 ); padding: 100px;">
						<form method="post" modelAttribute="users"
							onsubmit="return check()">
							<fieldset>
								<legend><h1 style="color: #1C1C1C">로그인</h1></legend>
								<hr style="margin-bottom: 20px;">
								
								<script type="application/javascript">
								function check() {
									var email = $('#email').val();
									var password = $('#password').val();
									
									<c:forEach var="user" items="${users}">
									if('${user.email}'==email) {
										if('${user.password}'==password) {
											if(${user.user_auth}==true) {
												return true;
											}
											alert('이메일 인증을 완료하세요.');
											$('#email').val('');
											$('#password').val('');
											return false;		
											
										}
									}
									                                
								</c:forEach>
								alert('등록되지 않은 이메일이거나, 이메일 또는 비밀번호가 잘못 입력되었습니다.');
								$('#email').val('');
								$('#password').val('');
								return false;
								}			
		
							</script>
								<div class="form-group">
									<input type="email" class="form-control" id="email" name="email" placeholder="이메일 입력">
								</div>
								<div class="form-group">
									<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호 입력">
								</div>
								<button type="submit" class="btn btn-primary btn-block">로그인
								</button>
							</fieldset>
						</form>
						<div style="font-weight: bold; color: #2E2E2E; text-align: center; margin-top: 30px;">
							<a class="a1" style="cursor: pointer" data-url="findPw"><span>비밀번호 찾기</span></a>
							<span> | </span>
							<a class="a1" style="cursor: pointer" data-url="join"><span>회원가입</span></a>
						</div>

					</div>
					
				</div>

			</div>
			
		</section>

		<!--푸터-->
		<footer id="footer">
			<br>
			<br>
			<p><a href="#" style="text-decoration: none;">▲ TOP</a></p>
			<p>Copyright  © 너의 18번을 들려줘 </p>
		</footer>
		
	</div>

</body>
</html>