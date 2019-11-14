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
	<div id="content">
		<div style="text-align: center; padding-top: 150px;">

			<!--게시판 내비게이션-->
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link"
					style="cursor: pointer" data-url="/page/bestBoard">베스트</a></li>
				<li class="nav-item"><a class="nav-link" style="cursor: pointer" data-url="/page/freeBoard?pg=1">자유
						게시판</a></li>
				<li class="nav-item"><a class="nav-link" style="cursor: pointer" data-url="/page/tipBoard?pg=1">팁
						게시판</a></li>
				<li class="nav-item"><a class="nav-link" style="cursor: pointer" data-url="/page/recommendBoard?pg=1">노래
						추천</a></li>
				<li class="nav-item"><a class="nav-link" style="cursor: pointer" data-url="/page/boastBoard?pg=1">전국
						노래 자랑</a></li>
			</ul>
		</div>
</body>
</html>