package my.custom.project.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import my.custom.project.controller.BoardController;
import my.custom.project.model.Comment;

@Repository
@Transactional
public class CommentDao {
	
	private static final Logger logger = LoggerFactory.getLogger(CommentDao.class);
	
	
	@Autowired
	private SessionFactory sessionFactory;
	
	public void create(Comment comment) {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(comment);
		session.flush();
	}

	public List<Comment> getCommentListByBno(int bno) {
		Session session = sessionFactory.getCurrentSession();
		List<Comment> commentList = session.createQuery("from Comment where b_code = " + bno + " order by regdate ASC").list();
		return commentList;
	}

	public void delete(Comment comment) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(comment);
		session.flush();
	}

	public Comment getCommentByC_code(int c_code) {
		Session session = sessionFactory.getCurrentSession();
		Comment comment = session.get(Comment.class, c_code);
		return comment;
	}

}
