script.js
/**
 * script.js
 */
 
var isCheck = false;
var use;
var pwuse;

$(function(){
	$("input[name=id]").keydown(function(){
		$("#idmessage").css('display','none');
		isCheck = false;
		use = "";
	});
});

function searchAddress(){
	new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById("address1").value = data.address;
        }
    }).open();
}

function repassword_keyup(){
	//alert(1);
	if($("input[name=password]").val() == $("input[name=passwordcheck]").val()){
		$("#pwmessage").html("<font color = blue>비밀번호 일치</font>");
		pwuse = "same";
	} else {
		$("#pwmessage").html("<font color = red>비밀번호 불일치</font>");
		pwuse = "nosame";
	}
}

function pwcheck(){ // 영문 소문자/숫자 조합 8~16자
	pvalue = $("input[name=password").val();
	
	var regexp = /^[a-z0-9]{8,16}$/;
	
	if(pvalue.search(regexp) == -1){
		alert("길이는 8~16 사이어야 합니다.");
		pwerror = "error";
		setTimeout(function(){               
			f.password.select();             
		}, 10);
		return false;
	}
	
	var chk_eng = pvalue.search(/[a-z]/i); // i는 대소문자 구분하지 않는다 즉, [a-z]/i = [a-zA-Z]
	var chk_num = pvalue.search(/[0-9]/);
	if(chk_eng<0 || chk_num<0){
		alert("영문 소문자, 숫자 조합이 아닙니다.");
		pwerror = "error";
		setTimeout(function(){               
			f.password.select();             
		}, 10);
		return false;
	} else {
		pwerror = "";
	}
	
}


function idformcheck(){
	if(f.name.value == ""){
		alert('이름을 입력하세요.');
		return false;
	}

	if(isNaN(f.phone.value)){
		alert("휴대폰 번호는 숫자로 입력해 주세요.");
		setTimeout(function(){               
			f.phone.select();             
		}, 10);
		return false;
	}
	
	if(f.phone.value.length<11){
		alert("휴대폰 번호를 전부 입력해 주세요.");
		setTimeout(function(){               
			f.phone.focus();             
		}, 10);
		return false;
	}
}

function pwformcheck(){
	
	if(f.member_id.value == ""){
		alert('아이디를 입력하세요.');
		return false;
	}

	if(isNaN(f.phone.value)){
		alert("휴대폰 번호는 숫자로 입력해 주세요.");
		return false;
	}
	
	if(f.phone.value.length<11){
		alert("휴대폰 번호를 전부 입력해 주세요.");
		return false;
	}
	
	if (f.email.value.trim() == "") {
        alert('이메일을 입력하세요.');
        return false;
    }
	
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

    if (!emailPattern.test(f.email.value)) {
        alert('올바른 이메일 형식이 아닙니다.');
        return false;
    }
}

function updatecheck(){
	if(f.nickname.value == ""){
		alert('닉네임을 입력하세요.');
		return false;
	}
	
	if(f.password.value == ""){
		alert('비밀번호를 입력하세요.');
		return false;
	}
	
	if(f.address1.value == ""){
		alert('도로명주소를 입력하세요.');
		return false;
	}
	
	if(f.address2.value == ""){
		alert('상세주소를 입력하세요.');
		return false;
	}
	
	if (f.email.value.trim() == "") {
        alert('이메일을 입력하세요.');
        return false;
    }
	
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

    if (!emailPattern.test(f.email.value)) {
        alert('올바른 이메일 형식이 아닙니다.');
        return false;
    }
    
    if(f.height.value == ""){
		alert('키를 입력하세요.');
		return false;
	}
	
	if(f.weight.value == ""){
		alert('몸무게를 입력하세요.');
		return false;
	}
}
