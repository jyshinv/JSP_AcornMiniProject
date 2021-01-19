<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<style>
</style>
</head>
<body>
<jsp:include page="../include/navbar.jsp"></jsp:include>
<div class="container">
	<h3>회원 가입</h3>
	<!-- 
		[novalidate 로 웹브라우저 자체의 검증기능 사용하지 않기]
		<input type="email" /> 같은 경우 웹브라우저가 직접 개입하기도 한다.
		해당기능 사용하지 않기 위해서는 novalidate를 form에 명시해야 한다. 
	 -->
	<%--form-group과 form-control로 부트스트랩 적용하기 --%>
	<form action="signup.jsp" method="post" id="myForm" novalidate>
		<div class="form-group">
			<label for="id">아이디</label>
			<input class="form-control" type="text" name="id" id="id" />
			<small class="form-text text-muted">영문자 소문자로 시작하고 5글자~10글자 이내로 입력하세요.</small>
			<%--div class속성값으로 invalid-feedback를 주면 input요소의 class속성값이 is-invalid일 때 경고하고, is-valid일 때 체크표시를 나타내준다. --%>
			<div class="invalid-feedback">사용할수 없는 아이디 입니다</div>
		</div>
		<div class="form-group">
			<label for="pwd">비밀번호</label>
			<input class="form-control" type="password" name="pwd" id="pwd" />
			<small class="form-text text-muted">5~10글자 이내로 입력하세요</small>
			<%--div class속성값으로 invalid-feedback를 주면 input요소의 class속성값이 is-invalid일 때 경고하고, is-valid일 때 체크표시를 나타내준다. --%>
			<div class="invalid-feedback">비밀번호를 확인하세요.</div>
		</div>
		<div class="form-group">
			<label for="pwd2">비밀번호 확인</label>
			<%-- pwd2는 form전송 안할것!! name속성을 뺌 --%>
			<input class="form-control" type="password" id="pwd2" />
		</div>
		<div class="form-group">
			<label for="email">이메일</label>
			<input class="form-control" type="text" name="email" id="email" />
			<%--div class속성값으로 invalid-feedback를 주면 input요소의 class속성값이 is-invalid일 때 경고하고, is-valid일 때 체크표시를 나타내준다. --%>
			<div class="invalid-feedback">이메일 형식을 확인 하세요.</div>
		</div>
		
		<button class="btn btn-outline-primary" type="submit">가입</button>
	</form>
</div>
<script>
	//jquery를 공부해보자! 자바스크립트 코드로도 가능하지만 jquery를 공부해보자.(jquery로딩 필수)
	
	//아이디를 검증할 정규 표현식(소문자로 시작하고 최소5글자 최대10글자 이내)
	let reg_id=/^[a-z].{4,9}$/;
	//비밀번호를 검증할 정규 표현식(5~10글자인지 검증)
	let reg_pwd=/^.{5,10}$/;
	//이메일을 검증할 정규 표현식(정확히 검증하려면 javascript 이메일 정규 표현식 검색해서 사용)
	let reg_email=/@/;
	
	//아이디 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isIdValid=false;
	//비밀번호 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isPwdValid=false;	
	//이메일 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	let isEmailValid=false;
	//폼 전체의 유효성 여부를 관리할 변수 만들고 초기값 부여하기
	//위의 3개가 모두 true여야 isFormValid가 true가 된다고 가정
	let isFormValid=false;
	
	//폼에 submit 이벤트가 일어났을 때 jquery를 활용해서 폼에 입력한 내용 검증하기
	//id가 myForm인 요소에 submit이벤트가 일어났을 때 실행할 함수 등록 
	$("#myForm").on("submit",function(){
		//폼 전체의 유효성 여부를 얻어낸다.
		isFormValid=isIdValid && isPwdValue && isEmailValid;
		//만일 폼이 유효하지 않는다면
		if(!isFormValid){
			return false; //폼 전송 막기(함수 종료시키기)
		}
	});
	
	//id가 pwd, pwd2인 요소에 input(입력) 이벤트가 일어났을 때 실행할 함수 등록
	$("#pwd, #pwd2").on("input",function(){
		//input 이벤트가 언제 일어나는지 콘솔창을 통해 확인 요망!
		//console.log("input!!");
		
		//입력한 두 비밀번호를 읽어온다.
		let pwd=$("#pwd").val();
		let pwd2=$("#pwd2").val();
		
		
		//일단 모든 검증 클래스를 제거하고
		$("#pwd").removeClass("is-valid is-invalid");
		//자바스크립트 test함수를 호출해 검증 결과가 false이면
		if(!reg_pwd.test(pwd)){
			//비밀번호가 유효하지 않는다고 표시하고
			$("#pwd").addClass("is-invalid");
			isPwdValid=false;
			//함수를 여기서 종료
			return;
		}
		
		//두 비밀번호가 같은지 확인해서
		if(pwd==pwd2){//만일 같으면
			//jquery 에서 클래스 속성값을 추가하는 방법은 .addClass("속성값")
			//유효하다는 클래스를 추가
			$("#pwd").addClass("is-valid");
			isPwdValid=true;
		}else{ //다르면 
			//유효하지 않다는 클래스 추가
			$("#pwd").addClass("is-invalid");
			isPwdValid=false;
		}
	});
	
	//아이디 입력란에 입력했을 때 실행할 함수 등록
	//jqery로 ajax기능 써보기 연습!!
	$("#id").on("input", function(){
		//1. 입력한 아이디를 읽어와서
		let inputId=$("#id").val();
		
		//일단 모든 검증 클래스를 제거하고
		$("#id").removeClass("is-valid is-invalid");
		//자바스크립트 test함수를 호출해 검증 결과가 false이면
		if(!reg_id.test(inputId)){
			//아이디가 유효하지 않는다고 표시하고
			$("#id").addClass("is-invalid");
			isIdValid=false;
			//함수를 여기서 종료
			return;
		}else{
			$("#id").addClass("is-valid");
			isIdValid=true;
			
		}
		
		
		
	});
	
	
	//이메일을 입력했을 때 실행할 함수 등록 
	//jqery로 ajax기능 써보기 연습!!
	$("#email").on("input", function(){
		//1. 입력한 아이디를 읽어와서
		let inputEmail=$("#email").val();
	
		
		//일단 모든 검증 클래스를 제거하고
		$("#email").removeClass("is-valid is-invalid");
		//자바스크립트 test함수를 호출해 검증 결과가 false이면(이메일이 정규표현식에 매칭되지 않는다면)
		if(!reg_email.test(inputEmail)){
			$("#email").addClass("is-invalid");
			isEmailValid=false;
		}else {
			$("#email").addClass("is-valid");
			isEmailValid=true;
		}
	});
	
	
</script>
</body>
</html>