<%@page import="product.model.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file= "../main/top.jsp" %>

<style type="text/css">
   #mainNav {
          font-size: 15pt;
          font-weight: 700;
          padding-top: 3px;
      }
   .body {
      width: 100%;
      overflow-x: hidden;
      margin: auto;
      overflow-x: hidden;
   }

   #carouselExampleAutoplaying {
      max-width: 66%;
      /* 최대 너비 설정 */
      margin: auto;
      /* 가운데 정렬 */
   }
   
   .custom-height{
         height:  171px;
   }
   .ptab {
      text-decoration: none;
      color: black;
   }
</style>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">
window.navigator.geolocation.getCurrentPosition(function(pos) {
    var latitude = pos.coords.latitude;
    var longitude = pos.coords.longitude;
    
    $.ajax({
      type: 'POST',
      url: 'view.style',
      data: {latitude: latitude, longitude: longitude}
  });
});

   $(document).ready(function () {
      var bsComponent = $(".bs-component");
      var initialPosition = bsComponent.offset().top;

      $(window).scroll(function () {
         var scrollPosition = $(window).scrollTop();
         var windowHeight = window.innerHeight;
         var elementHeight = bsComponent.outerHeight();

         // 스크롤이 일정 위치를 넘어가면 더 이상 조절하지 않음
         var newPosition = (windowHeight - elementHeight) / 2 + scrollPosition - initialPosition;

         console.log("scrollPosition:", scrollPosition);
         console.log("windowHeight:", windowHeight);
         console.log("elementHeight:", elementHeight);
         console.log("newPosition:", newPosition);

         // 새로운 top 위치를 부드러운 애니메이션으로 적용

   $.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=27f0e2dcc40e953d16644b55e897423d&units=metric',
           function (result) {
               var openWeatherTemperature = result.main.temp;
               
               $("#close").click(function(){
                  alert("click");
                  
                  $.ajax({
                     url: "/view.close",
                     type: "get",
                     data: {openWeatherTemperature:result.main.temp},
                     success:function(data){
                        alert("성공");
                     },
                     error:function(){
                        alert("실패");
                     }
                  });
               });
               
               var $ctemp = result.main.temp;
               $('#ctemp').text(openWeatherTemperature + '°C');
               var wiconUrl = '<img src="http://openweathermap.org/img/wn/' + result.weather[0].icon + '.png" alt="' + result.weather[0].description + '">';
               $('#icon').html(wiconUrl);
               $('#feel').text(result.main.feels_like + '°C');
               $('#description').text(result.weather[0].description);

               var ct = result.dt;

               function convertTime(ct) {
                   var ot = new Date(ct * 1000);
                   var year = ot.getFullYear();
                   var month = ot.getMonth() + 1;
                   var dt = ot.getDate();

                   return year + '년 ' + month + '월 ' + dt + '일 ';
               }

               var currentTime = convertTime(ct);
               $('.time').text(currentTime);
           });
         bsComponent.stop().animate({"margin-top": newPosition + "px"}, 700);
       });
     });
   
       function orderdetails(member_id){
          location.href="list.orders";
     }
   
       function productList(bigcate){
          location.href="list.product?bigcategory_name="+bigcate;
       }
</script>

<div class="body">

   <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
      <div class="carousel-inner">
         <div class="carousel-item active">
            <img src="resources/img/logo.png"
               class="d-block w-100 custom-height" alt="...">
         </div>
         <div class="carousel-item">
            <img src="resources/img/couponBanner.png"
               class="d-block w-100 custom-height" alt="...">
         </div>
         <div class="carousel-item">
            <img src="resources/img/serviceBanner.png"
               class="d-block w-100 custom-height" alt="...">
         </div>
         <div class="carousel-item">
            <img src="resources/img/serviceBanner2.png"
               class="d-block w-100 custom-height" alt="...">
         </div>
      </div>
      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying"
         data-bs-slide="prev">
         <span class="carousel-control-prev-icon" aria-hidden="true"></span>
         <span class="visually-hidden">Previous</span>
      </button>
      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying"
         data-bs-slide="next">
         <span class="carousel-control-next-icon" aria-hidden="true"></span>
         <span class="visually-hidden">Next</span>
      </button>
   </div>

   <div class="row">
      <div class="col-lg-2"></div>
      <div class="col-lg-8">
         <div class="album py-5">
            <div class="container">
               <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">

              <a href="view.style" class="link-dark link-underline-opacity-0">
                     <div class="col" align="center">
                        <img class="bd-placeholder-img card-img-top" width="100%" height="150"
                              style="border-radius: 20%;" id="par" src="resources/img/close.png">
                        오늘의 옷비서
                     </div>
                  </a>

              <a href="#" class="link-dark link-underline-opacity-0">
                     <div class="col" align="center">
                        <img class="bd-placeholder-img card-img-top" src="resources/img/man.png" width="100%" height="150"
                              style="border-radius: 20%;">
                        남자 코디
                     </div>
                  </a>

              <a href="#" class="link-dark link-underline-opacity-0">
                     <div class="col" align="center">
                        <img class="bd-placeholder-img card-img-top" src="resources/img/woman.png" width="100%" height="150"
                              style="border-radius: 20%;">
                        여자 코디
                     </div>
                  </a>

              <a href="#" class="link-dark link-underline-opacity-0">
                     <div class="col" align="center">
                        <img class="bd-placeholder-img card-img-top" src="resources/img/cou.png" width="100%" height="150"
                              style="border-radius: 20%;">
                        쿠폰
                     </div>
                  </a>

              <a href="#" class="link-dark link-underline-opacity-0">
                     <div class="col" align="center">
                        <img class="bd-placeholder-img card-img-top" src="resources/img/outer.avif" width="100%" height="150"
                              style="border-radius: 20%;" onclick="productList('아우터')">
                        아우터
                     </div>
                  </a>
               
              <a href="#" class="link-dark link-underline-opacity-0">
                     <div class="col" align="center">
                        <img class="bd-placeholder-img card-img-top" src="resources/img/top.png" width="100%" height="150"
                              style="border-radius: 20%;" onclick="productList('상의')">
                        상의
                     </div>
                  </a>
                  
              <a href="#" class="link-dark link-underline-opacity-0">
                     <div class="col" align="center">
                        <img class="bd-placeholder-img card-img-top" src="resources/img/bottom.png" width="100%" height="150"
                              style="border-radius: 20%;" onclick="productList('하의')">
                        하의
                     </div>
                  </a>
                  
              <a href="#" class="link-dark link-underline-opacity-0">
                     <div class="col" align="center">
                        <img class="bd-placeholder-img card-img-top" src="resources/img/shoes.png" width="100%" height="150"
                              style="border-radius: 20%;" onclick="productList('신발')">
                        신발
                     </div>
                  </a>

               </div>
            </div>
         </div>

         <br>
         <hr>
         <br>

         <div>
            Most Popular <br>
            <h4>인기 상품
               <font size="2" style="float: right; margin-top:20;">
               <a href="list.product?sort=sale" class="ptab">전체보기</a>
            </font>
            </h4>
             <br>
         </div>
         <div class="album py-5">
            <div class="container">
               <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">

                  <c:forEach var="pb" items="${plists }" begin="1" end="4">
                     <div class="col">
                     <div class="card shadow-sm">
                        <a href="detail.product?product_number=${pb.product_number }"><img class="bd-placeholder-img card-img-top" 
                        src="<%=request.getContextPath()%>/resources/productImage/${pb.image}" height="100%"></a>
                        <b>${fn:substringBefore(pb.product_name,'/') }</b>  
                        ${fn:substringAfter(pb.product_name,'/') }<br>
                        <b><fmt:formatNumber value="${pb.price }" pattern="#,###" />원</b>
                     </div>
                     </div>
                  </c:forEach> 
               </div>
            </div>
         </div>

         <br>
         <hr>
         <br>

         <div>
            Style <br>
            <h4>코디 모음
               <font size="2" style="float: right; margin-top:20;">
               <a href="mainView.style" class="ptab">전체보기</a>
            </font>
         </h4> 
         </div>
         <div class="album py-5">
            <div class="container">
               <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
               <c:forEach var="mainStyleBean" items="${mainStyleList}">
               <div class="card m-2 border-0" style="width:23%;">
               <c:if test="${not empty mainStyleBean.image2}"> 
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#C0C0C0" class="bi bi-images" id="imageMulti" viewBox="0 0 16 16">
                    <path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3"/>
                    <path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2M14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1M2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10"/>
                </svg>
             </c:if>
             <a href="detail.style?style_number=${mainStyleBean.style_number}" class="link-dark link-underline-opacity-0">
                 <div class="card-body p-0">
                     <img src="<%=request.getContextPath()%>/resources/styleImage/${mainStyleBean.image1}" style="max-height: 320px;" class="card-img-top">
                     <div class="d-flex align-items-center">
                         <img src="<%=request.getContextPath()%>/resources/memberImage/${mainStyleBean.member_image}" id="profile" style="width:2vw; height: 2vw; margin-top: 5px; border-radius: 100%; border: 0.5px solid #C0C0C0;">
                         &nbsp; ${mainStyleBean.nickname}
                     </div>
                      <p class="card-text" style="font-size: 10pt; margin-top: 5px;">${mainStyleBean.title}</p>
                 </div>
             </a>
         </div>
         </c:forEach>
         </div>
            </div>
         </div>
      </div>
      

      <div class="col-lg-2 mt-3 px-4">
         <div class="bs-component">
            <div class="card mb-3">
               <h3 class="card-header" align="center">오늘의 날씨</h3>
               <div class="card-body">
                  <h5 class="card-title time">Special title treatment</h5>
                  <p class="card-text">현재 온도 : <span id="ctemp"></span></p>
                  <p class="card-text">체감 온도 : <span id="feel"></span></p>
                  <p class="card-text">날씨 : <span id="icon"></span></p>
               </div>
            </div>
         </div>
      </div>
      
   </div>

 </div> 


<%@ include file="../main/bottom.jsp" %>