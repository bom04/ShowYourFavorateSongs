<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
 
<%
    String uploadPath = request.getRealPath("/upload");
     
    int maxSize =1024 *1024 *10;// 한번에 올릴 수 있는 파일 용량 : 10M로 제한
     
    String title ="";
    String content ="";
    
    String s = "";
  	String s2 = "";
    
     
    String filename ="";// 중복처리된 이름
    String originalName1 ="";// 중복 처리전 실제 원본 이름
    long fileSize =0;// 파일 사이즈
    String fileType ="";// 파일 타입
     
    MultipartRequest multi =null;
    System.out.println("request getContentType : " + request.getContentType());
    
     
    try{
        multi =new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
       
        //input name="..."의 value
        
        title = multi.getParameter("title");
        out.println("제목: "+title);
        
        content = multi.getParameter("content");
        out.println("내용: "+content);
        
        s = request.getParameter("user_idx");
  		int user_idx = Integer.parseInt(s);
  		out.println(user_idx);
  	
  		s2 = request.getParameter("board_id");
  		int board_id = Integer.parseInt(s2);
  		out.println(board_id);
         
        // 전송한 전체 파일이름들을 가져옴
        Enumeration files = multi.getFileNames();
         
        while(files.hasMoreElements()){
            String file1 = (String)files.nextElement();

            originalName1 = multi.getOriginalFileName(file1);
            filename = multi.getFilesystemName(file1);

            fileType = multi.getContentType(file1);
            File file = multi.getFile(file1);
            fileSize = file.length();
        }
    }catch(Exception e){
    	System.out.println("안돼");
        e.printStackTrace();
    }
%>
<!--
    해당 페이지는 사용자에게 보여줄 필요가 없고 해당 정보를 전달만 해주면 되기 때문에 hidden으로 했다.
 -->
<form method="post" name="fileCheckFormName">
	<input type="hidden" value="<%=title%>" name="title" />
    <input type="hidden" value="<%=content%>" name="content" />
    <input type="hidden" value="<%=filename%>" name="filename" />
    <input type="hidden" value="<%=originalName1%>" name="originalName1" />
</form>
 
<!--
    a태그로 클릭시 파일체크하는 jsp페이지로 이동하도록 함
    javascript를 이용해서 onclick시 폼태그를 잡아와 submit()을 호출해 폼태그를 전송
 -->
<p style="text-align: center;"><img src="${pageContext.request.contextPath}/upload/<%=filename %>" style="width: 700px;"></p>



