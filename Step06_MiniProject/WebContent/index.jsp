<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<head>
<meta charset="utf-8">
<title>MiniProject</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/cover/">

<style>
  .bd-placeholder-img {
    font-size: 1.125rem;
    text-anchor: middle;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
  }

  @media (min-width: 768px) {
    .bd-placeholder-img-lg {
      font-size: 3.5rem;
    }
  }
  
	  /*
	 * Globals
	 */
	
	/* Links */
	a,
	a:focus,
	a:hover {
	  color: #fff;
	}
	
	/* Custom default button */
	.btn-secondary,
	.btn-secondary:hover,
	.btn-secondary:focus {
	  color: #333;
	  text-shadow: none; /* Prevent inheritance from `body` */
	  background-color: #fff;
	  border: .05rem solid #fff;
	  margin-bottom : 10px;
	}
	
	
	/*
	 * Base structure
	 */
	
	html,
	
	body {
	  height: 100%;
	  background-color: #333;
	}
	
	body {
	  display: -ms-flexbox;
	  display: flex;
	  color: #fff;
	  text-shadow: 0 .05rem .1rem rgba(0, 0, 0, .5);
	  box-shadow: inset 0 0 5rem rgba(0, 0, 0, .5);
	}
	
	.cover-container {
	  max-width: 42em;
	}
	
	
	/*
	 * Header
	 */
	.masthead {
	  margin-bottom: 2rem;
	}
	
	.masthead-brand {
	  margin-bottom: 0;
	}
	
	.nav-masthead .nav-link {
	  padding: .25rem 0;
	  font-weight: 700;
	  color: rgba(255, 255, 255, .5);
	  background-color: transparent;
	  border-bottom: .25rem solid transparent;
	}
	
	.nav-masthead .nav-link:hover,
	.nav-masthead .nav-link:focus {
	  border-bottom-color: rgba(255, 255, 255, .25);
	}
	
	.nav-masthead .nav-link + .nav-link {
	  margin-left: 1rem;
	}
	
	.nav-masthead .active {
	  color: #fff;
	  border-bottom-color: #fff;
	}
	
	@media (min-width: 48em) {
	  .masthead-brand {
	    float: left;
	  }
	  .nav-masthead {
	    float: right;
	  }
	}
	
	
	/*
	 * Cover
	 */
	.cover {
	  padding: 0 1.5rem;
	}
	.cover .btn-lg {
	  padding: .75rem 1.25rem;
	  font-weight: 700;
	  margin : 10px;
	}
	
	
	/*
	 * Footer
	 */
	.mastfoot {
	  color: rgba(255, 255, 255, .5);
	}
	
	.cover-heading{
		margin-bottom : 10px;
	}
	
	img{
		width : 100px;
		height : 100px;
	}
</style>
</head>
<body class="text-center">

<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
  <header class="masthead mb-auto">
	<jsp:include page="include/navbar.jsp"></jsp:include>
  </header>

 
  <main role="main" class="inner cover">
  	<img src="images/free-icon-team-2936607.png"/>
    <h1 class="cover-heading">Mini Project</h1>
    <a href="${pageContext.request.contextPath }/cafe/list.jsp" class="btn btn-default btn-lg btn-secondary">Board</a>
    <a href="${pageContext.request.contextPath }/file/list.jsp" class="btn btn-default btn-lg btn-secondary">File</a>
    <a href="${pageContext.request.contextPath }/gallery/list.jsp" class="btn btn-default btn-lg btn-secondary">Gallery</a><br />  	
    <a href="https://docs.google.com/document/d/1BJOU68zf_rXJNKHKn8ffXrrG0rsZrJVAEDkNvAU5mos/edit" ><u>acorn web&app class document</u></a>  	
  </main>
 	
	
  	

  <footer class="mastfoot mt-auto">
    <div class="inner">
      <p>Cover template for <a href="https://getbootstrap.com/">Bootstrap</a>, by <a href="https://sjy1218vv.tistory.com/">@jy</a>.</p>
    </div>
  </footer>
</div>
</body>
</html>
    