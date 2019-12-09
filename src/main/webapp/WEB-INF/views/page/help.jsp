<%@ page pageEncoding="utf-8"%>
<meta charset="utf-8">
<title>너의 18번을 들려줘</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:url var="R" value="/" />
<!-- 이게 원래 css인데...
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


<script>
	$(document).ready(function() {
		$("#spreadBtn").click(function() {
			if ($("#hiddenList").is(":visible")) {
				$("#hiddenList").slideUp();
			} else {
				$("#hiddenList").slideDown();
			}
		});
		$("#spreadBtn2").click(function() {
			if ($("#hiddenList2").is(":visible")) {
				$("#hiddenList2").slideUp();
			} else {
				$("#hiddenList2").slideDown();
			}
		});
		$("#spreadBtn3").click(function() {
			if ($("#hiddenList3").is(":visible")) {
				$("#hiddenList3").slideUp();
			} else {
				$("#hiddenList3").slideDown();
			}
		});
		$("#spreadBtn4").click(function() {
			if ($("#hiddenList4").is(":visible")) {
				$("#hiddenList4").slideUp();
			} else {
				$("#hiddenList4").slideDown();
			}
		});
		$("#spreadBtn5").click(function() {
			if ($("#hiddenList5").is(":visible")) {
				$("#hiddenList5").slideUp();
			} else {
				$("#hiddenList5").slideDown();
			}
		});
		$("#spreadBtn6").click(function() {
			if ($("#hiddenList6").is(":visible")) {
				$("#hiddenList6").slideUp();
			} else {
				$("#hiddenList6").slideDown();
			}
		});
		$("#spreadBtn7").click(function() {
			if ($("#hiddenList7").is(":visible")) {
				$("#hiddenList7").slideUp();
			} else {
				$("#hiddenList7").slideDown();
			}
		});
		$("#spreadBtn8").click(function() {
			if ($("#hiddenList8").is(":visible")) {
				$("#hiddenList8").slideUp();
			} else {
				$("#hiddenList8").slideDown();
			}
		});
		// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
		/*var floatPosition = parseInt($("#nav-left").css('top'));
		// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

		$(window).scroll(function() {
			// 현재 스크롤 위치를 가져온다.
			var scrollTop = $(window).scrollTop();
			var newPosition = scrollTop + floatPosition + "px";


			$("#nav-left").stop().animate({
				"top" : newPosition
			}, 500);
			
			
		}).scroll();*/

	});
</script>


</head>

<body>
	<div id="wrap">
		<!--헤더: 내비게이션 & 배너-->
		<header id="header">
			<%@ include file="/WEB-INF/include/top.jsp"%>
			<%@ include file="/WEB-INF/include/top2_board.jsp"%>
		</header>

		<!--본문-->
		<section>
			<div id="content">

				<%@ include file="/WEB-INF/include/informationList.jsp"%>

				<div
					style="text-align: center; padding-top: 100px; padding-bottom: 0px;">
					<h1 style="font-size: 23pt">도움말</h1>
				</div>
				<div class="container-fluid">
				<hr style="color:#D8D8D8">
				</div>

			<br><br>
				<div class="container"
					style="padding: 60px 50px;">
					<div class="helplist">

						<div>

							<h2 style="margin-bottom: 20px;">
								<span
									style="border-bottom: 2px solid #D8D8D8; padding-bottom: 5px;">회원
									정보</span>
							</h2>
							<div style="padding-left: 30px;">
								<h3 id="join">
									회원 가입
									<button class="imgbtn" id="spreadBtn" style="curser: pointer">
										<img
											src="${pageContext.request.contextPath}/res/images/drop.png"
											class="btnimg">
									</button>
								</h3>
								<div id="hiddenList"
									style="text-align: center; margin: 40px; display: none;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/join1.png">
									<p class="text-primary">1. 로그인 화면 하단의 회원가입을 클릭합니다</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/join2.PNG">
									<p class="text-primary">2. 이메일, 비밀번호, 닉네임을 입력한 뒤 다음 단계를
										클릭합니다.</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/join3.PNG">
									<p class="text-primary">3. 입력한 이메일 주소로 전송된 링크를 클릭하면 회원가입이
										완료됩니다.</p>
								</div>
								<h3 id="findpassword">
									비밀번호 찾기
									<button class="imgbtn" id="spreadBtn2">
										<img
											src="${pageContext.request.contextPath}/res/images/drop.png"
											class="btnimg">
									</button>
								</h3>
								<div id="hiddenList2"
									style="text-align: center; margin-top: 40px; display: none;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/fp1.png">
									<p class="text-primary">1. 로그인 화면 하단의 비밀번호 찾기를 클릭합니다</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/fp3.PNG">
									<br> <img
										src="${pageContext.request.contextPath}/res/images/helpImg/fp2.PNG">
									<p class="text-primary">2. 가입한 이메일 주소를 입력하면 비밀번호 재설정 링크가
										이메일로 전송됩니다</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/fp4.PNG">
									<p class="text-primary">3. 새로운 비밀번호를 입력합니다.</p>
								</div>
								<h3 id="changeprofile">
									회원 정보 수정
									<button class="imgbtn" id="spreadBtn3">
										<img
											src="${pageContext.request.contextPath}/res/images/drop.png"
											class="btnimg">
									</button>
								</h3>
								<div id="hiddenList3"
									style="text-align: center; margin-top: 40px; display: none;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/cp1.png">
									<p class="text-primary">1. 로그인 후 마이페이지의 닉네임 옆 정보수정 버튼을
										클릭합니다.</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/cp2.PNG"
										style="width: 1000px;">
									<p class="text-primary">2. 변경할 정보를 입력 후 등록 버튼을 클릭합니다.</p>
								</div>
							</div>
						</div>

						<hr style="margin: 40px 0;">

						<div>
							<h2 style="margin-bottom: 20px;">
								<span
									style="border-bottom: 2px solid #D8D8D8; padding-bottom: 5px;">검색</span>
							</h2>
							<div style="padding-left: 30px;">
								<h3 id="searchsong">
									곡 검색
									<button class="imgbtn" id="spreadBtn4">
										<img
											src="${pageContext.request.contextPath}/res/images/drop.png"
											class="btnimg">
									</button>
								</h3>
								<div id="hiddenList4"
									style="text-align: center; margin-top: 40px; display: none;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/ss1.PNG"
										style="width: 1000px;">
									<p class="text-primary">1. 홈페이지 메인의 곡 검색 창에 가수 혹은 곡명을
										입력합니다.</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/ss2.PNG"
										style="width: 1000px;"> <br> <img
										src="${pageContext.request.contextPath}/res/images/helpImg/ss3.PNG"
										style="width: 1000px;">
									<p class="text-primary">2. 검색 결과 화면에서 노래방 별 곡번호를 확인할 수
										있습니다.</p>
								</div>
							</div>
						</div>

						<hr style="margin: 40px 0;">

						<div>
							<h2 style="margin-bottom: 20px;">
								<span
									style="border-bottom: 2px solid #D8D8D8; padding-bottom: 5px;">커뮤니티</span>
							</h2>
							<div style="padding-left: 30px;">
								<h3 id="following">
									팔로잉
									<button class="imgbtn" id="spreadBtn5">
										<img
											src="${pageContext.request.contextPath}/res/images/drop.png"
											class="btnimg">
									</button>
								</h3>
								<div id="hiddenList5"
									style="text-align: center; margin-top: 40px; display: none;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/fo1.PNG"
										style="width: 1000px;">
									<p class="text-primary">1. 다른 유저의 페이지에서 팔로우 버튼을 클릭합니다.</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/fo2.PNG"
										style="width: 1000px;">
									<p class="text-primary">2. 마이 페이지의 팔로잉 탭을 클릭하면 내가 팔로우 한 유저
										목록을 볼 수 있습니다.</p>
								</div>
								<h3 id="postwrite">
									게시글 작성하기
									<button class="imgbtn" id="spreadBtn6">
										<img
											src="${pageContext.request.contextPath}/res/images/drop.png"
											class="btnimg">
									</button>
								</h3>
								<div id="hiddenList6"
									style="text-align: center; margin-top: 40px; display: none;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/wp1.PNG"
										style="width: 1000px;">
									<p class="text-primary">1. 로그인 후 커뮤니티 게시판 하단의 글작성 버튼을
										클릭합니다.</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/wp2.PNG"
										style="width: 1000px;">
									<p class="text-primary">2. 게시판을 선택하고 제목과 내용을 입력합니다.</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/wp3.PNG"
										style="width: 1000px;">
									<p class="text-primary">3. 하단의 파일 첨부 버튼을 통해 파일을 업로드 할 수
										있습니다. 파일 추가 버튼을 통해 업로드할 파일을 추가할 수 있습니다.</p>

								</div>
							</div>
						</div>

						<hr style="margin: 40px 0;">

						<div>
							<h2 style="margin-bottom: 20px;">
								<span
									style="border-bottom: 2px solid #D8D8D8; padding-bottom: 5px;">마이리스트</span>
							</h2>
							<div style="padding-left: 30px;">
								<h3 id="savesong">
									리스트에 곡 저장하기
									<button class="imgbtn" id="spreadBtn7">
										<img
											src="${pageContext.request.contextPath}/res/images/drop.png"
											class="btnimg">
									</button>
								</h3>
								<div id="hiddenList7"
									style="text-align: center; margin-top: 40px; display: none;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/sav1.PNG"
										style="width: 1000px;">
									<p class="text-primary">1. 검색에서 저장: 로그인이 된 상태로 곡 검색화면에서 노래방
										선택 후 원하는 곡을 클릭해 저장합니다.</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/sav2.PNG"
										style="width: 1000px;">
									<p class="text-primary">2. 차트에서 저장: 로그인이 된 상태로 인기 차트에서 노래방
										선택 후 원하는 곡을 클릭해 저장합니다.</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/sav3.PNG"
										style="width: 1000px;">
									<p class="text-primary">3. 다른 유저 페이지에서 저장: 로그인이 된 상태로 다른 유저
										페이지에서 노래방 선택 후 원하는 곡을 클릭해 저장합니다.</p>
									<hr
										style="width: 30px; border: 2px solid #D8D8D8; margin-top: 20px; margin-bottom: 20px;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/sav4.PNG"
										style="width: 1000px;">
									<p class="text-primary">4. 마이 페이지에서 내가 좋아하는 곡들을 한번에 볼 수
										있습니다.</p>
								</div>
								<h3 id="deletesong">
									리스트에서 곡 삭제하기
									<button class="imgbtn" id="spreadBtn8">
										<img
											src="${pageContext.request.contextPath}/res/images/drop.png"
											class="btnimg">
									</button>
								</h3>
								<div id="hiddenList8"
									style="text-align: center; margin-top: 40px; display: none;">
									<img
										src="${pageContext.request.contextPath}/res/images/helpImg/ds1.PNG"
										style="width: 1000px;">
									<p class="text-primary">1. 마이페이지의 마이리스트에서 삭제하고 싶은 곡을 클릭 후
										삭제합니다.</p>
								</div>
							</div>
						</div>

						<div style="height: 300px;"></div>

					</div>

				</div>

			</div>



		</section>

		<!--푸터-->
		<%@ include file="/WEB-INF/include/footer.jsp"%>

	</div>

</body>