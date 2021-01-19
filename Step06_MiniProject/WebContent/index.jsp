<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/index.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>
	
	<ul class="list-group list-group-flush">
		<li class="list-group-item"><a href="${pageContext.request.contextPath }/users/signup_form.jsp">회원가입</a></li>
		<li class="list-group-item"><a href="${pageContext.request.contextPath }/users/login_form.jsp">로그인</a></li>
		<li class="list-group-item"><a href="${pageContext.request.contextPath }/cafe/list.jsp">게시판</a></li>
		<li class="list-group-item"><a href="${pageContext.request.contextPath }/file/list.jsp">자료실(파일)</a></li>
	</ul>
</body>
</html>