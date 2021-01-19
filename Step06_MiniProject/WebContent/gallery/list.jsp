<%@page import="test.gallery.dto.GalleryDto"%>
<%@page import="test.gallery.dao.GalleryDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한페이지에 몇개씩 게시물을 표시할 것인지
	final int PAGE_ROW_COUNT=8;
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
	
	//startRowNum과 endRowNum을 GalleryDto 객체에 담고
	GalleryDto dto=new GalleryDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	//GalleryDao 객체를 이용해서 회원 목록을 얻어온다.
	List<GalleryDto> list= GalleryDao.getInstance().getList(dto);
	
	//int pageDisplayCount=5; 화면에 페이지 버튼이 5칸이 있다면
	//중요!!! 정수를 정수로 나누면 정수밖에 안나옴! ex) 1/5=0.xxxx 따라서 0이 나옴!!
	//하단 시작 페이지 번호
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT; // 페이지가 1~5페이지일때 시작페이지 1, 페이지가 6~10일때 시작페이지 6
	
	//하단 끝 페이지 번호 
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1 ;
	
	//전체 row의 개수
	int totalRow=GalleryDao.getInstance().getCount();
	
	//전체 페이지의 개수 구하기
	//totalRow가 20이고 한페이지에 5개씩 게시물을 표현할거라면? 20/5.0 = 4.0 --> 전체페이지 4
	//totalRow가 22이고 한페이지에 5개의 게시물을 표현할거라면? 21/5.0 = 4.2xx --> 전체페이지 4이면 안됨!! 5여야 한다. 
	//따라서 소수점 아래가 1이상이라면 무조건 올려주는 ceil연산을 통해 올려준 후 int형으로 바꿔준다.
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT); 
	
	//끝 페이지 번호가 이미 전체 페이지 개수보다 크게 계산되었다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해준다. 
	}
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>갤러리</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<!-- 
	jquery 플러그인 imgLiquid.js 로딩하기
	- 반드시 jquery.js 가 먼저 로딩이 되어 있어야지만 동작한다.(bootstrap도 jquery를 로딩 후 사용해야함?? 영상 다시 확인할 것)
	- 사용법은 이미지의 부모 div크기를 결정하고 이미지를 선택해서 .imgLiquid() 동작을 하면된다. 
 -->
<script src="${pageContext.request.contextPath }/js/imgLiquid.js"></script>
<style>
	/*card 이미지 부모요소의 높이 지정*/
	.img-wrapper{
		height: 250px;
		/*아래 hover되었을 때 transform을 적용할 때 0.3s동안 순차적으로 적용하기 
		0.3초동안 커져서 커지는 과정이 보임*/
		transition : transform 0.3s ease-out;
		/*transition : all 0.3s ease-out;*/
	}
	
	/*img-wrapper에 마우스가 hover 되었을 때 적용할 css*/
	.img-wrapper:hover{
		/*원본 크기의 1.1배로 확대시키기*/
		transform : scale(1.1);
		background-color: pink;
	}
	
	.card .card-text{
		/*한줄만 text가 나오고 나머지 한줄 넘는 길이에 대해서는 ...처리 */
		display : block;
		white-space : nowrap;
		text-overflow : ellipsis;
		overflow : hidden;
	}
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp">
	<jsp:param value="gallery" name="thisPage"/>
</jsp:include>
<!-- depth 주기 -->
<div class="container">
	<nav>
		<ul class="breadcrumb">
			<li class="breadcrumb-item">
				<a href="${pageContext.request.contextPath }/">Home</a>
			</li>
			<li class="breadcrumb-item active">갤러리</li>
		</ul>
	</nav>
	<a href="private/upload_form.jsp">사진 업로드 하러 가기</a>
	<h1>갤러리 목록 입니다.</h1>
	<div class="row">
		<%for(GalleryDto tmp:list){ %>
		<!-- 
			[칼럼의 폭을 반응형으로]
			device 폭 768px 미만에서 칼럼의 폭 => 6/12 (50%) (12칸중 6칸을 카드 한폭으로 쓰겠다)
			md - medium device 폭 768px ~992px 에서 칼럼의 폭 => 4/12 (33.333%) (12칸중 4칸을 카드 한폭으로 쓰겠다)
			lg - large device 폭 992px 이상에서 칼럼의 폭 => 3/12 (25%%) (12칸중 3칸을 카드 한폭으로 쓰겠다)
		 -->
		<div class="col-6 col-md-4 col-lg-3">
				<div class="card mb-3"><!-- margin bottom 3단계를 주겠다. -->
					<a href="detail.jsp?num=<%=tmp.getNum() %>">
						<div class="img-wrapper"><!-- 여기에 id부여 금지(id는 오직한개임, for문안에 id를 넣으면 오직 한개 규칙을 깨는것임) -->
							<img class="card-img-top" src="${pageContext.request.contextPath }<%=tmp.getImagePath() %>" />
						</div>
					</a>
					<div class="card-body">
						<p class="card-text"><%=tmp.getCaption() %></p>
						<p class="card-text">by <strong><%=tmp.getWriter() %></strong></p>
						<p><small><%=tmp.getRegdate() %></small></p>
					</div>
				</div>
		</div>
		<%} %>
	</div>
	<nav>
		<%-- 부트스트랩 css document pagination 참고! --%>
		<!-- justify-content-center로 페이지UI 가운데 두기 -->
		<ul class="pagination justify-content-center">
			<%--페이지버튼이 5개 있을 때 1~5페이지가 가장 첫 페이지 이므로 1~5페이지에 해당할 떼는  Prev버튼이 생성되지 않도록 한다.--%>
			<%if(startPageNum != 1){ %>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1%>">Prev</a>
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
						<a class="page-link" href="list.jsp?pageNum=<%=i%>"><%=i %></a>
					</li>
				<%}else{ %><%--같지 않을 때 --%>
					<li class="page-item">
						<a class="page-link" href="list.jsp?pageNum=<%=i%>"><%=i %></a>
					</li>
				<%} %>
			<%} %>
			<%-- 페이지버튼이 5개일 때 endPageNum보다 totalPageCount가 클때는 Next버튼이 생성되지 않도록 한다. --%>
			<%if(endPageNum <totalPageCount){%>				
				<%--페이지버튼이 5개씩 있을 때 Next버튼을 누르면 그 다음 5개 페이지가 보이도록 한다. --%>
				<li class="page-item">
					<a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1%>">Next</a>
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
</div>
<script>
	//card이미지의 부모 요소를 선택해서 imgLiquid 동작(jquery plugin 동작 하기)
	$(".img-wrapper").imgLiquid();
</script>
</body>
</html>