<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<jsp:include page="../include/resource.jsp"></jsp:include>
<!-- 아래 스타일은 부트스트랩 sign in example에서 사용된 커스텀 css를 복붙한 것임 -->
<style>
	html,
	body {
	  height: 100%;
	}
	
	body {
	  display: -ms-flexbox;
	  display: flex;
	  -ms-flex-align: center;
	  align-items: center;
	  padding-top: 40px;
	  padding-bottom: 40px;
	  background-color: #f5f5f5;
	}
	
	.form-signin {
	  width: 100%;
	  max-width: 330px;
	  padding: 15px;
	  margin: auto;
	}
	.form-signin .checkbox {
	  font-weight: 400;
	}
	.form-signin .form-control {
	  position: relative;
	  box-sizing: border-box;
	  height: auto;
	  padding: 10px;
	  font-size: 16px;
	}
	.form-signin .form-control:focus {
	  z-index: 2;
	}
	.form-signin input[type="email"] {
	  margin-bottom: -1px;
	  border-bottom-right-radius: 0;
	  border-bottom-left-radius: 0;
	}
	.form-signin input[type="password"] {
	  margin-bottom: 10px;
	  border-top-left-radius: 0;
	  border-top-right-radius: 0;
	}
</style>
</head>
<body class="text-center">
<%
	//GET 방식 파라미터 url이라는 이름으로 전달되는 값이 있는 지 읽어와보기
	String url=request.getParameter("url");
	//만일 넘어오는 값이 없다면(이 경우는 예를들어 바로 로그인 하는 경우이다. 바로 로그인하는 경우 index.jsp로 가도록 설정한다.)
	if(url==null){
		//로그인 후에 index.jsp 페이지로 가도록 절대 경로를 구성한다.
		String cPath=request.getContextPath();
		url=cPath+"/index.jsp";
	}
	
	
	//쿠키에 저장된 아이디와 비밀번호를 담을 변수
	String savedId="";
	String savedPwd="";
	//쿠키에 저장된 값을 위의 변수에 저장하는 코드를 작성해 보세요.
	Cookie[] cooks=request.getCookies();
	if(cooks!=null){
		//반복문 돌면서 쿠키객체를 하나씩 참조해서 
		for(Cookie tmp: cooks){
			//저장된 키값을 읽어온다.
			String key=tmp.getName();
			//만일 키값이 savedId 라면 
			if(key.equals("savedId")){
				//쿠키 value 값을 savedId 라는 지역변수에 저장
				savedId=tmp.getValue();
			}
			if(key.equals("savedPwd")){
				savedPwd=tmp.getValue();
			}
			
		}
	}
%>
<!-- 부트스트랩 4.5 example의 sign in예시 html에서 일부 복붙해옴 -->
<form class="form-signin" action="login.jsp" method="post">
	<%-- 원래 가려던 목적지 정보를 url 이라는 파라미터 명으로 전송될수 있도록 한다. --%>
	<input type="hidden" name="url" value="<%=url%>"/>
	
  	<h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
  	
  	<label for="id" class="sr-only">아이디</label>
  	<input type="text" id="id" name="id" class="form-control" 
  		placeholder="아이디 입력..." value="<%=savedId %>" required autofocus>
  		
  	<label for="pwd" class="sr-only">비밀번호</label>
  	<input type="password" id="pwd" name="pwd" class="form-control" 
  		placeholder="비밀번호 입력..." value="<%=savedPwd %>" required>
  		
	<div class="checkbox mb-3">
	    <label>
	      <input type="checkbox" name="isSave" value="yes"> 로그인 정보 저장
	    </label>
	</div>
	<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
</form>
</body>
</html>