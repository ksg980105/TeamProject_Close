package style.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import style.model.StyleBean;
import style.model.StyleDao;

@Controller
public class CloseViewController {

   private final String command = "/view.style";
   private final String viewPage = "close";

   public String latString = "";
   public String longString = "";

   @Autowired
   StyleDao styleDao;
   
    public static String coordToAddr(String longitude, String latitude) {
        String url = "https://dapi.kakao.com/v2/local/geo/coord2address.json?x=" + longitude + "&y=" + latitude;
        String addr = "";
        try {
            addr = getRegionAddress(getJSONData(url));
        } catch (Exception e) {
            System.out.println("주소 api 요청 에러");
            e.printStackTrace();
        }
        return addr;
    }
    
    private static String getJSONData(String apiUrl) throws Exception {
        HttpURLConnection conn = null;
        StringBuilder response = new StringBuilder();

        String auth = "KakaoAK " + "44b34b58cb54c27ae218a2289fc544d9";

        URL url = new URL(apiUrl);

        conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("GET");
        conn.setRequestProperty("X-Requested-With", "curl");
        conn.setRequestProperty("Authorization", auth);

        conn.setDoOutput(true);

        int responseCode = conn.getResponseCode();
        if (responseCode == 400) {
            System.out.println("400:: 해당 명령을 실행할 수 없음");
        } else if (responseCode == 401) {
            System.out.println("401:: Authorization가 잘못됨");
        } else if (responseCode == 500) {
            System.out.println("500:: 서버 에러, 문의 필요");
        } else { // 성공 후 응답 JSON 데이터받기

            BufferedReader br = new BufferedReader(
                    new InputStreamReader(conn.getInputStream(), java.nio.charset.StandardCharsets.UTF_8));

            String inputLine;
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
        }

        return response.toString();
    }

    private static String getRegionAddress(String jsonString) {
        String value = "";
        try {
            JSONObject jObj = new JSONObject(jsonString);
            JSONArray documents = jObj.getJSONArray("documents");
            if (documents.length() > 0) {
                JSONObject address = documents.getJSONObject(0).getJSONObject("address");
                String region1 = address.getString("region_1depth_name");
                String region2 = address.getString("region_2depth_name");
                String region3 = address.getString("region_3depth_name");
                value = region1 + " " + region2 + " " + region3;
            }
        } catch (Exception e) {
            System.out.println("JSON에서 주소 추출 중 오류 발생");
            e.printStackTrace();
        }
        return value;
    }

   // 현재 위치좌표 받아오기
    @RequestMapping(value = command, method = RequestMethod.POST)
    public void temp(@RequestParam("latitude") double latitude, @RequestParam("longitude") double longitude) {
        String addr = coordToAddr(String.valueOf(longitude), String.valueOf(latitude));

        System.out.println("Latitude: " + latitude);
        System.out.println("Longitude: " + longitude);
        System.out.println("Address: " + addr);

        this.latString = String.valueOf(latitude);
        this.longString = String.valueOf(longitude);
    }

   @RequestMapping(value = command, method = RequestMethod.GET)
   public String close(Model model) {
      
      System.out.println("latString: " + latString);
      System.out.println("longString: " + longString);
      
      String addr = coordToAddr(longString, latString);
       System.out.println("Address: " + addr);
       
       model.addAttribute("addr", addr);

      String apiUrl = "";
      if (latString == null || longString == null) {
         apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=27f0e2dcc40e953d16644b55e897423d&units=metric";
      } else {
         apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=" + latString + "&lon=" + longString
               + "&appid=27f0e2dcc40e953d16644b55e897423d&units=metric";
      }
      try {

         URL url = new URL(apiUrl);
         HttpURLConnection connection = (HttpURLConnection) url.openConnection();
         connection.setRequestMethod("GET");

         System.out.println("apiUrl : " + apiUrl);

         BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
         StringBuilder response = new StringBuilder();
         String line;
         while ((line = reader.readLine()) != null) {
            response.append(line);
         }
         reader.close();
         connection.disconnect();
         // JSON 데이터 파싱
         JSONObject result = new JSONObject(response.toString());
         // 날씨 정보 출력
         double temp = result.getJSONObject("main").getDouble("temp");
         double feelTemperature = result.getJSONObject("main").getDouble("feels_like");
         long dt = result.getLong("dt");

         Date ot = new Date(dt * 1000);
         SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 기준");
         String currentTime = sdf.format(ot);

         System.out.println("temp : " + temp + "°C");
         System.out.println("feelTemperature : " + feelTemperature + "°C");
         System.out.println("currentTime : " + currentTime);
         model.addAttribute("temp", temp);
         model.addAttribute("feelTemperature", feelTemperature);
         model.addAttribute("currentTime", currentTime);
         model.addAttribute("latString", latString);
         model.addAttribute("longString", longString);

         // 추가: 이미지 URL 및 설명을 모델에 추가
         String wiconUrl = "http://openweathermap.org/img/wn/"
               + result.getJSONArray("weather").getJSONObject(0).getString("icon") + ".png";
         String description = result.getJSONArray("weather").getJSONObject(0).getString("description");

         model.addAttribute("wiconUrl", wiconUrl);
         model.addAttribute("description", description);

         Map<String, Double> map = new HashMap<String, Double>();
         map.put("temp", temp);

         List<StyleBean> lists = styleDao.getTemperatureByStyle(map);

         System.out.println("전체 lists 크기: " + lists.size());

         // 전체 lists 크기 출력

         model.addAttribute("lists", lists);

         // 클릭 이벤트 처리 및 AJAX 호출
         String closeApiUrl = "/view.style?temp=" + temp;
         System.out.println("Click Event: " + closeApiUrl);
         // 여기서 AJAX 호출로 대체할 부분을 구현하면 됩니다.

      } catch (IOException e) {
         e.printStackTrace();
      }

      return viewPage;

   }
}