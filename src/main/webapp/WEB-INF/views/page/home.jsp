<%@ page pageEncoding="utf-8"%>
<meta charset="utf-8">
<title>너의 18번을 들려줘</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<div id="wrap">
		<header id="header" style="height: 600px;">
			<%@ include file="/WEB-INF/include/top.jsp"%>
			<%@ include file="/WEB-INF/include/top2_main.jsp"%>
		</header>

		<section>
			<div id="content"
				style="background-image: url('${pageContext.request.contextPath}/res/images/main2.png'); background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">
				<div class="container">
					<div class="jumbotron"
						style="padding-top: 200px; padding-bottom: 100px;">
						<!--곡 검색-->
						<div style="margin-top: 30px;">
							<form action="/page/searchingSong/0" method="get"> <!-- 0이면 ky,1이면 tj -->
								<input type="text" class="search-song" name="keyword"
									placeholder="곡 제목 혹은 가수 검색" style="text-align: center;">
								<div style="text-align: center; margin-top: 30px;">
									<button type="submit" class="btn btn-primary"
										style="width: 200px;">찾기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			<div id="content">
				<div class="container" style="margin-top: 100px">
					<div class="jumbotron"
						style="padding-top: 150px; padding-bottom: 150px; margin-bottom: 0px;">
						<div class="row" style="margin-right: 0; margin-left: 0">
							<div
								style="width: 333px; height: 350px; background: #D8D8D8; margin-left: 0; margin-right: 20px; padding: 60px 30px; text-align: center;">
								<h2>마이 리스트</h2>
								<h2>-</h2>
								<p style="color: #151515; font-weight: 400;">나만의 애창곡 리스트를 통해
									더 쉽고 빠르게 노래방을 즐기세요</p>
								<button type="button" class="btn btn-primary"
									style="margin-top: 40px; width: 120px;"
									onclick="location.href='login'">바로 가기</button>
							</div>
							<div
								style="width: 333px; height: 350px; background: #D8D8D8; margin-right: 21px; padding: 60px 30px; text-align: center;">
								<h2>베스트 게시판</h2>
								<h2>-</h2>
								<p style="color: #151515; font-weight: 400;">지금 가장 HOT한 게시글을
									읽어보세요</p>
								<button type="button" class="btn btn-primary"
									style="margin-top: 40px; width: 120px;"
									onclick="location.href='bestBoard'">바로 가기</button>
							</div>
							<div
								style="width: 333px; height: 350px; background: #D8D8D8; padding: 60px 30px; text-align: center;">
								<h2>노래방 맵</h2>
								<h2>-</h2>
								<p style="color: #151515; font-weight: 400;">내 주변에 있는 노래방을
									찾아보세요</p>
								<button type="button" class="btn btn-primary"
									style="margin-top: 40px; width: 120px;"
									onclick="location.href='map'">바로 가기</button>
							</div>
						</div>
					</div>
				</div>
			</div>

		</section>


		<!--푸터-->
		<%@ include file="/WEB-INF/include/footer.jsp"%>

	</div>

</body>