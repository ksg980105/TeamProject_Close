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
	text-align: right;
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	  // 로드될 때 localStorage에서 마지막으로 클릭한 인덱스 가져오기
	  var lastClickedTabIndex = localStorage.getItem('lastClickedTabIndex');

	  // 인덱스가 있으면 해당 탭을 활성화
	  if (lastClickedTabIndex !== null) {
	    $('#myTabContent .nav-link').removeClass('active');
	    $('#myTabContent .tab-pane').removeClass('show active');

	    $('#myTabContent .nav-link').eq(lastClickedTabIndex).addClass('active');
	    $('#myTabContent .tab-pane').eq(lastClickedTabIndex).addClass('show active');
	  }

	  // nav-link 클릭 시 이벤트 핸들러
	  $('#myTabContent .nav-link').on('click', function() {
	    // 현재 클릭한 탭의 인덱스를 가져와 localStorage에 저장
	    var tabIndex = $(this).index();
	    localStorage.setItem('lastClickedTabIndex', tabIndex);
	  });

	  // 목록보기 버튼을 클릭했을 때
	  $('#listButton').on('click', function() {
	    // 판매 내역 탭으로 변경
	    $('#orderTab').tab('show');
	  });
	});

	function goMain(){
		location.href="view.main";
	}

</script>

<div class="container">
    <div class="py-5 text-center">
	   <a href = "view.main">
	      <img class="d-block mx-auto mb-4" src="resources/img/logo.png" width="500" height="100">
	   </a>
      <h2>관리자 페이지</h2>
    </div>
 	
	<ul class="nav nav-tabs" role="tablist">
	  <li class="nav-item" role="presentation">
	    <a class="nav-link active" data-bs-toggle="tab" href="#mypage" aria-selected="false" role="tab">신고 관리</a>
	  </li>
	  <li class="nav-item" role="presentation">
	    <a id="orderTab" class="nav-link" data-bs-toggle="tab" href="#order" aria-selected="true" role="tab" tabindex="-1">판매 내역</a>
	  </li>
	</ul>
	
	<div id="myTabContent" class="tab-content">
		<!-- 첫번째 탭 -->
		<div class="tab-pane fade active show" id="mypage" role="tabpanel">
			<div class="row">
        <table class="table" id="article-table">
            <thead>
            <tr align="left">
                <th class="report_number col-1">번호</th>
                <th class="report_category col-2">신고유형</th>
                <th class="content col-3">내용</th>
                <th class="reporter_id">신고자</th>
                <th class="reported_user_id">신고대상자</th>
                <th class="created-at">신고일</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${ fn:length(lists) == 0 }">
            	<tr>
            		<td colspan="6">
            			신고 목록이 없습니다.
            		</td>
            	</tr>
            </c:if>
            <c:if test="${ fn:length(lists) != 0 }">
            	<c:forEach var="reportBean" items="${ lists }">
	            	<tr>
		                <td class="report_number col-1">${ number }<c:set var="number" value="${ number - 1 }" /></td>
		                <td class="report_category col-2">${ reportBean.report_category  }</td>
		                <td class="content col-3"><a href="reportDetail.member?report_number=${ reportBean.report_number }&pageNumber=${ pageInfo.pageNumber }">${ reportBean.content  }</a></td>
		                <td class="reporter_id">${ reportBean.reporter_id  }</td>
		                <td class="reported_user_id">${ reportBean.reported_user_id  }</td>
		                <td class="created-at"><fmt:formatDate value="${ reportBean.write_date }" pattern="yyyy-MM-dd" /></td>
	            	</tr>
            	</c:forEach>
            </c:if>
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
		
		<!-- 두번째 탭 -->
		<div class="tab-pane fade" id="order" role="tabpanel">
			<div class="row">
				<table class="table" id="article-table">
					<tr>
						<th>
							주문	번호 
						</th>
						<th>
							회원 아이디 
						</th>
						<th>
							주문 상태 
						</th>
						<th>
							결제 금액 
						</th>
						<th>
							주문 날짜 
						</th>
					</tr>
					<c:if test="${ fn:length(orderLists) == 0 }">
						<tr>
							<td colspan="5" align="center">판매 내역이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${ fn:length(orderLists) != 0 }">
					<c:forEach var="orderLists" items="${ orderLists }">
						<tr>
							<td><a href="adminOrderDetail.member?orders_id=${ orderLists.orders_id }">${ orderLists.orders_number }</a></td>
							<td>${ orderLists.member_id }</td>
							<td>${ orderLists.status }</td>
							<td>${ orderLists.totalamount }</td>
							<td>${ orderLists.orders_date }</td>
						</tr>
					</c:forEach>
					</c:if>
				</table>
			</div>
		</div>
		
		<!-- 세번째 탭 -->
		<div class="tab-pane fade" id="bb" role="tabpanel">
			<div class="row">
			
			</div>
		</div>
		
		<!-- 네번째 탭 -->
		<div class="tab-pane fade" id="delete" role="tabpanel">
			<div class="row">
	        </div>
		</div>
	</div>
	
	
	<footer class="my-5 pt-5 text-body-secondary text-center text-small">
	  <p class="mb-1">© 2023 Minhyeok, Byeon</p>
	</footer>
</div>