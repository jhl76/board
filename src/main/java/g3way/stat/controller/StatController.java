package g3way.stat.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import g3way.stat.service.StatService;
import g3way.stat.vo.SidoVo;
import g3way.stat.vo.UmdVo;

@Controller("StatController")
public class StatController {

	@Autowired
	private StatService statService;
	
	@RequestMapping("/gisHome.do")
	public String gisHome(Model model) throws Exception{
		SidoVo sido = statService.sidoList();
		model.addAttribute("sido", sido);
		return "gisHome";
	}
	
	@RequestMapping(value = "/getEmdInfoByPoint.do", method = RequestMethod.POST)
	public ModelAndView getEmdInfoByPoint(@RequestParam double lat, @RequestParam double lng) throws Exception
	{
		System.out.println("lat : " + lat);
		System.out.println("lng : " + lng); 
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try { 
			UmdVo umd = statService.getEmdInfoByPoint(lat, lng);
			if (umd != null) {
				resultMap.put("status", "success");
				resultMap.put("umd", umd);
			}else {
				resultMap.put("status", "error"); 
			}
		} catch (Exception e) {
			 e.printStackTrace();
			 resultMap.put("status", "error");
		}
		ModelAndView mav = new ModelAndView("jsonView");
		mav.addObject("resultMap", resultMap);
		return mav;
	}
	
	@RequestMapping("/gisOlHome.do")
	public String gisOlHome() throws Exception{
		return "gisOlHome";
	}
	
	@RequestMapping(value = "/proxy.do", method = RequestMethod.GET)
	public ModelAndView proxy() throws Exception
	{
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    ModelAndView mav = new ModelAndView("jsonView");

	    try {
	        // OpenAPI URL 구성
			/*
			 * String apiUrl =
			 * "https://www.reb.or.kr/r-one/openapi/SttsApiTblData.do?STATBL_ID=A_2024_00900&DTACYCLE_CD=YY&WRTTIME_IDTFR_ID=2022&Type=json";
			 */
			/*
			 * String apiUrl =
			 * "https://www.reb.or.kr/r-one/openapi/SttsApiTblItm.do?STATBL_ID=A_2024_00900";
			 */
	    	String apiUrl = "https://www.reb.or.kr/r-one/openapi/SttsApiTblData.do"
	    		    + "?KEY=650f2fdab92040b9b4d256b205cce038"
	    		    + "&STATBL_ID=A_2024_00900"
	    		    + "&DTACYCLE_CD=YY"
	    		    + "&Type=json";

	        // 연결 설정
	        URL url = new URL(apiUrl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");

	        // 응답 읽기
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        StringBuilder sb = new StringBuilder();
	        String line;

	        while ((line = br.readLine()) != null) {
	            sb.append(line);
	        }
	        br.close();
	        System.out.println("응답 내용: " + sb.toString());
	        // JSON 문자열을 바로 클라이언트로 전달
	        resultMap.put("status", "success");
	        resultMap.put("data", sb.toString());

	    } catch (Exception e) {
	        e.printStackTrace();
	        resultMap.put("status", "error");
	        resultMap.put("message", e.getMessage());
	    }

	    mav.addObject("resultMap", resultMap);
	    return mav;
	}
	
	
	@RequestMapping("/rOne.do")
	public String rOne() throws Exception{
		return "rOne";
	}	
	
}
