<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../main/top.jsp" %>

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
       
       .custom-height{
            height:  200px;
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
        
        #styleContainer{
           width: 66%;
           margin: auto;
           
        }
        
        #imageMulti{
           position: absolute;
           top:5px;
           left: 14vw;
        }
    </style>

<script>
var page = 1;
var pageSize = 12;
var loadingData = false;  // 데이터 로딩 중인지 여부를 나타내는 플래그
var flag = false;

//페이지 로딩 후 처음 한 번은 바로 데이터를 로드하고, 그 후에는 일정한 간격으로 호출
$(document).ready(function () {
    // 페이지 로딩 후 한 번만 데이터를 로딩
    loadMoreData();
});

$(window).scroll(function () {
    if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
        if (!loadingData) {  // 로딩 중이 아닌 경우에만 실행
            loadingData = true;  // 로딩 시작
            page++;
            loadMoreData();
            

            // 일정 시간(예: 10초) 후에 로딩 상태를 해제
            setTimeout(function () {
                loadingData = false;
            }, 1000);  // 10000 밀리초 = 10초
        }
    }
});

function loadMoreData() {
    $.ajax({
        url: 'mainView.style',
        type: 'POST',
        data: { page: page, pageSize: pageSize },
        success: function (json) {
            if (json.length > 0) {
               if(!flag){
                  alert("로딩 표시 확인");
                  flag = true;
               }
                var jsonArray = JSON.parse(json);
                $(document).data('jsonArray', jsonArray);
                var contextPath = '<%= request.getContextPath() %>';
                $.each(jsonArray, function (index, styleBean) {
                    if (index % 4 === 0) {
                         var html = '';
                       html += '<div class="card m-2 border-0">';
                       if(styleBean.image2 != null){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#C0C0C0" class="bi bi-images" id="imageMulti" viewBox="0 0 16 16"><path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3"/><path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2M14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1M2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10"/></svg>';
                       }
                       html += '<a href="detail.style?style_number=' + styleBean.style_number + '" class="link-dark link-underline-opacity-0">';
                       html += '<div class="card-body p-0">';
                       html += '<img src="' + contextPath + '/resources/styleImage/' + styleBean.image1 + '" style="max-height: 450px;" class="card-img-top">';
                       html += '<div class="d-flex align-items-center">';
                       if(styleBean.member_image == null){
                          html += '<img src = "https://static.nid.naver.com/images/web/user/default.png" id="profile" style="width:2vw; height: 2vw; margin-top: 5px; border-radius: 100%; border: 0.5px solid #C0C0C0;">';
                       } else if(styleBean.member_image != null) {
                          html += '<img src="' + contextPath + '/resources/memberImage/' + styleBean.member_image + '" id="profile" style="width:2vw; height: 2vw; margin-top: 5px; border-radius: 100%; border: 0.5px solid #C0C0C0;">';
                       }
                       html += '<div style="width: 100px;">'+styleBean.nickname + "</div>";
                       html += '<div style="width:100%; text-align: right;">';
                       if(!styleBean.heartFlag){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="#C0C0C0" class="bi bi-heart" viewBox="0 0 16 16"><path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/></svg>'
                       } else if(styleBean.heartFlag){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="#f93737" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/></svg>'
                       }
                       html += '<span class="like-count" style="margin-left: 5px;">'+styleBean.heartCount+'</span>';
                       html += '</div>';
                       html += '</div>';
                       if(styleBean.title != null){
                          html += '<p class="card-text" style="font-size: 10pt; margin-top: 5px;">' + styleBean.title + '</p>';
                       } else if(styleBean.title == null){
                          html += '<p class="card-text" style="font-size: 10pt; margin-top: 5px;">' + styleBean.content + '</p>';
                       }
                       html += '</div>';
                       html += '</a>';
                       html += '</div>';
                       $("#firstCol").append(html);
                    }
                    
                    if (index % 4 === 1) {
                       var html = '';
                       html += '<div class="card m-2 border-0">';
                       if(styleBean.image2 != null){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#C0C0C0" class="bi bi-images" id="imageMulti" viewBox="0 0 16 16"><path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3"/><path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2M14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1M2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10"/></svg>';
                       }
                       html += '<a href="detail.style?style_number=' + styleBean.style_number + '" class="link-dark link-underline-opacity-0">';
                       html += '<div class="card-body p-0">';
                       html += '<img src="' + contextPath + '/resources/styleImage/' + styleBean.image1 + '" style="max-height: 450px;" class="card-img-top">';
                       html += '<div class="d-flex align-items-center">';
                       if(styleBean.member_image == null){
                          html += '<img src = "https://static.nid.naver.com/images/web/user/default.png" id="profile" style="width:2vw; height: 2vw; margin-top: 5px; border-radius: 100%; border: 0.5px solid #C0C0C0;">';
                       } else if(styleBean.member_image != null) {
                          html += '<img src="' + contextPath + '/resources/memberImage/' + styleBean.member_image + '" id="profile" style="width:2vw; height: 2vw; margin-top: 5px; border-radius: 100%; border: 0.5px solid #C0C0C0;">';
                       }
                       html += '<div style="width: 100px;">'+styleBean.nickname + "</div>";
                       html += '<div style="width:100%; text-align: right;">';
                       if(!styleBean.heartFlag){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="#C0C0C0" class="bi bi-heart" viewBox="0 0 16 16"><path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/></svg>'
                       } else if(styleBean.heartFlag){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="#f93737" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/></svg>'
                       }
                       html += '<span class="like-count" style="margin-left: 5px;">'+styleBean.heartCount+'</span>';
                       html += '</div>';
                       html += '</div>';
                       if(styleBean.title != null){
                          html += '<p class="card-text" style="font-size: 10pt; margin-top: 5px;">' + styleBean.title + '</p>';
                       } else if(styleBean.title == null){
                          html += '<p class="card-text" style="font-size: 10pt; margin-top: 5px;">' + styleBean.content + '</p>';
                       }
                       html += '</div>';
                       html += '</a>';
                       html += '</div>';
                       $("#secondCol").append(html);
                    }
                   
                    if (index % 4 === 2) {
                       var html = '';
                       html += '<div class="card m-2 border-0">';
                       if(styleBean.image2 != null){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#C0C0C0" class="bi bi-images" id="imageMulti" viewBox="0 0 16 16"><path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3"/><path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2M14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1M2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10"/></svg>';
                       }
                       html += '<a href="detail.style?style_number=' + styleBean.style_number + '" class="link-dark link-underline-opacity-0">';
                       html += '<div class="card-body p-0">';
                       html += '<img src="' + contextPath + '/resources/styleImage/' + styleBean.image1 + '" style="max-height: 450px;" class="card-img-top">';
                       html += '<div class="d-flex align-items-center">';
                       if(styleBean.member_image == null){
                          html += '<img src = "https://static.nid.naver.com/images/web/user/default.png" id="profile" style="width:2vw; height: 2vw; margin-top: 5px; border-radius: 100%; border: 0.5px solid #C0C0C0;">';
                       } else if(styleBean.member_image != null) {
                          html += '<img src="' + contextPath + '/resources/memberImage/' + styleBean.member_image + '" id="profile" style="width:2vw; height: 2vw; margin-top: 5px; border-radius: 100%; border: 0.5px solid #C0C0C0;">';
                       }
                       html += '<div style="width: 100px;">'+styleBean.nickname + "</div>";
                       html += '<div style="width:100%; text-align: right;">';
                       if(!styleBean.heartFlag){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="#C0C0C0" class="bi bi-heart" viewBox="0 0 16 16"><path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/></svg>'
                       } else if(styleBean.heartFlag){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="#f93737" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/></svg>'
                       }
                       html += '<span class="like-count" style="margin-left: 5px;">'+styleBean.heartCount+'</span>';
                       html += '</div>';
                       html += '</div>';
                       if(styleBean.title != null){
                          html += '<p class="card-text" style="font-size: 10pt; margin-top: 5px;">' + styleBean.title + '</p>';
                       } else if(styleBean.title == null){
                          html += '<p class="card-text" style="font-size: 10pt; margin-top: 5px;">' + styleBean.content + '</p>';
                       }
                       html += '</div>';
                       html += '</a>';
                       html += '</div>';
                       $("#thirdCol").append(html);
                    }

                    if (index % 4 === 3) {
                       var html = '';
                       html += '<div class="card m-2 border-0">';
                       if(styleBean.image2 != null){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#C0C0C0" class="bi bi-images" id="imageMulti" viewBox="0 0 16 16"><path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3"/><path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2M14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1M2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1h-10"/></svg>';
                       }
                       html += '<a href="detail.style?style_number=' + styleBean.style_number + '" class="link-dark link-underline-opacity-0">';
                       html += '<div class="card-body p-0">';
                       html += '<img src="' + contextPath + '/resources/styleImage/' + styleBean.image1 + '" style="max-height: 450px;" class="card-img-top">';
                       html += '<div class="d-flex align-items-center">';
                       if(styleBean.member_image == null){
                          html += '<img src = "https://static.nid.naver.com/images/web/user/default.png" id="profile" style="width:2vw; height: 2vw; margin-top: 5px; border-radius: 100%; border: 0.5px solid #C0C0C0;">';
                       } else if(styleBean.member_image != null) {
                          html += '<img src="' + contextPath + '/resources/memberImage/' + styleBean.member_image + '" id="profile" style="width:2vw; height: 2vw; margin-top: 5px; border-radius: 100%; border: 0.5px solid #C0C0C0;">';
                       }
                       html += '<div style="width: 100px;">'+styleBean.nickname + "</div>";
                       html += '<div style="width:100%; text-align: right;">';
                       if(!styleBean.heartFlag){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="#C0C0C0" class="bi bi-heart" viewBox="0 0 16 16"><path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15"/></svg>'
                       } else if(styleBean.heartFlag){
                          html += '<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="#f93737" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/></svg>'
                       }
                       html += '<span class="like-count" style="margin-left: 5px;">'+styleBean.heartCount+'</span>';
                       html += '</div>';
                       html += '</div>';
                       if(styleBean.title != null){
                          html += '<p class="card-text" style="font-size: 10pt; margin-top: 5px;">' + styleBean.title + '</p>';
                       } else if(styleBean.title == null){
                          html += '<p class="card-text" style="font-size: 10pt; margin-top: 5px;">' + styleBean.content + '</p>';
                       }
                       html += '</div>';
                       html += '</a>';
                       html += '</div>';
                       $("#fourthCol").append(html);
                    }
                });
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error("AJAX Error:", textStatus, errorThrown);
            alert("검색 중 오류가 발생했습니다. 자세한 내용은 콘솔을 확인하세요.");
        }
    });
}

$(document).ajaxStart(function () {
    // AJAX 요청이 시작되면 로딩 아이콘을 보여줌
    $("#loadingIcon").show();
});

$(document).ajaxStop(function () {
    // AJAX 요청이 모두 완료되면 로딩 아이콘을 숨김
    $("#loadingIcon").hide();
});
</script>
</head>
<body>

<div class="body">
    <!-- 이미지 컨테이너 -->
    <div style="width:66%; margin: auto; text-align: center;">
        <img class="d-block w-100 custom-height" src="resources/img/holilook.png">
    </div>

    <!-- 나의 코디 버튼 -->
    <c:if test="${not empty loginInfo or not empty kakaoLoginInfo}">
      <div style="width:66%; margin: auto; margin-top: 10px; margin-bottom: 10px;" class="d-flex justify-content-end">
           <input class="btn btn-dark" style="float: right;" type="button" value="스타일 등록" onclick="location.href='insert.style'">
       </div>
   </c:if>

   <c:set var="index" value="0"/>
    <!-- 스타일 컨테이너 -->
    <div class="d-flex flex-wrap" id="styleContainer">
        
        <c:if test="${index == 0}">
            <div class="flex-column" id="firstCol" style="width: 25%;">
            <c:set var="index" value="${index+1}"/>
        </c:if>
            </div>
            
      <c:if test="${index == 1}">
            <div class="flex-column" id="secondCol" style="width: 25%;">
            <c:set var="index" value="${index+1}"/>
        </c:if>
            </div>
         
         <c:if test="${index == 2}">
            <div class="flex-column" id="thirdCol" style="width: 25%;">
            <c:set var="index" value="${index+1}"/>
        </c:if>
            </div>
            
         <c:if test="${index == 3}">
            <div class="flex-column" id="fourthCol" style="width: 25%;">
            <c:set var="index" value="${index+1}"/>
        </c:if>
            </div>
            
    </div>
    
    <div style="width:100%; margin: auto; text-align: center;">
        <img src="resources/icon/Rolling-1s-200px.gif" id="loadingIcon" style="width: 100px; height: 100px;">
    </div>
    
</div>
</body>
</html>
<%@ include file="../main/bottom.jsp" %>