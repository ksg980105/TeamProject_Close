<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
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

.err{
	color: red;
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

<form:form action="styleReport.report" method="post" commandName="reportBean" enctype="multipart/form-data">
<input type="hidden" name="reporter_id" value="${ loginInfo.member_id }">
<input type="hidden" name="reported_user_id" value="${ reported_user_id }">
<input type="hidden" name="style_number" value="${ style_number }">
  <div class="row">
        <table class="table" id="article-table" style="width: 60%; margin: auto;">
    <tr>
		<th>문의유형</th>
		<td colspan="2">
			<% String[] categories = {"스팸홍보/도배글입니다.", "음란물입니다.", "욕설/혐오/차별적 표현입니다.", "불법정보를 포함하고 있습니다."};  %>
			<select name="report_category">
				<c:forEach var="report_category" items="<%= categories %>">
					<option value="${ report_category }" <c:if test="${ report_category == reportBean.report_category }">selected</c:if>>${ report_category }
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td colspan="2">
			<textarea id="myTextarea" name="content" cols="70" rows="10"  style="resize: none;" placeholder="커뮤니티 가이드라인을 위반하는 스타일탭의 콘텐츠를 신고합니다." oninput="updateCharCount()"></textarea>
			<p>글자수: (<span id="charCount">0</span>/1000)</p>
			<br><form:errors cssClass="err" path="content" />
		</td>
	</tr>
	<tr>
		<th>사진첨부</th>
		<td colspan="2">
			<input type="file" class="form-control" name="upload" value="${ reportBean.image }">
		</td>
	</tr>
	<tr>
		<td colspan="3" align="right">
			<input type="submit" class="btn btn-Dark me-md-2" value="작성">
		</td>
	</tr>
            </tbody>
        </table>
    </div>
</form:form>



	
