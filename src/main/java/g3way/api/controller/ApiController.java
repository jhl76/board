package g3way.api.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("ApiController")
public class ApiController {
	
	@RequestMapping(value = "/dogHome.do")
	public String dogHome() {
		return "dogHome";
	}
	
	@RequestMapping(value = "/kanye.do")
	public String kanye() {
		return "kanye";
	}
	
	@RequestMapping(value = "/poke.do")
	public String poke() {
		return "poke";
	}
	
}
