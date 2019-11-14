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
<!-- <script src="${R}res/common.js"></script>-->
<link rel="stylesheet" href="${R}res/common.css">


<!-- jQuery -->
<!-- <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>-->
<!-- <script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>-->

<body>
	<nav class="navbar navbar-expand-sm navbar-dark bg-primary"
		style="z-index: 999; opacity: 0.9;">
		<div class="container-fluid">

			<!--메인 링크-->
			<a class="navbar-brand" data-url="/page/home" style="cursor: pointer">너의
				18번을 들려줘&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| </a>

			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarColor01" aria-controls="navbarColor01"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarColor01">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item">
						<!--메인 링크--> <a class="nav-link" data-url="/page/home"
						style="cursor: pointer">홈<span class="sr-only">(current)</span></a>
					</li>
					<li class="nav-item">
						<!--공지 링크--> <a class="nav-link" data-url="/page/notice?pg=1"
						style="cursor: pointer">공지사항</a>
					</li>
					<li class="nav-item">
						<!--차트 링크--> <a class="nav-link" style="cursor: pointer"
						data-url="/page/chartBoard">인기차트</a>
					</li>
					<li class="nav-item dropdown">
						<!--커뮤니티 링크--> <a class="nav-link dropdown-toggle"
						data-toggle="dropdown" data-url="/page/bestBoard"
						style="cursor: pointer" role="button" aria-haspopup="true"
						aria-expanded="false">커뮤니티</a>
						<ul class="dropdown-menu" role="menu">
							<li><a style="cursor: pointer" data-url="/page/bestBoard">베스트
									게시판</a></li>
							<li><a style="cursor: pointer" data-url="/page/freeBoard?pg=1">자유
									게시판</a></li>
							<li><a style="cursor: pointer" data-url="/page/tipBoard?pg=1">팁 게시판</a></li>
							<li><a style="cursor: pointer" data-url="/page/recommendBoard?pg=1">노래
									추천</a></li>
							<li><a style="cursor: pointer" data-url="/page/boastBoard?pg=1">전국
									노래 자랑</a></li>
						</ul>
					</li>
					<li class="nav-item dropdown">
						<!--정보 링크--> <a class="nav-link dropdown-toggle"
						data-toggle="dropdown" data-url="/page/map" style="cursor: pointer"
						role="button" aria-haspopup="true" aria-expanded="false">정보</a>
						<ul class="dropdown-menu" role="menu">
							<li><a data-url="/page/map" style="cursor: pointer">노래방 맵</a></li>
							<li><a style="cursor: pointer" data-url="/page/relative">관련
									사이트</a></li>
						</ul>
					</li>
				</ul>
				<c:choose>
					<c:when test="${empty user }">
						<ul class="nav navbar-nav navbar-right">
							<li class="nav-item"><a class="nav-link login"
								data-url="/page/login"
								style="color: white; cursor: pointer; border: 1px solid #585858; padding: 10px 15px 10px 15px;">로그인</a>
							</li>
						</ul>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${user.manager eq 'true' }">
								<ul class="nav navbar-nav navbar-right">
									<li class="nav-item">관리자</li>
									<li class="nav-item"><a class="nav-link login"
										data-url="/page/logout"
										style="color: white; cursor: pointer; border: 1px solid #585858; padding: 10px 15px 10px 15px;">로그아웃</a>
									</li>
								</ul>
							</c:when>
							<c:otherwise>
								<ul class="nav navbar-nav">
									<li class="nav-item"><a class="nav-link logout"
										data-url="/page/user?user_idx=${ user.user_idx}&kara_type=0&sort=0"
										style="color: white; cursor: pointer; border: 1px solid #585858; padding: 10px 15px 10px 15px;">마이페이지</a>
									</li>
								</ul>
								<ul class="nav navbar-nav">
									<li class="nav-item"><a class="nav-link login"
										data-url="/page/logout"
										style="color: white; cursor: pointer; border: 1px solid #585858;">로그아웃</a>
									</li>
								</ul>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</nav>


</body>