<%@page import="test.cafe.dto.CafeDto"%>
<%@page import="test.cafe.dao.CafeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. 폼 전송되는 수정할 글의 번호, 제목, 내용을 읽어와서 
	int num=Integer.parseInt(request.getParameter("num"));
	String title=request.getParameter("title");
	String content=request.getParameter("content");
	//2. DB에 수정 반영하고
	CafeDto dto=new CafeDto();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	boolean isSuccess=CafeDao.getInstance().update(dto);
	//3. 응답한다.
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
</head>
<body>
	<%if(isSuccess){ %>
		<script>
			alert("수정했습니다.");
			location.href="../detail.jsp?num=<%=num%>";
		</script>
	<%}else{ %>
		<h1>알림</h1>
		<p>
			글 수정 실패!
			<a href="update_form.jsp?num=<%=num%>">다시 시도</a>
		</p>
	<%} %>
</body>
</html>