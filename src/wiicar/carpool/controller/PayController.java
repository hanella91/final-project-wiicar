package wiicar.carpool.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import wiicar.carpool.dto.CarpoolDTO;
import wiicar.carpool.service.PayServiceImpl;
import wiicar.member.service.MemberServiceImpl;

@Controller
@RequestMapping("/carpoolPay/*")
public class PayController {

	@Autowired
	private PayServiceImpl payService = null;
	@Autowired
	private MemberServiceImpl memberService = null;
	
	@RequestMapping("successPay.do")
	public String successPay(HttpServletRequest request, Model model) throws SQLException {
		int paynum = Integer.parseInt(request.getParameter("paynum"));
		payService.successPay(paynum);
		return "carpoolpay/successPay";
	}
	
	@RequestMapping("cancelPay.do")
	public String cancelPay(HttpServletRequest request, Model model) throws SQLException {
		int paynum = Integer.parseInt(request.getParameter("paynum"));
		payService.cancelPay(paynum);
		return "carpoolpay/cancelPay";
	}
	
	@RequestMapping("failPay.do")
	public String failPay(HttpServletRequest request) throws SQLException {
		int paynum = Integer.parseInt(request.getParameter("paynum"));
		payService.failPay(paynum);
		return "carpoolpay/failPay";
	}
	
	
	@RequestMapping("checkKakaoPay.do")
	@ResponseBody
	public String checkKakaoPay(CarpoolDTO dto, String message) throws SQLException {
		String res = payService.kakaoPay(dto, message);
		return res;
	}
	
}
