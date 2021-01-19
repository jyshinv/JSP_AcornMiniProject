<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 된 상태이기 때문에 글 작성자는 session scope에서 얻어낸다.
	String writer=(String)session.getAttribute("id");
	//1. 폼전송되는 글제목과 내용을 읽어와서
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	//2. DB에 저장하고
	CafeDto dto=new CafeDto();
	dto.setWriter(writer);
	dto.setTitle(title);
	dto.setContent(content);
	boolean isSuccess=CafeDao.getInstance().insert(dto);
	//3. 응답한다.
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새글 작성</title>
</head>
<body>
<script>
	<%if(isSuccess){ %>
		alert("새 글이 추가되었습니다.");
		location.href="${pageContext.request.contextPath }/cafe/list.jsp";
	<%}else{ %>
		alert("글 작성 실패!");
		location.href="insert_form.jsp";
	<%} %>
</script>
</body>
</html>