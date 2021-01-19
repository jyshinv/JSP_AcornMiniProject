<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="test.gallery.dao.GalleryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//자세히 보여줄 gallery item 번호를 읽어온다.
	int num=Integer.parseInt(request.getParameter("num"));
	//번호를 이용해서 갤러리 item 정보를 얻어온다. 
	GalleryDto dto=GalleryDao.getInstance().getData(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 자세히 보기</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="gallery" name="thisPage"/>
</jsp:include>
<div class="container">
	<!-- depth 주기 -->
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/">Home</a>
			</li>
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/gallery/list.jsp">갤러리 목록</a>
			</li>
			<li class="breadcrumb-item active">상세보기</li>
		</ul>
	</nav>
	<!-- card -->
	<div class="card text-center">
		<img class="card-img-top mt-3" src="${pageContext.request.contextPath }<%=dto.getImagePath() %>" />
		<div class="card-body">
			<p class="card-text"><%=dto.getCaption() %></p>
			<p class="card-text">by <strong><%=dto.getWriter() %></strong></p>
			<p><small><%=dto.getRegdate() %></small></p>
			
			<!-- 이전, 다음 버튼 -->
			<nav class="mt-5" aria-label="Page navigation example">
			  <ul class="pagination justify-content-center">
			    <li class="page-item">
					<%if(dto.getPrevNum() != 0){ %>
						<a class="page-link" href="detail.jsp?num=<%=dto.getPrevNum()%>" aria-label="Previous">
					        <span aria-hidden="true">&laquo;</span>
						</a>
					<%} %>	      
			    </li>
			    <li class="page-item">
					<%if(dto.getNextNum() != 0){ %>
						<a class="page-link" href="detail.jsp?num=<%=dto.getNextNum()%>" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
						</a>
					<%} %>
			    </li>
			  </ul>
			</nav>
		</div>
	</div>

</div>
</body>
</html>