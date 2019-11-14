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
<!-- <script src="${R}res/common.js"></script>-->
<link rel="stylesheet" href="${R}res/common.css">


<!-- jQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>


<body>
	<!--검색-->
	<div>
		<form action="/page/searchPost/1" class="form-inline my-2 my-lg-0">
			<select class="form-control" name="search_type">
				<option value="all">전체</option>
				<option value="title">제목</option>
				<option value="writer">작성자</option>
			</select> <input name="keyword" class="form-control mr-sm-2" type="text"
				placeholder="" style="margin-left: -3px">
			<button type="submit" class="btn btn-secondary my-2 my-sm-0"
				style="height: 45px; width: 100px; margin-left: -10px; padding-top: 10px;">찾기</button>
		</form>
	</div>

	<br>
	<br>
	<br>
	<br>
</body>
</html>