<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	/*프로필 이미지를 작은 원형으로 만든다.*/
	#profileImage{
		width : 100px;
		height : 100px;
		border : 1px solid #cecece;
		border-radius : 50%;
		margin-bottom : 10px
	}
	/*프로필 업로드 폼을 화면에 안보이게 숨긴다.*/
	#profileForm{
		display : none;
	}
</style>
</head>
<body>
<%
	//세션 영역에 저장된 아이디를 이용해서
	String id=(String)session.getAttribute("id");
	//DB에 저장된 가입정보를 읽어온다.
	UsersDto dto=UsersDao.getInstance().getData(id);
%>
<div class="container">
	<h1>가입정보 수정 폼 입니다.</h1>
	<a id="profileLink" href="javascript:">
		<%if(dto.getProfile()==null){ %>
			<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
	  			<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10z"/>
			</svg>
		<%}else{ %>
			<img src="${pageContext.request.contextPath }<%=dto.getProfile() %>" id="profileImage"/>	
		<%} %>
	</a>
	<form action="update.jsp" method="post">
		<div>
			<label for="id">아이디</label>
			<%--기본값은 dto.getId로, disabled속성으로 수정하지 못하게 막는다.  --%>
			<input type="text" id="id" value="<%=dto.getId() %>" disabled/>
		</div>
		<div>
			<label for="email">이메일</label>
			<%--기본값은 dto.getEmail로  --%>
			<input type="text" id="email" name="email" value="<%=dto.getEmail() %>" />
		</div>
		<button type="submit">수정확인</button>
		<button type="reset">취소</button>
	</form>
	<form action="profile_upload.jsp" method="post" enctype="multipart/form-data" id="profileForm">
		<label for="image">프로필 이미지 선택</label>
		<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG" />
		<button type="submit">업로드</button>
	</form>
</div>
<script>
	//프로필 링크를 클릭했을 때 실행할 함수 등록 (포커스 준 후 enter눌러도 이동한다.)
	$("#profileLink").on("click",function(){
		//아이디가 image인 요소를 강제 클릭하기
		$("#image").click();
	});
	//이미지를 선택했을 때 실행할 함수 등록
	$("#image").on("change",function(){
		//폼을 강제 제출해서 선택된 이미지가 업로드 되도록 한다.
		$("#profileForm").submit();
	});
</script>
</body>
</html>