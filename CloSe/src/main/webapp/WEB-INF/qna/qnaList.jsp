<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>

<%@ include file= "../main/top.jsp" %>
<style>
        .search-form {
  width: 80%;
  margin: 0 auto;
  margin-top: 1rem;
}

.search-form input {
  height: 100%;
  background: transparent;
  border: 0;
  display: block;
  width: 100%;
  padding: 1rem;
  height: 100%;
  font-size: 1rem;
}

.search-form select {
  background: transparent;
  border: 0;
  padding: 1rem;
  height: 100%;
  font-size: 1rem;
}

.search-form select:focus {
  border: 0;
}

.search-form button {
  height: 100%;
  width: 100%;
  font-size: 1rem;
}

.search-form button svg {
  width: 24px;
  height: 24px;
}

.card-margin {
  margin-bottom: 1.875rem;
}

@media (min-width: 992px) {
  .col-lg-2 {
    flex: 0 0 16.66667%;
    max-width: 16.66667%;
  }
}

.card {
  border: 0;
  box-shadow: 0px 0px 10px 0px rgba(82, 63, 105, 0.1);
  -webkit-box-shadow: 0px 0px 10px 0px rgba(82, 63, 105, 0.1);
  -moz-box-shadow: 0px 0px 10px 0px rgba(82, 63, 105, 0.1);
  -ms-box-shadow: 0px 0px 10px 0px rgba(82, 63, 105, 0.1);
}

.card {
  position: relative;
  display: flex;
  flex-direction: column;
  min-width: 0;
  word-wrap: break-word;
  background-color: #ffffff;
  background-clip: border-box;
  border: 1px solid #e6e4e9;
  border-radius: 8px;
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
	function insert(){
		location.href="insert.qna";
	}
</script>

  <div class="row">
 		<div>
 		<h1 style="margin-left: 220px; width: 50%">고객센터</h1>
        <div class="card search-form mb-3" style="width: 30%; height: 60px; margin-left: auto; margin-right: 220px;">
            <div class="card-body p-0" style="padding-top: 30px;">
                <form action="list.qna" method="get">
                    <div class="row">
                        <div class="col-12">
                            <div class="row no-gutters">
                                <div class="col-lg-2 col-md-3 col-sm-12 p-0">
                                    <label for="search-type" hidden>검색 유형</label>
                                    <select class="form-control" id="search-type" name="whatColumn">
                                        <option value="all">전체
										<option value="nickname">작성자
										<option value="title">제목
                                    </select>
                                </div>
                               
                                <div class="col-lg-8 col-md-6 col-sm-12 p-0">
                                    <label for="search-value" hidden>검색어</label>
                                    <input type="text" placeholder="검색어..." class="form-control" id="search-value"
                                           name="keyword">
                                </div>
                                <div class="col-lg-2 col-md-3 col-sm-12 p-0">
                                    <button type="submit" class="btn btn-base">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                             viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                             stroke-linecap="round" stroke-linejoin="round"
                                             class="feather feather-search">
                                            <circle cx="11" cy="11" r="8"></circle>
                                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        </div>
    </div>
 
    <div class="row">
        <table class="table" id="article-table" style="width: 70%; margin: auto;">
            <thead>
            <tr>
                <th class="number col-1"><a>번호</a></th>
                <th class="answer col-1"><a>답변여부</a></th>
                <th class="qna_category col-2"><a>문의유형</a></th>
                <th class="title col-4"><a>제목</a></th>
                <th class="user-id"><a>작성자</a></th>
                <th class="created-at"><a>작성일</a></th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${ fn:length(lists) == 0 }">
            	<tr>
            		<td colspan="6" align="center">검색된 레코드가 없습니다.</td>
            	</tr>
            </c:if>
            <c:if test="${ fn:length(lists) != 0 }">
            	<c:forEach var="qnaBean" items="${ lists }">
				<c:if test="${ qnaBean.re_level == 0 }">
						<tr>
			                <td class="number">
			                	${ number }
			                	<c:set var="number" value="${ number -1 }" />	
			                </td>
			                <c:if test="${ qnaBean.answer == 0 }">
				                <td class="anwer">
				                	답변예정
				                </td>
			                </c:if>
			                <c:if test="${ qnaBean.answer != 0 }">
								<td class="anwer">
			                		답변완료
			                	</td>
							</c:if>
							<td class="qna_category">${ qnaBean.qna_category }</td>
							<c:if test="${loginInfo.member_id == 'admin'}">
				        <c:if test="${ qnaBean.secret == 'YES'}">
				            <td>
				                <a href="detail.qna?pageNumber=${pageInfo.pageNumber}&qna_number=${qnaBean.qna_number}">
				                    ${qnaBean.title}
				                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-lock" viewBox="0 0 16 16">
									  <path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm-9 8c0 1 1 1 1 1h5v-1a1.9 1.9 0 0 1 .01-.2 4.49 4.49 0 0 1 1.534-3.693C9.077 9.038 8.564 9 8 9c-5 0-6 3-6 4Zm7 0a1 1 0 0 1 1-1v-1a2 2 0 1 1 4 0v1a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1h-4a1 1 0 0 1-1-1v-2Zm3-3a1 1 0 0 0-1 1v1h2v-1a1 1 0 0 0-1-1Z"/>
									</svg>	
				                </a>
				            </td>
				        </c:if>
				        <c:if test="${ qnaBean.secret == 'NO'}">
				            <td>
				                <a href="detail.qna?pageNumber=${pageInfo.pageNumber}&qna_number=${qnaBean.qna_number}">
				                    ${qnaBean.title}
				                </a>
				            </td>
				        </c:if>
				</c:if>
				<c:if test="${loginInfo.member_id != 'admin'}">
				        <c:if test="${qnaBean.member_id != loginInfo.member_id && qnaBean.secret == 'YES'}">
				            <td>
				                ${qnaBean.title}
				                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-lock" viewBox="0 0 16 16">
								  <path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm-9 8c0 1 1 1 1 1h5v-1a1.9 1.9 0 0 1 .01-.2 4.49 4.49 0 0 1 1.534-3.693C9.077 9.038 8.564 9 8 9c-5 0-6 3-6 4Zm7 0a1 1 0 0 1 1-1v-1a2 2 0 1 1 4 0v1a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1h-4a1 1 0 0 1-1-1v-2Zm3-3a1 1 0 0 0-1 1v1h2v-1a1 1 0 0 0-1-1Z"/>
								</svg>
				            </td>
				        </c:if>
				        <c:if test="${qnaBean.member_id != loginInfo.member_id && qnaBean.secret == 'NO'}">
				            <td>
								<a href="detail.qna?pageNumber=${pageInfo.pageNumber}&qna_number=${qnaBean.qna_number}">
				                    ${qnaBean.title}
				                </a>
							</td>
				        </c:if>
				        <c:if test="${qnaBean.member_id == loginInfo.member_id && qnaBean.secret == 'YES'}">
				            <td>
				                <a href="detail.qna?pageNumber=${pageInfo.pageNumber}&qna_number=${qnaBean.qna_number}">
				                    ${qnaBean.title}
				                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-lock" viewBox="0 0 16 16">
									  <path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm-9 8c0 1 1 1 1 1h5v-1a1.9 1.9 0 0 1 .01-.2 4.49 4.49 0 0 1 1.534-3.693C9.077 9.038 8.564 9 8 9c-5 0-6 3-6 4Zm7 0a1 1 0 0 1 1-1v-1a2 2 0 1 1 4 0v1a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1h-4a1 1 0 0 1-1-1v-2Zm3-3a1 1 0 0 0-1 1v1h2v-1a1 1 0 0 0-1-1Z"/>
									</svg>	
				                </a>
				            </td>
				        </c:if>
				        <c:if test="${qnaBean.member_id == loginInfo.member_id && qnaBean.secret == 'NO'}">
				            <td>
								<a href="detail.qna?pageNumber=${pageInfo.pageNumber}&qna_number=${qnaBean.qna_number}">
				                    ${qnaBean.title}
				                </a>
							</td>
				        </c:if>
				</c:if>
			                <td class="nickname">${ qnaBean.nickname }</td>
			                <td>
			                	<fmt:formatDate value="${ qnaBean.write_date }" pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:if>
				</c:forEach>
			</c:if>
            </tbody>
        </table>
    </div>
<br>

    <div class="row">
        <div class="d-grid gap-2 d-md-flex justify-content-md-end" style="padding-right: 200px;">
        	<c:if test="${ loginInfo.member_id == null }">
        		<a href="login.member" class="btn btn-dark me-md-2" role="button" id="write-article">글쓰기</a>
        	</c:if>
        	<c:if test="${ loginInfo.member_id != null }">
        		<a href="insert.qna" class="btn btn-dark me-md-2" role="button" id="write-article">글쓰기</a>
        	</c:if>
            
        </div>
    </div>
    

<br><br>

<div class="row">
    <div class="col-lg-12 text-center">
        <div class="d-flex justify-content-center">
            ${pageInfo.pagingHtml}
        </div>
    </div>
</div>
