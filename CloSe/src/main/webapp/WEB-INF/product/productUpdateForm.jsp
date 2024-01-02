<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="product.model.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../main/top.jsp"%>

<style type="text/css">
.body {
	width: 100%;
	margin: auto;
}
	#shopNav {
        font-size: 15pt;
        font-weight: 700;
        padding-top: 3px;
	}
#par {
	position: relative;
}

#chi {
	position: absolute;
	left: 0px;
	top: 0px;
	opacity: 0.4;
}

#carouselExampleAutoplaying {
	max-width: 66%; /* 최대 너비 설정 */
	margin: auto; /* 가운데 정렬 */
}

.productrow {
	border-bottom: 1px solid rgba(0, 0, 0, .1);
	padding: 15 0 15 10;
}
 .err{
      color: red;
      font-weight: bold;
      font-size: 9pt;
   }
   
   
.btn-upload {
  width: 150px;
  height: 30px;
  background: #fff;
  border: 1px solid rgb(77,77,77);
  border-radius: 10px;
  font-weight: 500;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  &:hover {
    background: rgb(77,77,77);
    color: #fff;
  }
}
#file1, #file2 {
  display: none;
}
</style>


<div class="body">


	<div class="row">
		<div class="col-lg-2"></div>
		<div class="col-lg-8">
			<div class="row">
				<div class="col-lg-2"></div>
				<div class="col-lg-8">
					<div style="border-bottom: 3px solid;">
						<h3 style="padding: 22 0 22 0">상품수정</h3>
					</div>
					<form:form commandName="productBean" action="update.product"
						method="post" enctype="multipart/form-data">
						<input type="hidden" name="product_number" value="${productBean.product_number }">
						<div class="row productrow">
							<div class="col-2" style="white-space: nowrap;">
								<span>상품이미지<font color="red">*</font></span>
							</div>
							<div class="col-3">
								<img id="preview" width="200px" height="200px" style="margin: 10 0 10 0" 
									src='<c:url value='/resources/productImage/'/>${productBean.image}'
									 onerror="this.src='<c:url value='/resources/img/idd.PNG'/>'"/>
								<div>
									<form:errors path="image" cssClass="err"/>
								</div>
							</div>
							<div class="col-3">
							<label for="file1">
  								<div class="btn-upload">파일 업로드하기</div>
  							</label>
								<input type="file" name="pImage" onchange="readURL(this);" id="file1">
								<input type="hidden" name="prevImage" value="${productBean.image}">
								<input type="hidden" name="image" value="${productBean.image}">
							</div>
						</div>
						<div class="row productrow">
							<div class="col-2" style="white-space: nowrap;">
								<span>상품명<font color="red">*</font></span>
							</div>
							<div class="col-5">
								<input type="text" class="form-control mb-1" name="product_name" maxlength="50"
								placeholder="상품명을 입력해 주세요." value="${productBean.product_name }">
								<div>
									<form:errors path="product_name" cssClass="err"/>
								</div>
							</div>
						</div>

						<div class="row productrow">
							<div class="col-2" style="white-space: nowrap;">
								<span>카테고리<font color="red">*</font></span>
							</div>
							<div class="col-6">

								<select id="firstSelect" style="width: 100px" size="10" onchange="updateSecondSelect()">
								</select>
								<select name="smallcategory_name" id="secondSelect" style="width: 150px" size="10">
								</select>
								<div>
									<form:errors path="smallcategory_name" cssClass="err"/>
								</div>
							</div>
						</div>
						<div class="row productrow">
							<div class="col-2" style="white-space: nowrap;">
								<span>가격<font color="red">*</font></span>
							</div>
							<div class="col-3">
								<input type="text" class="form-control mb-1" name="price" maxlength="12"
								placeholder="가격을 입력해 주세요." value="${productBean.price }" oninput="NumerInput('price')">
								<div>
									<form:errors path="price" cssClass="err"/>
								</div>
							</div>
						</div>
						<div class="row productrow">
							<div class="col-2" style="white-space: nowrap;">
								<span>설명사진<font color="red">*</font></span>
							</div>
							<div class="col-6">
							<label for="file2">
  								<div class="btn-upload">파일 업로드하기</div>
  							</label>
								<input type="file" name="pContent" id="file2" onchange="handleFileSelection()">
								<input type="hidden" name="prevContent" value="${productBean.content}">
								<input type="hidden" name="content" value="${productBean.content}">
								<div>
									<form:errors path="content" cssClass="err"/>
							 		<span id="fileSelectionMessage"><br>
							 		선택된 파일: ${productBean.content }</span>
								</div>
							</div>
						</div>
						<div class="row productrow">
							<div class="col-2" style="white-space: nowrap;">
								<span>추천온도<font color="red">*</font></span>
							</div>
							<div class="col-3">
								<input type="text" class="form-control mb-1" 
									placeholder="추천온도를 입력해주세요." maxlength="2" value='${productBean.temperature}' name="temperature" oninput="NumerInput('temperature')">
								<div>
									<form:errors path="temperature" cssClass="err"/>
								</div>
							</div>
						</div>
						<div class="row productrow">
							<div class="col-2" style="white-space: nowrap;">
								<span>사이즈별 수량<font color="red">*</font></span>
							</div>
							<div class="col-2">
								S <input type="text" name="s_stock" class="form-control mb-1" maxlength="4"
								placeholder="0" value="${productBean.s_stock }" oninput="NumerInput('s_stock')">
								M <input type="text" name="m_stock" class="form-control mb-1" maxlength="4"
								placeholder="0" value="${productBean.m_stock }" oninput="NumerInput('m_stock')">
								L <input type="text" name="l_stock" class="form-control mb-1" maxlength="4"
								placeholder="0" value="${productBean.l_stock }" oninput="NumerInput('l_stock')">
								XL <input type="text" name="xl_stock" class="form-control mb-1" maxlength="4"
								placeholder="0" value="${productBean.xl_stock }" oninput="NumerInput('xl_stock')">
							</div>
						</div>
						<div style="padding-top: 15; float: right;">
							<input class="btn btn-dark btn-md" type="submit" value="수정하기">
						</div>
					</form:form> 
				</div>

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


<script type="text/javascript">
	const clothingMap = new Map();

	<c:forEach var="category" items="${clists}">
		clothingMap.set('${category.smallcategory_name}','${category.bigcategory_name}');
	</c:forEach>
	
	
	const set1 = new Set();
	
	for (const [key, value] of clothingMap) {
		set1.add(value);
	} 
	
	
	 const firstSelect = document.getElementById("firstSelect");
     for (const value of set1) {
         const option = document.createElement("option");
         option.value = value;
         option.text = value;
    	 if(value == clothingMap.get("${productBean.smallcategory_name}")){
    		 option.selected = true;
    	 }
         firstSelect.add(option);
    	 updateSecondSelect();
     }
     
	
     function updateSecondSelect() {
         const firstSelect = document.getElementById("firstSelect");
         const secondSelect = document.getElementById("secondSelect");
         const selectedCategory = firstSelect.value;

         // 이전 옵션 지우기
         secondSelect.innerHTML = '';

         // 선택한 카테고리에 기반하여 동적으로 옵션 추가
         for (const [key, value] of clothingMap) {
             if (value === selectedCategory) {
                 const option = document.createElement("option");
                 option.value = key;
                 option.text = key;
                 if(key == "${productBean.smallcategory_name}"){
            		 option.selected = true;
            	 }
                 secondSelect.add(option);
             }
         }
     }
     
     function readURL(input) { //상품이미지 나오게
 		var hiddenField = document.getElementsByName("image")[0];
 		if (input.files && input.files[0]) {
 			var reader = new FileReader();
 			reader.onload = function(e) {
 				document.getElementById('preview').src = e.target.result;
 			};
 			reader.readAsDataURL(input.files[0]);
 			alert(hiddenField.value);
	        hiddenField.value = "";
 		}
     
 	}
    function handleFileSelection() {
         var fileInput = document.getElementById("file2");
         var fileSelectionMessage = document.getElementById("fileSelectionMessage");
         var selectedFileName = document.getElementById("selectedFileName");

         if (fileInput.files.length > 0) {
             fileSelectionMessage.innerHTML = "선택된 파일: " + fileInput.files[0].name;
         } else {
             fileSelectionMessage.innerHTML = ""; // 파일이 선택되지 않은 경우 초기화
         }
    }
     
     
    function NumerInput(fieldName) { //숫자칸에는 숫자만 들어가게
    	var inputField = document.getElementsByName(fieldName)[0];
    	var inputValue = inputField.value;
    	var numericValue = inputValue.replace(/[^0-9]/g, '');
    	inputField.value = numericValue;
    }
</script>

<%@ include file="../main/bottom.jsp"%>