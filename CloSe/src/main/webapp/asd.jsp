<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<h2>weather</h2>
<h3 class="time">현재 시간 : </h3>
<h3 class="ctemp">현재 온도 : </h3>
<h3 class="feel">체감 온도 : </h3>
<h3 class="icon"></h3>
   
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script type="text/javascript">
	$.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=27f0e2dcc40e953d16644b55e897423d&units=metric',function(result){
		
		$('.ctemp').append(result.main.temp);
		var wiconUrl = '<img src="http://openweathermap.org/img/wn/' + result.weather[0].icon + '.png" alt="' + result.weather[0].description + '">'
		$('.icon').html(wiconUrl);
		var ct = result.dt;
		function convertTime(ct){
			
			$('#feel').append(result.main.feels_like);

			
			var ot = new Date(ct*1000);
			var year = ot.getFullYear();
			var month = ot.getMonth() + 1;
			var dt = ot.getDate();
			var hr = ot.getHours();
			var m = ot.getMinutes();
			
			return year + '년 ' + month + '월 ' + dt + '일 ' + hr + '시 기준';
		}
		var currentTime = convertTime(ct);
		$('.time').append(currentTime);
	});
</script>
