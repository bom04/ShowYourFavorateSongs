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
						<form onsubmit="return check()" method="post">
							<div style="margin-top: 10px; color: #2E2E2E;">
								<label class="col-form-label" for="message">한줄소개</label> <input
									type="text" class="form-control" name="message"
									placeholder="한줄 소개를 입력하세요 (100자까지 가능)" value="${me.message}">
							</div>

							<hr class="my-4" style="margin-top: 200px;">

							<div class="form-group"
								style="width: 400px; margin: 50px 0 100px 0;">
								<label class="col-form-label" for="inputNickname">닉네임 변경</label>
								<input type="text" class="form-control" placeholder="닉네임 변경"
									id="nickname" name="nickname" value="${me.nickname }">
								<button type="button" class="btn btn-primary"
									style="width: 110px; height: 50px;" onclick="nicknameCheck()">중복
									체크</button>
								<br>
								<script type="application/javascript">
									
									
								var n="";
								function nicknameCheck() {
									var nickname = $('#nickname').val();
									if(nickname.includes('관리자')) {
											alert('"관리자"라는 단어가 들어간 닉네임은 사용이 불가능합니다.');
											n="false";
											return;
										}
									if(nickname=='${user.nickname}') {
										alert("기존 닉네임입니다.");
										n="true";
										return;
									}
									<c:forEach var="user2" items="${users}">
										if('${user2.nickname}'==nickname) {
											alert('닉네임 중복입니다. 다시 입력하세요.');
											n="false";
											return;
										}                      
									</c:forEach>
									alert('닉네임 중복 체크 완료되었습니다.');
									n="true";
								}	
								function check() {
									var password = $('#password').val();
									var password2 = $('#password2').val();

									if(password!=password2) {
										alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
										return false;
									}
									if(n=="true")
										return true;
									alert("중복체크 확인해주세요");
									return false;
								}			
							
								
								</script>

								<label class="col-form-label" for="inputPassword1">새
									비밀번호</label> <input type="password" class="form-control" id="password"
									name="password" placeholder="새 비밀번호" required> <label
									class="col-form-label" for="inputPassword1">비밀번호 확인</label> <input
									type="password" class="form-control" id="password2"
									placeholder="비밀번호 확인" required>
							</div>
							<hr class="my-4" style="margin-top: 200px;">

							<div style="text-align: center; margin-top: 130px;">
								<button type="button" class="btn btn-primary btn2"
									style="width: 100px;"
									onclick="location.href='/page/user?user_idx=${user.user_idx}&kara_type=0&sort=0'">취소</button>
								<button type="submit" class="btn btn-primary"
									style="width: 100px;" data-change-profile>등록</button>
							</div>
						</form>
					</div>
				</div>

			</div>

		</section>
		<!--푸터-->
		<%@ include file="/WEB-INF/include/footer.jsp"%>

	</div>
</body>

</html>