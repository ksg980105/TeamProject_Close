<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<script src="resources/js/bootstrap.bundle.min.js"></script>
<script src="resources/js/jquery.js"></script>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/checkout.css" rel="stylesheet">

<style>
	table{
		text-align: center;
	}
	th{
		text-align: right;
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
	text-align: right;
	}
</style>

<div class="container">
    <div class="py-5 text-center">
	   <a href = "view.main">
	      <img class="d-block mx-auto mb-4" src="resources/img/logo.png" width="500" height="100">
	   </a>
      <h2>관리자 페이지</h2>
    </div>
 	
	<div id="myTabContent" class="tab-content">
		<!-- 첫번째 탭 -->
		<div class="tab-pane fade active show" id="mypage" role="tabpanel">
			<div class="row">
        <table class="table" id="article-table">
            <tbody>
            <tr>
            	<th>주문 번호</th>
            	<th>결제 금액</th>
            	<th>상태</th>
            	<th>주문 일자</th>
            </tr>
            <c:if test="${ fn:length(lists) != 0 }">
	            <c:forEach var="ordersBean" items="${ lists }">
		            <tr>
		            	<td>${ ordersBean.orders_id }</td>
		            	<td>${ ordersBean.totalamount }</td>
		            	<td>${ ordersBean.status }</td>
		            	<td>${ ordersBean.orders_date }</td>
		            </tr>
	            </c:forEach>
            </c:if>
            <tr>
            	<td colspan="4" align="right">
            		<input type="button" class="btn btn-Dark me-md-2" value="목록보기" onClick="location.href='adminPage.member?pageNumber=${ pageInfo.pageNumber }'">
            	</td>
            </tr>
            </tbody>
        </table>
		    </div> 
		 <div class="row">
        <nav id="pagination" aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">Next</a></li>
            </ul>
        </nav>
    </div>
		</div>
	</div>
	
	
	<footer class="my-5 pt-5 text-body-secondary text-center text-small">
	  <p class="mb-1">© 2023 Team, Clothes secretaryn</p>
	</footer>
</div>