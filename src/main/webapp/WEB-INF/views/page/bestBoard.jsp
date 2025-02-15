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

<script>
	function chageLangSelect() {
		var langSelect = document.getElementById("board_type");
		var selectValue = langSelect.options[langSelect.selectedIndex].value;
		location.href = "/page/bestBoard?board_type="+selectValue+"&pg=1"
	}
</script>

<body>
	<div id="wrap">
		<header id="header">
			<%@ include file="/WEB-INF/include/top.jsp"%>
			<%@ include file="/WEB-INF/include/top2_board.jsp"%>
		</header>
		<section>
			<div id="content">
				<%@ include file="/WEB-INF/include/communityList.jsp"%>

				<div
					style="text-align: center; padding-top: 100px; padding-bottom: 20px;">
					<h1 style="font-size: 23pt">베스트 게시판</h1>
				</div>

				<hr
					style="margin-bottom: -2px; border: 0; height: 1px; background: #E6E6E6; clear: both;">
	
				<br><br>

				<!--게시글 목록 테이블-->
				<div class="container">
					<div class="form-group">
					<select class="form-control" id="board_type" style="width:30%; float:right;" onchange="chageLangSelect()">
					    <option value=1 <c:if test="${board==1}"> selected </c:if>>전체 게시판</option>
					    <option value=2 <c:if test="${board==2}"> selected </c:if>>자유게시판</option>
					    <option value=3 <c:if test="${board==3}"> selected </c:if>>팁게시판</option>
					    <option value=4 <c:if test="${board==4}"> selected </c:if>>노래추천게시판</option>
					    <option value=5 <c:if test="${board==5}"> selected </c:if>>전국노래자랑게시판</option>
					</select>
					</div>
					
					<br><br><br>
					
					<table class="table table-hover">
						<thead>
							<tr>
								<th>번호</th>
								<th colspan=2>게시판</th>
								<th colspan=2>제목</th>
								<th colspan=2>작성자</th>
								<th colspan=2>날짜</th>
								<th>댓글</th>
								<th>조회</th>
								<th>추천</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="post" items="${posts}" varStatus="status">
								<c:set var="num" value="${fn:length(posts)-status.index}" />
								<c:set var="commentNum" value="0" />
								<c:set var="replyNum" value="0" />
								<c:forEach var="comm" items="${post.comments}">
									<c:if test="${comm.is_delete eq 0}">
										<c:set var="commentNum" value="${commentNum + 1}" />
									</c:if>

									<c:set var="replyNum" value="${fn:length(comm.replies)+replyNum}" />
								</c:forEach>
								<c:set var="commentAndReplyNum" value="${commentNum+replyNum}" />
								<c:if
									test="${num>fn:length(posts)-6*pg && num<=fn:length(posts)-6*(pg-1)}">
									<tr>
										<td><c:out value="${num}" /></td>
										<td colspan=2>${post.board.board_name}</td>
										<td colspan=2><a href="post/${post.post_id}"
											style="text-decoration: none; font-weight: bold; color: grey">${post.title}
										</a></td>
										<c:set var="theString" value="${post.user.nickname}" />
										<td colspan=2><c:if test="${fn:contains(theString,'관리자')}">${post.user.nickname}</c:if>
											<c:if test="${fn:indexOf(theString,'관리자')==-1}">
												<a
													href="user?user_idx=${post.user.user_idx}&kara_type=0&sort=0"
													style="text-decoration: none; font-weight: bold; color: grey">${post.user.nickname}</a>
											</c:if></td>
										<td colspan=2><fmt:formatDate value="${post.date}" pattern="yy/MM/dd HH:mm"/></td>
										<td>${commentAndReplyNum}</td>
										<td>${post.view}</td>
										<td><c:choose>
												<c:when test="${likes.containsKey(post.post_id) eq true}">
														${likes.get(post.post_id)}
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
								value="${fn:length(posts)/6+(1-((fn:length(posts)/6)%1))%1}"
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
									href="/page/bestBoard?pg=${paginationPrevious}">Previous</a></li>
							</c:if>
							<c:forEach var="i" begin="1" end="${totalPg}" step="3">
								<c:if test="${i>(paginationNum-1)*3 && (i+2)<=paginationNum*3}">
									<li class="page-item <c:if test="${pg eq i}">active</c:if>"><a
										class="page-link" href="/page/bestBoard?board_type=${board}&pg=${i}">${i}</a></li>
									<c:if test="${(i+1)<=totalPg}">
										<li
											class="page-item <c:if test="${pg eq (i+1)}">active</c:if>"><a
											class="page-link" href="/page/bestBoard?board_type=${board}&pg=${i+1}">${i+1}</a></li>
									</c:if>
									<c:if test="${(i+2)<=totalPg}">
										<li
											class="page-item <c:if test="${pg eq (i+2)}">active</c:if>"><a
											class="page-link" href="/page/bestBoard?board_type=${board}&pg=${i+2}">${i+2}</a></li>
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
									href="/page/bestBoard?board_type=${board}&pg=${paginationNext}">Next</a></li>
							</c:if>
						</ul>

					</div>

					<br> <br>

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






