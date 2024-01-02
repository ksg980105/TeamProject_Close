<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file= "../main/top.jsp" %>
<style>
	.err{
		color: red;
	}
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
	
	@media ( min-width : 992px) {
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

<div class="row">
	<form:form action="update.notice" method="post" commandName="noticeBean" enctype="multipart/form-data">
	<input type="hidden" name="notice_number" value="${ noticeBean.notice_number }">
	<input type="hidden" name="pageNumber" value="${ pageNumber }">
	<table class="table" id="article-table" style="width: 60%; margin: auto;">
		<tbody>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" value="${ noticeBean.title }">
					<form:errors cssClass="err" path="title" />
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="2">
					<textarea id="myTextarea" oninput="updateCharCount()" name="content" cols="50" rows="10"  style="resize: none;">${ noticeBean.content }</textarea>
					<p>글자수:( <span id="charCount">${ fn:length( noticeBean.content ) }</span>/1000자)</p>
					<br><form:errors cssClass="err" path="content" />
				</td>
			</tr>
			<tr>
				<th>사진첨부</th>
				<td>
					<c:if test="${ noticeBean.image != null }">
						<img src="<%= request.getContextPath() %>/resources/noticeImage/${ noticeBean.image }" width="150px" />
					</c:if>
					<div style="width: 300px;">
						<input type="file" class="form-control" name="upload" value="${ noticeBean.image }">
					</div>
					<input type="hidden" name="upload1" value="${ noticeBean.image }">
					<input type="hidden" name="upload2" value="${ noticeBean.image }">
					<br><form:errors cssClass="err" path="image" />
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" class="btn btn-Dark me-md-2" value="수정">
				</td>			
			</tr>
		</tbody>
	</table>
	</form:form>
</div>
