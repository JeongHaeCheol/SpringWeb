package my.custom.project.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import my.custom.project.email.Email;
import my.custom.project.email.EmailSender;
import my.custom.project.service.UserService;

@Controller
@RequestMapping("/userHelp/*")
public class UserHelpController {

	@Autowired
	private EmailSender emailSender;

	@Autowired
	private Email email;

	@Autowired
	private UserService userService;

	@RequestMapping("findPassword")
	public String findPassword() {
		return "user/findPassword";
	}

	@RequestMapping("findPwSuccess")
	public String findPwSuccess() {
		return "user/findPwSuccess";
	}
	
	@RequestMapping("findIdFail")
	public String findIdFail() {
		return "user/findIdFail";
	}
	
	@RequestMapping("sendPassword")
	public String sendEmailAction(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {

		String username = (String) paramMap.get("username");
		String e_mail = (String) paramMap.get("email");
		String pw = userService.getPasswordByUsernameAndEmail(username, e_mail);
		
		if (pw != null) {
			email.setContent("비밀번호는 " + pw + " 입니다.");
			email.setReceiver(e_mail);
			email.setSubject(username + "님 비밀번호 찾기 메일입니다.");
			emailSender.SendEmail(email);
			return "redirect:findPwSuccess";
		} else {
			return "redirect:findIdFail";
		}

	}
}	
