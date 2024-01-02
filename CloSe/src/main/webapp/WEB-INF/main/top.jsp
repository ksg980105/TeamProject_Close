<%@page import="category.model.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%@ include file="../common/common.jsp" %>

<script src="resources/js/bootstrap.bundle.min.js"></script>
<script src="resources/js/jquery.js"></script>
<script src="resources/js/sidebars.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/sidebars.css" rel="stylesheet">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	function saveTo() {
			var searchWordValue = document.getElementById('searchWord').value;
			alert(searchWordValue);
			saveToLocalStorage(searchWordValue);
	}
	function saveToLocalStorage(searchWord) {
  	     if (searchWord.length > 0) {
  	         // 로컬 스토리지에서 최근 검색어 목록을 읽어옴
  	         var recentSearchList = JSON.parse(localStorage.getItem("recentSearchList")) || [];

  	         // recentSearchList가 배열이 아니면 초기화
  	         if (!Array.isArray(recentSearchList)) {
  	             recentSearchList = [];
  	         }

  	         // 중복 확인
  	         var existingIndex = recentSearchList.indexOf(searchWord);
  	         if (existingIndex !== -1) {
  	             // 중복된 검색어가 이미 있다면 삭제
  	             recentSearchList.splice(existingIndex, 1);
  	         }

  	         // 최근 검색어 목록에 추가
  	         recentSearchList.push(searchWord);

  	         // 로컬 스토리지에 최근 검색어 목록을 저장
  	         localStorage.setItem("recentSearchList", JSON.stringify(recentSearchList));

  	         // 최근 검색어 목록 업데이트
  	         updateRecentSearchList(recentSearchList);
  	     }
  	 }
   function goLogin() {
      location.href = "login.member";
   }
   function goLogout() {
      location.href = "logout.jsp";
   }
   function goKakaoLogin() {
      location.href = "kakaologin.member";
   }
   function goMyCart(){
	   location.href = "cartAdd.cart";
   }
   
   function goCart() {
	   if("${empty loginInfo and empty kakaoLoginInfo}"){
		   alert("로그인이 필요한 서비스입니다.");
		   goLogin();
	   }
	   if("${not empty loginInfo}"){
		   alert("카카오${kakaoLoginInfo.member_id}")
		   alert('${loginInfo.member_id}');
		   location.href = "cartAdd.cart?member_id='${loginInfo.member_id}'";
	   } else if("${not empty kakaoLoginInfo}"){
		   location.href = "cartAdd.cart?member_id='${kakaoLoginInfo.member_id}'";
	   }
	   
	}
   
   function goEvent(){
	   location.href="main.event";
   }
   
   Kakao.init('2cdf0145ab332ff37556bbc8268b13a1');
   function kakaoLogout() {
	    if (Kakao.Auth.getAccessToken()) {
	      Kakao.API.request({
	        url: '/v1/user/unlink',
	        success: function (response) {
	        	console.log(response)
	        	alert('로그아웃 되었습니다.');
				location.href = 'kakaologout.jsp';

	        },
	        fail: function (error) {
	          console.log(error)
	        },
	      })
	      Kakao.Auth.setAccessToken(undefined)
	    }
	}

   function goLoginOrKakaoLogin() {
	    if (${not empty loginInfo}) {
	        goLogout();
	    } else if (${not empty kakaoLoginInfo}) {
	    	goKakaoLogin();
	    }
	}

	function goLogoutOrKakaoLogout() {
	    if (${not empty loginInfo}) {
	        goLogout();
	    } else if (${not empty kakaoLoginInfo}) {
	    	kakaoLogout();
	    }
	}
	
	function goQna(){ //고객센터
	    location.href = "list.qna";
	}
	function goNotice(){ //공지사항
	    location.href="list.notice";
	}
	 
	function goMyPage(){
		location.href="mypage.member";
	}
	
   	function search() {
       var overlay = document.getElementById('overlay');
       overlay.style.display = 'block';
    }
   	function hideOverlay() {
   		var overlay = document.getElementById('overlay');
   		overlay.style.display = 'none';
	}
	   	
	   	$(document).ready(function () {
	   	    // 페이지 로드 시 최근 검색어 목록을 가져와서 업데이트
	   	    var recentSearchList = JSON.parse(localStorage.getItem("recentSearchList")) || [];
	   	    updateRecentSearchList(recentSearchList);

	   	    $("#searchWord").on("input", function () {
	   	        var searchWord = $(this).val().trim();
	   	        if (searchWord.length === 0) {
	   	            $("#displayList").hide();
	   	        } else {
	   	            $.ajax({
	   	                url: "wordSearchShow.main",
	   	            	method: "get",
	   	                data: {"searchWord": searchWord},
	   	                dataType: "text",
	   	                success: function (json) {
	   	                	if (json.length > 0) {
	   	                        var html = '<ol class="list-group" style="cursor:pointer; border: 1pt solid black;">';
	   	                        var jsonArray = JSON.parse(json);
	   	                        $(document).data('jsonArray', jsonArray);
	   	                        var contextPath = '<%= request.getContextPath() %>';
	   	                        $.each(jsonArray, function (index, item) {
	   	                         	var productNameParts = item.product_name.split('/'); // /를 기준으로 나눔
	   	                        	html += '<li id="prosea" class="list-group-item d-flex justify-content-between align-items-start" style="border: none;">';
	   	              			   	html += '<div><img id="displayList_img" src="' + contextPath +"/resources/productImage/"+ item.image + '"></div>';
	   	              			    html += '<div class="ms-2 me-auto my-auto">';
		   	              			// 각 부분을 출력
		   	              		    for (var i = 0; i < productNameParts.length; i++) {
		   	              		        html += '<div class="fw-bold">' + productNameParts[i] + '</div>';
		   	              		    }
	
		   	              		    html += '₩ ' + item.price + '</div>';
		   	              		    html += '<span class="badge bg-black rounded-pill my-auto">' + item.smallcategory_name + '</span></li>';
	   	                        });
	   	                        
	   	                        html += '</ol>';
	   	                        $("#displayList").html(html);
	   	                        $("#displayList").show();
	   	                    }
	   	                },
	   	                error: function (jqXHR, textStatus, errorThrown) {
	   	                    console.error("AJAX Error:", textStatus, errorThrown);
	   	                    alert("검색 중 오류가 발생했습니다. 자세한 내용은 콘솔을 확인하세요.");
	   	                }
	   	            });
	   	        }
	   	    });
	   	    
	   		// 전체 지우기 버튼 클릭 이벤트 핸들러
	   	    $("#clearAllBtn").on("click", function () {
	   	        // 로컬 스토리지에서 최근 검색어 목록을 제거
	   	        localStorage.removeItem("recentSearchList");

	   	        // 최근 검색어 목록 업데이트
	   	        updateRecentSearchList([]);
	   	    });

	   	    $(document).on('click', "#prosea", function () {
	   	    	var jsonArray = $(document).data('jsonArray');
	   	        var itemIndex = $(this).index(); // 클릭된 항목의 인덱스 가져오기
	   	        var productName = jsonArray[itemIndex].product_name;
	   	        
	   	        $("#displayList").hide();
	   	        
	   	  		// 최근 검색어에 저장
	   	        saveToLocalStorage(productName);
	   	  
		   	    var url = 'list.product?whatColumn=product_name&searchWord=' + productName;
	
		   	    // 페이지 이동
		   	    window.location.href = url;
	   	    	});
	   	    
	   	// 검색어 저장 함수
	   	 function saveToLocalStorage(searchWord) {
	   	     if (searchWord.length > 0) {
	   	         // 로컬 스토리지에서 최근 검색어 목록을 읽어옴
	   	         var recentSearchList = JSON.parse(localStorage.getItem("recentSearchList")) || [];

	   	         // recentSearchList가 배열이 아니면 초기화
	   	         if (!Array.isArray(recentSearchList)) {
	   	             recentSearchList = [];
	   	         }

	   	         // 중복 확인
	   	         var existingIndex = recentSearchList.indexOf(searchWord);
	   	         if (existingIndex !== -1) {
	   	             // 중복된 검색어가 이미 있다면 삭제
	   	             recentSearchList.splice(existingIndex, 1);
	   	         }

	   	         // 최근 검색어 목록에 추가
	   	         recentSearchList.push(searchWord);

	   	         // 로컬 스토리지에 최근 검색어 목록을 저장
	   	         localStorage.setItem("recentSearchList", JSON.stringify(recentSearchList));

	   	         // 최근 검색어 목록 업데이트
	   	         updateRecentSearchList(recentSearchList);
	   	     }
	   	 }
			
			// 최근 검색어 목록 업데이트 함수
			function updateRecentSearchList(list) {
			    var recentSearchListElement = $("#recentSearchList");
			    recentSearchListElement.empty(); // 목록 초기화
			    for (var i = 0; i < list.length; i++) {
			        // 각 검색어 옆에 지우기 버튼 추가
			        var searchWords = list[i].split('/'); // 검색어를 /로 나눔

			        var listItem = $("<li>");

			        for (var j = 0; j < searchWords.length; j++) {
			            // 나눈 각 부분을 리스트에 추가
			            listItem.append("<span class='search-word-part'>" + searchWords[j] + "</span> ");
			        }

			        // 지우기 버튼 추가
			        listItem.append("<button class='delete-btn' data-word='" + list[i] + "'>삭제</button>");

			        // 완성된 리스트 아이템을 목록에 추가
			        recentSearchListElement.append(listItem);
			    }

			}
			
				// 검색어 삭제 버튼 클릭 시
			   $(document).on('click', ".delete-btn", function (event) {
			       event.stopPropagation(); // 부모 클릭 방지
			       var wordToDelete = $(this).data("word");
			
			       // 로컬 스토리지에서 최근 검색어 목록을 읽어옴
			       var recentSearchList = JSON.parse(localStorage.getItem("recentSearchList")) || [];
			
			       // 해당 검색어 삭제
			       var indexToDelete = recentSearchList.indexOf(wordToDelete);
			       if (indexToDelete !== -1) {
			           recentSearchList.splice(indexToDelete, 1);
			           localStorage.setItem("recentSearchList", JSON.stringify(recentSearchList));
			           updateRecentSearchList(recentSearchList);
			       }
			   });
				
	   		});
	   		
	 	
</script>

<style>
	.overlay {
      display: none;
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(255, 255, 255); /* 반투명한 검은 배경 */
      z-index: 1200;
   	}
   
    @font-face {
      font-family: 'IBMPlexSansKR-Regular';
      src: url('resources/font/IBMPlexSansKR-Regular.ttf') format('woff');
      src: url('resources/font/IBMPlexSansKR-Regular.ttf') format('woff2');
    }

    body {
      font-family: 'IBMPlexSansKR-Regular', sans-serif;
      font-size: 12pt;
      font-weight: 500;
    }
    .border{
    	border: none;
    }
    #displayList_img{
      width:100px;
      height:100px;
   }
   .custom-border {
	    border-width: 2px !important;
	    /* 기타 스타일 설정 */
	}
    }
   #clearAllBtn {
   	margin-bottom: 5px;
    padding: 5px 5px; /* 패딩 */
    font-size: 10px; /* 글자 크기 */
    text-align: center; /* 텍스트 중앙 정렬 */
    cursor: pointer; /* 커서 모양을 클릭 가능한 형태로 변경 */
    outline: none; /* 아웃라인 제거 */
    color: #fff; /* 글자 색상 */
    background-color: black; /* 배경 색상 */
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 모서리 둥글게 */
    transition: all 0.3s; /* 클릭 효과를 위한 전환 효과 */
  }

  /* 버튼을 눌렀을 때의 스타일 */
  #clearAllBtn:active {
    background-color: #3e50b4; /* 배경 색상을 어둡게 변경 */
    box-shadow: 0 5px #666; /* 그림자 위치 변경 */
    transform: translateY(4px); /* 버튼을 아래로 조금 이동 */
  }

  /* 마우스 오버 시 버튼 스타일 */
  #clearAllBtn:hover {
    background-color: #6c7ae0; /* 배경 색상 변경 */
  }
  
  /* 최근 검색어를 감싸는 div의 스타일 */
  #recentSearchDiv {
    width: 100%; /* 부모 요소의 너비에 맞춥니다 */
    /* 필요하다면 여기에 추가적인 스타일을 적용하세요 */
  }

  /* 최근 검색어 리스트 스타일 */
  #recentSearchList {
    list-style: none; /* 기본 리스트 스타일 제거 */
    padding-left: 0; /* 리스트의 왼쪽 패딩 제거 */
    display: flex; /* 항목들을 가로로 나열 */
    flex-wrap: wrap; /* 내용이 넘치면 다음 줄로 */
  }

  /* 리스트 아이템 스타일 */
  #recentSearchList li {
    background: #f2f2f2; /* 배경색 설정 */
    margin: 5px; /* 주변과의 거리 설정 */
    border-radius: 20px; /* 타원형 모양을 만들기 위한 굴곡 설정 */
    padding: 5px 15px; /* 내부 여백 설정 */
    display: flex; /* 내부 요소를 가로로 나열 */
    align-items: center; /* 세로 중앙 정렬 */
    justify-content: center; /* 가로 중앙 정렬 */
  }

  /* 삭제 버튼 스타일 */
  .delete-btn {
    cursor: pointer; /* 커서 모양 변경 */
    background: none; /* 배경 투명 */
    border: none; /* 테두리 없음 */
    margin-left: 10px; /* 왼쪽 여백 설정 */
    color: #ff0000; /* 색상 설정 */
  }
  
  /* 인기 키워드 리스트 스타일 */
  ol {
    list-style: none; /* 기본 리스트 스타일 제거 */
    padding-left: 0; /* 리스트의 왼쪽 패딩 제거 */
    background-color: #f9f9f9; /* 배경 색상 설정 */
    border-radius: 8px; /* 모서리 둥글게 */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
    width: 100%; /* 너비 설정 */
    max-width: 600px; /* 최대 너비 설정 */
    margin: 20px auto; /* 상하 마진 20px, 좌우 마진 자동(가운데 정렬) */
    counter-reset: item;
  }

  /* 리스트 아이템 스타일 */
  ol li {
    background-color: #ffffff; /* 배경 색상 설정 */
    padding: 10px 20px; /* 내부 여백 설정 */
    margin: 8px 0; /* 위아래 마진 설정 */
    border-radius: 4px; /* 모서리 둥글게 */
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); /* 그림자 효과 추가 */
    transition: background-color 0.3s ease; /* 배경 색상 변화 애니메이션 */
  }

  /* 리스트 아이템 호버 스타일 */
  ol li:hover {
    background-color: #f0f0f0; /* 호버시 배경 색상 변경 */
  }

  /* 리스트 아이템의 숫자 스타일 */
  ol li::before {
    content: counter(item) ". "; /* 숫자와 점 추가 */
    counter-increment: item; /* 숫자 증가 */
    font-weight: bold; /* 글자 두껍게 */
    margin-right: 10px; /* 숫자와 텍스트 사이의 여백 */
  }
</style>


<div id="overlay" class="overlay">
	<a href="javascript:hideOverlay()">
	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="black" class="bi bi-x-lg" viewBox="0 0 16 16" style="float: right; margin-right: 20px; margin-top: 20px;">
	  <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
	</svg>
	</a>
	<br><br>
	<form action="list.product" onsubmit="return saveTo()" name="searchForm" method="get" style="width: 50%; margin: auto; margin-bottom: 1px;">
	   <div class="d-flex justify-content-between border-bottom border-dark">
	      <div><input type="text" id="searchWord" name="searchWord" autocomplete= 'off' placeholder="브랜드, 상품, 프로필 등" style="border: none; outline: none; width: 500px;"></div>
	      <input type="hidden" name="whatColumn" value="product_name">
	      <div><input type="image" src="resources/icon/search.svg" style="width: 25px; height: 25px;"></div>
	   </div>
	</form>
	<div id="displayList" style="overflow: auto; border-top: 0px; width: 50%; margin: auto;"></div>
	<div class="d-flex justify-content-start" style="border: none; outline: none; width: 50%; margin: auto; margin-top: 3px;">
      <!-- 최근 검색어를 출력하는 부분 추가 -->
		<div id="recentSearchDiv">
		    최근 검색어 <button id="clearAllBtn" >전체 삭제</button>
		    <ul id="recentSearchList"></ul>
		</div>
	</div>
	<div style="margin: auto;">
	    <h2 align="center">인기 키워드</h2>
	    <ol>
	        <c:forEach var="pop" items="${popList}">
	            <li>${pop.keyword}</li>
	        </c:forEach>
	    </ol>
	</div>
</div>

<div class="sticky-top" id="stop">
<div class="px-3 py-2 bg-white">
   <div class="container" style="width:66%;">
      <div
         class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
         <a href="view.main"
            class="d-flex align-items-center my-2 my-lg-0 me-lg-auto text-white text-decoration-none">
            <img src="resources/img/logo.png" class="bi me-2" width="280"
            height="60" role="img" aria-label="#home">
         </a>

         <ul class="nav col-12 col-lg-auto my-2 justify-content-center my-md-0">
            <li>
	            <c:if test="${empty loginInfo and empty kakaoLoginInfo}">
				    <a href="javascript:goLogin()" class="nav-link text-black"> 
				        <img src="resources/icon/box-arrow-in-right.svg" class="bi d-block mx-auto mb-1" width="30" height="30"> 
				        <font size="2">로그인</font>
				    </a>
				</c:if>
				
				<c:if test="${not empty loginInfo or not empty kakaoLoginInfo}">
				    <a href="javascript:goLogoutOrKakaoLogout()" class="nav-link text-black"> 
				        <img src="resources/icon/box-arrow-left.svg" class="bi d-block mx-auto mb-1" width="30" height="30"> 
				        <font size="2">로그아웃</font>
				    </a>
				</c:if>
            </li>
            
            <li>
               <c:if test="${not empty loginInfo or not empty kakaoLoginInfo}">
               <c:if test="${ loginInfo.member_id != 'admin' }">
                <a href="javascript:goMyPage()" class="nav-link text-black"> 
                    <img src="resources/icon/person.svg" class="bi d-block mx-auto mb-1" width="30" height="30"> 
                    <font size="2">마이페이지</font>
                </a>
               </c:if>
               <c:if test="${ loginInfo.member_id == 'admin' }">
                <a href="adminPage.member" class="nav-link text-black"> 
                    <img src="resources/icon/person.svg" class="bi d-block mx-auto mb-1" width="30" height="30"> 
                    <font size="2">관리자페이지</font>
                </a>
               </c:if>
            	</c:if>
            </li>
            
            <li>
            	<c:if test="${empty loginInfo and empty kakaoLoginInfo}">
	               <a href="javascript:goCart()" class="nav-link text-black"> 
	                  <img src="resources/icon/cart.svg" class="bi d-block mx-auto mb-1" width="30" height="30" style="margin-top: 1px;"> 
	                  <font size="2">장바구니</font>
	               </a>
                </c:if>
                
                <c:if test="${not empty loginInfo or not empty kakaoLoginInfo}">
				    <c:choose>
				        <c:when test="${not empty loginInfo and loginInfo.member_id eq 'admin'}">
				            <a href="register.product" class="nav-link text-black">
				                <img src="resources/icon/patch-plus.svg" class="bi d-block mx-auto mb-1" width="30" height="30" style="margin-top: 1px;"> 
				                <font size="2">상품등록</font>
				            </a>
				        </c:when>
				        <c:otherwise>
				            <a href="javascript:goMyCart()" class="nav-link text-black">
				                <img src="resources/icon/cart.svg" class="bi d-block mx-auto mb-1" width="30" height="30" style="margin-top: 1px;"> 
				                <font size="2">장바구니</font>
				            </a>
				        </c:otherwise>
				    </c:choose>
				</c:if>
            </li>
            
            <li>
               <a href="javascript:search()" class="nav-link text-black"> 
               <svg src xmlns="http://www.w3.org/2000/svg" class="bi d-block mx-auto mb-1" width="28" height="28" style="margin-top: 2.5px;" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                 <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
            </svg> 
            <font size="2">검색</font>
               </a>
            </li>
         </ul>
      </div>
   </div>
</div>

<nav class="mb-2 py-2 bg-white border-bottom">
    <div class="container d-flex flex-wrap" style="width:66%;">
      <ul class="nav me-auto">
      	<c:if test="${empty loginInfo and empty kakaoLoginInfo}">
	        <li class="nav-item"><a href="view.main" id="mainNav" class="nav-link link-body-emphasis px-2">HOME</a></li>
	        <li class="nav-item"><a href="login.member" id="closeNav" class="nav-link link-body-emphasis px-2">오늘의 옷비서</a></li>
	        <li class="nav-item"><a href="mainView.style" id="styleNav" class="nav-link link-body-emphasis px-2">STYLE</a></li>
	        <li class="nav-item"><a href="list.product" id="shopNav" class="nav-link link-body-emphasis px-2">SHOP</a></li>
	        <li class="nav-item"><a href="event.member" id="eventNav" class="nav-link link-body-emphasis px-2">EVENT</a></li>
      	</c:if>
      	<c:if test="${not empty loginInfo or not empty kakaoLoginInfo}">
      		<li class="nav-item"><a href="view.main" id="mainNav" class="nav-link link-body-emphasis px-2">HOME</a></li>
	        <li class="nav-item"><a href="view.style" id="closeNav" class="nav-link link-body-emphasis px-2">오늘의 옷비서</a></li>
	        <li class="nav-item"><a href="mainView.style" id="styleNav" class="nav-link link-body-emphasis px-2">STYLE</a></li>
	        <li class="nav-item"><a href="list.product" id="shopNav" class="nav-link link-body-emphasis px-2">SHOP</a></li>
	        <li class="nav-item"><a href="event.member" id="eventNav" class="nav-link link-body-emphasis px-2">EVENT</a></li>
      	</c:if>
      </ul> 
      <ul class="nav">
      	<c:if test="${not empty loginInfo}">
      		<li class="nav-item" style="margin-top: 4px;"><font size="2" color="green">${loginInfo.nickname} 님 환영합니다.</font> &nbsp;</li>
      	</c:if>
      	<c:if test="${not empty kakaoLoginInfo}">
      		<li class="nav-item" style="margin-top: 4px;"><font size="2" color="green">${kakaoLoginInfo.nickname} 님 환영합니다.</font> &nbsp;</li>
      	</c:if>
      	<li class="nav-item"><a href="javascript:goNotice()" class="nav-link link-body-emphasis px-2"><font size="2">공지사항</font></a></li>
        <li class="nav-item"><a href="javascript:goQna()" class="nav-link link-body-emphasis px-2"><font size="2">고객센터</font></a></li>
      </ul>
    </div>
  </nav>
</div>