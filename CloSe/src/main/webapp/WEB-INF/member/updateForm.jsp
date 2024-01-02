<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<script src="resources/js/bootstrap.bundle.min.js"></script>
<script src="resources/js/jquery.js"></script>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/checkout.css" rel="stylesheet">
<script type="text/javascript" src = "resources/js/script.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="resources/js/jquery.js"></script>

<style>
   table{
      text-align: center;
   }
   th{
      text-align: right;
   }
</style>
   

<script type="text/javascript">
var cert = false;
var registercheck = false;

function sendSMS(콜) {
    alert('인증번호를 요청했습니다.');
    // Ajax 요청
    $.ajax({
        type: "GET",
        url: "sendSms.member?phone="+phone,
        data: { phone: phone },
        success: function(response) {
            // 서버에서 받은 응답(response)을 처리
            console.log(response);

            // 받은 랜덤 값(response)을 전역 변수에 저장
            window.randomValue = response;
         cert = true;
        },
        error: function(error) {
            console.error(error);
            // 에러가 발생했을 경우에 대한 처리를 추가할 수 있습니다.
            alert('전화번호가 일치하지 않습니다.');
        }
    });
}

function verify() {
    var verificationCode = document.getElementById('verificationCode').value;

    // 인증번호가 비어 있으면 알림창을 띄우고 함수를 종료
    if (verificationCode.trim() === '') {
        alert('인증번호를 입력하세요.');
        return;
    }

    // 사용자가 입력한 값
    var userInput = document.getElementById('verificationCode').value;

    // 전역 변수에 저장된 랜덤 값과 사용자가 입력한 값 비교
    if (userInput == window.randomValue) {
        // 일치할 경우, 여기에 원하는 동작 추가
        alert('인증 성공!');
        registercheck = true;
    } else {
        // 불일치할 경우, 여기에 원하는 동작 추가
        alert('인증번호가 일치하지 않습니다. 다시 시도하세요.');
    }
}

function goMain(){
   location.href="view.main";
}

function goUpdate(){
   location.href="update.member";
}

function goDelete(member_id) {
    if (!cert) {
        alert('인증번호를 받으세요');
        return;
    } else if (!registercheck) {
        alert('인증번호를 확인하세요');
        return;
    }

    // If the conditions are met, proceed with the deletion
    location.href = "delete.member?member_id=" + member_id;
}

$(document).ready(function() {
    
    $('#nickname').keyup(function(){ // 닉네임 중복체크

        $.ajax({
            url : "nickduplicate.member", // 요청url
            data : ({
                inputnick : $('input[name="nickname"]').val()
            }),
            success : function(data){
               if(jQuery.trim(data)=='YES'){
                    $('#nickmessage').html("<font color=blue>사용 가능합니다.</font>");
                    nickuse = "possible";
                    $('#nickmessage').show();
                } else {
                    $('#nickmessage').html("<font color=red>이미 사용중인 닉네임입니다.</font>")
                    nickuse = "impossible";
                    $('#nickmessage').show();
                }
            }
        });
    });
    
    $('#sub').click(function(event){ // submit 클릭
        if(nickuse == "impossible"){
           alert('이미 사용중인 닉네임입니다.');
           return false;
        }
    });
});

   function goMyPage(){
      location.href="mypage.member";
   }
   
   function previewImage() {
       var input = document.getElementById('upload');
       var imgThumb = document.getElementById('imgThumb');

       if (input.files && input.files[0]) {
           var reader = new FileReader();

           reader.onload = function (e) {
               imgThumb.src = e.target.result;
           };

           reader.readAsDataURL(input.files[0]);
       }
   }

</script>

<div class="container">
    <div class="py-5 text-center">
      <a href = "view.main">
         <img class="d-block mx-auto mb-4" src="resources/img/logo.png" width="500" height="100">
      </a>
      <h2>마이페이지</h2>
    </div>
 
   <ul class="nav nav-tabs" role="tablist">
     <li class="nav-item" role="presentation">
       <a class="nav-link active" data-bs-toggle="tab" href="#home" aria-selected="true" role="tab">수정하기</a>
     </li>

   </ul>
   
   <div id="myTabContent" class="tab-content">
      <!-- 첫번째 탭 -->
      <div class="tab-pane fade active show" id="home" role="tabpanel">
         <div class="row">
              <form name="f" class="needs-validation" action = "update.member" method="post" onsubmit="return updatecheck()" enctype="multipart/form-data">
                 <table class="table" id="article-table">
                    <c:if test="${not empty loginInfo or not empty kakaoLoginInfo}">
                       <tr>
                          <th>프로필 사진</th>
                          <td>
                               <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                   <c:if test="${kakaoLoginInfo.member_image == null}">
                                        <img id="imgThumb" src="https://static.nid.naver.com/images/web/user/default.png" width="100" height="100"><br><br>
                                     </c:if>
                                     <c:if test="${kakaoLoginInfo.member_image != null}">
                                      <img id="imgThumb" src="<%=request.getContextPath()%>/resources/memberImage/${kakaoLoginInfo.member_image}" width="100" height="100"><br><br>
                                    </c:if>
                                    <input type="file" class="form-control mb-3" id="upload" name="upload" value="${kakaoLoginInfo.member_image}" style="border-color: black; width: 250px; margin: auto;" onchange="previewImage()">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                     <c:if test="${loginInfo.member_image == null}">
                                        <img id="imgThumb" src="https://static.nid.naver.com/images/web/user/default.png" width="100" height="100"><br><br>
                                     </c:if>
                                     <c:if test="${loginInfo.member_image != null}">
                                        <img id="imgThumb" src="<%=request.getContextPath()%>/resources/memberImage/${loginInfo.member_image}" width="100" height="100"><br><br>
                                     </c:if>
                                    <input type="file" class="form-control mb-3" id="upload" name="upload" value="${loginInfo.member_image}" style="border-color: black; width: 250px; margin: auto;" onchange="previewImage()">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>아이디</th>
                          <td>
                               <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    <input type="text" id="member_id" name="member_id" disabled="disabled" value="${kakaoLoginInfo.member_id}">
                                    <input type="hidden" name="member_id" value="${kakaoLoginInfo.member_id}">
                                    <input type="hidden" name="social" value="kakao">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <input type="text" id="member_id" name="member_id" disabled="disabled" value="${loginInfo.member_id}">
                                    <input type="hidden" name="member_id" value="${loginInfo.member_id}">
                                    <input type="hidden" name="social" value="general">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>닉네임</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    <input type="text" id="nickname" name="nickname" maxlength="8" value="${kakaoLoginInfo.nickname}"><br>
                                    <span id="nickmessage" style = "display: none;"></span>
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <input type="text" id="nickname" name="nickname" maxlength="8" value="${loginInfo.nickname}"><br>
                                    <span id="nickmessage" style = "display: none;"></span>
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                           <th>비밀번호</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    <input type="password" id="password" name="password" value="${kakaoLoginInfo.password}">
                                    <form:errors cssClass="err" path="password"/>
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <input type="password" id="password" name="password" value="${loginInfo.password}" onblur="pwcheck()">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>이름</th>
                          <td>
                               <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    <input type="text" id="name" name="name" disabled="disabled" value="${kakaoLoginInfo.name}">
                                    <input type="hidden" name="name" value="${kakaoLoginInfo.name}">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <input type="text" id="name" name="name" disabled="disabled" value="${loginInfo.name}">
                                    <input type="hidden" name="name" value="${loginInfo.name}">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>성별</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                <input type="radio" id="gender" name="gender" value="남자" <c:if test="${kakaoLoginInfo.gender eq '남자'}">checked</c:if>> 남자
                                <input type="radio" id="gender" name="gender" value="여자" <c:if test="${kakaoLoginInfo.gender eq '여자'}">checked</c:if>> 여자
                              </c:when>
                              <c:when test="${not empty loginInfo}">
                                <input type="radio" id="gender" name="gender" value="남자" <c:if test="${loginInfo.gender eq '남자'}">checked</c:if>> 남자
                                <input type="radio" id="gender" name="gender" value="여자" <c:if test="${loginInfo.gender eq '여자'}">checked</c:if>> 여자
                              </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>도로명 주소</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    <input type="text" id="address1" name="address1" value="${kakaoLoginInfo.address1}"><br><br>
                                    <button type="button" class="btn btn-outline-dark" onclick="searchAddress()">주소 찾기</button>
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <input type="text" id="address1" name="address1" value="${loginInfo.address1}"><br><br>
                                    <button type="button" class="btn btn-outline-dark" onclick="searchAddress()">주소 찾기</button>
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>상세주소</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    <input type="text" id="address2" name="address2" value="${kakaoLoginInfo.address2}">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <input type="text" id="address2" name="address2" value="${loginInfo.address2}">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>휴대폰 번호</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    <input type="text" id="phone" name="phone" disabled="disabled" value="${kakaoLoginInfo.phone}">
                                    <input type="hidden" name="phone" value="${kakaoLoginInfo.phone}">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <input type="text" id="phone" name="phone" disabled="disabled" value="${loginInfo.phone}">
                                    <input type="hidden" name="phone" value="${loginInfo.phone}">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>이메일 주소</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    <input type="text" id="email" name="email" value="${kakaoLoginInfo.email}">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <input type="text" id="email" name="email" value="${loginInfo.email}">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>생년월일</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                   <c:set var="kakaoBirth" value="${fn:substring(kakaoLoginInfo.birth, 0, 10)}" />
                               <input type="date" id="birth" name="birth" value="${kakaoBirth}">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <c:set var="Birth" value="${fn:substring(loginInfo.birth, 0, 10)}" />
                               <input type="date" id="birth" name="birth" value="${Birth}">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>키 (cm)</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    <input type="number" id="height" name="height" value="${kakaoLoginInfo.height}">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <input type="number" id="height" name="height" value="${loginInfo.height}">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>몸무게 (kg)</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    <input type="number" id="weight" name="weight" value="${kakaoLoginInfo.weight}">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <input type="number" id="weight" name="weight" value="${loginInfo.weight}">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                    </c:if>
                    <tr>
                       <td colspan="2">
                         <input type="submit" id="sub" class="btn btn-dark btn-md" value="수정"/>
                         <input type="button" class="btn btn-dark btn-md" value="돌아가기" onclick="goMyPage()">
                       </td>
                    </tr>
                 </table>
              </form>
          </div>  
      </div>
   </div>





    

   <footer class="my-5 pt-5 text-body-secondary text-center text-small">
     <p class="mb-1">© 2023 Minhyeok, Byeon</p>
   </footer>
</div>