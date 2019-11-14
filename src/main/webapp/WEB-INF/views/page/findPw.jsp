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


<body>
	<div id="wrap"
		style="background-image: url('${pageContext.request.contextPath}/res/images/loginImage.jpg'); background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">
		<!--헤더: 내비게이션 & 배너-->
		<header>
			<%@ include file="/WEB-INF/include/top.jsp"%>
		</header>


		<section>
			<div id="content">
				<div class="container-fluid">
					<div
						style="margin: 300px 600px 200px; width: 700px; background-color: rgba(255, 255, 255, 0.8); padding: 100px;">
						<form method="post" modelAttribute="users" onsubmit="return check()">
							<fieldset style="color: #585858">
								<legend>
									<h1 style="color: #1C1C1C">비밀번호 찾기</h1>
								</legend>
								<p>
									<small>비밀번호를 찾기 위해 아래 정보를 입력하세요</small>
								</p>
							<script type="application/javascript">
								function check() {
									var email = $('#email').val();

									<c:forEach var="user" items="${users}">
									if('${user.email}'==email) {
										return true;
									}
									                                
								</c:forEach>
								alert('존재하지 않는 이메일입니다.');
								$('#email').val('');
								return false;
								}			
		
							</script>
								<hr style="margin-bottom: 20px;">
								<div class="form-group">
									<label for="inputEmail1">이메일 주소</label> <input type="email"
										class="form-control" id="email" name="email"
										aria-describedby="emailHelp" placeholder="이메일 주소 입력" required>
								</div>

								<button type="submit" class="btn btn-primary btn-block" 
									style="margin-top: 20px;">다음 단계</button>
								
							</fieldset>
						</form>
					</div>

				</div>

			</div>

		</section>
		<!--푸터-->
		<footer id="footer">
			<br> <br>
			<p>
				<a href="#" style="text-decoration: none;">▲ TOP</a>
			</p>
			<p>Copyright © 너의 18번을 들려줘</p>
		</footer>

	</div>

</body>
</html>