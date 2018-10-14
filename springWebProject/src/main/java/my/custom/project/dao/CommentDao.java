package my.custom.project.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import my.custom.project.model.Comment;

@Repository
@Transactional
public class CommentDao {
	
	
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

}
