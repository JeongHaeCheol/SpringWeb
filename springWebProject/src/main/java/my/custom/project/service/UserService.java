package my.custom.project.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import my.custom.project.dao.UserDao;
import my.custom.project.model.User;



@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	
	public void addUser(User user){
		userDao.addUser(user);
	}
	
	public User getUserById(int userId){
		return userDao.getUserById(userId);
	}
	
	public User getUserByUsername(String username){
		return userDao.getUserByUsername(username);
	}
	
	public List<User> getAllUsers(){
		return userDao.getAllUsers();
	}
	
	
	public String getPasswordByUsernameAndEmail(String username, String email) {
		return userDao.getPasswordByUsernameAndEmail(username, email);
	}
}
