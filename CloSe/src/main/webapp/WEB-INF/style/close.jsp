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
      #closeNav {
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
           width: 100%;
           margin: auto;
        }
        #wrapper-bg {
          background-size: cover; /* 배경 이미지가 항상 전체를 덮도록 설정합니다. */
          background-position: center; /* 배경 이미지가 항상 중앙에 위치하도록 설정합니다. */
      }
      #result{
         float: left;
         width: 1000px;
      }
    </style>
</head>

<script type="text/javascript">
$(document).ready(function() {
    let queryUrl = "https://api.openweathermap.org/data/2.5/weather?";
    let apiKey = "apiKey";
    let apiOptions = "units=metric";
    let file;
    let lat = null;
    let long = null;

    navigator.geolocation.getCurrentPosition(function(position) {
        lat = position.coords.latitude;
        long = position.coords.longitude;

        if(lat == null || long == null){
            let q = "q=Seoul&";
            file = queryUrl + q + apiKey + apiOptions;
        }else{
            let latQuery = "lat=" + lat + "&";
            let lonQuery = "lon=" + long + "&";
            file = queryUrl + latQuery + lonQuery + apiKey + apiOptions;
        }
        
        fetchFile();
    });

    function fetchFile(){
   fetch(file)
   .then((response) => response.json())
   .then((data) => {
      // Weather main data
      var main = data.weather[0].main;
      var temp = data.main.temp;
      var description = data.weather[0].description;
      var feelTemperature = data.main.feels_like;
      
      document.getElementById("wrapper-temp").innerHTML = temp + "°C";
      document.getElementById("wrapper-feelTemperature-span").innerHTML = "(체감 온도 : " + feelTemperature + "°C)";
      document.getElementById("wrapper-description").innerHTML = description;
      
      let iconBaseUrl = "http://openweathermap.org/img/wn/";
      let iconFormat = ".webp";
      var iconCode = data.weather[0].icon;
      
      let iconFullyUrl = iconBaseUrl + iconCode + iconFormat;
      let iconElement = document.getElementById("wrapper-icon-today");
      if (iconElement) {
          iconElement.src = iconFullyUrl;
      } else {
      }

      // Backgrounds
      switch (main) {
      case "Snow":
      document.getElementById("wrapper-bg").style.backgroundImage =
      "url('https://mdbgo.io/ascensus/mdb-advanced/img/snow.gif')";
      break;
      case "Clouds":
      document.getElementById("wrapper-bg").style.backgroundImage =
      "url('https://mdbgo.io/ascensus/mdb-advanced/img/clouds.gif')";
      break;
      case "Fog":
      document.getElementById("wrapper-bg").style.backgroundImage =
      "url('https://mdbgo.io/ascensus/mdb-advanced/img/fog.gif')";
      break;
      case "Rain":
      document.getElementById("wrapper-bg").style.backgroundImage =
      "url('https://mdbgo.io/ascensus/mdb-advanced/img/rain.gif')";
      break;
      case "Clear":
      document.getElementById("wrapper-bg").style.backgroundImage =
      "url('https://mdbgo.io/ascensus/mdb-advanced/img/clear.gif')";
      break;
      case "Thunderstorm":
      document.getElementById("wrapper-bg").style.backgroundImage =
      "url('https://mdbgo.io/ascensus/mdb-advanced/img/thunderstorm.gif')";
      break;
      default:
      document.getElementById("wrapper-bg").style.backgroundImage =
      "url('https://mdbgo.io/ascensus/mdb-advanced/img/clear.gif')";
      break;
      }
   });
   
   callRequest();
   
   $("input[type='checkbox']").change(function() {
       callRequest();
   });
   
   function callRequest() {
       var checkboxSeasonValues = $("input[name='season']:checked").map(function() {
           return this.value;
       }).get();
       var checkboxGenderValues = $("input[name='gender']:checked").map(function() {
           return this.value;
       }).get();
       var checkboxStyleValues = $("input[name='style']:checked").map(function() {
           return this.value;
       }).get();
       
       var tempValue = "${temp}";

       $.ajax({
           url: 'styleFilter.style',
           method: 'POST',
           data: {
               'seasonArray': checkboxSeasonValues,
               'genderArray': checkboxGenderValues,
               'styleArray': checkboxStyleValues,
               'temp': tempValue
           },
           success: function(response) {
              var contextPath = "<%= request.getContextPath() %>";
               var jsonArray = JSON.parse(response);
               if (!(jsonArray instanceof Array)) { // jsonArray가 배열이 아닌 경우
                    jsonArray = [jsonArray]; // jsonArray를 배열로 변환
                }
                $(document).data('jsonArray', jsonArray);

                var styleContainer = $('#result'); // 결과를 표시할 컨테이너
                styleContainer.empty(); // 결과 컨테이너 초기화
                styleContainer.addClass('d-flex flex-wrap');

                $.each(jsonArray, function(index, styleBean) {
                    if (index % 4 == 0) {
                        var html = '';
                        html += '<div class="flex-column" style="width: 25%;">';
                        html += '<div class="card m-3">';
                        html += '<a href="detail.style?style_number=' + styleBean.style_number + '" class="link-dark link-underline-opacity-0">';
                        html += '<img src="' + contextPath + '/resources/styleImage/' + styleBean.image1 + '" class="card-img-top">';
                        html += '<div class="card-body">';
                        html += '<img src="data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'16\' height=\'16\' fill=\'gray\' class=\'bi bi-person-circle\' viewBox=\'0 0 16 16\'%3E%3Cpath d=\'M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z\'/%3E%3Cpath fill-rule=\'evenodd\' d=\'M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z\'/%3E%3C/svg%3E" alt="Person Icon">';
                        html += styleBean.nickname;
                        html += '<p class="card-text">' + styleBean.title + '</p>';
                        html += '</div>';
                        html += '</a>';
                        html += '</div>';
                        html += '</div>';
                        styleContainer.append(html);
                    }
                    if (index % 4 == 1) {
                        var html = '';
                        html += '<div class="flex-column" style="width: 25%;">';
                        html += '<div class="card m-3">';
                        html += '<a href="detail.style?style_number=' + styleBean.style_number + '" class="link-dark link-underline-opacity-0">';
                        html += '<img src="' + contextPath + '/resources/styleImage/' + styleBean.image1 + '" class="card-img-top">';
                        html += '<div class="card-body">';
                        html += '<img src="data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'16\' height=\'16\' fill=\'gray\' class=\'bi bi-person-circle\' viewBox=\'0 0 16 16\'%3E%3Cpath d=\'M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z\'/%3E%3Cpath fill-rule=\'evenodd\' d=\'M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z\'/%3E%3C/svg%3E" alt="Person Icon">';
                        html += styleBean.nickname;
                        html += '<p class="card-text">' + styleBean.title + '</p>';
                        html += '</div>';
                        html += '</a>';
                        html += '</div>';
                        html += '</div>';
                        styleContainer.append(html);
                    }
                    if (index % 4 == 2) {
                        var html = '';
                        html += '<div class="flex-column" style="width: 25%;">';
                        html += '<div class="card m-3">';
                        html += '<a href="detail.style?style_number=' + styleBean.style_number + '" class="link-dark link-underline-opacity-0">';
                        html += '<img src="' + contextPath + '/resources/styleImage/' + styleBean.image1 + '" class="card-img-top">';
                        html += '<div class="card-body">';
                        html += '<img src="data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'16\' height=\'16\' fill=\'gray\' class=\'bi bi-person-circle\' viewBox=\'0 0 16 16\'%3E%3Cpath d=\'M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z\'/%3E%3Cpath fill-rule=\'evenodd\' d=\'M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z\'/%3E%3C/svg%3E" alt="Person Icon">';
                        html += styleBean.nickname;
                        html += '<p class="card-text">' + styleBean.title + '</p>';
                        html += '</div>';
                        html += '</a>';
                        html += '</div>';
                        html += '</div>';
                        styleContainer.append(html);
                    }
                    if (index % 4 == 3) {
                        var html = '';
                        html += '<div class="flex-column" style="width: 25%;">';
                        html += '<div class="card m-3">';
                        html += '<a href="detail.style?style_number=' + styleBean.style_number + '" class="link-dark link-underline-opacity-0">';
                        html += '<img src="' + contextPath + '/resources/styleImage/' + styleBean.image1 + '" class="card-img-top">';
                        html += '<div class="card-body">';
                        html += '<img src="data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' width=\'16\' height=\'16\' fill=\'gray\' class=\'bi bi-person-circle\' viewBox=\'0 0 16 16\'%3E%3Cpath d=\'M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z\'/%3E%3Cpath fill-rule=\'evenodd\' d=\'M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z\'/%3E%3C/svg%3E" alt="Person Icon">';
                        html += styleBean.nickname;
                        html += '<p class="card-text">' + styleBean.title + '</p>';
                        html += '</div>';
                        html += '</a>';
                        html += '</div>';
                        html += '</div>';
                        styleContainer.append(html);
                    }
                });
           },
           error: function (jqXHR, textStatus, errorThrown) {
               console.error('AJAX Error:', textStatus, errorThrown);
           }
       });
   }
    }
});
</script>
<div>

<div class="d-flex">
<div class="flex-column" style="height: 450px;">
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
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small" id="season">
            <li><input type="checkbox" style="accent-color: black;" name="season" value="Spring"> 봄</li>
            <li><input type="checkbox" style="accent-color: black;" name="season" value="Summer"> 여름</li>
            <li><input type="checkbox" style="accent-color: black;" name="season" value="Fall"> 가을</li>
            <li><input type="checkbox" style="accent-color: black;" name="season" value="Winter"> 겨울</li>
          </ul>
        </div>
      </li>
      <li class="mb-1">
        <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
          성별
        </button>
        <div class="collapse" id="dashboard-collapse" style="margin-left: 30px;">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small" id="gender">
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
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small" id="style">
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
 </div> 
        
        <div class="flex-column" style="width:100%; margin-left: 50px;">
      <div class="col-md-9 col-md-7 col-xl-5" style="width:70%;">
        <div id="wrapper-bg" class="card text-white bg-image shadow-4-strong" style="height: 400px; margin-left: 150px;">
          <!-- Main current data -->
          <div class="card-header pt-4 border-0">
            <div class="text-center mb-3">
              <span class="" style="font-size: 45px;">오늘의 날씨</span><br><br>
              <span class="" style="font-size: 30px;">${ addr }</span><br>
              <span class="" style="font-size: 20px;">${ currentTime }</span><br>
              <p class="display-1 mb-1" id="wrapper-temp"></p>
              <span id="wrapper-feelTemperature-span" style="font-size: 25px;"></span><br>
              <p class="mb-1" id="wrapper-description" style="display: none;"></p>
            </div>
          </div>
          <div class="card-body p-0">
            <div class="row align-items-center">
              <div class="col-sm-12 text-center">
                 <strong>
                 <span>추천 옷 - </span>
                <span class="">         
                   <c:if test="${ temp <= 4.0 }">
                  패딩, 두꺼운코트, 목도리, 기모제품
               </c:if>
               <c:if test="${ temp > 4.0 && temp <= 8.0 }">
                  코트, 가죽자켓, 히트텍, 니트, 레깅스
               </c:if>
               <c:if test="${ temp > 8.0 && temp <= 12.0 }">
                  자켓, 트렌치코트, 야상, 니트, 청바지, 스타킹
               </c:if>
               <c:if test="${ temp > 12.0 && temp <= 16.0 }">
                  자켓, 가디건, 야상, 스타킹, 청바지, 면바지
               </c:if>
               <c:if test="${ temp > 16.0 && temp <= 19.0 }">
                  얇은 니트, 맨투맨, 가디건, 청바지
               </c:if>
               <c:if test="${ temp > 19.0 && temp <= 22.0 }">
                  얇은 가디건, 긴팔, 면바지, 청바지
               </c:if>
               <c:if test="${ temp > 22.0 && temp <= 27.0 }">
                  반팔, 얇은 셔츠, 반바지, 면바지
               </c:if>
               <c:if test="${ temp > 27.0 }">
                  민소매, 반팔, 반바지, 원피스
               </c:if>
            </span>
            </strong>
              </div>

            </div>


          </div>
        </div>
        </div>
           <div id="result" class="d-flex flex-wrap"></div>
      </div>

  
</div>
</div>
<%@ include file="../main/bottom.jsp" %>
