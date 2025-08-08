package g3way.api.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("ApiController")
public class ApiController {
	@RequestMapping(value = "/poke.do")
	public String poke() {
		return "poke";
	}
	
}
