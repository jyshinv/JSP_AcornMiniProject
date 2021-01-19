<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//session scope에 "id"라는 키값으로 저장된 문자열이 있는지 읽어와 본다.
	//null이면 로그인을 하지 않은 것이고, null이 아니라면 로그인을 한것이다.
	String id=(String)session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/index.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>
	<%--만일 id가 null이 아니면 로그인을 한 상태이다. --%>
	<%if(id != null){ %>
		<p>
		<%--id를 누르면 개인정보창으로 가게끔 만든다. --%>
		<a href="${pageContext.request.contextPath }/users/private/info.jsp"><%=id %></a> 님 로그인중...
		<%--
			logout을 클릭한 후 index.jsp페이지에서 
			주소창에 http://localhost:8888/Step06_Final/users/private/info.jsp
			라고 쳐보면 로그인 필터의 sendRedirect() 메소드의 인자로 전달한
			res.sendRedirect(cPath+"/users/login_form.jsp");
			즉, /users/login_form.jsp로 이동한다.  
		 --%>
		<a href="${pageContext.request.contextPath }/users/logout.jsp">로그아웃</a>
		</p>
	<%} %>
	<ul class="list-group list-group-flush">
		<li class="list-group-item"><a href="${pageContext.request.contextPath }/users/signup_form.jsp">회원가입</a></li>
		<li class="list-group-item"><a href="${pageContext.request.contextPath }/users/login_form.jsp">로그인</a></li>
		<li class="list-group-item"><a href="${pageContext.request.contextPath }/cafe/list.jsp">게시판</a></li>
		<li class="list-group-item"><a href="${pageContext.request.contextPath }/file/list.jsp">파일저장소</a></li>
	</ul>
</body>
</html>