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


<body>
	<div id="wrap">
		<header id="header">
			<%@ include file="/WEB-INF/include/top.jsp"%>
			<%@ include file="/WEB-INF/include/top2_board.jsp"%>
		</header>
		<section>
			<div id="content">

				<div
					style="text-align: center; padding-top: 200px; padding-bottom: 20px;">
					<c:if test="${kara_type eq 0}"><h1 style="font-size: 23pt">금영</hi></c:if>
					<c:if test="${kara_type eq 1}"><h1 style="font-size: 23pt">태진</hi></c:if>
					<br>
					<h1 style="font-size: 23pt">인기차트</h1>
				</div>

				<hr
					style="margin-bottom: -2px; border: 0; height: 1px; background: #E6E6E6; clear: both;">

				<br>
				<br>
				
				<div style="text-align:center;">	
					<c:if test="${kara_type eq 0}">
						<button type="button" class="btn btn-primary btn"
							style="width: 300px; border: 1px solid black">금영</button>
						<button type="button" class="btn btn-default btn"
							style="margin-left: 30px; width: 300px; border: 1px solid black" onclick="location.href='/page/chartBoard?kara_type=1'">태진</button>
					</c:if>
					<c:if test="${kara_type eq 1}">
						<button type="button" class="btn btn-default btn"
							style="width: 300px; border: 1px solid black" onclick="location.href='/page/chartBoard?kara_type=0'" >금영</button>
						<button type="button" class="btn btn-primary btn"
							style="margin-left: 30px; width: 300px; border: 1px solid black">태진</button>
					</c:if>
				</div>
				
				<div class="container" style="margin-bottom: 200px;">
					
					<div class="jumbotron"
						style="margin-top: 50px; background: #FAFAFA;">
						
						<div style="text-align:center">담긴 수가 같으면 이름 순으로 정렬됩니다.</div>
						<br>
						<table class="table table-hover"
							style="background: #FAFAFA; color: #2E2E2E;">
							<thead>
								<tr data-add-list>
									<th style="font-weight: bold; font-size: 12pt;">순위</th>
									<th style="font-weight: bold; font-size: 12pt;">곡번호</th>
									<th colspan=2 style="font-weight: bold; font-size: 12pt;">곡명</th>
									<th colspan=2 style="font-weight: bold; font-size: 12pt;">가수</th>
									<th style="font-weight: bold; font-size: 12pt;">담긴 수</th>
								</tr>
							</thead>

							<tbody>
								<c:forEach var="song" items="${rank}" varStatus="status">
									<c:set var="num" value="${status.index+1}"/>
									<tr style="cursor: pointer" <c:if test="${user.manager ne 'true'}"> song-add-chart="${kara_type} ${song.song_id}" </c:if>>
										<td><c:out value="${num}"/></td>
										<td>${song.song_num}</td>
										<td colspan=2>${song.title}</td>
										<td colspan=2>${song.singer}</td>
										<td>${song.likenum}</td>
									</tr>
								</c:forEach>
							</tbody>

						</table>
						
					</div>
				</div>

			</div>

		</section>

		<!--푸터-->
		<%@ include file="/WEB-INF/include/footer.jsp"%>

	</div>
</body>