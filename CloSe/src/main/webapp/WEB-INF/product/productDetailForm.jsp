<%@page import="member.model.MemberBean"%>
<%@page import="product.model.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ include file="../main/top.jsp"%>

<style type="text/css">
#preview {
   width: 100%;
}
.ptab {
   text-decoration: none;
   color: black;
   cursor: pointer;
}

.nav-item {
   cursor: pointer;
}
#totalP{
   border:none; 
   text-align:right;
}
#totalP:focus{
   outline:none;
}
.layer {
   display: none;
}
   #shopNav {
        font-size: 15pt;
        font-weight: 700;
        padding-top: 3px;
   }
.td {
   position: relative;
   box-sizing: border-box;
   border-top: 1px solid #f2f2f2;
   margin-left: 100px;
}

.d {
   width: 100%;
   heiht: 100%;
}

.total_price {
    color: #666;
    font-size: 14px;
     padding: 20px 0 8px; 
    text-align: right;
    box-sizing: border-box;
}

.total_cartAdd {
    color: #666;
    font-size: 14px;
    box-sizing: border-box;
}
.totals-value {
    font-size: 30px;
    color: #333;
    font-style: normal;
    font-weight: bold;
    padding-left: 12px;
    text-align: right;
}
.section-01,.section-02,.section-03,.section-04  { position: relative;
   margin-top: 50;
}

.fixed-menu { 
  position: fixed;
  left: 0;
  top: 142; 
  width: 100%;
  z-index: 1000;
  background-color: #fff; /* 배경색을 지정해주면 메뉴가 스크롤되는 내내 보일 것입니다. */
  box-shadow: 0px 1px 5px rgba(0, 0, 0, 0.1); /* 그림자 효과를 추가할 수 있습니다. */
}

fieldset {
        display: inline-block;
        direction: rtl;
        border:0;
}
#star {
        font-size: 1em;
        color: transparent;
        text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
} 
#gstar{
    font-size: 1em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
.off-screen {
   display: none;
}
#nav {
   width: 500px;
   text-align: center;
}
#nav a {
   display: inline-block;
   padding: 3px 5px;
   margin-right: 10px;
   font-family:Tahoma;
   background: #ccc;
   color: #000;
   text-decoration: none;
}
#nav a.active {
   background: #333;
   color: #fff;
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
</style>
<script type="text/javascript">
window.addEventListener('scroll', function() {
   var stickyTopHeight = document.getElementById('stop').offsetHeight;
    var floatingMenu = document.querySelector('.floating-menu');
    var fixedMenu = document.querySelector('.fixed-menu');
    var scrollPosition = window.scrollY;
    
    if (scrollPosition > 600) {
      floatingMenu.classList.add('fixed-menu');
    } else {
      floatingMenu.classList.remove('fixed-menu');
    }
}); //스크롤내렸을때

   function fnCalCount(type, size) {
        // size를 사용하여 적절한 선택자를 찾도록 수정
        var $input = $("input[name='" + size + "']");
        var tCount = Number($input.val());
        var max;
        if(size == "s_stock"){
           max = '${pb.s_stock}';
        }
        if(size == "m_stock"){
           max = '${pb.m_stock}';
        }
        if(size == "l_stock"){
           max = '${pb.l_stock}';
        }
        if(size == "xl_stock"){
           max = '${pb.xl_stock}';
        }
        if (type == 'p') {
            if (tCount < max) $input.val(Number(tCount) + 1);
        } else {
            if (tCount > 1) $input.val(Number(tCount) - 1);
        }
        updateTotalPrice(size, $input.val());
    }
   function deleteProduct(pnum){
	   if(confirm("품절처리하시겠습니까?")){
      	location.href="delete.product?product_number="+pnum;
	   }
   }
   function updateProduct(pnum){
      location.href="update.product?product_number="+pnum;
   }
   
   
   
   
   function addToCart(){
      var formData = $("#buyForm").serialize();
        $.ajax({
            type: "POST", // or "GET" depending on your server-side implementation
            url: "cartAdd.cart", // Specify the URL to your server-side endpoint
            async : false,
            data: formData,
            success: function(response) {
               if(response == "o"){
                   var addToCart = confirm("상품을 장바구니에 추가했습니다. 장바구니로 이동하시겠습니까?");
                  
                  if (addToCart) {
                       location.href = "cartAdd.cart";
                  } else{
                     return;
                  }
               }
               if(response == "x"){
                  alert("이미 장바구니에 있는 상품입니다.");
               }
            }
        });
   }
   <% 
    MemberBean mb = (MemberBean)session.getAttribute("loginInfo");
    MemberBean mb1 = (MemberBean)session.getAttribute("kakaoLoginInfo");

    String memberid = null;

    if (mb != null) {
        memberid = mb.getMember_id();
    } else if (mb1 != null) {
        memberid = mb1.getMember_id();
    }
   %>
   
   //=======
   function reviewList(pageNum){
      if(pageNum)
      $("#review").html("");
      $.ajax({
            url: "list.review?product_number=${pb.product_number }&start="+pagingUtil.getStartOffset(pageNum,1)+"&end=5", 
            type: "post", 
            contentType: "application/json; charset=utf8",
            success: function(data) {
               if (data.rlists.length === 0) { 
                  
                  pageNum = pageNum-1;
                  // 데이터가 비어있을 경우 메시지를 표시하는 HTML을 생성
                  var noReviewHtml = "<tr>";
                  noReviewHtml += "<td align='center' height='200px;'>등록된 리뷰가 없습니다.</td>";
                  noReviewHtml += "</tr>";
               
                  
                  
                  // 생성한 메시지를 화면에 추가
                  $("#review").append(noReviewHtml);
              } else {
                  $(data.rlists).each(function () {
                     // 각 리뷰에 대한 정보를 가져와서 HTML로 구성
                     
                       var reviewHtml = "<tr>";
                       reviewHtml += "<td>";
                       reviewHtml += "<fieldset>";
                       
                       // 별점 출력
                       for (var i = 1; i <= 5; i++) {
                           if (i <= 5 - this.rating) {
                               reviewHtml += "<label id='gstar'>★</label>";
                           } else {
                               reviewHtml += "<label id='star'>★</label>";
                           }
                       }
                       
                       reviewHtml += "</fieldset>";
                       reviewHtml += "</td>";
                       reviewHtml += "<td> | " + this.write_date + "</td>";
                       reviewHtml += "<td> | " + this.member_id + "</td>";
                       reviewHtml += "</tr>";
                       reviewHtml += "<tr>";
                       reviewHtml += "<td><b>선택한 옵션: " + this.product_size + "</b></td>";
                       reviewHtml += "<td colspan='2' style='text-align:right;'>";
                       if('<%= memberid %>' == this.member_id){
                       reviewHtml += "<a class='ptab' href='javascript:deleteReview("+this.review_number+")'>X</a>";
                       }
                       reviewHtml += "</td>";
                       reviewHtml += "</tr>";
                       reviewHtml += "<tr style='border-bottom: 0.5px solid rgba(0, 0, 0, .1);'>";
                       reviewHtml += "<td>" + this.text + "</td>";
                       reviewHtml += "</tr>";
                  
                       $("#review").append(reviewHtml);
                       document.getElementById("pagination").innerHTML = pagingUtil.pagingView(pageNum, "5", data.totalCount, "reviewList");
                       
                  });
               }
            }//success
            
        });
   }
   
   function deleteReview(review_number){
      if(confirm("정말로 삭제하시겠습니까?")){
         $.ajax({
               url: "delete.review?review_number=1", 
               type: "post", 
               success: function(data) { 
                  if(data == 1){
                     alert("리뷰가 삭제되었습니다.");
                  } 
                     reviewList(1);
               }
         }); 
      }      
   }
   //============================================
    var pagingUtil = {
       pagingView: function (currentPageNo, pageSize, totalCount, targetFunction) {
           var pageNo = parseInt(currentPageNo); // 현재 페이지 번호
           var countPage = 10; // 한 화면에 출력될 페이징 개수.
           var finalPageNo = parseInt(totalCount / pageSize);  //마지막 페이지 번호
           var strPaging = "";
           var targetFunction = (targetFunction == null || targetFunction == "") ? "goPage" : targetFunction;
           
           if (totalCount % pageSize > 0) {
               finalPageNo++;
           }
   
           if (finalPageNo < pageNo) {
               pageNo = finalPageNo;
           }
   
           var startPage = Math.floor(((pageNo - 1) / countPage)) * countPage + 1;
           var endPage = startPage + countPage - 1;
   
           if (startPage <= 0) {
               startPage = 1;
           }
           if (endPage > finalPageNo) {
               endPage = finalPageNo;
           }
         if(finalPageNo<pageNo){
            pageNo = finalPageNo;
         }
           //strPaging ="<ul class='paginate'>";
           if (pageNo > 1) {
               // strPaging += "<a href=\"javascript:"+targetFunction+"(1);\">처음으로</a>";
               strPaging += "<li class='page-item'><a href=\"javascript:" + targetFunction + "(" + (pageNo - 1) + "); \" class='page-link'><</a></li>";
           }
   
           for (var iCount = startPage; iCount <= endPage; iCount++) {
               if (iCount == pageNo) {
                   strPaging += "<li class='page-item active'><a href='javascript:void(0);' class='page-link'><strong>" + iCount + "</strong></a></li>";
               } else {
                   strPaging += "<li class='page-item'><a href=\"javascript:" + targetFunction + "(" + iCount + ");\" class='page-link'>" + iCount + "</a></li>";
               }
           }
   
           if (pageNo < finalPageNo) {
               strPaging += "<li class='page-item'><a href=\"javascript:" + targetFunction + "(" + (pageNo + 1) + ");\" class='page-link'>></a></li>";
               //strPaging += "<a href=\"javascript:"+targetFunction+"("+finalPageNo+"); \" class='next'>다음페이지</a>";
           }
           //strPaging +="</ul>";
   
           return strPaging;
       }
       //게시글의 시작 인덱스번호
       , getStartOffset: function (currentPageNo, pageSize) {
           //      return ((currentPageNo -1) * pageSize) + 1;
           return (currentPageNo - 1) * pageSize;
       }
   
       //게시글의 끝 인덱스번호
       , getEndOffset: function (currentPageNo, pageSize) {
           return currentPageNo * pageSize;
       }
   
       //마지막 페이지 번호
       , getfinalPageNo: function (totalCount, pageSize) {
           var finalPageNo = parseInt(totalCount / pageSize);
           if (totalCount % pageSize > 0) {
               finalPageNo++;
           }
           return finalPageNo;
       }
   }
   //=====페이지끝
   
   
   $(document).ready(function() {
      reviewList(1);//reviewList가져오는 함수
      
      $('#insertBasket').click(function () {
         <c:if test="${empty loginInfo and empty kakaoLoginInfo}">
            alert("로그인이 필요한 서비스입니다.");
            window.location.href = 'login.member';
            return;
         </c:if>
         if ($('.quantity-selection').length === 0) {
               alert("사이즈를 선택해주세요.");
               return;
           }
         addToCart();
      });
      
      
      $('#goodsOrder').click(function () { 
         <c:if test="${empty loginInfo and empty kakaoLoginInfo}">
            alert("로그인이 필요한 서비스입니다.");
            window.location.href = 'login.member';
            return;
         </c:if>
           if ($('.quantity-selection').length === 0) {
               alert("사이즈를 선택해주세요.");
                  return;
           }
           $("#buyForm").attr("action", "details2.orders");
           $("#buyForm").submit();
      });
      
      $('select[name="size"]').change(function() {
           // 선택된 사이즈 값을 가져옵니다.
           var selectedSize = $(this).val();
           var selectedSizeText = $(this).find('option:selected').text();
           var sST = selectedSizeText.split(' ');
           
           // 유효한 사이즈가 선택된 경우
           if (selectedSize !== "") {
               // 동적으로 수량 선택 버튼을 생성합니다.
               if (!$('.quantity-selection[data-size="' + selectedSize + '"]').length) {
                // 동적으로 수량 선택 버튼을 생성합니다.
                var quantitySelection = '<div class="quantity-selection" data-size="' + selectedSize + '">';
                quantitySelection += '<span>' + sST[0] + '</span>';
                quantitySelection += '<button type="button" onclick="fnCalCount(\'m\', \'' + selectedSize + '\')">-</button>';
                quantitySelection += '<input type="text" name='+selectedSize+' class="sq" size="2" value="1" readonly style="text-align:right;"/>';
                quantitySelection += '<button type="button" onclick="fnCalCount(\'p\', \'' + selectedSize + '\')">+</button>';
                var totalPrice = ${pb.price} * 1;
                quantitySelection += '<span class="total-price">' + totalPrice.toLocaleString() + '</span>원';
                quantitySelection += '<button type="button" class="remove-button" onclick="removeQuantitySelection(this)">X</button>';
                quantitySelection += '</div>';

               // 생성한 수량 선택 버튼을 컨테이너에 추가합니다.
               $('.selSize').append(quantitySelection);
               }
           }
           
           $("#selsize option:eq(0)").prop("selected", true);
           
           
           var totalSum = 0;
          $('.quantity-selection .total-price').each(function () {
              totalSum += Number($(this).text().replace(/,/g,""));
          });

          $('#cart-total').html(totalSum.toLocaleString());
          
       });
      
      //=-===================메뉴바========================
       var $menu     = $('.floating-menu li.m'),
           $contents = $('.scroll'),
           $doc      = $('html, body');
       $(function () {
           // 해당 섹션으로 스크롤 이동
           $menu.on('click','a', function(e){
               var $target = $(this).parent(),
                   idx     = $target.index(),
                   section = $contents.eq(idx),
                   offsetTop = section.offset().top-200;
               $doc.stop()
                       .animate({
                           scrollTop :offsetTop
                       }, 1);
               return false;
           });
       });

       // menu class 추가
       $(window).scroll(function(){
           var scltop = $(window).scrollTop();
           $.each($contents, function(idx, item){
               var $target   = $contents.eq(idx),
                   i         = $target.index(),
                   targetTop = $target.offset().top;

               if (targetTop <= scltop) {
                   $menu.removeClass('on');
                   $menu.eq(idx).addClass('on');
               }
               if (!(200 <= scltop)) {
                   $menu.removeClass('on');
               }
           })

       });
       
   }); //document function 끝
       
       
      function removeQuantitySelection(button) { //사이즈별 수량 선택란 제거
          $(button).closest('.quantity-selection').remove();
          var totalSum = 0;
          $('.quantity-selection .total-price').each(function () {
              totalSum += Number($(this).text().replace(/,/g,""));
          });

          $('#cart-total').html(totalSum.toLocaleString());
      }
      function updateTotalPrice(selectedSize, quantity) {
          var productPrice = ${pb.price};
          var totalPrice = productPrice * quantity;
          $('.quantity-selection[data-size="' + selectedSize + '"] .total-price').text(totalPrice.toLocaleString());
          
          var totalSum = 0;
          $('.quantity-selection .total-price').each(function () {
              totalSum += Number($(this).text().replace(/,/g,""));
          });

          $('#cart-total').html(totalSum.toLocaleString());
      }
</script>

<div class="body">


   <div class="row">
      <div class="col-lg-2"></div>
      <div class="col-lg-8">
            <form method="post" id="buyForm">
               <input type="hidden" name="product_number" value="${pb.product_number }"> 
               <div class="row">
                  <div class="col-lg-1"></div>
                  <div class="col-lg-10 row">
                  
      <div style="display: flex; justify-content: space-between; align-items: center;">

          <!-- Left side with the image and product information -->
       <div style="flex: 1; margin-right: 20px;">
           <img id="preview" style="width: 300px;" src='<%=request.getContextPath()%>/resources/productImage/${pb.image }' />
      </div>

      <div style="flex: 1;">
         <table border="0">
            <tr>
               <td>
                  <span
                  style="background-color: #ff80bf; line-height: 27px; border-radius: 10px;"><font
                  color="#ffffff" size="2">${pb.smallcategory_name }</font></span>
               </td>
            </tr>

            <tr>
               <td id="goodsName"><font size="5"
                  style="box-sizing: border-box; position: relative;">${fn:substringAfter(pb.product_name,'/') }</font>
               </td>
            </tr>

            <tr>
               <td><font size="3">브랜드 : ${fn:substringBefore(pb.product_name,'/') }</font></td>
            </tr>

            <tr>
               <td></td>
            </tr>

            <tr>
               <td id="price"
                  style="font-weight: 600px; font-Size: 24px; line-height: 42px;">
                  <fmt:formatNumber value="${pb.price }" pattern="#,###" />원
               </td>
            </tr>
         </table>

         <table>
            <tr>
               <td>
                  <hr style="border-top: 1px solid #bbb;" width=500px>
               <td>
            </tr>
         </table>

         <br>

         <table>
            <tr class="option_section">
               <td width="100px"><font size="3">배송비</font></td>
               <td><font size="3">선불4,000원(50,000원 이상 무료배송)</font></td>
            </tr>
         </table>

         <table>
            <tr class="option_section">
               <td width="100px"><font size="3">배송종류</font></td>
               <td><font size="3">국내배송</font></td>
            </tr>
         </table>

         <br>
         <br>

         <div id="item_option">
            <table>
               <tr>
                  <td>
                  <select id="selsize" name="size" <c:if test="${loginInfo.member_id == 'admin'}">disabled</c:if>>
                     <option value="">옵션선택</option>
                     <option value="s_stock"
                        <c:if test="${pb.s_stock == 0}"> disabled </c:if>>
                        S
                        <c:if test="${pb.s_stock == 0}">(품절)</c:if><c:if
                           test="${1<=pb.s_stock and 5>=pb.s_stock}"> [${pb.s_stock }개 남음]</c:if>
                     </option>
                     <option value="m_stock"
                        <c:if test="${pb.m_stock == 0}"> disabled </c:if>>
                        M
                        <c:if test="${pb.m_stock == 0}">(품절)</c:if><c:if
                           test="${1<=pb.m_stock and 5>=pb.m_stock}"> [${pb.m_stock }개 남음]</c:if>
                     </option>
                     <option value="l_stock"
                        <c:if test="${pb.l_stock == 0}"> disabled </c:if>>
                        L
                        <c:if test="${pb.l_stock == 0}">(품절)</c:if><c:if
                           test="${1<=pb.l_stock and 5>=pb.l_stock}"> [${pb.l_stock }개 남음]</c:if>
                     </option>
                     <option value="xl_stock"
                        <c:if test="${pb.xl_stock == 0}"> disabled </c:if>>
                        XL
                        <c:if test="${pb.xl_stock == 0}">(품절)</c:if><c:if
                           test="${1<=pb.xl_stock and 5>=pb.xl_stock}"> [${pb.xl_stock }개 남음]</c:if>
                     </option>
                  </select>
                  <div class="selSize">
                     <!-- 수량선택 -->
                  </div>
                  </td>
               </tr>

               <tr>
                  <td></td>
               </tr>
            </table>
         </div>

         <div class="totals-item totals-item-total" style="float:left; margin-left:200px;">
               <label class="total_price">총상품금액</label>&nbsp;&nbsp;
               <div class="total_price" style="float:right;">원</div>
               <div class="totals-value" id="cart-total" style="float:right;">0</div>
             </div>
         <br><br> 
         
         <table>
            <tr>
               <td><hr style="border-top: 1px solid #bbb;" width=500px>
               <td>
            </tr>
         </table>
         <c:choose>
             <c:when test="${loginInfo.member_id == 'admin'}">
                 <button type="button" style="width: 150px; margin-left: 100px; height: 40px;"
                         class="btn btn-dark" onclick="updateProduct('${pb.product_number}')">수정하기</button>
                 <button type="button" style="width: 150px; height: 40px;"
                         class="btn btn-dark" onclick="deleteProduct('${pb.product_number}')">품절처리</button>
             </c:when>
             <c:otherwise>
                 <button type="button" style="width: 150px; margin-left: 100px; height: 40px;"
                         class="btn btn-dark" id="insertBasket">장바구니</button>
                 <button type="button" style="width: 150px; height: 40px;"
                         class="btn btn-dark" id="goodsOrder">구매하기</button>
             </c:otherwise>
         </c:choose>
      </div>
   </div>
                  </div> 
               </div>
            </form>


            <div> <!-- 메뉴바 -->
               <div class="floating-menu" style="text-align: center;">
                  <ul class="nav nav-tabs" role="tablist" style="width: 100%">
                    <li class="nav-item m" role="presentation" style="width: 25%">
                      <a class="nav-link menu-01 active" data-bs-toggle="tab" href="#section-01" aria-selected="true" role="tab">상품상세</a>
                    </li>
                    <li class="nav-item m" role="presentation" style="width: 25%">
                      <a class="nav-link menu-02" data-bs-toggle="tab" href="#section-02" aria-selected="false" role="tab" tabindex="-1">상품리뷰</a>
                    </li>
                    <li class="nav-item m" role="presentation" style="width: 25%">
                      <a class="nav-link menu-03" data-bs-toggle="tab" href="#section-03" aria-selected="false" role="tab" tabindex="-1">코디</a>
                    </li>
                    <li class="nav-item m" role="presentation" style="width: 25%">
                      <a class="nav-link menu-04" data-bs-toggle="tab" href="#section-04" aria-selected="false" role="tab" tabindex="-1">쇼핑가이드</a>
                    </li>
                  </ul>
                  
               </div>
            </div>

   <div style="margin-top: 30px">
      <div class="section-01 scroll">
           <h2>상품상세</h2>
           <hr>
           <div style="width: 800; margin:auto;">
              <img id="preview" width="100%"
                  src='<c:url value='/resources/productImage/'/>${pb.content }' />
           </div>
       </div>
   
       <div class="section-02 scroll">
           <h2>상품리뷰</h2>
           <hr>
           
           
           <table id="review" width="100%" style="border-collapse: collapse;">
              <tbody>
              <c:if test="${empty rlists }">
                 <tr>
                    <td align="center" height="200px;">등록된 리뷰이 없습니다.</td>
                 </tr>
              </c:if>
            </tbody>
           </table>
           <div class="col-lg-12 text-center">
              <div class="d-flex justify-content-center">
                <nav>
                    <ul class="pagination" id="pagination"></ul>
                </nav>
             </div>
         </div>
           
           
           
           <%-- ${pageInfo.pagingHtml } --%>
       </div>
   
       <div class="section-03 scroll">
          <h2>
             코디
            <font size="2" style="float: right; margin-top:20;">
               <a href="mainView.style" class="ptab">전체보기</a>
            </font>     
          </h2> 
          <hr>
          <table width="100%">
             <tr>
                <c:if test="${empty slists}">
                      <td align='center' height='200px;'>해당 제품의 코디가 없습니다.</td>
                </c:if>
                <c:forEach var="sb" items="${slists}" begin="0" end="4">
                   <td width="200" style="padding: 20">
                      <a href="detail.style?style_number=${sb.style_number }" class="link-dark link-underline-opacity-0">
                         <img src="<%=request.getContextPath()%>/resources/styleImage/${sb.image1}" width="100%">
                         <b>${sb.title}</b><br>
                        ${sb.style}                         
                      </a>
                   </td>
                </c:forEach>
             </tr>
             <tr><td></td><td></td><td></td><td></td><td></td></tr>
          </table>
       </div>
       
       
       <div class="section-04 scroll">
          <div>
              <h5 style="margin-top: 60;">주문안내</h5><!-- https://liemar.co.kr/product/detail.html?product_no=137&gclid=CjwKCAiAs6-sBhBmEiwA1Nl8szjl1bAD1VYuX8dSnj9VaZ94a3YwNjg3ne4DFAIaVxJPZLzA-Y4iPhoCgqAQAvD_BwE#tab02 --> 
              <hr>
              <span>상품주문은 다음단계로 이루어집니다.</span>
              <ul>
                 <li>Step1:회원 로그인 후 장바구니에 상품 담기</li>
                 <li>Step2:주문서 작성</li>
                 <li>Step3:결제방법선택 및 결제</li>
                 <li>Step4:주문 성공 화면(주문번호)</li>
              </ul>
              <h5 style="margin-top: 60;">배송안내</h5><!-- https://liemar.co.kr/product/detail.html?product_no=137&gclid=CjwKCAiAs6-sBhBmEiwA1Nl8szjl1bAD1VYuX8dSnj9VaZ94a3YwNjg3ne4DFAIaVxJPZLzA-Y4iPhoCgqAQAvD_BwE#tab02 --> 
              <hr>
              <ul style="list-style-type: none;">
                 <li>배송 방법:택배</li>
                 <li>배송 지역:전국지역</li>
                 <li>배송 비용:선불4,000원(50,000원 이상 무료배송)</li>
                 <li>배송 기간:1일~3일</li>
              </ul>
              <span>고객님께서 주문하신 사움은 입금 확인 후 배송해 드립니다. 다만, 상품 종류에 따라서 상품의 배송이 다소 지연될 수 있습니다.</span>
              <h5 style="margin-top: 60;">환불안내</h5><!-- https://liemar.co.kr/product/detail.html?product_no=137&gclid=CjwKCAiAs6-sBhBmEiwA1Nl8szjl1bAD1VYuX8dSnj9VaZ94a3YwNjg3ne4DFAIaVxJPZLzA-Y4iPhoCgqAQAvD_BwE#tab02 --> 
              <hr>
              <span>
                 환불시 반품 확인여부를 확인한 후 3영업일 이내에 결제 금액을 환불해 드립니다.
               신용카드로 결제하신 경우는 신용카드 승인을 취소하여 결제 대금이 청구되지 않게 합니다.
            </span>
           </div>
       </div>
   </div>

</div>




   </div>
</div>

<%@ include file="../main/bottom.jsp"%>