<%@page import="java.io.File"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. GET 방식 전달되는 삭제할 파일 번호를 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	//2. DB에서 해당 파일의 정보를 읽어온다.
	FileDto dto=FileDao.getInstance().getData(num);
	
	//만일 로그인 된 아이디와 글 작성자가 다르면 에러를 응답한다.
	//이 처리를 해주지 않으면 로그인 한 상태로 다른 사람이 업로드한 파일을 주소창을 통해 delete.jsp?num=~ 으로
	//삭제가 가능하게 된다. 
	String id=(String)session.getAttribute("id"); //로그인 된 아이디
	if(!dto.getWriter().equals(id)){
		//SC_FORBIDDEN = 403 이다. 
		response.sendError(HttpServletResponse.SC_FORBIDDEN, "상대방의 파일을 지울 수 없습니다.");
		return; //메소드 종료 
	}
	
	
	//3. DB에서 파일 정보를 삭제한다.
	FileDao.getInstance().delete(num);
	//4. 파일시스템(upload 폴더)에 저장된 파일을 삭제한다.
	//삭제할 파일의 절대 경로
	/*
		Linux는 파일 경로 구분자가 슬래시(/) 이고
		Window는 파일 경로 구분자가 역슬래시(\) 이다.
		File.separator로 운영체제에 맞게끔 알맞은 파일 구분자를 얻어낼 수 있다.
		따라서 Linux와 Window 운영체제 모두 사용하려면 File객체의 separator을 사용해야한다. 
	*/
	String path=application.getRealPath("/upload")+
		File.separator+dto.getSaveFileName();
	//삭제할 파일을 access 할 수 있는 File객체 생성
	File file=new File(path);
	if(file.exists()){
		file.delete();
	}
	//5. 응답한다.(리다일렉트)
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/file/list.jsp");
%>
