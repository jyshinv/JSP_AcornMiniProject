<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//폼 전송되는 가입할 회원의 정보를 읽어온다.
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	String email=request.getParameter("email");
	
	//UsersDto 객체에 회원정보를 담고
	UsersDto dto=new UsersDto();
	dto.setId(id);
	dto.setPwd(pwd);
	dto.setEmail(email);
	//UsersDao 객체를 이용해서 DB에 저장한다.
	boolean isSuccess=UsersDao.getInstance().insert(dto);
	//결과를 응답하기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 결과</title>
</head>
<body>
<div class="container">
	<h1>알림</h1>
	<%if(isSuccess){ %>
		<p>
			<strong><%=id %></strong>회원님 가입 되셨습니다.
			<a href="login_form.jsp">로그인 하러가기</a>
		</p>
	<%}else{ %>
		<p>
			가입이 실패했습니다.
			<a href="signup_form.jsp">다시 가입</a>
		</p>
	<%} %>
</div>
</body>
</html>