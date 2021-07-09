package my.custom.project.dao;

import java.util.List;

import javax.persistence.NoResultException;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import my.custom.project.model.User;

@Repository
@Transactional
public class UserDao {

	
	private static final Logger logger = LoggerFactory.getLogger(UserDao.class);
	
	@Autowired
	private SessionFactory sessionFactory;

	@Autowired
	private PasswordEncoder passwordEncoder;

	public void addUser(User user) {
		Session session = sessionFactory.getCurrentSession();
		//user.setPassword(passwordEncoder.encode(user.getPassword()));
		session.saveOrUpdate(user);
		session.flush();
	}

	public User getUserById(int userId) {
		Session session = sessionFactory.getCurrentSession();
		return (User) session.get(User.class, userId);
	}

	@SuppressWarnings("unchecked")
	public User getUserByUsername(String username) {
		Session session = sessionFactory.getCurrentSession();
		TypedQuery<User> query = session.createQuery("from User where username=?");
		query.setParameter(0, username);

		return query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public List<User> getAllUsers() {
		Session session = sessionFactory.getCurrentSession();
		TypedQuery<User> query = session.createQuery("from User");
		List<User> userList = query.getResultList();
		return userList;
	}

	public String getPasswordByUsernameAndEmail(String username, String email) {
		Session session = sessionFactory.getCurrentSession();
		TypedQuery<String> query = session.createQuery("select password from User where username = ? and email = ?")
				.setParameter(0, username).setParameter(1, email);

		try {
			return query.getSingleResult();
		} catch(NoResultException e) {
			return null;
		}
	}

}
