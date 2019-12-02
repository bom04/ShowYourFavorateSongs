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
					<c:if test="${me.user_idx==u.user_idx}">
						<h1 style="font-size: 20pt">마이 페이지</h1>
					</c:if>
					<c:if test="${me.user_idx!=u.user_idx}">
						<h1 style="font-size: 20pt">${u.nickname}님의 개인페이지</h1>
					</c:if>
				</div>

				<hr
					style="margin-bottom: -2px; border: 0; height: 1px; background: #E6E6E6; clear: both;">

				<div class="container"
					style="margin-bottom: 100px; margin-top: 50px;">
					<div class="jumbotron">
						<span style="float: left; margin-right: 10px; padding-top: 5px;"><h3>${u.nickname}</h3></span>
						<c:if test="${u.user_idx eq user.user_idx}">
							<button type="button" class="btn btn-primary btn5"
								style="margin-right: 40px; border: 1px solid #BDBDBD; background: #fff; color: #BDBDBD;"
								onclick="location.href='/page/changeProfile?user_idx=${user.user_idx}'">정보
								수정</button>
						</c:if>
						<c:choose>
							<c:when test="${u.user_idx eq user.user_idx || user.manager eq true}">
								<!-- 본인의 마이페이지 일때 -->
								<button type="button" class="btn btn-default btn4"
									style="border: 1px solid grey">팔로우</button>
							</c:when>
							<c:otherwise>
								<!-- 본인의 마이페이지가 아닐때-->
								<c:choose>
									<c:when test="${follow eq true}">
										<!-- 이미 팔로우한 유저일때 -->
										<button type="button" class="btn btn-primary btn4"
											delete-follow="${u.user_idx} ${kara} ${sort} ${me.user_idx}">팔로우</button>
									</c:when>
									<c:otherwise>
										<!-- 팔로우가 안되어있는 유저일때 -->
										<button type="button" class="btn btn-default btn4"
											style="border: 1px solid grey"
											data-follow="${u.user_idx} ${kara} ${sort} ${me.user_idx}">팔로우</button>
									</c:otherwise>
								</c:choose>

							</c:otherwise>
						</c:choose>
						<div class="btn btn-primary btn4"
							style="border: 1px solid #BDBDBD; background: #fff; color: #BDBDBD;">${followedNum}</div>

						<!--유저 삭제-->
						<c:choose>
							<c:when test="${user.manager eq 'true' }">
								<button type="button" class="btn btn-primary btn3"
									style="float: right; border: 1px solid #FA5858; background: #FA5858;"
									onclick="location.href='userDelete?user_idx=${u.user_idx}'">유저
									삭제</button>
							</c:when>
						</c:choose>
						<div style="margin-top: 30px; color: #2E2E2E;">
							<span style="font-weight: bold;"> <a href="#modalLayer"
								class="modalLink"
								style="text-decoration: none; margin-right: 20px;">팔로우 
								<c:choose>
										<c:when test="${empty followingList}">0</c:when>
										<c:otherwise>
											<c:set var="followingListNum"
												value="${fn:length(followingList)}" />${followingListNum}
								</c:otherwise>
									</c:choose>
							</a>
							</span> <span style="font-weight: bold; margin-right: 20px;"> <a
								href="/page/userPost?user_idx=${u.user_idx}" style="text-decoration: none;">포스트 ${count}</a>
							</span> <span style="font-weight: bold; margin-right: 20px;"> <a
								href="/page/userComment?user_idx=${u.user_idx}" style="text-decoration: none;">댓글 ${countComment}</a>
							</span> <span style="font-weight: bold; margin-right: 20px;"> <a
								href="/page/recommendedPost?user_idx=${u.user_idx}" style="text-decoration: none;">좋아요 ${countLike}</a>
							</span>

						</div>
						<hr class="my-4">
						<div style="margin-top: 30px; color: #2E2E2E;">
							<p>${u.message}</p>
						</div>
					</div>
				</div>

				<div style="padding-bottom: 10px; text-align: center;">
					<h1 style="font-size: 15pt">${u.nickname}님의 애창곡 목록</h1>
				</div>
				<hr
					style="margin-bottom: -40px; border: 0; height: 1px; background: #E6E6E6; clear: both;">

				<div class="container" style="margin-bottom: 200px;">
					<div class="jumbotron" style="margin-top: 10px;">
						<c:if test="${kara eq 0}">
							<button type="button" class="btn btn-primary btn"
								style="margin-left: 230px; width: 300px; border: 1px solid black"
								onclick="location.href='/page/user?user_idx=${u.user_idx}&kara_type=0&sort=0'">금영</button>
							<button type="button" class="btn btn-default btn"
								style="margin-left: 30px; width: 300px; border: 1px solid black"
								onclick="location.href='/page/user?user_idx=${u.user_idx}&kara_type=1&sort=0'">태진</button>
						</c:if>
						<c:if test="${kara eq 1}">
							<button type="button" class="btn btn-default btn"
								style="margin-left: 230px; width: 300px; border: 1px solid black"
								onclick="location.href='/page/user?user_idx=${u.user_idx}&kara_type=0&sort=0'">금영</button>
							<button type="button" class="btn btn-primary btn"
								style="margin-left: 30px; width: 300px; border: 1px solid black"
								onclick="location.href='/page/user?user_idx=${u.user_idx}&kara_type=1&sort=0'">태진</button>
						</c:if>
						<br> <br>
						<div class="form-group" style="margin-bottom: 50px;">
							<select class="custom-select" id="sort"
								onchange="chageLangSelect()">
								<option value="0" <c:if test="${sort eq 0}">selected</c:if>>가수로
									정렬</option>
								<option value="1" <c:if test="${sort eq 1}">selected</c:if>>제목으로
									정렬</option>
							</select>
						</div>
						<table class="table table-hover" style="color: #2E2E2E;">
							<thead>
								<tr>
									<th style="font-weight: bold; font-size: 12pt;">번호</th>
									<th colspan=2 style="font-weight: bold; font-size: 12pt;">곡명</th>
									<th style="font-weight: bold; font-size: 12pt;">가수</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach var="song" items="${songs}" varStatus="status">
									<tr
										<c:choose>
											<c:when test="${u.user_idx eq user.user_idx}"> song-delete="${user.user_idx} ${kara} ${sort} ${song.song.song_id}"</c:when>
											<c:otherwise>song-add-userpage="${user.user_idx} ${kara} ${song.song.song_id} ${sort}"</c:otherwise>
										</c:choose>
										style="cursor: pointer">
										
										<td>${song.song.song_num}</td>
										<td colspan=2>${song.song.title}</td>
										<td>${song.song.singer}</td>
									</tr>
								</c:forEach>
							</tbody>

						</table>

					</div>
				</div>


				<!-- Button trigger modal -->

				<div id="modalLayer">
					<div class="modalContent">
						팔로우 목록
						<table>
							<c:forEach var="following" items="${followingList}"
								varStatus="status">
								<tr id="tr">
									<td><a href="/page/user?user_idx=${following.user_idx}&kara_type=0&sort=0" style="cursor: pointer">${following.nickname}</a></td>
								</tr>
							</c:forEach>
						</table>
						<button type="button" class="btn btn-primary btn3"
							style="float: right; border: 1px solid #FA5858; background: #FA5858;">닫기</button>

					</div>
				</div>

			</div>

		</section>

		<!--푸터-->
		<%@ include file="/WEB-INF/include/footer.jsp"%>

	</div>

	<script>
		function chageLangSelect() {
			var langSelect = document.getElementById("sort");

			// select element에서 선택된 option의 value가 저장된다.
			var selectValue = langSelect.options[langSelect.selectedIndex].value;
			location.href = "/page/user?user_idx=${u.user_idx}&kara_type=${kara}&sort="
					+ selectValue;
		}
	</script>
</body>