<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file= "../main/top.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photo Tagging</title>
    <style>
    	#styleNav {
		    font-size: 15pt;
		    font-weight: 700;
		    padding-top: 3px;
		}
        
        #photo-container {
            position: relative;
            width: 30%;
        }

        .tag-container {
            position: absolute;
            top: 0;
            left: 0;
        }

        .tag {
            position: absolute;
            background-color: #3498db;
            color: #fff;
            padding: 5px;
            border-radius: 5px;
            cursor: pointer;
        }
        #styleNav{
        	font-size: 15pt;
        	font-weight: 700;
        	padding-top: 3px;
        }
        #img{
        	width: 80%;
        	height: 100%;
        	border-radius: 50%;
        }
        #imgDiv{
        	text-align: center;
        }
        #imgContainer{
        	width: 66%;
        	margin: auto;
        }
        
        #styleDetailContainer{
        	width: 50%;
        	margin: auto;
        }
        
        .btn{
			border: none;
			padding: 0;
		}
        
        .overlay2 {
	      display: none; /* 초기에는 배경 숨김 */
	      position: fixed;
	      width: 100%;
	      height: 100%;
	      z-index: 1200;
	      background-color: rgba(255, 255, 255, 0);
	   	}
	   	
	   	.overlay2 ul {
		    position: absolute;
		    top: 35%; /* 원하는 위치로 조절할 수 있습니다. */
		    left: 35%; /* 원하는 위치로 조절할 수 있습니다. */
		    width: 30%; /* 원하는 너비로 조절할 수 있습니다. */
		    cursor: pointer;
		}
		
		.carousel-indicators [data-bs-target] {
			background-color: black;
			width: 7px;
	  		height: 7px;
			border-radius:50%;
		}
		
		.carousel-indicators {
		    position: absolute;
		    transform: translateY(45px);
		}
		
		.carousel-indicators [data-bs-target] {
			background-color: black;
			width: 7px;
	  		height: 7px;
			border-radius:50%;
		}
		
		.carousel-control-prev-icon, .carousel-control-next-icon {
		  width: 30px; /* 아이콘 크기 지정 */
		  height: 30px; /* 아이콘 크기 지정 */
		  background-color: gray; /* 배경색 지정 */
		  border-radius: 50%;
		}
		
		#carouselExampleIndicators {
		   width: 100%; /* 최대 너비 설정 */
		}
		
		#pimage{
			width:7vw;
			height:11vh;
			margin: auto;
		}
		
		.custom-height{
			height: 70vw;
		}
        
    </style>
    
    <script type="text/javascript">
	    function search2() {
	        var overlay2 = document.getElementById('overlay2');
	        overlay2.style.display = 'block';
	     }
    	function hideOverlay2() {
    		var overlay2 = document.getElementById('overlay2');
    		overlay2.style.display = 'none';
	 	 }
    	function goLogin2() {
			alert("로그인 후에 이용 가능합니다.");
			location.href="login.member";
		}
    	function showDeleteConfirmation(style_number) {
            // 확인창을 띄우고 사용자의 선택 결과를 확인
            var isConfirmed = confirm("정말로 삭제하시겠습니까?");

            // 사용자가 확인을 선택했을 때
            if (isConfirmed) {
                location.href="delete.style?style_number="+style_number;
            } else {
                alert("삭제가 취소되었습니다.");
            }
        }
    </script>
</head>
<body>
	
	<div id="overlay2" class="overlay2" onclick="javascript:hideOverlay2();">
		<ul class="list-group" style="cursor: pointer;">
			<c:if test="${loginInfo.member_id == styleBean.member_id or kakaoLoginInfo.member_id == styleBean.member_id}">
				<li class="list-group-item d-flex justify-content-center" onclick="location.href='update.style?style_number=${styleBean.style_number}'">게시물 수정</li>
			</c:if>
			<c:if test="${loginInfo.member_id == styleBean.member_id or kakaoLoginInfo.member_id == styleBean.member_id}">
				<li class="list-group-item d-flex justify-content-center" onclick="javascript:showDeleteConfirmation('${styleBean.style_number}');"><font color="blue">게시물 삭제</font></li>
			</c:if>
			<li class="list-group-item d-flex justify-content-center" <c:if test="${not empty loginInfo or not empty kakaoLoginInfo}">onclick="location.href='styleReport.report?style_number=${styleBean.style_number}'"</c:if>
			<c:if test="${empty loginInfo and empty kakaoLoginInfo}">onclick="javascript:goLogin2()"</c:if>><font color="red">유저 신고</font></li>
	        <li class="list-group-item d-flex justify-content-center" onclick="javascript:hideOverlay2()">취소</li>
	    </ul>
	</div>
	
	<div id="styleDetailContainer">
	    <div class="row" style="margin-bottom: 10px;">
	    	<div class="col-1">
	    		<img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='50' height='50' fill='gray' class='bi bi-person-circle' viewBox='0 0 16 16'%3E%3Cpath d='M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z'/%3E%3Cpath fill-rule='evenodd' d='M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z'/%3E%3C/svg%3E" alt="Person Icon">
	        </div>
	        <div class="col-3" style="padding-left: 15px;">
	            <b>${styleBean.nickname}</b>
	            <c:set var="write_date" value="${styleBean.write_date}" />
	            <br>
	            <font color="gray" size="2.5rem">
					<fmt:formatDate value="${write_date}" pattern="yyyy년 MM월 dd일" />
				</font>
	    	</div>
	    	<div class="col-8" style="text-align:right; align-self: center;">
	    		<button type="button" class="btn" onclick="javascript:search2()">
	    			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-three-dots" viewBox="0 0 16 16">
					  <path d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3z"/>
					</svg>
	    		</button>
	    	</div>
	    </div>
		    
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
		    <div class="carousel-indicators" id="carouselIndicators">
		    	<c:if test="${not empty styleBean.image2}">
					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
   					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
				</c:if>
				<c:if test="${not empty styleBean.image3}">
					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
				</c:if>
				<c:if test="${not empty styleBean.image4}">
					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
				</c:if>
				
				<c:if test="${not empty styleBean.image5}">
					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
				</c:if>
		    </div>
		    
		    <div class="carousel-inner" id="carouselInner">
		    	<div class="carousel-item active">
			      <img src="<%=request.getContextPath()%>/resources/styleImage/${styleBean.image1}" class="d-block w-100 custom-height" alt="...">
			    </div>
				
				<c:if test="${not empty styleBean.image2}">
					<div class="carousel-item">
				      <img src="<%=request.getContextPath()%>/resources/styleImage/${styleBean.image2}" class="d-block w-100 custom-height" alt="...">
				    </div>
				</c:if>
				
				<c:if test="${not empty styleBean.image3}">
					<div class="carousel-item">
				      <img src="<%=request.getContextPath()%>/resources/styleImage/${styleBean.image3}" class="d-block w-100 custom-height" alt="...">
				    </div>
				</c:if>
				
				<c:if test="${not empty styleBean.image4}">
					<div class="carousel-item">
				      <img src="<%=request.getContextPath()%>/resources/styleImage/${styleBean.image4}" class="d-block w-100 custom-height" alt="...">
				    </div>
				</c:if>
				
				<c:if test="${not empty styleBean.image5}">
					<div class="carousel-item">
				      <img src="<%=request.getContextPath()%>/resources/styleImage/${styleBean.image3}" class="d-block w-100 custom-height" alt="...">
				    </div>
				</c:if>
		    </div>
		    
		    <c:if test="${not empty styleBean.image2}">
			    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			        <span class="visually-hidden">이전</span>
			    </button>
			    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			        <span class="carousel-control-next-icon" aria-hidden="true"></span>
			        <span class="visually-hidden">다음</span>
			    </button>
			</c:if>
		</div>
		
		<div class="d-flex justify-content-between my-4">
			<div>
				<c:choose>
					<c:when test="${not empty styleBean.product_number4}">
						상품 태그 <b>4</b>개
					</c:when>
					<c:when test="${not empty styleBean.product_number3}">
						상품 태그 <b>3</b>개
					</c:when>
					<c:when test="${not empty styleBean.product_number2}">
						상품 태그 <b>2</b>개
					</c:when>
					<c:when test="${not empty styleBean.product_number1}">
						상품 태그 <b>1</b>개
					</c:when>
					<c:otherwise>
						상품 태그 <b>없음</b>
					</c:otherwise>
				</c:choose>
			</div>
			<div>
				<c:if test="${!heartFlag}">
					<c:if test="${not empty loginInfo}">
						<a class="link-dark link-underline-opacity-0" href="heart.style?style_number=${styleBean.style_number}&member_id=${loginInfo.member_id}">
					</c:if>	
					<c:if test="${not empty kakaoLoginInfo}">
						<a class="link-dark link-underline-opacity-0" href="heart.style?style_number=${styleBean.style_number}&member_id=${kakaoLoginInfo.member_id}">
					</c:if>
					<c:if test="${empty loginInfo and empty kakaoLoginInfo}">
						<a class="link-dark link-underline-opacity-0" href="login.member">
					</c:if>
						<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="#C0C0C0" class="bi bi-heart" viewBox="0 0 16 16">
						  <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/>
						</svg>
					</a>
				</c:if>
				
				<c:if test="${heartFlag}">
					<c:if test="${not empty loginInfo}">
						<a class="link-dark link-underline-opacity-0" href="unheart.style?style_number=${styleBean.style_number}&member_id=${loginInfo.member_id}">
					</c:if>	
					<c:if test="${not empty kakaoLoginInfo}">
						<a class="link-dark link-underline-opacity-0" href="unheart.style?style_number=${styleBean.style_number}&member_id=${kakaoLoginInfo.member_id}">
					</c:if>
					<c:if test="${empty loginInfo and empty kakaoLoginInfo}">
						<a class="link-dark link-underline-opacity-0" href="login.member">
					</c:if>
						<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="#f93737" class="bi bi-heart-fill" viewBox="0 0 16 16">
						  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
						</svg>
					</a>
				</c:if>
    			<span class="like-count">${heartCount}</span>
			</div>
		</div>
		
		<div class="d-flex justify-content-start">
		<ol class="list-group list-group-horizontal" style="cursor: pointer; width:100%;">
		<c:if test="${not empty styleBean.product_number1}">
			<li class="list-group-item me-3" style="width:25%; border-radius: 10%; padding: 5px; align-self: center;" onclick="location.href='detail.product?product_number=${styleBean.product_number1}'">
   			   	<div style="text-align: center;"><img src="<%=request.getContextPath()%>/resources/productImage/${styleBean.pimage1}" id="pimage"></div>
   			    <div class="ms-2 me-auto my-auto" style="text-align: center;">
	   			    <div>${fn:substringBefore(styleBean.product_name1,'/') }<br>${fn:substringAfter(styleBean.product_name1,'/') }</div>
	   			    <div class="fw-bold">
	   			    <fmt:formatNumber value="${styleBean.price1}" pattern="###,###원" />
	   			    </div>
   			    </div>
			</li>
		</c:if>
		<c:if test="${not empty styleBean.product_number2}">
			<li class="list-group-item me-3" style="width:25%; border-left: 1px solid #dee2e6; border-radius: 10%; padding: 5px; align-self: center;" onclick="location.href='detail.product?product_number=${styleBean.product_number2}'">
   			   	<div style="text-align: center;"><img src="<%=request.getContextPath()%>/resources/productImage/${styleBean.pimage2}" id="pimage"></div>
   			    <div class="ms-2 me-auto my-auto" style="text-align: center;">
	   			    <div>${fn:substringBefore(styleBean.product_name2,'/') }<br>${fn:substringAfter(styleBean.product_name2,'/') }</div>
	   			    <div class="fw-bold">
	   			    	<fmt:formatNumber value="${styleBean.price2}" pattern="###,###원" />
	   			    </div>
   			    </div>
			</li>
		</c:if>
		<c:if test="${not empty styleBean.product_number3}">
			<li class="list-group-item me-3" style="width:25%; border-left: 1px solid #dee2e6; border-radius: 10%; padding: 5px; align-self: center;" onclick="location.href='detail.product?product_number=${styleBean.product_number3}'">
   			   	<div style="text-align: center;"><img src="<%=request.getContextPath()%>/resources/productImage/${styleBean.pimage3}" id="pimage"></div>
   			    <div class="ms-2 me-auto my-auto" style="text-align: center;">
	   			    <div>${fn:substringBefore(styleBean.product_name3,'/') }<br>${fn:substringAfter(styleBean.product_name3,'/') }</div>
	   			    <div class="fw-bold">
	   			    	<fmt:formatNumber value="${styleBean.price3}" pattern="###,###원" />
	   			    </div>
   			    </div>
			</li>
		</c:if>
		<c:if test="${not empty styleBean.product_number4}">
			<li class="list-group-item me-3" style="width:25%; border-left: 1px solid #dee2e6; border-radius: 10%; padding: 5px; align-self: center;" onclick="location.href='detail.product?product_number=${styleBean.product_number4}'">
   			   	<div style="text-align: center;"><img src="<%=request.getContextPath()%>/resources/productImage/${styleBean.pimage4}" id="pimage"></div>
   			    <div class="ms-2 me-auto my-auto" style="text-align: center;">
	   			    <div>${fn:substringBefore(styleBean.product_name4,'/') }<br>${fn:substringAfter(styleBean.product_name4,'/') }</div>
	   			    <div class="fw-bold">
						<fmt:formatNumber value="${styleBean.price4}" pattern="###,###원" />
					</div>
   			    </div>
			</li>
		</c:if>	
		</ol>		
		</div>
			
	</div>
	
</body>
</html>