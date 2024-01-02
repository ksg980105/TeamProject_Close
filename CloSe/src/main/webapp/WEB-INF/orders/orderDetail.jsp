<%@page import="product.model.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ include file="../main/top.jsp"%>

<style>
#myform{
	display: none;
}
</style>

<script type="text/javascript">
function openReviewFormWindow(orderDetailNumber) {
	alert(orderDetailNumber);
    // 새 창을 열기
    window.open("reviewRegister.jsp?orderDetailNumber="+orderDetailNumber, "reviewWindow", "_blank", "menubar=no, toolbar=no");
}

</script>

<div class="body">
   <div class="row">
      <div class="col-lg-2"></div>
      <div class="col-lg-8">
         <div style="padding:20 10 20 10">
            <div style="">
               <h3 style="padding: 22 0 22 0">주문내역</h3>
            </div>
            
            <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">이미지</th>
                            <th scope="col">상품정보</th>
                            <th scope="col">가격</th>
                            <th scope="col">옵션</th>
                            <th scope="col">주문수량</th>
                            <th scope="col">소계</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="oi" items="${olists}" varStatus="status">
                           <c:set var="totalPrice" value="${totalPrice + (oi.price*oi.qty)}" />
                            <tr>
                                <td>
                                    <img id="preview" width="100px"
                                        src='<c:url value='/resources/productImage/'/>${oi.image }'
                                        class="rounded" />
                                 </td>
                                <td>
                                   <a href="detail.product?product_number=${oi.product_number }">[${fn:substringBefore(oi.product_name,'/') }] <br>
                                   ${fn:substringAfter(oi.product_name,'/') }</a> 
                                </td>
                                <td>
                                   ${oi.price}원
                                </td>
                                <td>
                                    ${oi.product_size }
                                </td>
                                <td>
                                    ${oi.qty }
                                </td>
                                <td>
                                	${oi.price*oi.qty}원
                                	<button type="button" onclick="openReviewFormWindow('${oi.orderdetail_number}')">리뷰작성</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
				
				<div style="">
					<h3 style="padding: 22 0 22 0">구매자 정보</h3>
				</div>
				<table class="table">
					<tbody>
						<c:forEach var="oi" items="${olists}" begin="0" end="0" varStatus="status">
						<c:set var="order_id" value="${oi.orders_id }"/>
						<tr>
							<td>주문자</td>
							<td>${oi.name }</td>
						</tr>
						<tr>
							<td>연락처</td>
							<td>${oi.phone }</td>
						</tr>
						<tr>
							<td>이메일</td>
							<td>${oi.email }</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div style="">
					<h3 style="padding: 22 0 22 0">배송지 정보</h3>
				</div>
				<table class="table">
					<tbody>
						<c:forEach var="oi" items="${olists}" begin="0" end="0" varStatus="status">
						<tr>
							<td>수령인</td>
							<td>${oi.receiver }</td>
						</tr>
						<tr>
							<td>연락처</td>
							<td>${oi.receiver_phone }</td>
						</tr>
						<tr> 
							<td>배송지</td>
							<td>${oi.address }</td>
						</tr>
						<tr>
							<td>배송메모</td>
							<td>${oi.d_message }</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div style="">
					<h3 style="padding: 22 0 22 0">주문 금액 상세</h3>
				</div>
				<table class="table">
					<tbody>
						<tr>
							<td>상품금액</td>
							<td>${totalPrice }</td>
						</tr>
						<tr>
							<td>할인</td>
							<td>${totalPrice + (totalPrice > 50000 ? '0' : '4000') -olists[0].totalamount }</td>
						</tr>
						<tr>
							<td>배송비</td>
							<td>
								${totalPrice > 50000 ? '0' : '4000'}
								<c:set var="delivery" value="${totalPrice > 50000 ? '0' : '4000'}"/>
							</td>
							
						</tr>
						<tr>
							<td>총 주문금액</td>
							<td>${olists[0].totalamount }</td>
						</tr>
					</tbody>
				</table>
				<a href="${referer }">
					<button type="button">목록보기</button>
				</a>
				<button type="button" onclick="location.href='refund.orders?order_id=${order_id}&pageNumber=${pageNumber }'">환불하기</button>
				 
			</div>
		</div>

      <div class="col-lg-2 mt-5 px-5">
         <div class="bs-component">
            <div class="card mb-3">
               <h3 class="card-header">오늘의 날씨 정보</h3>
               <div class="card-body">
                  <h5 class="card-title">Special title treatment</h5>
                  <h6 class="card-subtitle text-muted">Support card subtitle</h6>
               </div>
               <svg xmlns="http://www.w3.org/2000/svg"
                  class="d-block user-select-none" width="100%" height="200"
                  aria-label="Placeholder: Image cap" focusable="false" role="img"
                  preserveAspectRatio="xMidYMid slice" viewBox="0 0 318 180"
                  style="font-size: 1.125rem; text-anchor: middle">
                  <rect width="100%" height="100%" fill="#868e96"></rect>
                  <text x="50%" y="50%" fill="#dee2e6" dy=".3em">Image cap</text>
                </svg>
            </div>
         </div>
      </div>



   </div>
</div>


<button onclick="location.href='view.main'">이동</button>
<%@ include file="../main/bottom.jsp"%>