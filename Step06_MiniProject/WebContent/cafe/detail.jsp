<%@page import="test.cafe.dao.CafeDao"%>
<%@page import="test.cafe.dto.CafeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. GET방식 파라미터로 전달되는 자세히 보여줄 글 번호를 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	//2. 글 번호를 이용해서 DB에서 글 정보를 읽어온다.
	CafeDto dto=CafeDao.getInstance().getData(num);
	//3. 글 조회수를 올린다. detail이 요청될때마다 글조회수가 올라간다고 생각하기
	CafeDao.getInstance().addViewCount(num);
	//4. 응답한다. 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<%--include는 반드시 상대경로로 --%>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="cafe" name="thisPage"></jsp:param>
</jsp:include>
<div class="container">
	<%--depth를 줄 수 있다. --%>
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/">Home</a>
			</li>
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/cafe/list.jsp">게시판</a>
			</li>
			<li class="breadcrumb-item active">상세보기</li>
		</ul>
	</nav>
	<table class="table table-bordered">
		<tr>
			<th>글 번호</th>
			<td><%=dto.getNum()%></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=dto.getWriter() %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=dto.getTitle() %></td>
		</tr>
		<tr>
			<th>조회수 </th>
			<td><%=dto.getViewCount() %></td>
		</tr>
		<tr>
			<th>등록일</th>
			<td><%=dto.getRegdate() %></td>
		</tr>
		<tr>
			<td colspan="2">
				<div><%=dto.getContent() %></div>
			</td>
		</tr>
	</table>
	<%
		//session scope에서 로그인된 아이디를 읽어와본다. (null일수도 있음)
		String id=(String)session.getAttribute("id");
	%>
	<ul>
		<li><a href="list.jsp">목록보기</a></li>
		<%--로그인 해야지만 수정, 삭제가 가능하게끔~ --%>
		<%--session에 있는 id와  글작성자가 같을 때 수정, 삭제가 가능하다. --%>
		<%--id.equals(dto.getWriter())로 하게될경우 id가 null이면
		 nullpointexception으로 500번 버스를 탈 수 있다.--%>
		<%if(dto.getWriter().equals(id)){ %>
			<li><a href="private/update_form.jsp?num=<%=dto.getNum()%>">수정</a></li>
			<li><a href="javascript:deleteConfirm()">삭제</a></li>		
		<%} %>
	</ul>
</div>
<script>
	function deleteConfirm(){
		let isDelete=confirm("글을 삭제하시겠습니까?");
		if(isDelete){
			location.href="private/delete.jsp?num=<%=dto.getNum()%>";
		}
	}
</script>
</body>
</html>