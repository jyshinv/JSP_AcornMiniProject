<%@page import="java.io.File"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//Tomcat 서버를 실행했을 때 WebContent/upload 폴더의 실제 경로 얻어오기
	//아래 코드는 실제경로를 얻어오는 것! 
	//webContent에는 upload폴더가 실제로 있어야하고, 서버가 쓰는 경로는 realPath에 있는 upload폴더이고 파일도 여기로 업로드된다.)
	String realPath=application.getRealPath("/upload");
	//콘솔에 realPath 출력해보기 
	System.out.println("realPath:"+realPath);
	
	//해당 경로를 access 할 수 있는 파일 객체 생성
	File f=new File(realPath);
	if(!f.exists()){ //만일 폴더가 존재 하지 않으면
		f.mkdir();  //upload폴더 만들기 
	}
	
	//최대 업로드 사이즈 설정
	int sizeLimit=1024*1024*50; //50MByte
	/*
		WEB-INF/lib/cos.jar 라이브러리가 있으면 아래의 객체를 생성할 수 있다.
		
		new MultipartRequest(HttpServletRequest 객체,
				업로드 된 파일을 저장할 절대 경로,
				최대 업로드 사이즈 제한,
				인코딩 설정,
				DefaultFileRenamePolicy 객체);
	
		MultipartRequest 객체가 성공적으로 생성이 된다면 업로드된 파일에 대한 정보도
		추출할 수 있다. 
	*/
	//<form enctype="multipart/form-data"> 로 전송된 값은 아래의 객체(mr)를 이용해서 추출한다. 
	MultipartRequest mr=new MultipartRequest(request,
			realPath,
			sizeLimit,
			"utf-8",
			new DefaultFileRenamePolicy());
	
	//업로드 된 이미지 파일의 저장 경로만 json으로 응답하면 된다.
	String saveFileName=mr.getFilesystemName("image");
	String imagePath="/upload/"+saveFileName;
%>
{"imagePath":"<%=imagePath %>"}