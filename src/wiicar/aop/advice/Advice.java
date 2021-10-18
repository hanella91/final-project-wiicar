package wiicar.aop.advice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/aop/*")
public class Advice {

	@RequestMapping("error.do")
	public String main3() {
		System.out.println("errorPage 요청");
		return "error";
	}
}
