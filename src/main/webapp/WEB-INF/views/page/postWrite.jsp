<%@ page pageEncoding="utf-8"%>
<meta charset="utf-8">
<title>너의 18번을 들려줘</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

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
	
	<script type="text/javascript">
	$(document).ready(function() {
		$('.post_body_input').on('keyup', function() {

			if ($(this).val().length > 1000) {

				$(this).val($(this).val().substring(0, 1000));

			}

		});

	});
	function check() {
		if($('input[name=title]').val()=='') {
			alert('제목은 필수 요소입니다.');
			return false;
		}
		return true;	
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

						<form:form method="post" modelAttribute="post" onsubmit="return check()"
							enctype="multipart/form-data">
							<c:choose>
								<c:when
									test="${(user.manager eq 'false') &&(postModify ne 'yes') }">
									<!--셀렉트태그-->
									<select name="board_id" id="board_id" class="form-control" />
									<option value="1"
										<c:if test="${selectBoard == 1}">selected</c:if>>자유
										게시판</option>
									<option value="4"
										<c:if test="${selectBoard == 4}">selected</c:if>>팁
										게시판</option>
									<option value="3"
										<c:if test="${selectBoard == 3}">selected</c:if>>노래
										추천</option>
									<option value="2"
										<c:if test="${selectBoard == 2}">selected</c:if>>전국
										노래 자랑</option>
									</select>
									<br>
								</c:when>
								<c:when
									test="${(user.manager eq 'false') &&(postModify eq 'yes') }">
									<c:if test="${selectBoard == 1}">
										<p style="font-size: 1.7em;">자유 게시판</p>
									</c:if>
									<c:if test="${selectBoard == 2}">
										<p style="font-size: 1.7em;">전국 노래 자랑</p>
									</c:if>
									<c:if test="${selectBoard == 3}">
										<p style="font-size: 1.7em;">노래 추천</p>
									</c:if>
									<c:if test="${selectBoard == 4}">
										<p style="font-size: 1.7em;">팁 게시판</p>
									</c:if>
									<br>
								</c:when>
								<c:when
									test="${(user.manager eq 'true') &&(postModify eq 'yes') }">
									<c:if test="${selectBoard == 1}">
										<p style="font-size: 1.7em;">자유 게시판</p>
									</c:if>
									<c:if test="${selectBoard == 2}">
										<p style="font-size: 1.7em;">전국 노래 자랑</p>
									</c:if>
									<c:if test="${selectBoard == 3}">
										<p style="font-size: 1.7em;">노래 추천</p>
									</c:if>
									<c:if test="${selectBoard == 4}">
										<p style="font-size: 1.7em;">팁 게시판</p>
									</c:if>
									<c:if test="${selectBoard == 5}">
										<p style="font-size: 1.7em;">공지사항</p>
									</c:if>

								</c:when>
								<c:otherwise>
									<!--셀렉트태그-->
									<select name="board_id" id="board_id" class="form-control" />
									<option value="5"
										<c:if test="${selectBoard == 5}">selected</c:if>>공지사항</option>
									<option value="1"
										<c:if test="${selectBoard == 1}">selected</c:if>>자유
										게시판</option>
									<option value="4"
										<c:if test="${selectBoard == 4}">selected</c:if>>팁
										게시판</option>
									<option value="3"
										<c:if test="${selectBoard == 3}">selected</c:if>>노래
										추천</option>
									<option value="2"
										<c:if test="${selectBoard == 2}">selected</c:if>>전국
										노래 자랑</option>
									</select>
									<br>
								</c:otherwise>
							</c:choose>
							<!--제목-->
							<div style="margin-top: 30px;">
								<input type="text" maxlength="45" name="title" id="Title"
									class="post_title_input" placeholder="제목을 입력하세요"
									value="${post.title}" />
							</div>

							<hr class="my-4" style="clear: both">

							<!--내용 작성-->
							<div>
								<textarea name="content" class="post_body_input"
									id="exampleTextarea" rows="15" placeholder="내용을 입력하세요">${post.content}</textarea>
							</div>
							
							<hr class="my-4" style="clear: both;">
							<!--파일 첨부-->
							<div style="padding-left: 10px;">
								<label for="inputFile">파일 첨부</label>
								<input type="file" name="filename" class="form-control-file" aria-describedby="fileHelp" multiple>
							</div>
							
							<br>
							
							<c:if test="${filelist.size()>0}">
							<p>삭제파일 선택</p>
							<div style="padding-left:10px;padding:20px;border:1px solid #E6E6E6">							
							    <c:forEach var="file" items="${filelist}">
								    <div class="form-check">
									    <label class="form-check-label">
									    <input class="form-check-input" type="checkbox" name="check" id="${file.file_id}" value="${file.file_id}" style="padding-left:10px;">
									    	${file.file_name}
									    </label>
								    </div>
							    </c:forEach>
							</div>
							</c:if>
							
							
							<hr class="my-4" style="clear: both;">

							<div style="text-align: center; margin-top: 70px;">
								<button type="button" class="btn btn-primary btn2"
									style="width: 100px;" data-cancel>취소</button>
								<c:if test="${postModify eq 'yes'}"><button type="submit" value="submit" class="btn btn-primary"
									style="width: 100px;" post-modify>등록</button></c:if>
								<c:if test="${postModify ne 'yes'}"><button type="submit" value="submit" class="btn btn-primary"
									style="width: 100px;">등록</button></c:if>
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






