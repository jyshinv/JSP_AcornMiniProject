<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그 아웃은 session scope에 저장된 id값을 삭제하면 된다.
	session.removeAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/logout.jsp</title>
</head>
<body>
<script>
	alert("로그아웃 되었습니다.");
	/*locagion.href="${pageContext.request.contextPath }/index.jsp"와
	locagion.href="${pageContext.request.contextPath }/"는
	모두 최상위경로 index.jsp를 요청한다!
	최상위경로는 어디에 명시되어있을까? 
	WEB-INF에 있는 web.xml의 welcome-file-list에 명시되어있다!!
	*/
	location.href="${pageContext.request.contextPath }/";//최상위경로 요청(index.jsp(welcome file list에 있는 최상위경로))
	
	
</script>
</body>
</html>