<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//이 코드는 선생님의 코드를 복붙해왔습니다~ 2021 JAVA ANDROID 과정 수업진행을 참고해주세요
	//java.lang.IllegalStateException: 이 응답을 위해 getOutputStream()이 이미 호출되었습니다.
	//이 오류 나지만 신경쓰지 말기 
	//1. GET방식 파라미터로 전달되는 다운로드 시켜 줄 파일의 번호를 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	/*
		2. DB에서 다운로드 시켜줄 파일의 정보를 읽어온다.
		어떤 파일명으로 upload 폴더에 저장되어 있는지 => saveFileName
		업로드 당시 원본 파일명은 무엇인지 => orgFileName
		파일의 사이는 어떻게 되는지 => fileSize
		-다운로드 시켜주기 위해서는 위의 3가지 정보가 필요하다.
	*/
	FileDto dto=FileDao.getInstance().getData(num);
	//3. 서버의 파일시스템(upload) 에 저장된 파일에서 바이트 알갱이를 읽어서 출력한다.(다운로드)
	String orgFileName=dto.getOrgFileName();
	String saveFileName=dto.getSaveFileName();
	//다운로드 시켜줄 파일의 실제 경로 구성하기 
	String path=request.getServletContext().getRealPath("/upload")+
					File.separator+saveFileName;
	//다운로드할 파일에서 읽어들일 스트림 객체 생성하기
	FileInputStream fis=new FileInputStream(path);
	//다운로드 시켜주는 작업을 한다. (실제 파일 데이터와 원본파일명을 보내줘야한다.)
	//다운로드 시켜주는 작업을 한다. 
	String encodedName=null;
	System.out.println(request.getHeader("User-Agent"));
	//한글 파일명 세부처리 
	if(request.getHeader("User-Agent").contains("Firefox")){
		//벤더사가 파이어 폭스인경우 
		encodedName=new String
			(orgFileName.getBytes("utf-8"),"ISO-8859-1");
	}else{ //그외 다른 벤더사 
		encodedName=URLEncoder.encode(orgFileName, "utf-8");
		//파일명에 공백이있는 경우 처리 
		encodedName=encodedName.replaceAll("\\+"," ");
	}
	
	//응답 헤더 정보 설정
	response.setHeader("Content-Disposition","attachment;filename="+encodedName);
	response.setHeader("Content-Transfer-Encoding", "binary");
	
	//다운로드할 파일의 크기 읽어와서 다운로드할 파일의 크기 설정
	response.setContentLengthLong(dto.getFileSize());
	
	//클라이언트에게 출력할수 있는 스트림 객체 얻어오기
	BufferedOutputStream bos=
		new BufferedOutputStream(response.getOutputStream());
	//한번에 최대 1M byte 씩 읽어올수 있는 버퍼
	byte[] buffer=new byte[1024*1024];
	int readedByte=0;
	//반복문 돌면서 출력해주기
	while(true){
		//byte[] 객체를 이용해서 파일에서 byte 알갱이 읽어오기
		readedByte = fis.read(buffer);
		if(readedByte == -1)break; //더이상 읽을 데이터가 없다면 반복문 빠져 나오기
		//읽은 만큼 출력하기
		bos.write(buffer, 0, readedByte);
		bos.flush(); //출력
	}
	//FileInputStream 닫아주기 
	fis.close();	

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 다운로드</title>
</head>
<body>

</body>
</html>