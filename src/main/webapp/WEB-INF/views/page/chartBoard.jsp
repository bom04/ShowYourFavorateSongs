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
					<h1 style="font-size: 23pt">인기차트</h1>
				</div>

				<hr
					style="margin-bottom: -2px; border: 0; height: 1px; background: #E6E6E6; clear: both;">

				<div class="container" style="margin-bottom: 200px;">
					<div class="jumbotron"
						style="margin-top: 50px; background: #FAFAFA;">
						<table class="table table-hover"
							style="background: #FAFAFA; color: #2E2E2E;">
							<thead>
								<tr data-add-list>
									<th style="font-weight: bold; font-size: 12pt;">순위</th>
									<th style="font-weight: bold; font-size: 12pt;">태진</th>
									<th style="font-weight: bold; font-size: 12pt;">금영</th>
									<th style="font-weight: bold; font-size: 12pt;">곡명</th>
									<th style="font-weight: bold; font-size: 12pt;">가수</th>
								</tr>
							</thead>

							<tbody>
								<tr data-add-list style="cursor: pointer">
									<td>1</td>
									<td>31754</td>
									<td>46815</td>
									<td>링딩동</td>
									<td>샤이니</td>
								</tr>
								<tr data-add-list style="cursor: pointer">
									<td>2</td>
									<td>30459</td>
									<td>46493</td>
									<td>U R Man</td>
									<td>SS501</td>
								</tr>
								<tr data-add-list style="cursor: pointer">
									<td>3</td>
									<td>84145</td>
									<td>79942</td>
									<td>쏘리 쏘리</td>
									<td>슈퍼주니어</td>
								</tr>
								<tr data-add-list style="cursor: pointer">
									<td>4</td>
									<td>97112</td>
									<td>90844</td>
									<td>뿜뿜</td>
									<td>모모랜드</td>
								</tr>
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