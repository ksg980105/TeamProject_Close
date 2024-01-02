<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="resources/js/bootstrap.bundle.min.js"></script>
<link href="resources/css/sign-in.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src = "resources/js/jquery.js"></script>
<script type="text/javascript" src = "resources/js/script.js"></script>
<script type="text/javascript">
	function goLogin(){
		location.href="login.member";
	}
</script>

<body class="d-flex align-items-center py-4 bg-body-tertiary">

   <main class="form-signin w-100 m-auto">
      <form name = "f" action = "findpw.member" method="post" onsubmit="return pwformcheck()">
      <a href = "view.main">
         <img class="mb-3" src="resources/img/logo.png" alt="" width="300"
            height="80"
            style="margin-left: auto; margin-right: auto; display: block;">
      </a>
         <h1 class="h3 mb-8 fw-normal" align="center"><b>비밀번호 찾기</b></h1>
         
         <div class="btn-group w-100 py-2" role="group" aria-label="Basic example" style = "margin-top: 30px">
              <input type="radio" class="btn-check" name="options" id="option1" onclick = "location.href='findid.member'" autocomplete="off">
			  <label class="btn btn-outline-secondary" for="option1">아이디 찾기</label>
				
			  <input type="radio" class="btn-check" name="options" id="option2" onclick = "location.href='findpw.member'" autocomplete="off" checked>
			  <label class="btn btn-outline-secondary" for="option2">비번 찾기</label>
         </div>

         <label for="country" class="form-label" style = "margin-top: 30px">아이디</label>
         <div class="form-floating">
            <input type="text" class="form-control mb-2" id="floatingId" name = "member_id" placeholder="Id"> 
             <label for="floatingId">아이디 입력</label>
         </div>
         
         <label for="country" class="form-label">휴대폰 번호</label>
         <div class="form-floating">
            <input type="text" class="form-control mb-2" id="floatingPassword" maxlength="11" name = "phone" placeholder="Password"> 
            <label for="floatingPassword">- 없이 휴대폰 번호 입력</label>
         </div>
         
         <label for="country" class="form-label">이메일 주소</label>
         <div class="form-floating">
            <input type="text" class="form-control mb-4" id="floatingEmail" name = "email" placeholder="Email"> 
            <label for="floatingEmail">name@example.com</label>
         </div>

         <button class="btn btn-dark w-100 py-2" type="submit">비밀번호 찾기</button>&nbsp;
         <input type="button" class="btn btn-dark w-100 py-2" value="로그인하러 가기" onclick="goLogin()">
         <p class="mt-5 mb-3 text-body-secondary">© 2023 Team, Clothes secretary</p>
      </form>
   </main>

</body>