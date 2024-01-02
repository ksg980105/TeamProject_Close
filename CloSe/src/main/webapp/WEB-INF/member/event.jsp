<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
<%@ include file= "../main/top.jsp" %>

<style>
	#eventNav {
	    font-size: 15pt;
	    font-weight: 700;
	    padding-top: 3px;
	}
	table{
		width: 1050px;
		margin: auto;
		height: 1000px;
	}
	#birth{
		position: relative; top: 430; left: 375;
		opacity: 0;
	}
	#new{
		position: relative; top: 430; left: 830;
		opacity: 0;
	}
	
</style>

<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
    function formatBirthday(birthday) {
        var date = new Date(birthday);
        var year = date.getFullYear();
        var month = ('0' + (date.getMonth() + 1)).slice(-2);
        var day = ('0' + date.getDate()).slice(-2);

        return year + month + day;
    }

    function setCookie(name, value, days) {
        var expires = "";
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
            expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + value + expires + "; path=/";
    }

    function getCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) === ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
        }
        return null;
    }

    //생일쿠폰 받기
    function birthdayCoupon(memberId, birthday) {
        var formattedBirthday = formatBirthday(birthday);

        // 현재 날짜 구하기
        var today = new Date();
        var todayMonth = today.getMonth() + 1; // getMonth()는 0부터 시작하므로 +1
        var todayDay = today.getDate();

        // 생일 날짜 구하기
        var birthdayDate = new Date(birthday);
        var birthdayMonth = birthdayDate.getMonth() + 1;
        var birthdayDay = birthdayDate.getDate();

        // 두 날짜 비교
        if (todayMonth === birthdayMonth && todayDay === birthdayDay) {
            // memberId와 연관된 쿠키 이름 생성
            var birthdayCookie = "couponReceived_" + memberId;

            if (getCookie(birthdayCookie) !== "true") {
                alert("쿠폰이 발급되었습니다.");
                location.href = "coupon.member?memberId=" + memberId + "&name=생일기념 쿠폰&discount=40";

                // 쿠폰을 받은 상태를 쿠키에 저장
                setCookie(birthdayCookie, "true", 30);
            } else {
                alert('이미 쿠폰을 발급받았습니다.');
            }
        } else {
            alert("생일이 아닙니다.");
        }
    }
    
    //신규가입 쿠폰 
    function newRegisterCoupon(memberId){
    	var newCookie = "couponReceived" + memberId;

        if (getCookie(newCookie) !== "true") {
            alert("쿠폰이 발급되었습니다.");
            location.href = "coupon.member?memberId=" + memberId + "&name=신규가입 쿠폰&discount=30";

            // 쿠폰을 받은 상태를 쿠키에 저장
            setCookie(newCookie, "true", 30);
        } else {
            alert('이미 쿠폰을 발급받았습니다.');
        }
    }

    function goLogin() {
        alert('로그인 후 이용해주세요.');
        location.href = "login.member";
    }
</script>



<table style="background-image: url('resources/img/newRegi.png'); margin-bottom: 35px;">
	<tr>
		<td id="birth">
			<c:if test="${empty loginInfo and empty kakaoLoginInfo}">
				<input type="button" style="width: 330px; height: 65px;" onclick="goLogin()">
			</c:if>
			<c:if test="${not empty loginInfo}">
				<input type="button" style="width: 330px; height: 65px;" onclick="newRegisterCoupon('${loginInfo.member_id}')">
			</c:if>
			<c:if test="${not empty kakaoLoginInfo}">
				<input type="button" style="width: 330px; height: 65px;" onclick="newRegisterCoupon('${kakaoLoginInfo.member_id}')">
			</c:if>
		</td>
	</tr>
</table>

<table id="birthdayTable" style="background-image: url('resources/img/birthday.png');">
	<tr>
		<td id="new">
			<c:if test="${empty loginInfo and empty kakaoLoginInfo}">
				<input type="button" style="width: 125px; height: 32px;" onclick="goLogin()">
			</c:if>
			<c:if test="${not empty loginInfo}">
				<input type="button" style="width: 125px; height: 32px;" onclick="birthdayCoupon('${loginInfo.member_id}','${loginInfo.birth}')">
			</c:if>
			<c:if test="${not empty kakaoLoginInfo}">
				<input type="button" style="width: 125px; height: 32px;" onclick="birthdayCoupon('${kakaoLoginInfo.member_id}','${kakaoLoginInfo.birth}')">
			</c:if>
		</td>
	</tr>
</table>

<%@ include file="../main/bottom.jsp" %>