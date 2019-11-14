<%@ page pageEncoding="utf-8"%>
<meta charset="utf-8">
<title>너의 18번을 들려줘</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


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
				<c:if test="${selectBoard eq 5}">
					<br>
					<br>
				</c:if>
				<!--글 본문-->
				<div class="container">
					<div class="jumbotron" style="margin-top: 40px;">

						<form:form method="post" modelAttribute="post"
							enctype="multipart/form-data">
							<c:choose>
								<c:when
									test="${(user.manager eq 'false') &&(postModify ne 'yes') }">
									<!--셀렉트태그-->
									<select name="board_id" id="board_id" class="post_title_input" />
									<option value="1"
										<c:if test="${selectBoard == 1}">selected</c:if>>자유
										게시판</option>
									<option value="2"
										<c:if test="${selectBoard == 2}">selected</c:if>>전국
										노래 자랑</option>
									<option value="3"
										<c:if test="${selectBoard == 3}">selected</c:if>>노래
										추천</option>
									<option value="4"
										<c:if test="${selectBoard == 4}">selected</c:if>>팁
										게시판</option>
									</select>
									<br>
								</c:when>
								<c:when
									test="${(user.manager eq 'false') &&(postModify eq 'yes') }">
									<c:if test="${selectBoard == 1}"><p style = "font-size:1.7em;">자유
										게시판</p></c:if>
									<c:if test="${selectBoard == 2}"><p style = "font-size:1.7em;">전국 노래 자랑</p></c:if>
										<c:if test="${selectBoard == 3}"><p style = "font-size:1.7em;">노래 추천</p></c:if>
									<c:if test="${selectBoard == 4}"><p style = "font-size:1.7em;">팁 게시판</p></c:if>
									<br>
								</c:when>
								<c:when
									test="${(user.manager eq 'true') &&(postModify eq 'yes') }">
									<c:if test="${selectBoard == 1}"><p style = "font-size:1.7em;">자유
										게시판</p></c:if>
									<c:if test="${selectBoard == 2}"><p style = "font-size:1.7em;">전국 노래 자랑</p></c:if>
										<c:if test="${selectBoard == 3}"><p style = "font-size:1.7em;">노래 추천</p></c:if>
									<c:if test="${selectBoard == 4}"><p style = "font-size:1.7em;">팁 게시판</p></c:if>
									<c:if test="${selectBoard == 5}"><p style = "font-size:1.7em;">공지사항</p></c:if>
									
								</c:when>
								<c:otherwise>
									<!--셀렉트태그-->
									<select name="board_id" id="board_id" class="post_title_input" />
									<option value="1"
										<c:if test="${selectBoard == 1}">selected</c:if>>자유
										게시판</option>
									<option value="2"
										<c:if test="${selectBoard == 2}">selected</c:if>>전국
										노래 자랑</option>
									<option value="3"
										<c:if test="${selectBoard == 3}">selected</c:if>>노래
										추천</option>
									<option value="4"
										<c:if test="${selectBoard == 4}">selected</c:if>>팁
										게시판</option>
									<option value="5"
										<c:if test="${selectBoard == 5}">selected</c:if>>공지사항</option>
									</select>
									<br>
								</c:otherwise>
							</c:choose>
							<!--제목-->
							<div style="margin-top: 30px;">
								<input type="text" name="title" id="Title"
									class="post_title_input" placeholder="제목을 입력하세요"
									value="${post.title}" required />
							</div>

							<hr class="my-4" style="clear: both">

							<!--내용 작성-->
							<div>
								<textarea name="content" class="post_body_input"
									id="exampleTextarea" rows="15" placeholder="내용을 입력하세요" required>${post.content}</textarea>
							</div>

							<hr class="my-4" style="clear: both;">

							<div style="padding-left: 10px;">
								<label for="inputFile">파일 첨부</label> 
								<input type="file" name="filename" class="form-control-file" id="inputFile" aria-describedby="fileHelp" multiple>
							</div>
							
							<c:forEach var="file" items="${filelist}">
								${file.file_name}
								<span><a href="/page/delete?id=${file.file_id}" style="font-weight: 200">삭제</a></span>
							</c:forEach>

							<hr class="my-4" style="clear: both;">

							<div style="text-align: center; margin-top: 70px;">
								<button type="button" class="btn btn-primary btn2"
									style="width: 100px;" onclick="location.href='freeBoard?pg=1'">취소</button>
								<button type="submit" value="submit" class="btn btn-primary"
									style="width: 100px;">등록</button>
							</div>
						</form:form>
					</div>

				</div>
			</div>



		</section>

		<!--푸터-->
		<%@ include file="/WEB-INF/include/footer.jsp"%>

	</div>
</body>

<!---->