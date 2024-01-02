<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<script src="resources/js/bootstrap.bundle.min.js"></script>
<script src="resources/js/jquery.js"></script>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/checkout.css" rel="stylesheet">

<style>
   .body{
      width: 95vw;
      margin: auto;
   }
   .row{
      width: 70%;
      margin: auto;
   }
   table{
      text-align: center;
   }
   th{
      text-align: center;
   }
   .page-link {
     color: #000; 
     background-color: #fff;
     border: 1px solid #ccc; 
   }
   
   .page-item.active .page-link {
    z-index: 1;
    color: #555;
    font-weight:bold;
    background-color: #f1f1f1;
    border-color: #ccc;
    
   }
   
   .page-link:focus, .page-link:hover {
     color: #000;
     background-color: #fafafa; 
     border-color: #ccc;
   }
   .pd{
      text-decoration: none;
      color: black;
   #profile{
      border-radius: 100%;
      border: 1px solid #C0C0C0;
   }
   .container{
      width: 100%;
   }
   ul{
      width: 100%;
   }
</style>

<script type="text/javascript">

   var cert = false;
   var registercheck = false;
   
   function sendSMS(phone) {
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

       var userResponse = confirm('회원탈퇴시 보유하신 쿠폰이 모두 사라집니다.');
       if (!userResponse) {
          alert('회원탈퇴가 취소되었습니다.');
          location.href='mypage.member';
       }else{
          location.href = "delete.member?member_id=" + member_id;          
       }
   }

   $(document).ready(function () {
       // 페이지 로딩 시 URL 파라미터 확인
       var activeTab = '${param.activeTab}';
       // URL 파라미터에 따라 탭 활성화
       if(activeTab!=3){
          $("a[href='#tab1']").addClass('active');
       }
       if (activeTab == 3) {
           $('.tab-pane').removeClass('active show'); // 모든 탭에서 'active' 클래스 제거
           $('.tab-nav-link').removeClass('active'); // 모든 탭에서 'active' 클래스 제거
           $("a[href='#tab"+activeTab+"']").addClass('active');
           $('#tab' + activeTab).addClass('active show'); // 선택된 탭에 'active' 클래스 추가
       }
       
       
   });
   var oid = "";
   function orderdetail(orders_id){
      oid = orders_id;
      $('.tab-pane').removeClass('active show');
      $.ajax({
        url: "detail.orders?orders_id="+orders_id,
        type: "post", 
        contentType: "application/json; charset=utf8",
        success : function(data){
         $("#orderdetail").empty();
         $("#buyer").empty();
         $("#receiver").empty();
         $("#receipt").empty();
         
         var tableHeader = $("<thead><tr><th scope='col'>이미지</th><th scope='col'>상품정보</th><th scope='col'>가격</th><th scope='col'>옵션</th><th scope='col'>주문수량</th><th scope='col'>소계</th></tr></thead>");
         $("#orderdetail").append(tableHeader);
         
         var totalPrice = 0;
         var firstElement = data[0];
           // 받은 데이터를 기반으로 새로운 테이블 행을 동적으로 생성하고 삽입합니다.
           $(data).each(function () {
               var newRow = $("<tr>");
               newRow.append("<td><img id='preview' width='100px' src='<%=request.getContextPath()%>/resources/productImage/" + this.image + "' class='rounded' /></td>");
               
               // Splitting the product_name based on '/'
               var productNameParts = this.product_name.split('/');
               newRow.append("<td><a class='pd' href='detail.product?product_number=" + this.product_number + "'>[" + productNameParts[0] + "] <br>" + productNameParts[1] + "</a></td>");
               
               newRow.append("<td>" + this.price.toLocaleString() + "원</td>");
               newRow.append("<td>" + this.product_size + "</td>");
               newRow.append("<td>" + this.qty + "</td>");
               newRow.append("<td>" + (this.price * this.qty).toLocaleString() + "원 <button class='btn btn-dark btn-md' type='button' onclick='openReviewFormWindow(" + this.orderdetail_number + ")'>리뷰작성</button></td>");
               newRow.appendTo("#orderdetail");
               totalPrice += this.price * this.qty;
           });
           
           var buyerHtml = "<tr>" +
                           "<td>주문자</td>" +
                           "<td>" + firstElement.name + "</td>" +
                        "</tr>" +
                        "<tr>" +
                           "<td>연락처</td>" +
                           "<td>" + firstElement.phone + "</td>" +
                        "</tr>" +
                        "<tr>" +
                           "<td>이메일</td>" +
                           "<td>" + firstElement.email + "</td>" +
                        "</tr>";
         $("#buyer").append(buyerHtml);
           
         var receiverHtml = "<tr>" +
                              "<td>수령인</td>" +
                              "<td>" + firstElement.receiver + "</td>" +
                           "</tr>" +
                           "<tr>" +
                              "<td>연락처</td>" +
                              "<td>" + firstElement.receiver_phone + "</td>" +
                           "</tr>" +
                           "<tr>" +
                              "<td>배송지</td>" +
                              "<td>" + firstElement.address + "</td>" +
                           "</tr>" +
                           "<tr>" +
                              "<td>배송메모</td>" +
                              "<td>" + firstElement.d_message + "</td>" +
                           "</tr>";
         $("#receiver").append(receiverHtml);
         
         var receiptHtml = "<tr>" +
                              "<td>상품금액</td>" +
                              "<td>" + totalPrice.toLocaleString() + "원</td>" +
                           "</tr>" +
                           "<tr>" +
                              "<td>할인</td>" +
                              "<td>" + ((totalPrice + (totalPrice>50000? 0 : 4000)) - firstElement.totalamount).toLocaleString() + "원</td>" +
                           "</tr>" +
                           "<tr>" +
                              "<td>배송비</td>" +
                              "<td>" + (totalPrice>50000? 0 : 4000).toLocaleString() + "원</td>" +
                           "</tr>" +
                           "<tr>" +
                              "<td>총 주문금액</td>" +
                              "<td>" + firstElement.totalamount.toLocaleString() + "원</td>" +
                           "</tr>";
         $("#receipt").append(receiptHtml);
         
         
           // 새로운 탭을 표시합니다.
           $('#tab3-1').addClass('active show');
        },
        error : function(){
         alert("실패");           
        }
      });
   } 
   
   function openReviewFormWindow(orderDetailNumber) {
       // 새 창을 열기
       window.open("reviewRegister.jsp?orderDetailNumber="+orderDetailNumber, "reviewWindow", "menubar=no,toolbar=no,width=500,height=200");
   }
   function handleTabClick(num){
      $('#tab3-1').removeClass('active show');
      if(num==3){
         $('#tab3').addClass('active show');
      }
   }
   function odlist(){
      $('#tab3-1').removeClass('active show');
      $('#tab3').addClass('active show');
   }
   function refund(){
      if(confirm("환불하시겠습니까?")){
         $.ajax({
              url: "refund.orders?orders_id="+oid,
              type: "post", 
              success : function(data){
               if(data == "x"){
                  alert("이미 환불처리된 주문입니다.")
               }
               if(data == "o"){
                  alert("환불처리되었습니다.");                  
                  location.href="mypage.member?startDate=${pageInfo.startDate}&endDate=${pageInfo.endDate}&pageNumber=${pageInfo.pageNumber}&activeTab=3";
               }
              }
           });
      } else{
         alert("취소되었습니다.")
      }
       
   }
</script>

<div class="body">
    <div class="py-5 text-center">
      <a href = "view.main">
         <img class="d-block mx-auto mb-4" src="resources/img/logo.png" width="500" height="100">
      </a>
      <h2>마이페이지</h2>
    </div>
    
    <div class="d-flex justify-content-start mb-3" style="width: 70%; margin: auto;">
   <ul class="nav nav-tabs" role="tablist">
     <li class="nav-item" role="presentation">
       <a class="nav-link" data-bs-toggle="tab" href="#tab1" aria-selected="true" role="tab" onclick="handleTabClick()">내 정보</a>
     </li> 
     <li class="nav-item" role="presentation">
       <a class="nav-link" data-bs-toggle="tab" href="#cody" aria-selected="false" role="tab" tabindex="-1">내 코디</a>
     </li>
     <li class="nav-item" role="presentation">
       <a class="nav-link" data-bs-toggle="tab" href="#tab3" aria-selected="false" role="tab" tabindex="-1" onclick="handleTabClick('3')">구매 상품</a>
     </li>
     <li class="nav-item" role="presentation">
       <a class="nav-link" data-bs-toggle="tab" href="#coupon" aria-selected="false" role="tab" tabindex="-1" onclick="handleTabClick()">보유쿠폰</a>
     </li>
     <li class="nav-item" role="presentation">
       <a class="nav-link" data-bs-toggle="tab" href="#delete" aria-selected="false" role="tab" tabindex="-1" onclick="handleTabClick()">회원탈퇴</a>
     </li>
   </ul>
   </div>
   
   <div id="myTabContent" class="tab-content">
      <!-- 첫번째 탭 -->
      <div class="tab-pane fade active show" id="tab1" role="tabpanel">
         <div class="row">
            <form>
                 <table class="table" id="article-table">
                    <c:if test="${not empty loginInfo or not empty kakaoLoginInfo}">
                       <tr>
                         <th>프로필사진</th>
                         <td>
                             <c:choose>
                                 <c:when test="${not empty kakaoLoginInfo}">
                                    <c:choose>
                                         <c:when test="${not empty kakaoLoginInfo.member_image}">
                                             <img src="<%=request.getContextPath()%>/resources/memberImage/${kakaoLoginInfo.member_image}" width="100" height="100">
                                         </c:when>
                                         <c:otherwise>
                                             <div class="profile_photo">
                                                 <img id="imgThumb" src="https://static.nid.naver.com/images/web/user/default.png" width="100" height="100">
                                                 <span class="mask"></span>
                                             </div>
                                         </c:otherwise>
                                     </c:choose>
                                 </c:when>
                                 <c:when test="${not empty loginInfo}">
                                     <c:choose>
                                         <c:when test="${not empty loginInfo.member_image}">
                                             <img src="<%=request.getContextPath()%>/resources/memberImage/${loginInfo.member_image}" width="100" height="100">
                                         </c:when>
                                         <c:otherwise>
                                             <div class="profile_photo">
                                                 <img id="imgThumb" src="https://static.nid.naver.com/images/web/user/default.png" width="100" height="100">
                                                 <span class="mask"></span>
                                             </div>
                                         </c:otherwise>
                                     </c:choose>
                                 </c:when>
                             </c:choose>
                         </td>
                     </tr>
                       <tr>
                          <th>아이디</th>
                          <td>
                               <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    ${kakaoLoginInfo.member_id}
                                    <input type="hidden" name="member_id" value="${kakaoLoginInfo.member_id}">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    ${loginInfo.member_id}
                                    <input type="hidden" name="member_id" value="${loginInfo.member_id}">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>닉네임</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    ${kakaoLoginInfo.nickname}
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    ${loginInfo.nickname}
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                           <th>비밀번호</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    ${kakaoLoginInfo.password}
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    ${loginInfo.password}
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>이름</th>
                          <td>
                               <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    ${kakaoLoginInfo.name}
                                    <input type="hidden" name="name" value="${kakaoLoginInfo.name}">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    ${loginInfo.name}
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
                                ${kakaoLoginInfo.gender}
                              </c:when>
                              <c:when test="${not empty loginInfo}">
                                ${loginInfo.gender}
                              </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>도로명 주소</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    ${kakaoLoginInfo.address1}
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    ${loginInfo.address1}
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>상세주소</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    ${kakaoLoginInfo.address2}
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    ${loginInfo.address2}
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>휴대폰 번호</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    ${kakaoLoginInfo.phone}
                                    <input type="hidden" name="phone" value="${kakaoLoginInfo.phone}">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    ${loginInfo.phone}
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
                                    ${kakaoLoginInfo.email}
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    ${loginInfo.email}
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
                               ${kakaoBirth}
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    <c:set var="Birth" value="${fn:substring(loginInfo.birth, 0, 10)}" />
                               ${Birth}
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>키 (cm)</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    ${kakaoLoginInfo.height}cm
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    ${loginInfo.height}cm
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                       <tr>
                          <th>몸무게 (kg)</th>
                          <td>
                             <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    ${kakaoLoginInfo.weight}kg
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    ${loginInfo.weight}kg
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                    </c:if>
                    <tr>
                       <td colspan="2">
                         <input type="button" id="sub" class="btn btn-dark btn-md" value="수정하기" onclick="goUpdate()"/>
                         <input type="button" class="btn btn-dark btn-md" value="취소" onclick="goMain()">
                       </td>
                    </tr>
                 </table>
              </form>
          </div>  
      </div>
      
      <!-- 두번째 탭 -->
      <div class="tab-pane fade" id="cody" role="tabpanel">
            <!-- 스타일 컨테이너 -->
             <div class="d-flex flex-wrap" id="styleContainer">
                 <c:forEach var="styleBean" items="${styleList}">
                    <div class="card m-2 border-0" style="width:23%;">
                        <a href="detail.style?style_number=${styleBean.style_number}" class="link-dark link-underline-opacity-0">
                            <div class="card-body p-0">
                               <img src="<%=request.getContextPath()%>/resources/styleImage/${styleBean.image1}" style="height: 350px;" class="card-img-top" >
                               <div class="d-flex align-items-center">
                               <img src="<%=request.getContextPath()%>/resources/memberImage/${styleBean.member_image}" id="profile" style="width:3vw; height: 3vw; margin-top: 5px; border-radius: 100%; border: 1px solid #C0C0C0;">
                                &nbsp;${styleBean.nickname}
                                </div>
                                <p class="card-text" style="font-size: 10pt; margin-top: 5px;">${styleBean.content}</p>
                            </div>
                        </a>
                    </div>
                </c:forEach>
             </div>
      </div>
      
      <!-- 세번째 탭 -->
      <div class="tab-pane fade" id="tab3" role="tabpanel">
         <div class="row">
            <div style="margin-bottom: 20px; margin-top:30px;">
                <form action="mypage.member" method="get">
                   <input type="hidden" name="activeTab" value="3">
                    <label for="startDate">시작일:</label>
                    <input type="date" id="startDate" name="startDate">
                    
                    <label for="endDate">종료일:</label>
                    <input type="date" id="endDate" name="endDate">
                    
                    <button class="btn btn-dark btn-md" style="height: 35px" type="submit">필터</button>
                </form>
            </div>
            
            <table class="table">
               <thead>
                  <tr>
                     <th>
                        주문 날짜
                     </th>
                     <th>
                        주문   번호 
                     </th>
                     <th>
                        주문 상태 
                     </th>
                     <th>
                        결제 금액 
                     </th>
                     <th>
                        상세 
                     </th>
                  </tr>   
               </thead>
               <c:if test="${empty olists }">
                  <tbody>
                     <tr>
                        <td colspan="5">등록된 상품이 없습니다.</td>
                     </tr>
                   </tbody>
               </c:if>
               <tbody>
                  <c:forEach var="ob" items="${olists }">
                     <tr>
                        <td>
                           ${ob.orders_date }
                        </td>
                        <td>
                           ${ob.orders_id }
                        </td>
                        <td>
                           ${ob.status }
                        </td>
                        <td>
                           <fmt:formatNumber value="${ob.totalamount }" pattern="#,###" />원
                        </td>
                        <td>
                           <button class="btn btn-dark btn-md" onclick="orderdetail('${ob.orders_id }')">주문상세</button>
                        </td>
                     </tr>
                  </c:forEach>
               </tbody>
            </table>
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="d-flex justify-content-center">
                        ${pageInfo.pagingHtml}
                    </div>
                </div> 
            </div>
            
         </div>
      </div>
      <div class="tab-pane fade" id="tab3-1" role="tabpanel">
         <div class="row">
            <div style="">
                  <h3 style="padding: 22 0 22 0">주문내역</h3>
               </div>
            <table class="table" id="orderdetail">
               
            </table>
            <div style="">
               <h3 style="padding: 22 0 22 0">구매자 정보</h3>
            </div>
            <table class="table" id="buyer">
            </table>
            <div style="">
               <h3 style="padding: 22 0 22 0">구매자 정보</h3>
            </div>
            <table class="table" id="receiver">
            </table>
            <div style="">
               <h3 style="padding: 22 0 22 0">주문 금액 상세</h3>
            </div>
            <table class="table" id="receipt"> 
            </table>
            
            
            <div class="col-lg-12 text-center">
               <button class="btn btn-dark btn-md" type="button" onclick="odlist()" style="width: 100px;">
                  목록보기
               </button>
               <button class="btn btn-dark btn-md" type="button" onclick="refund()" style="width: 100px;">
                  환불하기
               </button>
            </div>
         </div>
      </div>
      
      
      
      
      <!-- 네번째 탭 -->
      <div class="tab-pane fade" id="coupon" role="tabpanel">
         <div class="row">
            <table class="table" id="article-table">
                    <tr>
                       <th>아이디</th>
                       <th>보유쿠폰</th>
                       <th>할인률</th>
                    </tr>
                 <c:if test="${not empty clist}">
                    <c:forEach var="coupon" items="${clist}">
                       <tr>
                           <td>
                              ${coupon.member_id}
                           </td>
                           <td>
                              ${coupon.coupon_name}
                           </td>
                           <td>
                              ${coupon.coupon_discount}
                           </td>
                       </tr>
                   </c:forEach>
                 </c:if>
                 <c:if test="${empty loginLists and empty kakaoLoginLists}">
                    <tr>
                       <td colspan="3" align="center">
                          사용가능한 쿠폰이 없습니다.
                       </td>
                    </tr>
                 </c:if>
              </table>
         </div>
      </div>
      
      <!-- 다섯번째 탭 -->
      <div class="tab-pane fade" id="delete" role="tabpanel">
         <div class="row">
              <table class="table" id="article-table">
                 <c:if test="${not empty loginInfo or not empty kakaoLoginInfo}">
                    <tr>
                      <th>아이디</th>
                          <td>
                               <c:choose>
                                <c:when test="${not empty kakaoLoginInfo}">
                                    ${kakaoLoginInfo.member_id}
                                    <input type="hidden" id="member_id" name="member_id" value="${kakaoLoginInfo.member_id}">
                                  </c:when>
                                  <c:when test="${not empty loginInfo}">
                                    ${loginInfo.member_id}
                                    <input type="hidden" id="member_id" name="member_id" value="${loginInfo.member_id}">
                                  </c:when>
                               </c:choose>
                          </td>
                       </tr>
                    <tr>
                        <th>휴대폰번호</th>
                       <td>
                       &nbsp;&nbsp;&nbsp;
                          <c:choose>
                             <c:when test="${not empty kakaoLoginInfo}">
                                ${kakaoLoginInfo.phone}
                                 <input type="hidden" id="phone" name="phone">
                               </c:when>
                               <c:when test="${not empty loginInfo}">
                                  ${loginInfo.phone}
                                 <input type="hidden" id="phone" name="phone">
                               </c:when>
                            </c:choose>
                           <input type = "button" id="phoneVerificationButton" value = "인증번호 요청" onclick = "sendSMS($('input[name=phone]').val())">
                       </td>
                    </tr>
                    <tr>
                       <th>휴대폰 인증</th>
                       <td>
                          <input type="text" id="verificationCode" name="verificationCode" size="7">&nbsp;
                          <input type="button" value="인증하기" onClick="verify()">
                       </td>
                    </tr>
                 </c:if>
                 <tr>
                  <td colspan="2">
                      <input type="button" id="sub" class="btn btn-dark btn-md" value="회원탈퇴" onclick="goDelete($('#member_id').val())"/>
                    <input type="button" class="btn btn-dark btn-md" value="취소" onclick="goMain()">
                  </td>
                </tr>
              </table>
           </div>
      </div>
   </div>
   
   <footer class="my-5 pt-5 text-body-secondary text-center text-small">
     <p class="mb-1">© 2023 Team, Clothes secretary</p>
   </footer>
</div>