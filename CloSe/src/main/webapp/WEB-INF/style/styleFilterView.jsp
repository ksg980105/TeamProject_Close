<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file= "../main/top.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photo Tagging</title>
    <style>
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
        
        #styleContainer{
        	width: 66%;
        	margin: auto;
        }
        
    </style>
</head>

<div class="d-flex justify-content-start">
<div class="flex-shrink-0 p-3 bg-white" style="width: 280px;">
    <a href="/" class="d-flex align-items-center pb-3 mb-3 link-dark text-decoration-none border-bottom">
      <svg class="bi me-2" width="30" height="24"><use xlink:href="#bootstrap"></use></svg>
      <span class="fs-5 fw-semibold">필터</span>
    </a>
    <ul class="list-unstyled ps-0">
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded" data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
          계절
        </button>
        <div class="collapse show" id="home-collapse" style="margin-left: 30px;">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li><input type="checkbox" style="accent-color: black;" id="season" name="season" value="Spring" onClick=""> Spring</li>
            <li><input type="checkbox" style="accent-color: black;" id="season" name="season" value="Summer"> Summer</li>
            <li><input type="checkbox" style="accent-color: black;" id="season" name="season" value="Fall"> Fall</li>
            <li><input type="checkbox" style="accent-color: black;" id="season" name="season" value="Winter"> Winter</li>
          </ul>
        </div>
      </li>
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
          성별
        </button>
        <div class="collapse" id="dashboard-collapse" style="margin-left: 30px;">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
            <li><input type="checkbox" style="accent-color: black;" name="gender" value="남자"> 남자</li>
            <li><input type="checkbox" style="accent-color: black;" name="gender" value="여자"> 여자</li>
          </ul>
        </div>
      </li>
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#orders-collapse" aria-expanded="false">
          스타일
        </button>
        <div class="collapse" id="orders-collapse" style="margin-left: 30px;">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
          	<li><input type="checkbox" style="accent-color: black;" name="style" value="로맨틱"> 로맨틱</li>
            <li><input type="checkbox" style="accent-color: black;" name="style" value="모던"> 모던</li>
            <li><input type="checkbox" style="accent-color: black;" name="style" value="미니멀"> 미니멀</li>
            <li><input type="checkbox" style="accent-color: black;" name="style" value="빈티지"> 빈티지</li>
            <li><input type="checkbox" style="accent-color: black;" name="style" value="스트릿"> 스트릿</li>
            <li><input type="checkbox" style="accent-color: black;" name="style" value="스포티"> 스포티</li>
            <li><input type="checkbox" style="accent-color: black;" name="style" value="아메카지"> 아메카지</li>
            <li><input type="checkbox" style="accent-color: black;" name="style" value="캐주얼"> 캐주얼</li>
            <li><input type="checkbox" style="accent-color: black;" name="style" value="클래식"> 클래식</li>
          </ul>
        </div>
      </li>
    </ul>
  </div>

<table border="1" style="margin: auto;">
	<tr>
		<td>오늘의 날씨</td>
	</tr>
	<tr>
		<td>${currentTime}</td>
	</tr>
	<tr>
		<td>
			날씨 : <img src="${wiconUrl}" alt="Weather Icon"> / ${ description }
		</td>
	</tr>
	<tr>
		<td>현재 온도 : ${ temp }</td>
	</tr>
	<tr>
		<td>체감 온도 : ${ feelTemperature }</td>
	</tr>
	<tr>
		<td>
			<c:if test="${ temp <= 4.0 }">
				추천 옷 : 패딩, 두꺼운코트, 목도리, 기모제품
			</c:if>
			<c:if test="${ temp > 4.0 && temp <= 8.0 }">
				추천 옷 : 코트, 가죽자켓, 히트텍, 니트, 레깅스
			</c:if>
			<c:if test="${ temp > 8.0 && temp <= 12.0 }">
				추천 옷 : 자켓, 트렌치코트, 야상, 니트, 청바지, 스타킹
			</c:if>
			<c:if test="${ temp > 12.0 && temp <= 16.0 }">
				추천 옷 : 자켓, 가디건, 야상, 스타킹, 청바지, 면바지
			</c:if>
			<c:if test="${ temp > 16.0 && temp <= 19.0 }">
				추천 옷 : 얇은 니트, 맨투맨, 가디건, 청바지
			</c:if>
			<c:if test="${ temp > 19.0 && temp <= 22.0 }">
				추천 옷 : 얇은 가디건, 긴팔, 면바지, 청바지
			</c:if>
			<c:if test="${ temp > 22.0 && temp <= 27.0 }">
				추천 옷 : 반팔, 얇은 셔츠, 반바지, 면바지
			</c:if>
			<c:if test="${ temp > 27.0 }">
				추천 옷 : 민소매, 반팔, 반바지, 원피스
			</c:if>
       </td>
	</tr>
</table>



  <div class="d-flex flex-wrap" id="styleContainer">
    <c:forEach var="styleBean" items="${lists}" varStatus="status">
        <c:if test="${status.index % 3 == 0}">
        	<c:if test="${status.index == 0}">
            	<div class="flex-column" style="width: 25%;">
            </c:if>

	        <div class="card m-3">
	            <a href="detail.style?style_number=${styleBean.style_number}" class="link-dark link-underline-opacity-0">
	                <img src="<%=request.getContextPath()%>/resources/styleImage/${styleBean.image1}" class="card-img-top">
	                <div class="card-body">
	                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='gray' class='bi bi-person-circle' viewBox='0 0 16 16'%3E%3Cpath d='M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z'/%3E%3Cpath fill-rule='evenodd' d='M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z'/%3E%3C/svg%3E" alt="Person Icon">
	                    ${styleBean.nickname}
	                    <p class="card-text">${styleBean.title}</p>
	                </div>
	            </a>
	        </div>
        </c:if>
    </c:forEach>
	</div>
	<c:forEach var="styleBean" items="${lists}" varStatus="status">
        <c:if test="${status.index % 3 == 1}">
        	<c:if test="${status.index == 1}">
            	<div class="flex-column" style="width: 25%;">
            </c:if>

	        <div class="card m-3">
	            <a href="detail.style?style_number=${styleBean.style_number}" class="link-dark link-underline-opacity-0">
	                <img src="<%=request.getContextPath()%>/resources/styleImage/${styleBean.image1}" class="card-img-top">
	                <div class="card-body">
	                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='gray' class='bi bi-person-circle' viewBox='0 0 16 16'%3E%3Cpath d='M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z'/%3E%3Cpath fill-rule='evenodd' d='M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z'/%3E%3C/svg%3E" alt="Person Icon">
	                    ${styleBean.nickname}
	                    <p class="card-text">${styleBean.title}</p>
	                </div>
	            </a>
	        </div>

        </c:if>
    </c:forEach>
    </div>
    <c:forEach var="styleBean" items="${lists}" varStatus="status">
        <c:if test="${status.index % 3 == 2}">
        	<c:if test="${status.index == 2}">
            	<div class="flex-column" style="width: 25%;">
            </c:if>

	        <div class="card m-3">
	            <a href="detail.style?style_number=${styleBean.style_number}" class="link-dark link-underline-opacity-0">
	                <img src="<%=request.getContextPath()%>/resources/styleImage/${styleBean.image1}" class="card-img-top">
	                <div class="card-body">
	                    <img src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='gray' class='bi bi-person-circle' viewBox='0 0 16 16'%3E%3Cpath d='M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z'/%3E%3Cpath fill-rule='evenodd' d='M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z'/%3E%3C/svg%3E" alt="Person Icon">
	                    ${styleBean.nickname}
	                    <p class="card-text">${styleBean.title}</p>
	                </div>
	            </a>
	        </div>

        </c:if>
    </c:forEach>
    </div>
	</div>  
</div>
<%@ include file="../main/bottom.jsp" %>