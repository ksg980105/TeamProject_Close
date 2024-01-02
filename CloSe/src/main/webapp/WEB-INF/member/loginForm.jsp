<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<script src="resources/js/bootstrap.bundle.min.js"></script>
<link href="resources/css/sign-in.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="resources/js/script.js"></script>
<script>
	Kakao.init('2cdf0145ab332ff37556bbc8268b13a1');
	function kakaoLogin() {
	    Kakao.Auth.login({
	        success: function (response) {
	            Kakao.API.request({
	                url: '/v2/user/me',
	                success: function (response) {
	                	var id = response.id;
	                    location.href="kakaologin.member?member_id="+id;
	                },
	                fail: function (error) {
	                    alert(JSON.stringify(error))
	                },
	            })
	        },
	        fail: function (error) {
	            alert(JSON.stringify(error))
	        },
	    })
	}

	function setCookie(name, value, days) {
	    var expires = '';
	    if (days) {
	        var date = new Date();
	        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
	        expires = '; expires=' + date.toUTCString();
	    }
	    document.cookie = name + '=' + value + expires + '; path=/';
	}
	
	// 쿠키 삭제 함수
	function deleteCookie(name) {
	    setCookie(name, '', -1);
	}
	
	// 쿠키 값 가져오기 함수
	function getCookie(name) {
	    var nameEQ = name + '=';
	    var ca = document.cookie.split(';');
	    for (var i = 0; i < ca.length; i++) {
	        var c = ca[i];
	        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
	        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
	    }
	    return null;
	}
	
	// 페이지 로드 시 실행되는 이벤트
	document.addEventListener('DOMContentLoaded', function () {
	    // 쿠키에서 기억된 사용자명 가져오기
	    var rememberedUsername = getCookie('rememberMe');
	    var checkbox = document.getElementById('flexCheckDefault');
	
	    // 쿠키에 기억된 사용자명이 있으면 입력 필드와 체크박스 설정
	    if (rememberedUsername) {
	        document.getElementById('floatingInput').value = rememberedUsername;
	        checkbox.checked = true;
	    } else {
	        // 쿠키에 기억된 사용자명이 없으면 체크박스 해제
	        checkbox.checked = false;
	    }
	
	    // 체크박스 상태가 변경될 때 쿠키 업데이트
	    checkbox.addEventListener('change', function () {
	        var memberId = document.getElementById('floatingInput').value;
	        if (checkbox.checked) {
	            // 체크박스가 선택되었을 경우, 7일 동안 유효한 쿠키 생성
	            setCookie('rememberMe', memberId, 7);
	        } else {
	            // 체크박스가 해제되었을 경우, 쿠키 삭제
	            deleteCookie('rememberMe');
	        }
	    });
	});
	
	// 폼 제출 전에 실행되는 함수
	function loginValidation() {
	    var memberId = document.getElementById('floatingInput').value;
	    var password = document.getElementById('floatingPassword').value;
	
	    // 아이디 또는 비밀번호가 비어있는 경우
	    if (memberId.trim() === '' || password.trim() === '') {
	        // 경고 메시지 또는 특정 스타일 적용
	        alert('아이디와 비밀번호를 입력하세요.');
	        return false; // 폼 제출을 막음
	    }
	
	    // 유효한 경우 폼을 제출
	    return true;
	}
	
	function togglePasswordVisibility() {
	    var passwordInput = document.getElementById('floatingPassword');
	    var passwordToggle = document.querySelector('.password-toggle');

	    if (passwordInput.type === 'password') {
	        passwordInput.type = 'text';
	        passwordToggle.style.backgroundImage = 'url(\'resources/icon/eye.svg\')';
	    } else {
	        passwordInput.type = 'password';
	        passwordToggle.style.backgroundImage = 'url(\'resources/icon/eye-slash.svg\')';
	    }
	}
	
	
</script>

<style>
	.password-toggle {
    position: absolute;
    top: 50%;
    right: 10px;
    cursor: pointer;
    transform: translateY(-50%);
    width: 24px;
    height: 24px;
    background: url('resources/icon/eye-slash.svg') center/cover no-repeat;
	}
</style>

<body class="d-flex align-items-center py-4 bg-body-tertiary">

   <main class="form-signin w-100 m-auto">
      <form action="login.member" method="post" onSubmit="return loginValidation()">
         <a href="view.main">
         	<img class="mb-3" src="resources/img/logo.png" alt="" width="350" height="100" style="margin-left: auto; margin-right: auto; display: block;">
         </a>
         <h1 class="h3 mb-4 fw-normal" align="center"><b>통합로그인</b></h1>

         <div class="form-floating">
            <input type="text" class="form-control" id="floatingInput"
               placeholder="Id" name="member_id"> <label for="floatingInput">아이디</label>
         </div>
         <div class="form-floating">
            <input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password"> 
            <label for="floatingPassword">비밀번호</label>
            <!-- 눈 모양 아이콘 -->
    		<span class="password-toggle" onclick="togglePasswordVisibility()"></span>
         </div>

         <div class="form-check text-start my-3">
            <input type="checkbox" value="remember-me" id="flexCheckDefault" style="accent-color: black; margin-left: -20px;"> 
            	<label class="form-check-label" for="flexCheckDefault"> 아이디 저장 </label> 
            	<label style="float: right;">
               <a href="findid.member" class="text-secondary link-underline link-underline-opacity-0">
               	<font size="2">아이디/비밀번호 찾기</font>
               </a>
               <a href="register.member" class="text-secondary link-underline link-underline-opacity-0">
               	<font size="2">회원가입</font>
               </a>
            </label>
         </div>
         <button class="btn btn-dark w-100 py-2" type="submit">로그인</button><hr>
         
         <!-- 카카오톡 로그인 -->
         <div class="form-group row" id="kakaologin">
         	<div class="kakaobtn">
         		<a href="javascript:kakaoLogin();">
         			<img src="resources/img/kakao_login_large_wide.png" style="width: 350px; height: 40px;"/>
         		</a>
         	</div>
         </div>
         
         <p class="mt-5 mb-3 text-body-secondary">© 2023 Team, Clothes secretary</p>
      </form>
   </main>

</body>
