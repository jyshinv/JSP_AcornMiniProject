<%@page import="java.net.URLEncoder"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="java.util.List"%>
<%@page import="test.file.dao.FileDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한페이지에 몇개씩 게시물을 표시할 것인지
	final int PAGE_ROW_COUNT=5;
	//하단 페이지 이동UI를 최대 몇개씩 표시할 것인지에 대한 값 
	final int PAGE_DISPLAY_COUNT=5;
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어온다면
	if(strPageNum != null){
		//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		pageNum=Integer.parseInt(strPageNum);
	}
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	/*
		[검색 키워드에 관련된 처리]
		-검색 키워드가 파라미터로 넘어올 수도 있고 안넘어올 수도 있다.
		
		
	*/
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	//만일 키워드가 넘어오지 않는다면
	if(keyword==null){
		//키워드와 검색 조건에 빈 문자열을 넣어준다. 
		//클라이언트 웹브라우저에 출력할 때 "null"을 출력되지 않게 하기 위해서
		keyword="";
		condition="";	
	}
	
	//특수기호를 인코딩한 키워드를 미리 준비한다.
	String encodedK=URLEncoder.encode(keyword);
	
	//startRowNum과 endRowNum을 FileDto 객체에 담고
	FileDto dto=new FileDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	//ArrayList객체의 참조값을 담을 지역변수를 미리 만든다.
	List<FileDto> list=null;
	
	//전체 row의 개수를 담을 지역변수를 미리 만든다. 
	int totalRow=0;
	
	//만일 검색 키워드가 넘어온다면 
	if(!keyword.equals("")){
		//검색 조건이 무엇이냐에 따라 분기하기
		if(condition.equals("title_filename")){//제목+파일명 검색인 경우
			//검색 키워드를 FileDto에 담아서 전달한다.
			dto.setTitle(keyword);
			dto.setOrgFileName(keyword);
			//제목+파일명 검색일 때 호출하는 메소드를 이용해서 목록 얻어오기
			list=FileDao.getInstance().getListTF(dto);
			//제목+파일명 검색일 때 호출하는 메소드를 이용해 row의 개수 얻어오기
			totalRow=FileDao.getInstance().getCountTF(dto);
		}else if(condition.equals("title")){//제목 검색인 경우
			dto.setTitle(keyword);
			list=FileDao.getInstance().getListT(dto);
			totalRow=FileDao.getInstance().getCountT(dto);
		}else if(condition.equals("writer")){//작성자 검색인 경우 
			dto.setWriter(keyword);
			list=FileDao.getInstance().getListW(dto);
			totalRow=FileDao.getInstance().getCountW(dto);
			
		}//다른 검색 조건을 추가하고 싶다면 아래에 else if()를 계속 추가하면 된다. 
			
	}else{//검색 키워드가 넘어오지 않는다면
		//키워드가 없을 때 호출하는 메소드를 이용해서 파일 목록을 얻어온다.
		list=FileDao.getInstance().getList(dto);
		//키워드가 없을 때 호출하는 메소드를 이용해서 전체 row의 개수를 얻어온다. 
		totalRow=FileDao.getInstance().getCount();
	}
	
	//int pageDisplayCount=5; 화면에 페이지 버튼이 5칸이 있다면
	//중요!!! 정수를 정수로 나누면 정수밖에 안나옴! ex) 1/5=0.xxxx 따라서 0이 나옴!!
	//하단 시작 페이지 번호
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT; // 페이지가 1~5페이지일때 시작페이지 1, 페이지가 6~10일때 시작페이지 6
	
	//하단 끝 페이지 번호 
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1 ;
	

	
	//전체 페이지의 개수 구하기
	//totalRow가 20이고 한페이지에 5개씩 게시물을 표현할거라면? 20/5.0 = 4.0 --> 전체페이지 4
	//totalRow가 22이고 한페이지에 5개의 게시물을 표현할거라면? 21/5.0 = 4.2xx --> 전체페이지 4이면 안됨!! 5여야 한다. 
	//따라서 소수점 아래가 1이상이라면 무조건 올려주는 ceil연산을 통해 올려준 후 int형으로 바꿔준다.
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT); 
	
	//끝 페이지 번호가 이미 전체 페이지 개수보다 크게 계산되었다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해준다. 
	}
	//로그인된 아이디가 있는지 읽어와본다. (로그인을 하지 않았으면 null이다.)
	String id=(String)session.getAttribute("id");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일저장소</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="file" name="thisPage"></jsp:param>
</jsp:include>
<div class="container">
	<%--depth를 줄 수 있다. --%>
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/">Home</a>
			</li>
			<li class="breadcrumb-item active">파일 저장소 목록</li>
		</ul>
	</nav>
	<a href="private/upload_form.jsp">업로드 하러가기</a>
	<h1>파일 저장소 입니다.</h1>
	<%--table table-stripted 테이블의 색이 알록달록 --%>
	<table class="table table-striped">
		<%--thead-dark 는 테이블의 1행이 어두운 색으로 --%>
		<thead class="thead-dark">
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>제목(설명)</th>
				<th>파일명</th>
				<th>파일크기</th>
				<th>등록일</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		<%for(FileDto tmp: list){ %>
			<tr>
				<td><%=tmp.getNum() %></td>
				<td><%=tmp.getWriter() %></td>
				<td><%=tmp.getTitle() %></td>
				<td><a href="download.jsp?num=<%=tmp.getNum()%>"><%=tmp.getOrgFileName() %></a></td>
				<td><%=tmp.getFileSize() %></td>
				<td><%=tmp.getRegdate() %></td>
				<%--삭제는 자기가 업로드 한 것만 삭제가 가능하다. 로그인한 계정과 작성자가 같을때만 삭제버튼 활성화 --%>
				<td>
					<%if(tmp.getWriter().equals(id)){ %>
						<a href="javascript:deleteConfirm(<%=tmp.getNum()%>)">삭제</a>
					<%} %>
				</td>
			</tr>
		<%} %>
		</tbody>
	</table>
	<nav>
		<%-- 부트스트랩 css document pagination 참고! --%>
		<!-- justify-content-center로 페이지UI 가운데 두기 -->
		<ul class="pagination justify-content-center">
			<%--페이지버튼이 5개 있을 때 1~5페이지가 가장 첫 페이지 이므로 1~5페이지에 해당할 떼는  Prev버튼이 생성되지 않도록 한다.--%>
			<%if(startPageNum != 1){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1%>&condition=<%=condition%>&keyword=<%=encodedK%>">Prev</a>
				</li>			
			<%}else{ %>
				<%-- 1~5페이지에 해당할 때는 대신 Prev버튼이 disabled상태가 되도록 한다. --%>
				<li class="page-item disabled">
					<%-- 자바 스크립트 javascript: 로 둬 클릭해도  아무 동작이 없게 한다.  --%>
					<a class="page-link" href="javascript:">Prev</a>
				</li>			
				
			<%} %>
			<%for(int i=startPageNum; i<=endPageNum; i++){ %>
				<%--i가 현재페이지와 같을 때 page-item에 active 추가해줌 현재 페이지에 해당하는 숫자가 파랗게 변함  --%>
				<%if(i==pageNum){ %>
					<li class="page-item active">
						<%--페이지 버튼을 클릭했을 때 list.jsp를 요청하며 
						동시에 ?pageNum=숫자를 통해 버튼위의 숫자와 같은 번호의 pageNum으로 넘어가도록 한다. --%>
						<a class="page-link" href="list.jsp?pageNum=<%=i%>&condition=<%=condition%>&keyword=<%=encodedK%>"><%=i %></a>
					</li>
				<%}else{ %><%--같지 않을 때 --%>
					<li class="page-item">
						<a class="page-link" href="list.jsp?pageNum=<%=i%>&condition=<%=condition%>&keyword=<%=encodedK%>"><%=i %></a>
					</li>
				<%} %>
			<%} %>
			<%-- 페이지버튼이 5개일 때 endPageNum보다 totalPageCount가 클때는 Next버튼이 생성되지 않도록 한다. --%>
			<%if(endPageNum <totalPageCount){%>				
				<%--페이지버튼이 5개씩 있을 때 Next버튼을 누르면 그 다음 5개 페이지가 보이도록 한다. --%>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1%>&condition=<%=condition%>&keyword=<%=encodedK%>">Next</a>
				</li>
			<%}else{%>
				<%-- 페이지버튼이 5개일 때 endPageNum보다 totalPageCount가 작을때는 Next버튼을 disabled상태로 둔다.--%>			
				<li class="page-item disabled">
					<!-- 클릭해도 아무 동작이 없게 만든다. -->
					<a class="page-link" href="javascript:">Next</a>
				</li>
			<%} %>
		</ul>
	</nav>
	
	
	<form action="list.jsp" method="get">
		<label for="condition">검색조건</label>
		<select name="condition" id="condition">
			<option value="title_filename" <%=condition.equals("title_filename") ? "selected" : ""%>>제목+파일명</option>
			<option value="title" <%=condition.equals("title") ? "selected" : ""%>>제목</option>
			<option value="writer" <%=condition.equals("writer") ? "selected" : ""%>>작성자</option>
		</select>
		<input type="text" name="keyword" placeholder="검색어..." value="<%=keyword %>" />
		<button type="submit">검색</button>
	</form>
	<%-- 만일 검색 키워드가 존재한다면 몇 개의 글이 검색되었는 지 알려준다. --%>
	<%if(!keyword.equals("")){ %>
		<div class="alert alert-success">
			<strong><%=totalRow %></strong> 개의 자료가 검색되었습니다.
		</div>
	<%} %>
</div>
<script>
	function deleteConfirm(num){
		let isDelete=confirm(num+"번 파일을 삭제 하시겠습니까?");
		if(isDelete){
			location.href="private/delete.jsp?num="+num;
		}
	}
</script>
</body>
</html>