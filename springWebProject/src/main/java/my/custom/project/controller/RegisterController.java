package my.custom.project.controller;

import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import my.custom.project.model.User;
import my.custom.project.service.UserService;



@Controller
public class RegisterController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/register")
	public String registerUser(Model model, User user){
		
		return "registerUser";
	}
	
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registerUserPost(@Valid User user , BindingResult result, Model model){

		if(result.hasErrors()){
			return "registerUser";
		}
		List<User> userList = userService.getAllUsers();
		
		for(int i=0; i<userList.size(); i++){
			if(user.getUsername().equals(userList.get(i).getUsername()) ){
				model.addAttribute("usernameMsg" , "username already exist" ); 
				return "registerUser";
			}
		}
		
		user.setEnabled(true);
		if(user.getUsername().equals("admin"))
			user.setAuthority("ROLE_ADMIN");
		else
			user.setAuthority("ROLE_USER");
		
		userService.addUser(user);
		
		return "registerUserSuccess";
	 }
	
}
