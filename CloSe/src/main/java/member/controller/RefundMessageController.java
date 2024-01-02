package member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class RefundMessageController {

	@RequestMapping(value = "/sendSms.member")
	@ResponseBody
	public String sendSms(HttpServletRequest request) throws Exception {
		
		// 문자인증 api
		String phone = request.getParameter("phone");
		System.out.println(phone);
		String api_key = "api_key";
		String api_secret = "api_secret";
		Message coolsms = new Message(api_key, api_secret);

		HashMap<String, String> set = new HashMap<String, String>();
		set.put("to", phone);

		String random = String.valueOf((int)(Math.random()*999999+10000));
		set.put("from", "phone");
		set.put("text", "인증번호는 ["+random+"] 입니다.");
		set.put("type", "sms");
		set.put("app_version", "test app 1.2"); 

		System.out.println(set);
		try {
			JSONObject result = (JSONObject) coolsms.send(set);

			System.out.println(result.toString());
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		return random;
	}

}
