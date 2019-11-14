<%@ page pageEncoding="utf-8"%>
<meta charset="utf-8">
<title>너의 18번을 들려줘</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
				<div class="container">
					<div class="jumbotron" style="margin-top: 100px;">

						<!--안내문 영역-->
						<div
							style="background: #E6E6E6; text-align: center; padding: 30px 0; color: #2E2E2E;">
							"${keyword}"(으)로 검색한 결과입니다.</div>

						<!--검색결과 테이블-->

						<table class="table table-hover" style="margin-top: 100px;">
							<thead>
								<tr>
									<th>게시판</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>조회수</th>
									<th>추천수</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach var="singeFinded" items="${finded}"
									varStatus="status">
									<c:set var="num" value="${fn:length(finded)-status.index}" />
									<c:set var="commentNum" value="0" />
									<c:set var="replyNum" value="0" />
									<c:forEach var="comm" items="${singeFinded.comments}">
										<c:if test="${comm.is_delete eq 0}">
											<c:set var="commentNum" value="${commentNum + 1}" />
										</c:if>

										<c:set var="replyNum"
											value="${fn:length(comm.replies)+replyNum}" />
									</c:forEach>
									<c:set var="commentAndReplyNum" value="${commentNum+replyNum}" />

									<c:if
										test="${num>fn:length(finded)-10*pg && num<=fn:length(finded)-10*(pg-1)}">

										<tr>
											<td>${singeFinded.board.board_name}</td>
											<td><a href="post/${singeFinded.post_id}"
												style="text-decoration: none; font-weight: bold; color: grey">${singeFinded.title}[${commentAndReplyNum}]</a></td>
											<c:set var="theString" value="${singeFinded.user.nickname}" />
											<td><c:if test="${fn:contains(theString,'관리자')}">${singeFinded.user.nickname}</c:if>
												<c:if test="${fn:indexOf(theString,'관리자')==-1}">
													<a
														href="user?user_idx=${singeFinded.user.user_idx}&kara_type=0&sort=0"
														style="text-decoration: none; font-weight: bold; color: grey">${singeFinded.user.nickname}</a>
												</c:if></td>
											<td>${singeFinded.date}</td>
											<td>${singeFinded.view}</td>
											<td><c:choose>
													<c:when
														test="${map_like.containsKey(singeFinded.post_id) eq true}">
														${map_like.get(singeFinded.post_id)}
												</c:when>
													<c:otherwise>0</c:otherwise>
												</c:choose></td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>

						</table>
						<div class="text-center" style="margin-top: 100px;">
							<!--페이지네이션-->
							<ul class="pagination">
								<!-- 한 페이지당 10개 게시글일때 총 몇 페이지인지 -->
								<fmt:parseNumber var="totalPg"
									value="${fn:length(finded)/10+(1-((fn:length(finded)/10)%1))%1}"
									integerOnly="true" />
								<!-- 1,2,3같이 페이지 3개가 한 페이지네이션일때 총 몇 페이지네이션이 나오는지 -->
								<fmt:parseNumber var="paginationTotal"
									value="${totalPg/3+(1-((totalPg/3)%1))%1}" integerOnly="true" />
								<!-- 현재 페이지가 몇번의 페이지네이션에 속하는지 -->
								<fmt:parseNumber var="paginationNum"
									value="${pg/3+(1-((pg/3)%1))%1}" integerOnly="true" />
								<!-- 다음 페이지네이션의 맨 첫번째 페이지 번호 -->
								<fmt:parseNumber var="paginationNext"
									value="${3*paginationNum+1}" integerOnly="true" />
								<!-- 이전 페이지네이션의 맨 마지막 페이지 번호 -->
								<fmt:parseNumber var="paginationPrevious"
									value="${3*(paginationNum-1)}" integerOnly="true" />

								<c:if test="${paginationNum eq 1}">
									<li class="page-item disabled"><a class="page-link"
										href="#">Previous</a></li>
								</c:if>
								<c:if test="${paginationNum ne 1}">
									<li class="page-item"><a class="page-link"
										href="/page/searchPost?pg=${paginationPrevious}&search_type=${type}&keyword=${keyword}">Previous</a></li>
								</c:if>
								<c:forEach var="i" begin="1" end="${totalPg}" step="3">
									<c:if test="${i>(paginationNum-1)*3 && (i+2)<=paginationNum*3}">
										<li class="page-item <c:if test="${pg eq i}">active</c:if>"><a
											class="page-link"
											href="/page/searchPost?pg=${i}&search_type=${type}&keyword=${keyword}">${i}</a></li>
										<c:if test="${(i+1)<=totalPg}">
											<li
												class="page-item <c:if test="${pg eq (i+1)}">active</c:if>"><a
												class="page-link"
												href="/page/searchPost?pg=${i+1}&search_type=${type}&keyword=${keyword}">${i+1}</a></li>
										</c:if>
										<c:if test="${(i+2)<=totalPg}">
											<li
												class="page-item <c:if test="${pg eq (i+2)}">active</c:if>"><a
												class="page-link"
												href="/page/searchPost?pg=${i+2}&search_type=${type}&keyword=${keyword}">${i+2}</a></li>
										</c:if>
									</c:if>

								</c:forEach>
								<c:if
									test="${(paginationNum eq paginationTotal) || (paginationTotal eq 0)}">
									<li class="page-item disabled"><a class="page-link"
										href="#">Next</a></li>
								</c:if>
								<c:if
									test="${(paginationNum ne paginationTotal)&& (paginationTotal ne 0)}">
									<li class="page-item"><a class="page-link"
										href="/page/searchPost?pg=${paginationNext}&search_type=${type}&keyword=${keyword}">Next</a></li>
								</c:if>
							</ul>
						</div>

					</div>

					<!--검색-->
					<%@ include file="/WEB-INF/include/searching.jsp"%>
					<br> <br> <br> <br>

				</div>
			</div>

		</section>
		<!--푸터-->
		<%@ include file="/WEB-INF/include/footer.jsp"%>

	</div>
</body>