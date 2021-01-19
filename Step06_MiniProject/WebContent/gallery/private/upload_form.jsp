<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 업로드</title>
</head>
<body>
<%--ajax_form.jsp는 upload_form.jsp의 ajax요청 버전이다. --%>
<%--upload_form.jsp는 단순히 업로드만 수행한다면 ajax_from.jsp는 업로드도 수행하면서 업로드한 이미지도 ajax요청으로 페이지 변환없이 불러온다. --%>
<div class="container">
	<form action="insert.jsp" method="post" id="insertForm">
		<input type="hidden" name="imagePath" id="imagePath" />
		<div>
			<label for="caption">설명</label>
			<input type="text" name="caption" id="caption" />
		</div>
	</form>
	<form action="upload.jsp" method="post" id="ajaxForm" enctype="multipart/form-data">
		<div>
			<label for="image">이미지</label>
			<input type="file" name="image" id="image" 
				accept=".jpg, .jpeg, .png, .JPG, .JPEG" />
		</div>
	</form>
	<button id="submitBtn">등록</button>
	<div class="img-wrapper">
		<img src=""/>
	</div>
</div>
<!-- jquery 로딩 -->
<script src="${pageContext.request.contextPath }/js/jquery-3.5.1.js"></script>
<!-- jquery form 플러그인 javascript 로딩 (플러그인은 jquery 로딩이 반드시 선행되어야한다.)-->
<script src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
<script>
	//form플러그인을 이용해서 form이 ajax 전송(페이지 전환없이) 되도록 한다.
	//jquery로 ajax요청을 해보자!
	$("#ajaxForm").ajaxForm(function(data){
		//data는 {imagePath:"업로드된 이미지경로"} 형태의 object이다. 
		console.log(data);
		//로딩할 이미지의 경로 구성
		let src="${pageContext.request.contextPath }"+data.imagePath;
		//img요소의 src속성으로 지정을 해서 이미지를 표시한다. 
		$(".img-wrapper img").attr("src",src);
		//위의 jquery 코드는 자바스크립트의
		//document.querySelector(".img-wrapper img").setAttribute("src",src);
		//와 같다. 
		
		//업로드 경로를 insertForm 에 input type="hidden" 에 value 넣어준다.
		$("#imagePath").val(data.imagePath);
	});
	
	
	//이미지를 선택하면 강제로 폼 전송 시키기, 
	//id가 image인 요소가 change하면 id가 ajaxFrom인 폼을 강제로 폼전송 시킨다.
	$("#image").on("change",function(){
		$("#ajaxForm").submit();
	});
	
	//버튼을 누르면 insertForm 강제 제출해서 이미지 정보가 저장되도록 한다.
	//id가 submitBtn인 요소가 click되면 id가 insertForm인 폼을 강제로 폼전송 시킨다. 
	$("#submitBtn").on("click",function(){
		$("#insertForm").submit();
	});
</script>
</body>
</html>