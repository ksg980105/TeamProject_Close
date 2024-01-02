<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
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

function replyForm() {
    var formData = new FormData(document.getElementById("insertForm"));

    var xhr = new XMLHttpRequest();
    xhr.open("POST", "reply.qna", true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                var result = xhr.responseText;
                window.opener.location.reload();
                window.close();
            } else {
                alert("서버 오류 발생");
            }
        }
    };
    xhr.send(formData);
}
</script>

<form:form action="reply.qna" method="post" commandName="qnaBean" id="insertForm">
	<div class="row mx-auto">
	        <table class="table" id="article-table">
	            <tbody>
	            <tr>
					<td>
						<input type="hidden" name="title" value="re:${ qnaBean.ref }">
						<input type="hidden" name="ref" value="${ ref }">
						<input type="hidden" name="re_level" value="${ re_level }">
						<input type="hidden" name="pageNumber" value="${ pageNumber }">
						<input type="hidden" name="qna_category" value="${ qnaBean.qna_category }">
						<input type="hidden" name="member_id" value="admin">
						<textarea id="myTextarea" oninput="updateCharCount()" name="content" cols="50" rows="10"  style="resize: none;" placeholder="답변작성">${ qnaBean.content }</textarea>
						<p>글자수:( <span id="charCount">${ fn:length(qnaBean.content) }</span>/1000자)</p>
						<br><form:errors cssClass="err" path="content" />
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" style="float: right;" class="btn btn-Dark me-md-2" value="작성">
					</td>
				</tr>
	            </tbody>
	        </table>
	    </div>
</form:form>