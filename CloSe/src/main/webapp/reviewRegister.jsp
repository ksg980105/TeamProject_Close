<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/assets/css/star.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link href="css/star-rating.css" media="all" rel="stylesheet" type="text/css" />
<style>
   #myform fieldset{
    display: inline-block;
    direction: rtl;
    border:0;
}
#myform fieldset legend{
    text-align: right;
}
#myform input[type=radio]{
    display: none;
}
#myform label{
    font-size: 2em;
    color: transparent;
    text-shadow: 0 0 0 #f0f0f0;
}
#myform label:hover{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform label:hover ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
#myform input[type=radio]:checked ~ label{
    text-shadow: 0 0 0 rgba(250, 208, 0, 0.99);
}
.form-control{
   font-size: 20px; 
}
</style>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#myform").submit(function (event) {
            // Check if a rating is selected
            if (!$("input[name='rating']:checked").val()) {
                alert("평점을 선택하세요.");
                event.preventDefault(); // Prevent form submission
            } else {
                // FormData 생성
                var formData = $('#myform').serialize();

                // Ajax를 통해 데이터 전송
                $.ajax({
                    type: "POST",
                    url: "register.review",
                    data: formData,
                    async: false,
                    success: function (data) {
                       if(data=="o"){
                           alert("리뷰가 성공적으로 등록되었습니다.");
                       } else if(data=="x"){
                          alert("이미 리뷰을 등록한 주문입니다.");
                       }
                       
                        window.close();
                    },
                    error: function (error) {
                        alert("리뷰 등록에 실패했습니다.");
                    }
                });
            }
        });
    });
</script>    
<form id="myform" method="post">
   <input type="hidden" name="orderdetail_number" value="${param.orderDetailNumber }">
    <textarea name="text" class="form-control" cols="30" rows="2" maxlength="30"></textarea><br>
    평점:  
    <fieldset> 
    <div style="caret-color: transparent;">
      <input type="radio" name="rating" value="5" id="rate1"><label
         for="rate1">★</label>
      <input type="radio" name="rating" value="4" id="rate2"><label
         for="rate2">★</label>
      <input type="radio" name="rating" value="3" id="rate3"><label
         for="rate3">★</label>
      <input type="radio" name="rating" value="2" id="rate4"><label
         for="rate4">★</label>
      <input type="radio" name="rating" value="1" id="rate5"><label
         for="rate5">★</label>
   </div>
   </fieldset><br>
    <button class="btn btn-dark" type="submit">리뷰 등록</button>
</form>