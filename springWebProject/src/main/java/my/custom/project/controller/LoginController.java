package my.custom.project.controller;

import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import my.custom.project.model.User;
import my.custom.project.service.UserService;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/login")
	public String Login(@RequestParam(value="error", required=false) String error, 
			@RequestParam(value="logout", required=false) String logout, Model model){
		
		if (error!=null){
			model.addAttribute("errorMsg","Invalid username and password");
		}
		if(logout!=null){
			model.addAttribute("logoutMsg", "You have been logged out successfully");
		}
		
		List<User> userList = userService.getAllUsers();
		
		
		for(User userInfo: userList) {
				logger.info("username : " + userInfo.getUsername());

				logger.info("password : " + userInfo.getPassword());
		}

		
		return "login";
	}

}
