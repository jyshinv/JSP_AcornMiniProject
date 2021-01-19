<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="test.gallery.dto.GalleryDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//폼 전송되는 imagePath와 caption을 추출해서 DB에 저장하고
	String imagePath=request.getParameter("imagePath");
	String caption=request.getParameter("caption");
	//업로드 아이디
	String id=(String)session.getAttribute("id");
	
	GalleryDto dto=new GalleryDto();
	dto.setImagePath(imagePath);
	dto.setCaption(caption);
	dto.setWriter(id);
	
	GalleryDao.getInstance().insert(dto);
	//목록보기로 리다이렉트 이동 
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/gallery/list.jsp");
%>
