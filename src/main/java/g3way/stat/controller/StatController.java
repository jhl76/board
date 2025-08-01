package g3way.stat.controller;

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
	public String gisOlHome(Model model) throws Exception{
		return "gisOlHome";
	}
	
}
