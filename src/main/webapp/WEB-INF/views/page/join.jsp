<%@ page pageEncoding="utf-8"%>
<meta charset="utf-8">
<title>너의 18번을 들려줘</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:url var="R" value="/" />

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
						style="margin: 300px 700px 200px; width: 700px; background-color: rgba(255, 255, 255, 0.8); padding: 100px;">
						<form:form method="post" modelAttribute="userModel">
							<fieldset style="color: #585858">
								<legend>
									<h1 style="color: #1C1C1C">회원가입</h1>
								</legend>
								<hr style="margin-bottom: 20px;">

								<div class="form-group">
									<label>이메일</label>
									<form:input path="email" class="form-control w200" placeholder="이메일을 입력하세요."/>
									<form:errors path="email" class="error"
										style="font-style:italic;font-size:0.8em;color:red;font-weight:bold" />
								</div>
								<div class="form-group">
									<label>비밀번호</label>
									<form:password path="password" class="form-control w200" placeholder="비밀번호를 입력하세요."/>
									<form:errors path="password" class="error"
										style="font-style:italic;font-size:0.8em;color:red;font-weight:bold" />
								</div>
								<div class="form-group">
									<label>비밀번호 확인</label>
									<form:password path="password2" class=" form-control w200" placeholder="비밀번호를 다시 입력하세요."/>
									<form:errors path="password2" class="error"
										style="font-style:italic;font-size:0.8em;color:red;font-weight:bold" />
								</div>
								<div class="form-group">
									<label>닉네임</label>
									<form:input path="nickname" class="form-control w200" placeholder="닉네임을 입력하세요."/>
									<form:errors path="nickname" class="error"
										style="font-style:italic;font-size:0.8em;color:red;font-weight:bold" />
								</div>
								<button type="submit" class="btn btn-primary btn-block">다음 단계
								</button>
							</fieldset>
						</form:form>
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