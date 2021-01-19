<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 로그인 아이디를 읽어온다.
	String id=(String)session.getAttribute("id");
	//2. 해당 아이디를 이용해서 DB에서 삭제한다.
	UsersDao.getInstance().delete(id);
	//3. 로그아웃 처리를 하고 응답한다. (DB에서 지워도 session scope에는 정보가 남아있음!)
	session.removeAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/delete.jsp</title>
</head>
<body>
	<div class="container">
		<h1>알림</h1>
		<p>
			<strong><%=id %></strong>님 탈퇴 처리 되었습니다.
			<a href="${pageContext.request.contextPath }/">인덱스로 가기</a>	
			
		</p>
	</div>
</body>
</html>