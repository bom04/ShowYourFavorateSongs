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
<!-- <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>-->
<!--  <script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>-->

<body>
	<div id="wrap">
		<header id="header">
			<%@ include file="/WEB-INF/include/top.jsp"%>
			<%@ include file="/WEB-INF/include/top2_board.jsp"%>
		</header>

		<section>
			<!--본문 작성-->
			<div id="content">
				<div class="container">
					<div class="jumbotron" style="margin-top: 100px;">
						<!--검색창 영역-->
						<div style="margin: 100px;">
							<form class="form-inline my-2 my-lg-0"
								action="/page/searchingSong/0" method="get">
								<input class="form-control" name="keyword" type="text"
									placeholder="곡 제목 혹은 가수 검색"
									style="width: 80%; text-align: center;" value="${keyword}">
								<button class="btn btn-secondary my-2 my-sm-0" type="submit">검색</button>
							</form>
						</div>

						<!--안내문 영역-->
						<div
							style="background: #E6E6E6; text-align: center; padding: 30px 0; color: #2E2E2E;">
							"${keyword}"(으)로 검색한 결과입니다.</div>
						<br> <br>
						<c:if test="${kara eq 0}">
							<button type="button" class="btn btn-primary btn"
								style="margin-left: 230px; width: 300px; border: 1px solid black" onclick="location.href='/page/searchingSong/0?keyword=${keyword}'" >금영</button>
							<button type="button" class="btn btn-default btn"
								style="margin-left: 30px; width: 300px; border: 1px solid black" onclick="location.href='/page/searchingSong/1?keyword=${keyword}'">태진</button>
						</c:if>
						<c:if test="${kara eq 1}">
							<button type="button" class="btn btn-default btn"
								style="margin-left: 230px; width: 300px; border: 1px solid black" onclick="location.href='/page/searchingSong/0?keyword=${keyword}'">금영</button>
							<button type="button" class="btn btn-primary btn"
								style="margin-left: 30px; width: 300px; border: 1px solid black" onclick="location.href='/page/searchingSong/1?keyword=${keyword}'">태진</button>
						</c:if>

						<!--검색결과 테이블-->

						<table class="table table-hover" style="margin-top: 30px;">
							<thead>
								<tr style="background: #E6E6E6; color: #2E2E2E;">
									<th>번호</th>
									<th>곡명</th>
									<th>가수</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach var="song" items="${songList}" varStatus="status">
									<tr style="cursor: pointer" <c:if test="${user.manager ne 'true'}">song-add="${kara} ${keyword} ${song.song_num}"</c:if> >
										<td>${song.song_num}</td>
										<td>${song.title}</td>
										<td>${song.singer}</td>
									</tr>
								</c:forEach>
							</tbody>

						</table>

						<!--안내문 영역-->
						<div
							style="background: #E6E6E6; text-align: center; padding: 30px 0; margin: 100px 0; color: #2E2E2E;">
							<span>찾으시는 곡이 없나요?</span> <span><a href="/page/relative"
								style="font-weight: bold;">노래 신청하러 가기</a></span>
						</div>
					</div>
				</div>
			</div>

		</section>
		<!--푸터-->
		<%@ include file="/WEB-INF/include/footer.jsp"%>

	</div>
</body>