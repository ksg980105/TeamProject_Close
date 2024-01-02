<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file= "../main/top.jsp" %>
<style>
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

    </style>
    
    <script type="text/javascript">
	// textarea에 입력할 때마다 호출되는 함수
	function updateCharCount() {
	  // textarea의 값을 가져온 후 글자수를 계산
	  var text = document.getElementById('myTextarea').value;
	  var count = text.length;
	
	  // 글자수를 HTML 요소에 업데이트
	  document.getElementById('charCount').innerText = count;
	  if (count > 1000) {
	      document.getElementById('myTextarea').value = text.substring(0, 1000);
	      document.getElementById('charCount').innerText = 1000;
	    }
	}
	
</script>
    
<form:form action="update.qna" method="post" commandName="qnaBean" enctype="multipart/form-data">
<input type="hidden" name="pageNumber" value="${ pageNumber }">
<input type="hidden" name="qna_number" value="${ qnaBean.qna_number }">
<div class="row">
        <table class="table" id="article-table" style="width: 70%; margin: auto;">
            <tr>
                <th>문의유형</th>
				<td>
					<% String[] qna_categoryList = {"사이즈", "배송", "재입고", "상품상세","교환/환불/취소"};  %>
					<c:forEach var="qna_category" items="<%= qna_categoryList %>">
						<input type="radio" style="accent-color: black;" name="qna_category" value="${ qnaBean.qna_category }" <c:if test="${ qnaBean.qna_category == qna_category }">checked</c:if>>${ qna_category }
					</c:forEach>
					<br><form:errors cssClass="err" path="qna_category" />
				</td>
            </tr>
            <tr>
                <th>제목</th>
				<td>
					<input type="text" name="title" value="${ qnaBean.title }">
					<input type="checkbox" style="accent-color: black;" name="secret" value="YES" <c:if test="${ qnaBean.secret == 'YES' }">checked</c:if>>비밀글
					<br><form:errors cssClass="err" path="title" />
				</td>
            </tr>
            <tr>
                <th>작성자</th>
				<td>${ qnaBean.nickname }
					<input type="hidden" name="nickname" value="${ qnaBean.nickname }">
				</td>
            </tr>
            <tr>
				<th>내용</th>
				<td colspan="2">
					<textarea id="myTextarea" oninput="updateCharCount()" name="content" cols="50" rows="10"  style="resize: none;">${ qnaBean.content }</textarea>
					<p>글자수:( <span id="charCount">${ fn:length(qnaBean.content) }</span>/1000자)</p>
					<br><form:errors cssClass="err" path="content" />
				</td>
            </tr>
            <tr>
				<th>사진첨부</th>
				<td>
					<c:if test="${ qnaBean.image != null }">
						<img src="<%= request.getContextPath() %>/resources/qnaImage/${ qnaBean.image }" width="150px" />
					</c:if>
					<div style="width: 300px;">
					<input type="file" class="form-control" name="upload" value="${ qnaBean.image }">
					<input type="hidden" name="upload2" value="${ qnaBean.image }">
					</div>
				</td>
			</tr>
            <tr>
            	<td colspan="2">
            		<input type="submit" class="btn btn-Dark me-md-2" value="수정" style="float: right;">
            	</td>
            </tr>
        </table>
    </div>
</form:form>
