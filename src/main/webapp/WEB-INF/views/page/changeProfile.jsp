<%@ page pageEncoding="utf-8"%>
<meta charset="utf-8">
<title>너의 18번을 들려줘</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
	<div id="wrap">
		<header id="header">
			<%@ include file="/WEB-INF/include/top.jsp"%>
			<%@ include file="/WEB-INF/include/top2_board.jsp"%>
		</header>
		<section>
			<!--본문 작성-->
			<div id="content">
				<div
					style="text-align: center; padding-top: 200px; padding-bottom: 20px;">
					<h1 style="font-size: 23pt">정보 수정</h1>
				</div>

				<hr
					style="margin-bottom: -2px; border: 0; height: 1px; background: #E6E6E6; clear: both;">

				<div class="container"
					style="margin-bottom: 200px; margin-top: 50px;">
					<div class="jumbotron">
						<span style="margin-right: 10px; padding-top: 0px;"><h3>${me.nickname}</h3></span>
						<form:form method="post" modelAttribute="profileUserModel">
							<div style="margin-top: 10px; color: #2E2E2E;">
								<label class="col-form-label" for="message">한줄소개</label> 
								<form:input path="message" class="form-control" value="${me.message}" placeholder="한줄 소개를 입력하세요."/>
								<form:errors path="message" class="error"
									style="font-style:italic;font-size:0.8em;color:red;font-weight:bold" />
							</div>
							<hr class="my-4" style="margin-top: 200px;">
							
							<div class="form-group">
								<label>닉네임</label>
								<form:input path="nickname" class="form-control" value="${me.nickname}" placeholder="닉네임을 입력하세요."/>
								<form:errors path="nickname" class="error"
									style="font-style:italic;font-size:0.8em;color:red;font-weight:bold" />
							</div>
							<div class="form-group">
								<label>새 비밀번호</label>
								<form:password path="password" class="form-control" placeholder="비밀번호를 입력하세요."/>
								<form:errors path="password" class="error"
									style="font-style:italic;font-size:0.8em;color:red;font-weight:bold" />
							</div>
							<div class="form-group">
								<label>새 비밀번호 확인</label>
								<form:password path="password2" class="form-control" placeholder="비밀번호를 다시 입력하세요." />
								<form:errors path="password2" class="error"
									style="font-style:italic;font-size:0.8em;color:red;font-weight:bold" />
							</div>
							<hr class="my-4" style="margin-top: 200px;">

							<div style="text-align: center; margin-top: 130px;">
								<button type="button" class="btn btn-primary btn2"
									style="width: 100px;"
									onclick="location.href='/page/user?user_idx=${user.user_idx}&kara_type=0&sort=0'">취소</button>
								<button type="submit" class="btn btn-primary"
									style="width: 100px;" data-change-profile>등록</button>
							</div>
						</form:form>
					</div>
				</div>

			</div>

		</section>
		<!--푸터-->
		<%@ include file="/WEB-INF/include/footer.jsp"%>

	</div>
</body>

</html>