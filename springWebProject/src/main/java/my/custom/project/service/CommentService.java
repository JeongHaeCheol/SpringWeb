package my.custom.project.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import my.custom.project.dao.CommentDao;
import my.custom.project.model.Comment;


@Service
public class CommentService {
	
	private static final Logger logger = LoggerFactory.getLogger(CommentService.class);

	@Autowired
	private CommentDao commentDao;
	
	public void create(Comment comment) {
		commentDao.create(comment);
	}
	
	public Comment getCommentByC_code(int c_code) {
		return commentDao.getCommentByC_code(c_code);
	}
	
	public List<Comment> getCommentListByBno(int bno) {
		return commentDao.getCommentListByBno(bno);
	}

	public void delete(Comment comment) {
		commentDao.delete(comment);
	}

}
