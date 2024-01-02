<%@page import="product.model.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ include file="../main/top.jsp"%>

<style type="text/css">
   .body {
      width: 75%;
      margin: auto;
   }
   .a {
      text-align: center;
   }
   
   .b {
      text-align: center;
      margin-bottom: 10px;
   }
   
   .bg-body-white {
      text-align: center;
   }
   
   .empty {
      width: 150px;
      height: 150px;
      margin-top: 50px;
   }
   .name {
      text-align: left;
      margin-top: 2em;
   }
   #procheck {
      margin-top: 65px;
   }
   #aaa {
      width: 110%;
   }
   
   #ddd {
      display: inline;
      float: right;
   }
   input[type="checkbox"] {
       accent-color: black;
   }
   .pd{
      text-decoration: none;
      color: black;
   }
</style>
<script type="text/javascript">
   <c:if test='${not empty qtycheck and qtycheck}'>
       alert("재고수량을 초과했습니다.");
   </c:if>


   function checkAllOnLoad() {
       var allCheckbox = document.getElementById("bbb");
       allCheckbox.checked = true; // 전체 선택 체크박스를 선택 상태로 만듭니다.
       allCheck(allCheckbox); // 모든 체크박스를 선택 상태로 만드는 함수 호출
   }
   window.addEventListener('load', checkAllOnLoad);
   
   
   function updateTotalPrice() { //checkbox를 선택, 해제했을 때 전체적인 금액부분 변경
        var selectedValues = getSelectedValues();
        var totalPrice = 0;

        <c:forEach var="cib" items="${cartInfoLists}">
            if (selectedValues.includes('${cib.cart_number}')) {
                totalPrice += ${cib.price * cib.qty};
            }
        </c:forEach>

        var allCheckbox = document.getElementById("bbb");
        var allCheckStatus = selectedValues.length === document.getElementsByName("rowcheck").length;
        allCheckbox.checked = allCheckStatus;
        
        document.getElementById('totalPrice').innerText = totalPrice.toLocaleString(); // 여기서 변경
        
        var deliveryElement = document.getElementById('delivery');
        var deliveryPriceElement = document.getElementById('deliveryPrice');
        var delivery = 0;
        
        if (selectedValues.length > 0) { //배송비계산
            if (totalPrice > 50000) {
               delivery ='0';
                deliveryElement.innerText = '0'; 
                deliveryPriceElement.innerText = '0'; 
            } else {
               delivery ='4000';
                deliveryElement.innerText = '4,000'; 
                deliveryPriceElement.innerText = '4,000'; 
            }
        } else {
            deliveryElement.innerText = '0';
            deliveryPriceElement.innerText = '0';
        }
        
        document.getElementById('total').innerText = (Number(totalPrice) + Number(delivery)).toLocaleString();
    }
   
   function allCheck(all) { //전체체크박스를 눌렀을때
      rcheck = document.getElementsByName("rowcheck");
      acheck = all.checked;

      if (acheck) {
         for (i = 0; i < rcheck.length; i++) {
            rcheck[i].checked = true;
         }
      } else {
         for (i = 0; i < rcheck.length; i++) {
            rcheck[i].checked = false;
         }
      }
      updateTotalPrice();
   } // allCheck

   function fnCalCount(type, cindex) { //수량 + - 버튼
        // size를 사용하여 적절한 선택자를 찾도록 수정
        var $input = $("#oqty"+cindex);
        var tCount = Number($input.val());
        
        if (type == 'p') {
            if (tCount < 100) $input.val(Number(tCount) + 1);
        } else {
            if (tCount > 1) $input.val(Number(tCount) - 1);
        }
    }
   
   function cartUpdate(cnum,cindex){ //수량 변경버튼
      var oqty = document.getElementById("oqty" + cindex).value;
      
      location.href="qtyUpdate.cart?cart_number="+cnum+"&qty="+oqty;
   }
   
   function getSelectedValues() {//선택되어있는 rowcheck의 value 얻음
       var selectedValues = [];
       var cnums = document.getElementsByName("rowcheck");
       for (var i = 0; i < cnums.length; i++) {
           if (cnums[i].checked) {
               selectedValues.push(cnums[i].value);
           }
       }
       return selectedValues;
   }
   
   
   function deleteSelected() { //선택삭제버튼
       var selectedValues = getSelectedValues();
       if (selectedValues.length === 0) {
           alert("삭제할 항목을 하나 이상 선택하세요.");
           return;
       }
       var deleteToCart = confirm("상품을 삭제하시겠습니까?");
       if(deleteToCart){
          document.myform.action = "delete.cart?cnums="+selectedValues;
          document.myform.submit();
       }else{
          return;
       }
   }
   function deleteSel(cnum){
      var deleteToCart = confirm("상품을 삭제하시겠습니까?");
       if(deleteToCart){
          document.myform.action = "delete.cart?cnum="+cnum;
          document.myform.submit();
       }else{
          return;
       }
   }
   
   function purchaseSelected() { //선택구매 버튼
       var selectedValues = getSelectedValues();
       if (selectedValues.length === 0) {
           alert("구매할 항목을 하나 이상 선택하세요.");
           return;
       }
       
       document.myform.action = "details.orders?cnums="+selectedValues; // 실제 URL로 업데이트
       document.myform.submit();
   } 
   
   function buyNow(cnum){ //바로구매
         location.href="details.orders?cnum="+cnum;
   }
</script>

<div class="body">
   <div class="row">
      <div class="col-lg-2"></div>
      <div class="col-lg-8">
         <div style="padding:20 10 20 10">
            <div style="">
               <h3 style="padding: 22 0 22 0">장바구니</h3>
            </div>
            
            
            <c:set var="cartlists" value="${cartInfoLists}" />
            <c:set var="sumPrice" value="0" />

<c:choose>
    <c:when test="${fn:length(cartInfoLists) == 0}">
        <div class="bg-body-white">
            <br>
            <font size="4" style="vertical-align: inherit;">
                <b>장바구니에 담긴 상품이 없습니다.</b>
            </font>
            <br>
            <br>
        </div>
        <div class="col-lg-12" style="text-align: center;">
           <button class='btn btn-dark btn-md' onclick="location.href='list.product'">쇼핑하러가기</button>
        </div>
    </c:when>
    
    
    <c:otherwise>
            <form method="post" name="myform">
            <table class="table">
              <thead>
                  <tr>
                    <th scope="col">
                         <input checked id="bbb" size="3" type="checkbox" name = "allcheck" onclick = "allCheck(this)">
               </th>
                        <th scope="col">이미지</th>
                        <th scope="col">상품정보</th>
                        <th scope="col">가격</th>
                        <th scope="col">주문수량</th>
                        <th scope="col">소계</th>
                        <th scope="col">구분</th>
                        <th scope="col">배송비</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cib" items="${cartInfoLists}" varStatus="status">
                      <tr>
                          <%-- <th scope="row">${status.index + 1}</th> --%>
                          <td>
                              <input class="pnum" type="checkbox" id="procheck"
                                  name="rowcheck" value="${cib.cart_number}" onclick="updateTotalPrice()">
                          </td>
                          <td>
                              <img id="preview" width="100px"
                                  src='<c:url value='/resources/productImage/'/>${cib.image }'
                                  class="rounded" />
                          </td>
                          <td>
                             <a class='pd' href='detail.product?product_number=${cib.product_number }'>
                             [${fn:substringBefore(cib.product_name,'/') }] <br>
                             ${fn:substringAfter(cib.product_name,'/') } <br>
                             사이즈:${cib.product_size }
                             </a>
                          </td>
                          <td>
                             <fmt:formatNumber value="${cib.price}" pattern="#,###" />원
                             <c:set var="totalPrice" value="${totalPrice + (cib.price * cib.qty)}" />
                          </td>
                          <td>
                              <div class="d-flex align-items-center">
                                  <button type="button" class="btn btn-light"
                                   onclick="fnCalCount('m','${status.index}')">
                                      -
                                  </button>
                                  <input type="text" class="form-control oqty" style="width: 50px;"
                                      id="oqty${status.index}" name="oqty" value="${cib.qty}" size="3"
                                      disabled>
                                  <button type="button" class="btn btn-light"
                                   onclick="fnCalCount('p','${status.index}')">
                                      +
                                  </button>
                              </div>
                              <div>
                                 <button type="button" class='btn btn-dark btn-md'
                                 onclick="cartUpdate('${cib.cart_number}','${status.index}')">변경</button>
                              </div>
                          </td>
                          <td>
                             <fmt:formatNumber value="${cib.price*cib.qty}" pattern="#,###" />원
                          </td>
                          <td>
                             <button class='btn btn-dark btn-md' style="width: 84" type="button" onclick="buyNow('${cib.cart_number}')">바로구매</button>
                             <button class='btn btn-dark btn-md' style="width: 84" type="button" onclick="deleteSel('${cib.cart_number}')">삭제하기</button>
                          </td>
                          <c:if test="${status.index==0 }">
                           <td rowspan="100%" style="vertical-align: middle;">
                              <span id="delivery" style="display: inline-block;"></span>원
                           </td>
                          </c:if>
                      </tr>
                  </c:forEach>
              </tbody>
              <tr>
                 <td colspan="2">
                    <span>상품금액 합계:</span><br>
                    <span>배송비:</span>
                 </td>
                 <td colspan="2">
                    <span id="totalPrice"></span>원 <br>
                    <span id="deliveryPrice"></span>원
                 </td>
                 <td colspan="4">
                    총결제금액: <span id="total"></span>원
                 </td>
              </tr>
              <tr>
                 <td colspan="8">
                    <button class='btn btn-dark btn-md' type="button" onclick="deleteSelected()">선택삭제</button>
                    <button class='btn btn-dark btn-md' type="button" onclick="purchaseSelected()">선택구매</button>
                 </td>
              </tr>
             </table>
            </form>
       </c:otherwise>
   </c:choose>


         </div>
      </div>
      <div class="col-lg-2 mt-5 px-5">
      </div>

   </div>
</div>

<%@ include file="../main/bottom.jsp"%>