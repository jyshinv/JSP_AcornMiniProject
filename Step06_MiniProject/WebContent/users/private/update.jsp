<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 수정할 회원 정보를 읽어와서
	String id=(String)session.getAttribute("id"); //session scope
	String email=request.getParameter("email");  //form전송
	UsersDto dto=new UsersDto();
	dto.setId(id);
	dto.setEmail(email);
	//2. DB에 수정 반영하고
	boolean isSuccess=UsersDao.getInstance().update(dto);
	//3. 응답한다.
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정</title>
</head>
<body>
<script>
	<%if(isSuccess){%>
		alert("수정 했습니다.");
		location.href="info.jsp";
	<%}else{%>
		alert("수정 실패");
		location.href="update_form.jsp"
	<%}%>
</script>
</body>
</html>