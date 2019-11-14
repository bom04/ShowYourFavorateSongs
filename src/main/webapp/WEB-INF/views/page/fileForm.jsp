<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>File Form Page</title>
</head>
<body>
<h1>File Form Page</h1>
<hr>
<!-- 파일 업로드를 위해서는 form에 속성을 enctype="multipart/form-data" 라고 부여해야지만 가능하다.  -->
<form method="post" enctype="multipart/form-data">
    파일 : <input type="file" name="file2"><br/>
    <input type="submit" value="File Upload">
</form>
</body>
</html>

