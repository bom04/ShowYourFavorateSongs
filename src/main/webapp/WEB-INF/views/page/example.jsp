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
<c:catch>
    <c:choose>
        <c:when test="${empty user }">
            <li>
                 <a href=""><i class="fa fa-sign-in"></i> 로그인</a>
             </li>
             <li>
                 <a href=""><i class="fa fa-user"></i> 회원가입</a>
             </li>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${user.user_idx eq '45' }">
                    <li>
                       <p>관리자 ${user.nickname}님, 환영합니다.</p>
                   </li>
                   <li>
                       <a href="/logout"><i class="fa fa-sign-out"></i> 로그아웃</a>
                   </li>
                </c:when>
                <c:otherwise>
                    <li>
                       <p>일반회원 ${user.nickname}님, 반갑습니다!</p>
                   </li>
                   <li>
                       <a href=""><i class="fa fa-sign-out"></i> 로그아웃</a>
                   </li>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>
</c:catch>

</body>
</html>