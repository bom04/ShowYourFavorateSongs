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
			<div id="content">
				<c:if test="${selectBoard ne 5}">
					<%@ include file="/WEB-INF/include/communityList.jsp"%>
				</c:if>
				<div class="container">
					<c:set var="theString" value="${post.user.nickname}" />
					<div class="jumbotron" style="margin-top: 10px;">
						<c:if test="${selectBoard ne 5}">
							<h4 style="padding-left: 5px;">${post.board.board_name}</h4>
						</c:if>
						<c:if test="${selectBoard eq 5}">
							<br>
							<br>
							<br>
							<br>
							<h4 style="padding-left: 5px;">공지사항</h4>
						</c:if>
						<br>
						<h1 class="display-5">${post.title}</h1>
						<br>
						<!--글 헤더-->
						<div>
							<p class="lead-2">
								<c:if test="${fn:contains(theString,'관리자')}">${post.user.nickname}</c:if>
								<c:if test="${fn:indexOf(theString,'관리자')==-1}">
									<a
										href="/page/user?user_idx=${post.user.user_idx}&kara_type=0&sort=0"
										style="text-decoration: none; font-weight: bold; color: grey">${post.user.nickname}</a>
								</c:if>
								</a>
							</p>
							<p class="lead" style="margin-right: 10px; float: right;">
								<img
									src="${pageContext.request.contextPath}/res/images/view.png" />&nbsp;${post.view}
							</p>
							<p class="lead" style="margin-right: 20px; float: right;">
								<img
									src="${pageContext.request.contextPath}/res/images/date.png" />&nbsp;${post.date}
							</p>
						</div>

						<hr class="my-4" style="clear: both">

						<!--내용-->
						<div class="lead-3" style="width: 100%">
							<p>${post.content}</p>
							<!--<p>본문 내용</p>-->
							<br> <br>
							<!--파일-->

							<c:forEach var="file" items="${files}">
								<p style="text-align: center;">
									<img
										src="${pageContext.request.contextPath}/upload/${file.file_name}"
										style="width: 700px;">
								</p>
							</c:forEach>
							<br> <br>
						</div>

						<!--추천-->
						<div class="lead" style="text-align: center; margin-bottom: 80px;">
							<c:choose>
								<c:when test="${empty user }">
									<a class="btn btn-default" href="/page/login" role="button"
										style="border: 1px solid grey"><img
										src="${pageContext.request.contextPath}/res/images/likey.png">&nbsp;추천</a>
								</c:when>
								<c:otherwise>

									<c:choose>
										<c:when test="${isLiked eq null}">
											<a class="btn btn-default"
												href="/page/post/${post.post_id}/post_like" role="button"
												style="border: 1px solid grey"><img
												src="${pageContext.request.contextPath}/res/images/likey.png">&nbsp;추천</a>
										</c:when>
										<c:otherwise>
											<a class="btn btn-primary"
												href="/page/post/${post.post_id}/post_like" role="button"><img
												src="${pageContext.request.contextPath}/res/images/likey.png">&nbsp;추천</a>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							<div class="btn"
								style="border: 1px solid grey; background: white; color: grey">&nbsp;${like_num}</div>
						</div>

						<c:choose>
							<c:when test="${post.user.user_idx eq user.user_idx }">
								<!-- 자기가 쓴 글일 때-->
								<button type="button" class="btn btn-primary btn3"
									style="float: right; margin-right: 10px;"
									onclick="location.href='/page/postDelete?post_id=${post.post_id}'">삭제</button>

								<button type="button" class="btn btn-primary btn3"
									style="float: right; margin-right: 10px;"
									onclick="location.href='/page/postModify?post_id=${post.post_id}'">수정</button>

							</c:when>
							<c:when test="${user.manager eq 'true' }">
								<!-- 관리자일 때 -->
								<button type="button" class="btn btn-primary btn3"
									style="float: right; margin-right: 10px;"
									onclick="location.href='/page/postDelete?post_id=${post.post_id}'">삭제</button>

							</c:when>
						</c:choose>
						<br> <br>
						<hr class="my-4" style="clear: both;">
						<!--댓글-->
						<p class="lead-2" style="">댓글</p>
						<hr class="my-4" style="clear: both; margin-bottom: -100px">

						<!--댓글 목록-->
						<div>
							<ul class="reply_ul">
								<c:forEach var="comments" items="${comments}" varStatus="status">
									<c:set var="theString2" value="${comments.user.nickname}" />
									<li style="margin-top: 10px; padding-bottom: -20px;">
										<div>
											<p class="user_id">
												<c:if test="${comments.is_delete==0}">
													<c:if test="${fn:contains(theString2,'관리자')}">${comments.user.nickname}</c:if>
													<c:if test="${fn:indexOf(theString2,'관리자')==-1}">
														<a
															href="/page/user?user_idx=${comments.user.user_idx}&kara_type=0&sort=0"
															style="text-decoration: none; font-weight: bold; color: grey">${comments.user.nickname}</a>
													</c:if>
													<span>${comments.date}</span>
													<!--댓글 삭제-->
													<c:choose>
														<c:when
															test="${comments.user.user_idx eq user.user_idx || user.manager eq 'true'}">
															<span style="float: right;"><a
																href="/page/post/${post.post_id}/comment/${comments.comment_id}/delete"
																style="font-weight: 200">삭제</a></span>
														</c:when>
													</c:choose>
												</c:if>
											</p>

											<!--댓글내용-->
											<c:if test="${comments.is_delete==0}">
												<div class="reply_text">${comments.content}</div>
											</c:if>
											<c:if test="${comments.is_delete==1}">
												<div class="reply_text"
													style="color: #BDBDBD; margin-top: -10px; font-size: 14pt;">${comments.content}</div>
											</c:if>

											<!--코멘트 좋아요-->
											<div>
												<c:if test="${comments.is_delete==0}">
													<c:choose>
														<c:when test="${empty user }">
															<button type="button" class="btn btn-primary btn5"
																style="border: 1px solid #BDBDBD; background: #fff; color: #BDBDBD; float: right;"
																onclick="location.href='/page/login'">
																<img
																	src=${pageContext.request.contextPath}/res/images/likey.png>
																<c:choose>
																	<c:when
																		test="${comment_like.containsKey(comments.comment_id) eq true}">
																		추천 ${comment_like.get(comments.comment_id)}
																</c:when>
																	<c:otherwise>추천 0</c:otherwise>
																</c:choose>
															</button>
														</c:when>
														<c:otherwise>
															<form
																action="/page/post/${post.post_id}/comment/${comments.comment_id}/like">
																<c:choose>
																	<c:when
																		test="${cl_user.get(comments.comment_id).contains(user.user_idx) eq true}">
																		<button type="submit" class="btn btn-primary btn5"
																			style="border: 1px solid #BDBDBD; background: #black; color: #BDBDBD; float: right;"
																			location.href='#'">
																	</c:when>
																	<c:otherwise>
																		<button type="submit" class="btn btn-primary btn5"
																			style="border: 1px solid #BDBDBD; background: #fff; color: #BDBDBD; float: right;"
																			location.href='#'">
																	</c:otherwise>
																</c:choose>
																<img
																	src=${pageContext.request.contextPath}/res/images/likey.png>
																<c:choose>
																	<c:when
																		test="${comment_like.containsKey(comments.comment_id) eq true}">
																			추천 ${comment_like.get(comments.comment_id)}
																	</c:when>
																	<c:otherwise>추천 0</c:otherwise>
																</c:choose>
																</button>
															</form>
														</c:otherwise>
													</c:choose>

													<!--변수증가필요-->
													<c:set var="num" value="${status.index}" />
													<span
														style="float: right; font-size: 10pt; margin-right: 30px; margin-top: 10px;"><a
														href="javascript:void(0);" data-rereply="${num}"
														style="font-weight: 200;">답글달기</a></span>
												</c:if>
											</div>
										</div> <br> <br> <br> <br> <br> <!--대댓글 목록-->
										<div style="color: grey">
											<ul class="reply_ul">
												<c:forEach var="replies" items="${comments.replies}"
													varStatus="status">
													<c:set var="theString3" value="${replies.user.nickname}" />
													<hr
														style="clear: both; background: #E6E6E6; border: 0; height: 2px;">

													<li style="background: #F2F2F2; margin-top: -15px;">
														<div>
															<p class="user_id">
																<c:if test="${fn:contains(theString3,'관리자')}">${replies.user.nickname}</c:if>
																<c:if test="${fn:indexOf(theString3,'관리자')==-1}">
																	<a
																		href="/page/user?user_idx=${replies.user.user_idx}&kara_type=0&sort=0"
																		style="text-decoration: none; font-weight: bold; color: grey">${replies.user.nickname}</a>
																</c:if>
																<span>${replies.date}</span>
																<!--대댓글 삭제-->
																<c:choose>
																	<c:when
																		test="${replies.user.user_idx eq user.user_idx || user.manager eq 'true'}">
																		<span style="float: right;"><a
																			href="/page/post/${post.post_id}/comment/${comments.comment_id}/${replies.reply_id}/delete"
																			style="font-weight: 200">삭제</a></span>
																	</c:when>
																</c:choose>
															</p>
															<div class="reply_text">${replies.content}</div>

														</div>
													</li>
												</c:forEach>
											</ul>
										</div> <!--대댓글작성-->
										<div data-txar style="display: none;">
											<div class="">
												<div class="bottom_txar">
													<c:choose>
														<c:when test="${empty user }">
															<textarea name="content" cols="30" rows="10" class="txar"
																placeholder=""></textarea>
															<button type="submit" class="btn btn-primary"
																style="float: right; margin-right: 10px;"
																onclick="location.href='/page/login'">등록</button>
														</c:when>
														<c:otherwise>
															<form
																action="/page/post/${post.post_id}/comment/${comments.comment_id}/reply">
																<textarea name="content" cols="30" rows="10"
																	class="txar" placeholder=""></textarea>

																<button type="submit" class="btn btn-primary"
																	style="float: right; margin-right: 10px;">등록</button>
															</form>
														</c:otherwise>
													</c:choose>
												</div>

											</div>
										</div>
									</li>

								</c:forEach>
							</ul>
						</div>



						<!--댓글 입력 폼-->
						<div class="txar_wrap">
							<div class="bottom_txar">
								<c:choose>
									<c:when test="${empty user }">
										<textarea name="content" cols="30" rows="10" class="txar"
											placeholder=""></textarea>

										<button type="submit" value="" class="btn btn-primary"
											style="float: left; width: 100%"
											onclick="location.href='/page/login'">등록</button>
									</c:when>
									<c:otherwise>
										<form action="/page/post/${post.post_id}/comment">
											<textarea name="content" cols="30" rows="10" class="txar"
												placeholder=""></textarea>

											<button type="submit" value="" class="btn btn-primary"
												style="float: left; width: 100%">등록</button>
										</form>
									</c:otherwise>
								</c:choose>
							</div>
						</div>


					</div>
				</div>
		</section>

		<!--푸터-->
		<%@ include file="/WEB-INF/include/footer.jsp"%>

	</div>
</body>