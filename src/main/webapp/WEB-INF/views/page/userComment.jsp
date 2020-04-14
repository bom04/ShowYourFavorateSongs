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
			<div id="content">
				<div style="text-align: center; padding-top: 150px;">

					<!--게시판 내비게이션-->
					<ul class="nav nav-tabs">
						<li class="nav-item">
							<a class="nav-link" href="/page/userPost?user_idx=${pagewowner.user_idx}">포스트</a>
						</li>
						<li class="nav-item">
							<a class="nav-link active" href="/page/userComment?user_idx=${pagewowner.user_idx}">댓글</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/page/recommendedPost?user_idx=${pagewowner.user_idx}">좋아요</a>
						</li>
					</ul>
				</div>

				<div style="text-align: center; padding-top: 100px; padding-bottom: 20px;">
					<c:if test="${log_in.user_idx==pagewowner.user_idx}">
						<h1 style="font-size: 23pt">내가 쓴 댓글</h1>
					</c:if>
					<c:if test="${log_in.user_idx!=pagewowner.user_idx}">
						<h1 style="font-size: 23pt">${pagewowner.nickname}님의 댓글 목록</h1>
					</c:if>	
				</div>

				<hr style="margin-bottom: -2px;border: 0;height: 1px; background: #E6E6E6; clear: both;">

				<!--게시글 목록 테이블-->
				<div class="container">
					<table class="table" style="color: grey; text-decoration: none;">
						<thead>
							<tr>
								<th>번호</th>
								<th>게시글</th>
								<th>작성일</th>
								<th>댓글 추천</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="comment" items="${user_comment}" varStatus="status">
								<c:if test="${comment.is_delete==0}">

								<c:set var="commentNum" value="0" />
								<c:set var="replyNum" value="0" />
								<c:forEach var="comm" items="${comment.post.comments}">
									<c:if test="${comm.is_delete eq 0}">
										<c:set var="commentNum" value="${commentNum + 1}" />
									</c:if>

									<c:set var="replyNum" value="${fn:length(comm.replies)+replyNum}" />
								</c:forEach>
								<c:set var="commentAndReplyNum" value="${commentNum+replyNum}" />
								
									<tr>
										<tr>
										<c:set var="num" value="${fn:length(user_comment)-status.index}" />
											<td rowspan=2 style="text-align:center; padding-top: 60px; border-right:1px solid #E6E6E6"><c:out value="${num}"/></td>
											<td style="width:">
												<a href="post/${comment.post.post_id}" style="text-decoration: none; font-weight: bold; color: grey">${comment.post.title}</a>
											</td>
											<td rowspan=2 style="text-align:center; padding-top: 60px;"><fmt:formatDate value="${comment.date}" pattern="yy/MM/dd HH:mm"/></td>
											<td rowspan=2 style="text-align:center; padding-top: 60px;">
											<c:choose>
												<c:when test="${likes.containsKey(comment.comment_id) eq true}">
													${likes.get(comment.comment_id)}
												</c:when>
												<c:otherwise>0</c:otherwise>
											</c:choose>
											</td>
										</tr>
										<tr>
											<td rowspan=2 style="text-align:center; background:#FAFAFA">
												re: ${comment.content}
											</td>
										</tr>
		
									</tr>
								</c:if>
								
							</c:forEach>
						</tbody>
					</table>
					
					<br><br>

					<br>
					<br>
					<br>
					<br>

				</div>
			</div>

		</section>
		<!--푸터-->
		<%@ include file="/WEB-INF/include/footer.jsp"%>

	</div>
</body>

<!---->